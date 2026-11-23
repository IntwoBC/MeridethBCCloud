// ============================================================
// Codeunit: CRM Ship-To Int. Mgt.
// Object ID  : 50101
// Publisher  : Intwo
// Direction  : PULL — CRM Ship-To Staging → BC Ship-to Address
//              (Table 222).
// Dependency : Customer must exist in BC before Ship-To is
//              processed. Run Customer staging first.
//
// Processing logic:
//   1. Validate Customer No. exists in BC Customer table.
//   2. Validate mandatory fields (Code, Name, Tax Area Code).
//   3. Generate Ship-to Code if blank (first 10 chars of Address).
//   4. Lookup reference tables (Country, Tax Area, Location).
//   5. Upsert BC Ship-to Address record.
//   6. Update staging status.
// ============================================================
codeunit 50101 "CRM Ship-To Int. Mgt."
{
    TableNo = "CRM Ship-To Staging";
    Permissions = TableData "CRM Customer Staging" = RIMD, TableData "CRM Ship-To Staging" = RIMD, TableData "Ship-to Address" = RIMD, Tabledata Customer = RIMD, Tabledata "CRM Integration Log" = RIMD;

    trigger OnRun()
    begin
        ProcessStagingRecord(Rec);
    end;

    // --------------------------------------------------------
    // PUBLIC: Process a single CRM Ship-To Staging record.
    // --------------------------------------------------------
    procedure ProcessStagingRecord(var Rec: Record "CRM Ship-To Staging")
    var
        ShipToAddress: Record "Ship-to Address";
        LogMgt: Codeunit "CRM Integration Log Mgt.";
        IsNew: Boolean;
        ErrMsg: Text;

    begin
        Rec."Integration Status" := Enum::"CRM Integration Status"::Open;
        Rec."Error Message" := '';
        Rec.Modify();
        // Commit();
        LogMgt.WriteLog('ShipTo', 'Pull', Rec."Customer No.", Rec.Code, Enum::"CRM Integration Status"::Open, 'Processing started.', Database::"CRM Ship-To Staging", Rec."Retry Count");

        // Step 1 — Validate mandatory fields
        ErrMsg := ValidateMandatoryFields(Rec);
        if ErrMsg <> '' then begin
            SetFailed(Rec, ErrMsg);
            exit;
        end;

        // Step 2 — Auto-generate Ship-to Code if not supplied.
        //          Sheet note: "To check with Liza on Formula"
        //          Using: uppercase first 10 chars of Address
        //          as a safe fallback formula.
        // if Rec.Code = '' then begin
        //     if Rec.Address <> '' then
        //         Rec.Code := CopyStr(UpperCase(Rec.Address), 1, 10)
        //     else
        //         Rec.Code := CopyStr(Rec."Customer No.", 1, 10);
        //     // Rec.Modify();
        // end;

        // Step 3 — Check parent Customer exists in BC
        if not CustomerExists(Rec."Customer No.") then begin
            SetFailed(Rec, StrSubstNo('Customer No. "%1" does not exist in BC. Process Customer staging first.', Rec."Customer No."));
            exit;
        end;

        // Step 4 — Determine Insert vs Modify
        IsNew := not ShipToAddress.Get(Rec."Customer No.", Rec.Code);
        if IsNew then begin
            ShipToAddress.Init();
            ShipToAddress."Customer No." := Rec."Customer No.";
            ShipToAddress.Code := Rec.Code;
        end;

        // Step 5 — Map fields
        if not TryMapToShipTo(Rec, ShipToAddress) then begin
            SetFailed(Rec, GetLastErrorText());
            exit;
        end;

        // Step 6 — Upsert
        if IsNew then begin
            if not TryInsertShipTo(ShipToAddress) then begin
                SetFailed(Rec, GetLastErrorText());
                exit;
            end;
        end else begin
            if not TryModifyShipTo(ShipToAddress) then begin
                SetFailed(Rec, GetLastErrorText());
                exit;
            end;
        end;

        Rec."Integration Status" := Enum::"CRM Integration Status"::Success;
        Rec."Processed DateTime" := CurrentDateTime();
        Rec."Error Message" := '';
        Rec.Modify();
        LogMgt.WriteLog('ShipTo', 'Pull', Rec."Customer No.", Rec.Code, Enum::"CRM Integration Status"::Success, 'Ship-to record processed successfully.', Database::"CRM Ship-To Staging", Rec."Retry Count");
    end;

    // --------------------------------------------------------
    // PUBLIC: Batch process all Open ship-to staging records.
    // --------------------------------------------------------
    procedure ProcessAllOpen()
    var
        CRMShipToStaging: Record "CRM Ship-To Staging";
        Processed: Integer;
        Failed: Integer;
    begin
        CRMShipToStaging.SetRange("Integration Status", Enum::"CRM Integration Status"::Open);
        if not CRMShipToStaging.FindSet(true) then begin
            Message('No open CRM Ship-To staging records to process.');
            exit;
        end;

        repeat
            if TryProcess(CRMShipToStaging) then
                Processed += 1
            else
                Failed += 1;
        until CRMShipToStaging.Next() = 0;

        Message('Ship-To staging batch complete.\nProcessed: %1  |  Failed: %2', Processed, Failed);
    end;

    [TryFunction]
    local procedure TryProcess(var CRMShipToStaging: Record "CRM Ship-To Staging")
    begin
        ProcessStagingRecord(CRMShipToStaging);
    end;

    // --------------------------------------------------------
    // PRIVATE: Validate mandatory fields.
    // --------------------------------------------------------
    local procedure ValidateMandatoryFields(Rec: Record "CRM Ship-To Staging"): Text
    var
        ErrBuilder: Text;
    begin
        if Rec."Customer No." = '' then
            ErrBuilder += 'Customer No. is mandatory. ';
        if Rec.Name = '' then
            ErrBuilder += 'Name is mandatory. ';
        if Rec."Tax Area Code" = '' then
            ErrBuilder += 'Tax Area Code is mandatory. ';

        // Tax Liable default = true
        Rec."Tax Liable" := true;

        // Location Code default per CRM integration mapping
        if Rec."Location Code" = '' then
            Rec."Location Code" := 'SAN PEDRO';
        //Rec.Modify();

        exit(ErrBuilder);
    end;

    // --------------------------------------------------------
    // PRIVATE: Check if BC Customer exists.
    // --------------------------------------------------------
    local procedure CustomerExists(CustomerNo: Code[20]): Boolean
    var
        Customer: Record Customer;
    begin
        exit(Customer.Get(CustomerNo));
    end;

    // --------------------------------------------------------
    // PRIVATE: Map staging → BC Ship-to Address fields.
    //          All field lengths match BC table 222 exactly.
    // --------------------------------------------------------
    [TryFunction]
    local procedure TryMapToShipTo(Rec: Record "CRM Ship-To Staging"; var ShipToAddress: Record "Ship-to Address")
    var
        CountryRegion: Record "Country/Region";
        TaxArea: Record "Tax Area";
        Location: Record Location;
        SalespersonPurchaser: Record "Salesperson/Purchaser";
    begin
        // Name (Text[100]) — Mandatory
        ShipToAddress.Name := CopyStr(Rec.Name, 1, 100);

        // Address (Text[100])
        ShipToAddress.Address := CopyStr(Rec.Address, 1, 100);

        // Address 2 (Text[50])
        ShipToAddress."Address 2" := CopyStr(Rec."Address 2", 1, 50);

        ShipToAddress."Location Code" := CopyStr(Rec."Location Code", 1, 10);

        // City (Text[30])
        ShipToAddress.City := CopyStr(Rec.City, 1, 30);

        if Rec.State <> '' then
            ShipToAddress.County := CopyStr(Rec.State, 1, MaxStrLen(ShipToAddress.County));

        // Post Code (Code[20])
        if Rec."Post Code" <> '' then
            ShipToAddress."Post Code" := CopyStr(Rec."Post Code", 1, 20);

        // Country/Region Code (Code[10])
        if Rec."Country/Region Code" <> '' then
            if CountryRegion.Get(CopyStr(Rec."Country/Region Code", 1, 10)) then
                ShipToAddress."Country/Region Code" := CountryRegion.Code;

        // Phone No. (Text[30])
        if Rec."Phone No." <> '' then
            ShipToAddress."Phone No." := CopyStr(Rec."Phone No.", 1, 30);

        // Contact (Text[100])
        if Rec.Contact <> '' then
            ShipToAddress.Contact := CopyStr(Rec.Contact, 1, 100);

        // Email — BC Ship-to Address uses "E-Mail" (Text[80])
        if Rec.Email <> '' then
            ShipToAddress."E-Mail" := CopyStr(Rec.Email, 1, 80);

        // Location Code (Code[10]) — validate existence
        // if Rec."Location Code" <> '' then
        //     if Location.Get(CopyStr(Rec."Location Code", 1, 10)) then
        //         ShipToAddress."Location Code" := Location.Code;

        // Tax Liable — Mandatory, default true
        ShipToAddress."Tax Liable" := true;

        // Tax Area Code (Code[20]) — MANDATORY; validate existence
        if not TaxArea.Get(CopyStr(Rec."Tax Area Code", 1, 20)) then
            Error('Tax Area Code "%1" does not exist in BC.', Rec."Tax Area Code");
        ShipToAddress."Tax Area Code" := TaxArea.Code;

        // Salesperson Code (Code[20])
        if Rec."Salesperson Code" <> '' then
            if SalespersonPurchaser.Get(CopyStr(Rec."Salesperson Code", 1, 20)) then
                ShipToAddress."Salesperson Code" := SalespersonPurchaser.Code;
    end;

    [TryFunction]
    local procedure TryInsertShipTo(var ShipToAddress: Record "Ship-to Address")
    begin
        ShipToAddress.Insert(true);
    end;

    [TryFunction]
    local procedure TryModifyShipTo(var ShipToAddress: Record "Ship-to Address")
    begin
        ShipToAddress.Modify(true);
    end;

    local procedure SetFailed(var Rec: Record "CRM Ship-To Staging"; ErrMsg: Text)
    var
        LogMgt: Codeunit "CRM Integration Log Mgt.";
    begin
        Rec."Integration Status" := Enum::"CRM Integration Status"::Failed;
        Rec."Error Message" := CopyStr(ErrMsg, 1, 250);
        Rec."Retry Count" += 1;
        Rec."Processed DateTime" := CurrentDateTime();
        Rec.Modify();
        LogMgt.WriteLog('ShipTo', 'Pull', Rec."Customer No.", Rec.Code, Enum::"CRM Integration Status"::Failed, ErrMsg, Database::"CRM Ship-To Staging", Rec."Retry Count");
    end;
}
