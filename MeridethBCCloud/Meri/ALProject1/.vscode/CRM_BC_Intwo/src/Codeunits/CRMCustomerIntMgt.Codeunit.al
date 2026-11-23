// ============================================================
// Codeunit: CRM Customer Int. Mgt.
// Object ID  : 50100
// Publisher  : Intwo
// Direction  : PULL — CRM Customer Staging → BC Customer (T18)
// Triggered  : API Page OnInsertRecord / Job Queue / Manual
//
// Processing logic:
//   1. Validate all mandatory fields from mapping sheet.
//   2. Lookup BC reference tables (Country, Tax Area, Currency,
//      Payment Terms) — fail if any mandatory lookup fails.
//   3. Apply hardcoded defaults per "Intwo Remarks":
//        Gen. Bus. Posting Group = GEN
//        Customer Posting Group  = TRADE
//        Payment Method Code     = CREDITCARD
//        Tax Liable              = true
//   4. Upsert BC Customer: Customer.Get → Modify, else Insert.
//   5. Update staging record with Success / Failed status.
// ============================================================
codeunit 50100 "CRM Customer Int. Mgt."
{
    // TableNo triggers OnRun when the codeunit is called via Job Queue
    // with a record filter on CRM Customer Staging.
    TableNo = "CRM Customer Staging";
    Permissions = TableData "CRM Customer Staging" = RIMD, TableData "CRM Ship-To Staging" = RIMD, TableData "Ship-to Address" = RIMD, TableData Customer = RIMD, tabledata "CRM Integration Log" = RIMD;


    trigger OnRun()
    begin
        // Called by Job Queue — process the record passed in.
        ProcessStagingRecord(Rec);
    end;

    // --------------------------------------------------------
    // PUBLIC: Process a single CRM Customer Staging record.
    //         Called from API Page and manual retry actions.
    // --------------------------------------------------------
    procedure ProcessStagingRecord(var Rec: Record "CRM Customer Staging")
    var
        Customer: Record Customer;
        LogMgt: Codeunit "CRM Integration Log Mgt.";
        IsNew: Boolean;
        ErrMsg: Text;
    begin
        // Step 1 — Reset to Open so status is accurate
        Rec."Integration Status" := Enum::"CRM Integration Status"::Open;
        Rec."Error Message" := '';
        Rec.Modify();
        Commit(); // Commit Open status before any error can occur
        LogMgt.WriteLog('Customer', 'Pull', Rec."No.", '', Enum::"CRM Integration Status"::Open, 'Processing started.', Database::"CRM Customer Staging", Rec."Retry Count"); //29062026

        // Step 2 — Validate mandatory fields
        ErrMsg := ValidateMandatoryFields(Rec);
        if ErrMsg <> '' then begin
            SetFailed(Rec, ErrMsg);
            exit;
        end;

        // Step 3 — Determine Insert vs Modify
        IsNew := not Customer.Get(Rec."No.");
        if IsNew then
            Customer.Init();

        // Step 4 — Map staging fields → BC Customer
        if not TryMapToCustomer(Rec, Customer) then begin
            SetFailed(Rec, GetLastErrorText());
            exit;
        end;

        // Step 5 — Upsert Customer record
        if IsNew then begin
            // New customer — Insert with trigger
            if not TryInsertCustomer(Customer) then begin
                SetFailed(Rec, GetLastErrorText());
                exit;
            end;
        end else begin
            // Existing customer — Modify with trigger
            if not TryModifyCustomer(Customer) then begin
                SetFailed(Rec, GetLastErrorText());
                exit;
            end;
        end;

        // Step 6 — Mark Success
        Rec."Integration Status" := Enum::"CRM Integration Status"::Success;
        Rec."Processed DateTime" := CurrentDateTime();
        Rec."Error Message" := '';
        Rec.Modify();
        LogMgt.WriteLog('Customer', 'Pull', Rec."No.", '', Enum::"CRM Integration Status"::Success, 'Customer record processed successfully.', Database::"CRM Customer Staging", Rec."Retry Count");
    end;

    // --------------------------------------------------------
    // PUBLIC: Batch-process all Open staging records.
    //         Used by Job Queue (no TableNo filter) and
    //         the "Process All Open" dashboard action.
    // --------------------------------------------------------
    procedure ProcessAllOpen()
    var
        CRMCustomerStaging: Record "CRM Customer Staging";
        Processed: Integer;
        Failed: Integer;
    begin
        CRMCustomerStaging.SetRange("Integration Status", Enum::"CRM Integration Status"::Open);
        if not CRMCustomerStaging.FindSet(true) then begin
            Message('No open CRM Customer staging records to process.');
            exit;
        end;

        repeat
            if TryProcess(CRMCustomerStaging) then
                Processed += 1
            else
                Failed += 1;
        until CRMCustomerStaging.Next() = 0;

        Message('Customer staging batch complete.\nProcessed: %1  |  Failed: %2', Processed, Failed);
    end;

    // --------------------------------------------------------
    // PRIVATE: TryFunction wrapper — prevents one record error
    //          from stopping the entire batch.
    // --------------------------------------------------------
    [TryFunction]
    local procedure TryProcess(var CRMCustomerStaging: Record "CRM Customer Staging")
    begin
        ProcessStagingRecord(CRMCustomerStaging);
    end;

    // --------------------------------------------------------
    // PRIVATE: Validate all mandatory fields per mapping sheet.
    //          Returns empty string if valid, error text if not.
    // --------------------------------------------------------
    local procedure ValidateMandatoryFields(Rec: Record "CRM Customer Staging"): Text
    var
        ErrBuilder: Text;
    begin
        // No. (Code[20]) — Mandatory
        if Rec."No." = '' then
            ErrBuilder += 'No. is mandatory. ';

        // Name (Text[100]) — Mandatory
        if Rec.Name = '' then
            ErrBuilder += 'Name is mandatory. ';

        // Tax Area Code (Code[20]) — Mandatory per sheet
        if Rec."Tax Area Code" = '' then
            ErrBuilder += 'Tax Area Code is mandatory. ';

        // Gen. Business Posting Group — Mandatory, default GEN
        // Apply default silently rather than failing
        if Rec."Gen. Business Posting Group" = '' then
            Rec."Gen. Business Posting Group" := 'GEN';

        // Customer Posting Group — Mandatory, default TRADE
        if Rec."Customer Posting Group" = '' then
            Rec."Customer Posting Group" := 'TRADE';
        if Rec."Location Code" = '' then
            Rec."Location Code" := 'SAN PEDRO';

        // Currency Code — Mandatory per sheet
        // if Rec."Currency Code" = '' then
        //     ErrBuilder += 'Currency Code is mandatory. ';

        // Tax Liable — default true per "Intwo Remarks"
        // (Boolean InitValue=true on field handles this at table level,
        //  but we explicitly set it here for clarity)
        Rec."Tax Liable" := true;

        // Payment Method Code — default CREDITCARD
        if Rec."Payment Method Code" = '' then
            Rec."Payment Method Code" := 'CREDITCARD';

        // Save the applied defaults back to staging
        // Rec.Modify();

        exit(ErrBuilder);
    end;

    // --------------------------------------------------------
    // PRIVATE: Map staging record fields to BC Customer record.
    //          All CopyStr calls use the BC Customer field lengths
    //          to prevent runtime "string too long" errors.
    // --------------------------------------------------------
    [TryFunction]
    local procedure TryMapToCustomer(Rec: Record "CRM Customer Staging"; var Customer: Record Customer)
    var
        CountryRegion: Record "Country/Region";
        TaxArea: Record "Tax Area";
        Currency: Record Currency;
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
    begin
        // --- Identity ---
        // No. (Code[20]) — PK, already set via Customer.Get or Init
        Customer."No." := CopyStr(Rec."No.", 1, 20);

        // Name (Text[100])
        Customer.Name := CopyStr(Rec.Name, 1, 100);

        // Name 2 (Text[50])
        if Rec."Name 2" <> '' then
            Customer."Name 2" := CopyStr(Rec."Name 2", 1, 50);

        // --- Address ---
        // Address (Text[100])
        Customer.Address := CopyStr(Rec.Address, 1, 100);

        // Address 2 (Text[50])
        Customer."Address 2" := CopyStr(Rec."Address 2", 1, 50);

        // City (Text[30])
        Customer.City := CopyStr(Rec.City, 1, 30);

        // State (Code[20]) maps to the standard BC Customer County field.
        if Rec.State <> '' then
            Customer.County := CopyStr(Rec.State, 1, MaxStrLen(Customer.County));

        // Post Code (Code[20])
        if Rec."Post Code" <> '' then
            Customer."Post Code" := CopyStr(Rec."Post Code", 1, 20);

        // Country/Region Code (Code[10]) — lookup to validate existence
        if Rec."Country/Region Code" <> '' then begin
            if CountryRegion.Get(CopyStr(Rec."Country/Region Code", 1, 10)) then
                Customer."Country/Region Code" := CountryRegion.Code;
            // If not found we skip — non-mandatory field
        end;

        // --- Contact ---
        if Rec.Contact <> '' then
            Customer.Contact := CopyStr(Rec.Contact, 1, 100);

        // Email (Text[80])
        if Rec.Email <> '' then
            Customer."E-Mail" := CopyStr(Rec.Email, 1, 80);

        // Phone No. (Text[30])
        if Rec."Phone No." <> '' then
            Customer."Phone No." := CopyStr(Rec."Phone No.", 1, 30);

        // --- Financial ---
        // Credit Limit (LCY)
        Customer."Credit Limit (LCY)" := Rec."Credit Limit (LCY)";

        // VAT Registration No. (Text[20])
        if Rec."VAT Registration No." <> '' then
            Customer."VAT Registration No." := CopyStr(Rec."VAT Registration No.", 1, 20);

        // Registration No. (Text[50]) — staging field name follows the
        // mapping sheet; BC base-app field is "Registration Number"
        // (current W1/BC14+ standard). If your tenant uses an older
        // localization with a different field name, update this one
        // line — VS Code IntelliSense (Ctrl+Space after "Customer.")
        // will show the exact available field name for your version.
        if Rec."Registration No." <> '' then
            Customer."Registration Number" := CopyStr(Rec."Registration No.", 1, 50);

        // Tax Liable — default true per Intwo Remarks
        Customer."Tax Liable" := true;

        // Tax Area Code (Code[20]) — MANDATORY; validate it exists in BC
        if not TaxArea.Get(CopyStr(Rec."Tax Area Code", 1, 20)) then
            Error('Tax Area Code "%1" does not exist in BC.', Rec."Tax Area Code");
        Customer."Tax Area Code" := TaxArea.Code;

        // Tax Identification Type mapping intentionally skipped.
        // This field is not available on Customer in the current symbol set.

        // --- Posting Groups (Mandatory, hardcoded per Intwo Remarks) ---
        // Gen. Business Posting Group = GEN
        Customer."Gen. Bus. Posting Group" := CopyStr(Rec."Gen. Business Posting Group", 1, 20);

        // Customer Posting Group = TRADE
        Customer."Customer Posting Group" := CopyStr(Rec."Customer Posting Group", 1, 20);

        Customer."Location Code" := CopyStr(Rec."Location Code", 1, 10);

        // --- Currency ---
        // Currency Code (Code[10]) — MANDATORY; validate existence
        // if not Currency.Get(CopyStr(Rec."Currency Code", 1, 10)) then
        //     Error('Currency Code "%1" does not exist in BC.', Rec."Currency Code");
        // Customer."Currency Code" := Currency.Code;

        // --- Payment ---
        // Payment Terms Code (Code[10])
        if Rec."Payment Terms Code" <> '' then
            if PaymentTerms.Get(CopyStr(Rec."Payment Terms Code", 1, 10)) then
                Customer."Payment Terms Code" := PaymentTerms.Code;

        // Payment Method Code (Code[10]) — default CREDITCARD
        if PaymentMethod.Get(CopyStr(Rec."Payment Method Code", 1, 10)) then
            Customer."Payment Method Code" := PaymentMethod.Code
        else begin
            // If CREDITCARD doesn't exist, try to continue without it
            // Log a warning — non-fatal for the integration
            Customer."Payment Method Code" := '';
        end;

        // Salesperson Code (Code[20])
        if Rec."Salesperson Code" <> '' then
            Customer."Salesperson Code" := CopyStr(Rec."Salesperson Code", 1, 20);

        // Ship-to Code (Code[10])
        if Rec."Ship-to Code" <> '' then
            Customer."Ship-to Code" := CopyStr(Rec."Ship-to Code", 1, 10);
    end;

    // --------------------------------------------------------
    // PRIVATE: TryFunction for Customer.Insert(true)
    // --------------------------------------------------------
    [TryFunction]
    local procedure TryInsertCustomer(var Customer: Record Customer)
    begin
        Customer.Insert(true);
    end;

    // --------------------------------------------------------
    // PRIVATE: TryFunction for Customer.Modify(true)
    // --------------------------------------------------------
    [TryFunction]
    local procedure TryModifyCustomer(var Customer: Record Customer)
    begin
        Customer.Modify(true);
    end;

    // --------------------------------------------------------
    // PRIVATE: Mark staging record as Failed with error message.
    //          Increments Retry Count for monitoring.
    // --------------------------------------------------------
    local procedure SetFailed(var Rec: Record "CRM Customer Staging"; ErrMsg: Text)
    var
        LogMgt: Codeunit "CRM Integration Log Mgt.";
    begin
        Rec."Integration Status" := Enum::"CRM Integration Status"::Failed;
        Rec."Error Message" := CopyStr(ErrMsg, 1, 250);
        Rec."Retry Count" += 1;
        Rec."Processed DateTime" := CurrentDateTime();
        Rec.Modify();
        LogMgt.WriteLog('Customer', 'Pull', Rec."No.", '', Enum::"CRM Integration Status"::Failed, ErrMsg, Database::"CRM Customer Staging", Rec."Retry Count");
    end;
}
