// ============================================================
// Codeunit: CRM Inbound API Handler
// Object ID  : 50104
// Publisher  : Intwo
// Purpose    : Parses inbound JSON payloads sent BY CRM (PULL
//              direction) for Customer Master and Ship-To
//              Address, populates staging tables, and triggers
//              processing. Can be called from a custom non-API
//              page/webhook receiver if you are not using the
//              standard BC API pages (50100/50101) directly.
// ============================================================
codeunit 50104 "CRM Inbound API Handler"

{
    Permissions =
        TableData "CRM Customer Staging" = RIMD,
        TableData "CRM Ship-To Staging" = RIMD,
        TableData "Ship-to Address" = RIMD,
        TableData Customer = RIMD,
        TableData "CRM Integration Log" = RIMD;

    // --------------------------------------------------------
    // PUBLIC: Handle Customer Master JSON from CRM.
    //
    //   Expected JSON:
    //   {
    //     "no": "C05056",
    //     "name": "Arnold Mireles Elementary Academy",
    //     "name2": "Lf Kingman Place",
    //     "creditLimit": 25000,
    //     "address": "9000 S EXCHANGE AVE",
    //     "address2": "107 PACIFIC HALL",
    //     "countryRegionCode": "US",
    //     "city": "North Miami Bch",
    //     "contact": "John Doe",
    //     "email": "john@example.com",
    //     "postCode": "33162",
    //     "vatRegistrationNo": "E9997-7109-07",
    //     "taxAreaCode": "LA",
    //     "taxIdentificationType": "Legal Entity",
    //     "registrationNo": "REG123",
    //     "currencyCode": "USD",
    //     "paymentTermsCode": "N30",
    //     "phoneNo": "312-555-0100",
    //     "salespersonCode": "JS",
    //     "shipToCode": "16756 CWAR"
    //   }
    // --------------------------------------------------------
    // [ServiceEnabled]
    // procedure HandleCustomerPayload(JsonPayload: Text)
    // var
    //     JObject: JsonObject;
    //     CRMCustomerStaging: Record "CRM Customer Staging";
    //     CRMCustomerIntMgt: Codeunit "CRM Customer Int. Mgt.";
    // begin
    //     if not JObject.ReadFrom(JsonPayload) then
    //         Error('Invalid JSON payload received for Customer Master.');

    //     ParseCustomerJson(JObject, CRMCustomerStaging);

    //     if CRMCustomerStaging.Get(CRMCustomerStaging."No.") then begin
    //         CRMCustomerStaging."Integration Status" := Enum::"CRM Integration Status"::Open;
    //         CRMCustomerStaging."Processed DateTime" := 0DT;
    //         CRMCustomerStaging."Error Message" := '';
    //         CRMCustomerStaging.Modify(true);
    //     end else begin
    //         CRMCustomerStaging."Created DateTime" := CurrentDateTime();
    //         CRMCustomerStaging."Integration Status" := Enum::"CRM Integration Status"::Open;
    //         CRMCustomerStaging."Error Message" := '';
    //         CRMCustomerStaging.Insert(true);
    //     end;
    //     CRMCustomerIntMgt.ProcessStagingRecord(CRMCustomerStaging);
    // end;


    procedure HandleCustomerPayload(JsonPayload: Text)
    var
        JObject: JsonObject;
        CRMCustomerStaging: Record "CRM Customer Staging";
        CRMCustomerIntMgt: Codeunit "CRM Customer Int. Mgt.";
    begin
        if not JObject.ReadFrom(JsonPayload) then
            Error('Invalid JSON payload received for Customer Master.');


        ParseCustomerJson(JObject, CRMCustomerStaging);
        ValidateMandatoryFields(CRMCustomerStaging);
        if CRMCustomerStaging.Get(CRMCustomerStaging."No.") then begin
            CRMCustomerStaging."Integration Status" := Enum::"CRM Integration Status"::Open;
            CRMCustomerStaging."Processed DateTime" := 0DT;
            CRMCustomerStaging."Error Message" := '';
            CRMCustomerStaging.Modify(true);
        end else begin
            CRMCustomerStaging."Created DateTime" := CurrentDateTime();
            CRMCustomerStaging."Integration Status" := Enum::"CRM Integration Status"::Open;
            CRMCustomerStaging."Error Message" := '';
            CRMCustomerStaging.Insert(true);
        end;
        CRMCustomerIntMgt.ProcessStagingRecord(CRMCustomerStaging);
    end;


    // procedure UpdateCustomerPayload(Payload: Text)
    // var
    //     JObject: JsonObject;
    //     Cust: Record Customer;
    //     CustomerNo: Code[20];
    // begin
    //     if not JObject.ReadFrom(Payload) then
    //         Error('Invalid JSON.');

    //     CustomerNo := CopyStr(GetJsonTextWithFallback(JObject, 'accountnumber', 'no'), 1, 20);

    //     if CustomerNo = '' then
    //         Error('Customer No. is mandatory.');

    //     if not Cust.Get(CustomerNo) then
    //         Error('Customer %1 not found.', CustomerNo);

    //     if GetJsonText(JObject, 'name') <> '' then
    //         Cust.Name := CopyStr(GetJsonText(JObject, 'name'), 1, MaxStrLen(Cust.Name));

    //     if GetJsonText(JObject, 'name2') <> '' then
    //         Cust."Name 2" := CopyStr(GetJsonText(JObject, 'name2'), 1, MaxStrLen(Cust."Name 2"));

    //     if GetJsonTextWithFallback(JObject, 'address1_line1', 'address') <> '' then
    //         Cust.Address := CopyStr(GetJsonTextWithFallback(JObject, 'address1_line1', 'address'), 1, MaxStrLen(Cust.Address));

    //     if GetJsonTextWithFallback(JObject, 'address1_line2', 'address2') <> '' then
    //         Cust."Address 2" := CopyStr(GetJsonTextWithFallback(JObject, 'address1_line2', 'address2'), 1, MaxStrLen(Cust."Address 2"));

    //     if GetJsonTextWithFallback(JObject, 'address1_city', 'city') <> '' then
    //         Cust.City := CopyStr(GetJsonTextWithFallback(JObject, 'address1_city', 'city'), 1, MaxStrLen(Cust.City));

    //     if GetJsonText(JObject, 'currencyCode') <> '' then
    //         Cust."Currency Code" := CopyStr(GetJsonText(JObject, 'currencyCode'), 1, MaxStrLen(Cust."Currency Code"));

    //     if GetJsonTextWithFallback(JObject, 'wf_customerpaymentterms', 'paymentTermsCode') <> '' then
    //         Cust."Payment Terms Code" := CopyStr(GetJsonTextWithFallback(JObject, 'wf_customerpaymentterms', 'paymentTermsCode'), 1, MaxStrLen(Cust."Payment Terms Code"));

    //     if GetJsonTextWithFallback(JObject, 'wf_taxcodelist', 'taxAreaCode') <> '' then
    //         Cust."Tax Area Code" := CopyStr(GetJsonTextWithFallback(JObject, 'wf_taxcodelist', 'taxAreaCode'), 1, MaxStrLen(Cust."Tax Area Code"));

    //     Cust.Modify(true);
    // end;
    [serviceEnabled]
    procedure UpdateCustomerPayload(Payload: Text)
    var
        JObject: JsonObject;
        Cust: Record Customer;
        CustomerNo: Code[20];
    begin
        if not JObject.ReadFrom(Payload) then
            Error('Invalid JSON.');

        CustomerNo := CopyStr(GetJsonTextWithFallback(JObject, 'accountnumber', 'no'), 1, 20);

        if CustomerNo = '' then
            Error('Customer No. is mandatory.');

        if not Cust.Get(CustomerNo) then
            Error('Customer %1 not found.', CustomerNo);

        if GetJsonText(JObject, 'name') <> '' then
            Cust.Name := CopyStr(GetJsonText(JObject, 'name'), 1, MaxStrLen(Cust.Name));

        if GetJsonText(JObject, 'name2') <> '' then
            Cust."Name 2" := CopyStr(GetJsonText(JObject, 'name2'), 1, MaxStrLen(Cust."Name 2"));

        if GetJsonTextWithFallback(JObject, 'address1_line1', 'address') <> '' then
            Cust.Address := CopyStr(GetJsonTextWithFallback(JObject, 'address1_line1', 'address'), 1, MaxStrLen(Cust.Address));

        if GetJsonTextWithFallback(JObject, 'address1_line2', 'address2') <> '' then
            Cust."Address 2" := CopyStr(GetJsonTextWithFallback(JObject, 'address1_line2', 'address2'), 1, MaxStrLen(Cust."Address 2"));

        if GetJsonTextWithFallback(JObject, 'address1_city', 'city') <> '' then
            Cust.City := CopyStr(GetJsonTextWithFallback(JObject, 'address1_city', 'city'), 1, MaxStrLen(Cust.City));

        if GetJsonTextWithFallback(JObject, 'address1_country', 'countryRegionCode') <> '' then
            Cust."Country/Region Code" := CopyStr(GetJsonTextWithFallback(JObject, 'address1_country', 'countryRegionCode'), 1, MaxStrLen(Cust."Country/Region Code"));

        if GetJsonTextWithFallback(JObject, 'address1_postalcode', 'postCode') <> '' then
            Cust."Post Code" := CopyStr(GetJsonTextWithFallback(JObject, 'address1_postalcode', 'postCode'), 1, MaxStrLen(Cust."Post Code"));

        if GetJsonTextWithFallback(JObject, 'wf_billingcontact', 'contact') <> '' then
            Cust.Contact := CopyStr(GetJsonTextWithFallback(JObject, 'wf_billingcontact', 'contact'), 1, MaxStrLen(Cust.Contact));

        if GetJsonTextWithFallback(JObject, 'wf_billingemail', 'email') <> '' then
            Cust."E-Mail" := CopyStr(GetJsonTextWithFallback(JObject, 'wf_billingemail', 'email'), 1, MaxStrLen(Cust."E-Mail"));
        if GetJsonTextWithFallback(JObject, 'address1_stateorprovince', 'state') <> '' then
            Cust.County :=
                CopyStr(GetJsonTextWithFallback(JObject, 'address1_stateorprovince', 'state'),
                1, MaxStrLen(Cust.County));

        if GetJsonTextWithFallback(JObject, 'telephone1', 'phoneNo') <> '' then
            Cust."Phone No." := CopyStr(GetJsonTextWithFallback(JObject, 'telephone1', 'phoneNo'), 1, MaxStrLen(Cust."Phone No."));

        if GetJsonText(JObject, 'vatRegistrationNo') <> '' then
            Cust."VAT Registration No." := CopyStr(GetJsonText(JObject, 'vatRegistrationNo'), 1, MaxStrLen(Cust."VAT Registration No."));

        if GetJsonTextWithFallback(JObject, 'wf_taxcodelist', 'taxAreaCode') <> '' then
            Cust."Tax Area Code" := CopyStr(GetJsonTextWithFallback(JObject, 'wf_taxcodelist', 'taxAreaCode'), 1, MaxStrLen(Cust."Tax Area Code"));

        if GetJsonText(JObject, 'registrationNo') <> '' then
            Cust."Registration Number" := CopyStr(GetJsonText(JObject, 'registrationNo'), 1, MaxStrLen(Cust."Registration Number"));

        // if GetJsonText(JObject, 'currencyCode') <> '' then
        //     Cust."Currency Code" := CopyStr(GetJsonText(JObject, 'currencyCode'), 1, MaxStrLen(Cust."Currency Code"));

        if GetJsonTextWithFallback(JObject, 'wf_customerpaymentterms', 'paymentTermsCode') <> '' then
            Cust."Payment Terms Code" := CopyStr(GetJsonTextWithFallback(JObject, 'wf_customerpaymentterms', 'paymentTermsCode'), 1, MaxStrLen(Cust."Payment Terms Code"));

        if GetJsonTextWithFallback(JObject, 'zzmd_salespersoncode', 'salespersonCode') <> '' then
            Cust."Salesperson Code" := CopyStr(GetJsonTextWithFallback(JObject, 'zzmd_salespersoncode', 'salespersonCode'), 1, MaxStrLen(Cust."Salesperson Code"));

        if Cust."Location Code" = '' then
            Cust."Location Code" := 'SAN PEDRO';

        if Evaluate(Cust."Credit Limit (LCY)", GetJsonTextWithFallback(JObject, 'creditLimit', 'creditlimit')) then;

        Cust.Modify(true);
    end;

    [ServiceEnabled]
    procedure DeleteCustomerPayload(Payload: Text)
    var
        JObject: JsonObject;
        Customer: Record Customer;
        CustomerNo: Code[20];
    begin
        if not JObject.ReadFrom(Payload) then
            Error('Invalid JSON.');

        CustomerNo := CopyStr(GetJsonTextWithFallback(JObject, 'accountnumber', 'no'), 1, 20);

        if CustomerNo = '' then
            Error('Customer No. is mandatory.');

        if not Customer.Get(CustomerNo) then
            Error('Customer %1 not found.', CustomerNo);

        Customer.Delete(true);
    end;

    // --------------------------------------------------------
    // PUBLIC: Handle Ship-To Address JSON from CRM.
    //
    //   Expected JSON:
    //   {
    //     "customerNo": "C00003",
    //     "code": "16756 CWAR",
    //     "name": "California Institution For Women & Men",
    //     "address": "16756 Chino-Corona Road",
    //     "address2": "Suite 1",
    //     "city": "North Miami Beach",
    //     "countryRegionCode": "US",
    //     "phoneNo": "(909) 597-1771 x 55",
    //     "contact": "Annex Warehouse",
    //     "email": "charity.anti@cdcr.ca.gov",
    //     "locationCode": "SAN PEDRO",
    //     "postCode": "91710",
    //     "salespersonCode": "JS",
    //     "taxAreaCode": "OS"
    //   }
    // --------------------------------------------------------
    procedure HandleShipToPayload(JsonPayload: Text)
    var
        JObject: JsonObject;
        CRMShipToStaging: Record "CRM Ship-To Staging";
        CRMShipToIntMgt: Codeunit "CRM Ship-To Int. Mgt.";
    begin
        if not JObject.ReadFrom(JsonPayload) then
            Error('Invalid JSON payload received for Ship-To Address.');

        ParseShipToJson(JObject, CRMShipToStaging);
        ValidateMandatoryFieldsship(CRMShipToStaging);
        if CRMShipToStaging.Get(CRMShipToStaging."Customer No.", CRMShipToStaging.Code) then begin
            CRMShipToStaging."Integration Status" := Enum::"CRM Integration Status"::Open;
            CRMShipToStaging.Modify(true);
        end else begin
            CRMShipToStaging."Created DateTime" := CurrentDateTime();
            CRMShipToStaging.Insert(true);
        end;

        CRMShipToIntMgt.ProcessStagingRecord(CRMShipToStaging);
    end;

    [ServiceEnabled]
    procedure UpdateShipToPayload(Payload: Text)
    var
        JObject: JsonObject;
        ShipTo: Record "Ship-to Address";
        CustomerNo: Code[20];
        ShipToCode: Code[20];
    begin
        if not JObject.ReadFrom(Payload) then
            Error('Invalid JSON.');

        CustomerNo := CopyStr(GetJsonTextWithFallback(JObject, 'accountnumber', 'customerNo'), 1, 20);
        ShipToCode := CopyStr(GetJsonText(JObject, 'code'), 1, 10);
        //     CustomerNo := CopyStr(
        // DelChr(GetJsonTextWithFallback(JObject, 'accountnumber', 'customerNo'), '=', ' '),
        // 1, 20);

        //     ShipToCode := CopyStr(
        //         DelChr(GetJsonText(JObject, 'code'), '=', ' '),
        //         1, 10);

        if CustomerNo = '' then
            Error('Customer No. is mandatory.');

        if ShipToCode = '' then
            Error('Ship-To Code is mandatory.');

        // if not ShipTo.Get(CustomerNo, ShipToCode) then
        //     Error('Ship-To %1 for Customer %2 not found.', ShipToCode, CustomerNo);
        ShipTo.Reset();
        ShipTo.SetRange("Customer No.", CustomerNo);
        ShipTo.SetRange(Code, ShipToCode);

        if ShipTo.FindFirst() then
            Message('Found Ship-To')
        else
            Error(
                'Not Found.\Customer=%1\ShipTo=%2',
                CustomerNo,
                ShipToCode);

        if GetJsonTextWithFallback(JObject, 'address1_name', 'name') <> '' then
            ShipTo.Name :=
                CopyStr(GetJsonTextWithFallback(JObject, 'address1_name', 'name'),
                1, MaxStrLen(ShipTo.Name));

        if GetJsonTextWithFallback(JObject, 'address1_line1', 'address') <> '' then
            ShipTo.Address :=
                CopyStr(GetJsonTextWithFallback(JObject, 'address1_line1', 'address'),
                1, MaxStrLen(ShipTo.Address));

        if GetJsonTextWithFallback(JObject, 'address1_line2', 'address2') <> '' then
            ShipTo."Address 2" :=
                CopyStr(GetJsonTextWithFallback(JObject, 'address1_line2', 'address2'),
                1, MaxStrLen(ShipTo."Address 2"));

        if GetJsonTextWithFallback(JObject, 'address1_city', 'city') <> '' then
            ShipTo.City :=
                CopyStr(GetJsonTextWithFallback(JObject, 'address1_city', 'city'),
                1, MaxStrLen(ShipTo.City));
        if GetJsonTextWithFallback(JObject, 'address1_stateorprovince', 'state') <> '' then
            ShipTo.County :=
                CopyStr(GetJsonTextWithFallback(JObject, 'address1_stateorprovince', 'state'),
                1, MaxStrLen(ShipTo.County));

        if GetJsonTextWithFallback(JObject, 'address1_country', 'countryRegionCode') <> '' then
            ShipTo."Country/Region Code" :=
                CopyStr(GetJsonTextWithFallback(JObject, 'address1_country', 'countryRegionCode'),
                1, MaxStrLen(ShipTo."Country/Region Code"));

        if GetJsonTextWithFallback(JObject, 'address1_postalcode', 'postCode') <> '' then
            ShipTo."Post Code" :=
                CopyStr(GetJsonTextWithFallback(JObject, 'address1_postalcode', 'postCode'),
                1, MaxStrLen(ShipTo."Post Code"));

        if GetJsonTextWithFallback(JObject, 'telephone1', 'phoneNo') <> '' then
            ShipTo."Phone No." :=
                CopyStr(GetJsonTextWithFallback(JObject, 'telephone1', 'phoneNo'),
                1, MaxStrLen(ShipTo."Phone No."));

        if GetJsonTextWithFallback(JObject, 'fullname', 'contact') <> '' then
            ShipTo.Contact :=
                CopyStr(GetJsonTextWithFallback(JObject, 'fullname', 'contact'),
                1, MaxStrLen(ShipTo.Contact));

        if GetJsonTextWithFallback(JObject, 'emailaddress1', 'email') <> '' then
            ShipTo."E-Mail" :=
                CopyStr(GetJsonTextWithFallback(JObject, 'emailaddress1', 'email'),
                1, MaxStrLen(ShipTo."E-Mail"));

        if GetJsonText(JObject, 'locationCode') <> '' then
            ShipTo."Location Code" :=
                CopyStr(GetJsonText(JObject, 'locationCode'),
                1, MaxStrLen(ShipTo."Location Code"))
        else
            if ShipTo."Location Code" = '' then
                ShipTo."Location Code" := 'SAN PEDRO';

        if GetJsonTextWithFallback(JObject, 'zzmd_salespersoncode', 'salespersonCode') <> '' then
            ShipTo."Salesperson Code" :=
                CopyStr(GetJsonTextWithFallback(JObject, 'zzmd_salespersoncode', 'salespersonCode'),
                1, MaxStrLen(ShipTo."Salesperson Code"));

        if GetJsonTextWithFallback(JObject, 'wf_taxcodelist', 'taxAreaCode') <> '' then
            ShipTo."Tax Area Code" :=
                CopyStr(GetJsonTextWithFallback(JObject, 'wf_taxcodelist', 'taxAreaCode'),
                1, MaxStrLen(ShipTo."Tax Area Code"));

        ShipTo."Tax Liable" := true;

        ShipTo.Modify(true);
    end;

    [ServiceEnabled]
    procedure DeleteShipToPayload(Payload: Text)
    var
        JObject: JsonObject;
        ShipTo: Record "Ship-to Address";
        CustomerNo: Code[20];
        ShipToCode: Code[20];
    begin
        if not JObject.ReadFrom(Payload) then
            Error('Invalid JSON.');

        CustomerNo := CopyStr(GetJsonTextWithFallback(JObject, 'accountnumber', 'customerNo'), 1, 20);
        ShipToCode := CopyStr(GetJsonText(JObject, 'code'), 1, 10);

        if CustomerNo = '' then
            Error('Customer No. is mandatory.');

        if ShipToCode = '' then
            Error('Ship-To Code is mandatory.');

        if not ShipTo.Get(CustomerNo, ShipToCode) then
            Error('Ship-To %1 for Customer %2 not found.', ShipToCode, CustomerNo);

        ShipTo.Delete(true);
    end;

    // --------------------------------------------------------
    // PRIVATE: Parse Customer JSON → staging fields.
    //          CopyStr lengths match table field lengths exactly,
    //          preventing "string too long" runtime errors.
    // --------------------------------------------------------
    local procedure ParseCustomerJson(JObject: JsonObject; var Rec: Record "CRM Customer Staging")
    var
        TaxIdTypeText: Text;
    begin
        Rec.Init();
        Rec."No." := CopyStr(GetJsonTextWithFallback(JObject, 'accountnumber', 'no'), 1, 20);
        Rec.Name := CopyStr(GetJsonText(JObject, 'name'), 1, 100);
        Rec."Name 2" := CopyStr(GetJsonText(JObject, 'name2'), 1, 50);
        Rec.Address := CopyStr(GetJsonTextWithFallback(JObject, 'address1_line1', 'address'), 1, 100);
        Rec."Address 2" := CopyStr(GetJsonTextWithFallback(JObject, 'address1_line2', 'address2'), 1, 50);
        Rec."Country/Region Code" := CopyStr(GetJsonTextWithFallback(JObject, 'address1_country', 'countryRegionCode'), 1, 10);
        Rec.City := CopyStr(GetJsonText(JObject, 'address1_city'), 1, 30);
        if Rec.City = '' then
            Rec.City := CopyStr(GetJsonText(JObject, 'city'), 1, 30);
        Rec.Contact := CopyStr(GetJsonTextWithFallback(JObject, 'wf_billingcontact', 'contact'), 1, 100);
        Rec.Email := CopyStr(GetJsonTextWithFallback(JObject, 'wf_billingemail', 'email'), 1, 80);
        Rec."Post Code" := CopyStr(GetJsonTextWithFallback(JObject, 'address1_postalcode', 'postCode'), 1, 20);
        Rec."VAT Registration No." := CopyStr(GetJsonText(JObject, 'vatRegistrationNo'), 1, 20);
        Rec.State := CopyStr(GetJsonTextWithFallback(JObject, 'address1_stateorprovince', 'state'), 1, 20); // New field added to staging table
        Rec."Tax Area Code" := CopyStr(GetJsonTextWithFallback(JObject, 'wf_taxcodelist', 'taxAreaCode'), 1, 20);
        Rec."Registration No." := CopyStr(GetJsonText(JObject, 'registrationNo'), 1, 50);
        //Rec."Currency Code" := CopyStr(GetJsonText(JObject, 'currencyCode'), 1, 10);
        Rec."Payment Terms Code" := CopyStr(GetJsonTextWithFallback(JObject, 'wf_customerpaymentterms', 'paymentTermsCode'), 1, 10);
        Rec."Phone No." := CopyStr(GetJsonTextWithFallback(JObject, 'telephone1', 'phoneNo'), 1, 30);
        Rec."Salesperson Code" := CopyStr(GetJsonTextWithFallback(JObject, 'zzmd_salespersoncode', 'salespersonCode'), 1, 20);
        Rec."Ship-to Code" := CopyStr(GetJsonText(JObject, 'shipToCode'), 1, 10);

        // Credit Limit — numeric, default 0 if missing/invalid
        if not Evaluate(Rec."Credit Limit (LCY)", GetJsonTextWithFallback(JObject, 'creditLimit', 'creditlimit')) then
            Rec."Credit Limit (LCY)" := 0;

        // Tax Identification Type — Option field, parse text safely
        TaxIdTypeText := GetJsonText(JObject, 'taxIdentificationType');
        if TaxIdTypeText = 'Natural Person' then
            Rec."Tax Identification Type" := Rec."Tax Identification Type"::"Natural Person"
        else
            Rec."Tax Identification Type" := Rec."Tax Identification Type"::"Legal Entity"; // default

        // Defaults per "Intwo Remarks" — applied here so the
        // staging record already reflects the hardcoded values
        // even before the processing codeunit runs.
        Rec."Gen. Business Posting Group" := 'GEN';
        Rec."Customer Posting Group" := 'TRADE';
        Rec."Location Code" := 'SAN PEDRO';
        if Rec."Payment Method Code" = '' then
            Rec."Payment Method Code" := 'CREDITCARD';
        Rec."Tax Liable" := true;
    end;

    // --------------------------------------------------------
    // PRIVATE: Parse Ship-To JSON → staging fields.
    // --------------------------------------------------------
    local procedure ParseShipToJson(JObject: JsonObject; var Rec: Record "CRM Ship-To Staging")
    begin
        Rec.Init();
        Rec."Customer No." := CopyStr(GetJsonTextWithFallback(JObject, 'accountnumber', 'customerNo'), 1, 20);
        Rec.Code := CopyStr(GetJsonText(JObject, 'code'), 1, 10);
        Rec.Name := CopyStr(GetJsonTextWithFallback(JObject, 'address1_name', 'name'), 1, 100);
        Rec.Address := CopyStr(GetJsonTextWithFallback(JObject, 'address1_line1', 'address'), 1, 100);
        Rec."Address 2" := CopyStr(GetJsonTextWithFallback(JObject, 'address1_line2', 'address2'), 1, 50);
        Rec.State := CopyStr(GetJsonTextWithFallback(JObject, 'address1_stateorprovince', 'state'), 1, 20); // New field added to staging table
        Rec.City := CopyStr(GetJsonTextWithFallback(JObject, 'address1_city', 'city'), 1, 30);
        Rec."Country/Region Code" := CopyStr(GetJsonTextWithFallback(JObject, 'address1_country', 'countryRegionCode'), 1, 10);
        Rec."Phone No." := CopyStr(GetJsonTextWithFallback(JObject, 'telephone1', 'phoneNo'), 1, 30);
        Rec.Contact := CopyStr(GetJsonTextWithFallback(JObject, 'fullname', 'contact'), 1, 100);
        Rec.Email := CopyStr(GetJsonTextWithFallback(JObject, 'emailaddress1', 'email'), 1, 80);
        Rec."Location Code" := CopyStr(GetJsonText(JObject, 'locationCode'), 1, 10);
        if Rec."Location Code" = '' then
            Rec."Location Code" := 'SAN PEDRO';
        Rec."Post Code" := CopyStr(GetJsonTextWithFallback(JObject, 'address1_postalcode', 'postCode'), 1, 20);
        Rec."Salesperson Code" := CopyStr(GetJsonTextWithFallback(JObject, 'zzmd_salespersoncode', 'salespersonCode'), 1, 20);
        Rec."Tax Area Code" := CopyStr(GetJsonTextWithFallback(JObject, 'wf_taxcodelist', 'taxAreaCode'), 1, 20);
        Rec."Tax Liable" := true; // Default per spec

    end;

    local procedure GetJsonTextWithFallback(JObject: JsonObject; PrimaryKey: Text; SecondaryKey: Text): Text
    var
        ValueText: Text;
    begin
        ValueText := GetJsonText(JObject, PrimaryKey);
        if ValueText = '' then
            ValueText := GetJsonText(JObject, SecondaryKey);

        exit(ValueText);
    end;

    // --------------------------------------------------------
    // PRIVATE: Safe JSON text extractor — returns '' if the key
    //          is missing rather than throwing a runtime error.
    // --------------------------------------------------------
    local procedure GetJsonText(JObject: JsonObject; PropertyKey: Text): Text
    var
        JToken: JsonToken;
    begin
        if JObject.Get(PropertyKey, JToken) then begin
            if JToken.IsValue() then
                exit(JToken.AsValue().AsText());
        end;
        exit('');
    end;

    procedure ValidateMandatoryFields(Rec: Record "CRM Customer Staging"): Text
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
        if errBuilder <> '' then
            error(ErrBuilder);
    end;

    procedure ValidateMandatoryFieldsship(Rec: Record "CRM Ship-To Staging"): Text
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
        //Rec.Modify();
        if errBuilder <> '' then
            error(ErrBuilder);
    end;
}
