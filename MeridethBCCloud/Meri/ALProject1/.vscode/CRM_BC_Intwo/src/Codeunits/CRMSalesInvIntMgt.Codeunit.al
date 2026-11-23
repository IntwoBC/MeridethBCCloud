// ============================================================
// Codeunit: CRM Sales Inv. Int. Mgt.
// Object ID  : 50103
// Publisher  : Intwo
// Direction  : PUSH — BC Posted Sales Invoice (Tables 112/113)
//              -> CRM Sales Inv. Header/Line Staging -> CRM API.
// Source Map : BC-CRM_Integration_Field_Mapping
//              _Sales_Invoice_Push_from_BC.xlsx
//
// Processing logic:
//   1. Read BC Sales Invoice Header (112) + Lines (113).
//   2. Stage header + lines into Tables 50103 / 50104.
//   3. Build JSON payload for the header, POST to CRM Header API.
//   4. On header success, push each line independently to the
//      separate CRM Lines API (own endpoint, own retry tracking).
//
// Trigger point: called from an Events subscriber on Sales-Post
//   (OnAfterInsertInvoiceHeader) so the push happens automatically
//   right after posting.
// ============================================================
codeunit 50103 "CRM Sales Inv. Int. Mgt."
{
    TableNo = "Sales Invoice Header";

    trigger OnRun()
    begin
        StageAndPushInvoice(Rec);
    end;

    // --------------------------------------------------------
    // PUBLIC: Stage a posted Sales Invoice (header + lines)
    //         and push to CRM.
    // --------------------------------------------------------
    procedure StageAndPushInvoice(var SalesInvHeader: Record "Sales Invoice Header")
    var
        CRMHeaderStaging: Record "CRM Sales Inv. Header Staging";
        CRMLineStaging: Record "CRM Sales Inv. Line Staging";
        SalesInvLine: Record "Sales Invoice Line";
        IsNew: Boolean;
    begin
        // ---------------- HEADER STAGING ----------------
        IsNew := not CRMHeaderStaging.Get(SalesInvHeader."No.");
        if IsNew then begin
            CRMHeaderStaging.Init();
            CRMHeaderStaging."No." := SalesInvHeader."No.";
            CRMHeaderStaging."Created DateTime" := CurrentDateTime();
        end;

        // Map BC Sales Invoice Header -> staging (per mapping sheet)
        CRMHeaderStaging."Sell-to Customer No." := SalesInvHeader."Sell-to Customer No.";
        CRMHeaderStaging."Bill-to City" := SalesInvHeader."Bill-to City";
        CRMHeaderStaging."Bill-to Country/Region Code" := SalesInvHeader."Bill-to Country/Region Code";
        CRMHeaderStaging."Bill-to Address" := SalesInvHeader."Bill-to Address";
        CRMHeaderStaging."Due Date" := SalesInvHeader."Due Date";
        CRMHeaderStaging."Bill-to Address 2" := SalesInvHeader."Bill-to Address 2";
        CRMHeaderStaging."Bill-to Contact" := SalesInvHeader."Bill-to Contact";
        CRMHeaderStaging."Bill-to Post Code" := SalesInvHeader."Bill-to Post Code";
        CRMHeaderStaging."Shipment Date" := SalesInvHeader."Shipment Date";
        CRMHeaderStaging."Ship-to City" := SalesInvHeader."Ship-to City";
        CRMHeaderStaging."Ship-to Country/Region Code" := SalesInvHeader."Ship-to Country/Region Code";
        CRMHeaderStaging."Ship-to Address" := SalesInvHeader."Ship-to Address";
        CRMHeaderStaging."Ship-to Address 2" := SalesInvHeader."Ship-to Address 2";
        CRMHeaderStaging."Ship-to Contact" := SalesInvHeader."Ship-to Contact";
        CRMHeaderStaging."Ship-to Post Code" := SalesInvHeader."Ship-to Post Code";
        CRMHeaderStaging."Bill-to Customer No." := SalesInvHeader."Bill-to Customer No.";
        CRMHeaderStaging."Order No." := SalesInvHeader."Order No.";
        CRMHeaderStaging."Posting Date" := SalesInvHeader."Posting Date";
        CRMHeaderStaging."External Document No." := SalesInvHeader."External Document No.";
        CRMHeaderStaging."Currency Code" := SalesInvHeader."Currency Code";
        CRMHeaderStaging."Payment Terms Code" := SalesInvHeader."Payment Terms Code";
        CRMHeaderStaging."Payment Method Code" := SalesInvHeader."Payment Method Code";
        CRMHeaderStaging."Tax Liable" := SalesInvHeader."Tax Liable";
        CRMHeaderStaging."Tax Area Code" := SalesInvHeader."Tax Area Code";
        CRMHeaderStaging."Location Code" := SalesInvHeader."Location Code";
        CRMHeaderStaging."Ship-to Code" := SalesInvHeader."Ship-to Code";
        CRMHeaderStaging."Integration Status" := Enum::"CRM Integration Status"::Open;
        CRMHeaderStaging."Error Message" := '';

        if IsNew then
            CRMHeaderStaging.Insert(true)
        else
            CRMHeaderStaging.Modify(true);

        // ---------------- LINE STAGING ----------------
        // Read BC Sales Invoice Lines and stage them
        SalesInvLine.SetRange("Document No.", SalesInvHeader."No.");
        if SalesInvLine.FindSet() then begin
            repeat
                // Check if line staging already exists
                if not CRMLineStaging.Get(SalesInvHeader."No.", SalesInvLine."Line No.") then begin
                    CRMLineStaging.Init();
                    CRMLineStaging."Document No." := SalesInvHeader."No.";
                    CRMLineStaging."Line No." := SalesInvLine."Line No.";
                    //   CRMLineStaging."Created DateTime" := CurrentDateTime();
                    CRMLineStaging.Insert(true);
                end;

                // Map BC Sales Invoice Line -> staging (per mapping sheet)
                CRMLineStaging.Type := SalesInvLine.Type;
                CRMLineStaging."No." := SalesInvLine."No.";
                CRMLineStaging.Description := SalesInvLine.Description;
                CRMLineStaging.Quantity := SalesInvLine.Quantity;
                CRMLineStaging."Unit of Measure Code" := SalesInvLine."Unit of Measure Code";
                CRMLineStaging."Unit Price Excl. Tax" := SalesInvLine."Unit Price";
                CRMLineStaging."Unit Cost" := SalesInvLine."Unit Cost";
                CRMLineStaging."Location Code" := SalesInvLine."Location Code";
                CRMLineStaging."Shipment Date" := SalesInvHeader."Shipment Date";
                CRMLineStaging."Tax Area Code" := SalesInvHeader."Tax Area Code";
                CRMLineStaging."Tax Group Code" := SalesInvLine."Tax Group Code";
                CRMLineStaging."Line Amount Excl. Tax" := SalesInvLine.Amount;
                CRMLineStaging."Amount Including VAT" := SalesInvLine."Amount Including VAT";
                CRMLineStaging."Line Discount Amount" := SalesInvLine."Line Discount Amount";
                CRMLineStaging."Vendor No." := SalesInvLine."Vendor No.";
                CRMLineStaging."Vendor Cross Reference No." := SalesInvLine."Vendor Cross Reference No.";
                CRMLineStaging."Integration Status" := Enum::"CRM Integration Status"::Open;
                CRMLineStaging."Error Message" := '';
                CRMLineStaging.Modify(true);
            until SalesInvLine.Next() = 0;
        end;

        Commit(); // Persist staged Open records before pushing

        // ---------------- PUSH TO CRM ----------------
        ProcessStagingRecord(CRMHeaderStaging);
    end;

    // --------------------------------------------------------
    // PUBLIC: Push one staged header to CRM; on success, push its
    //         lines independently to the separate Lines API.
    // --------------------------------------------------------
    procedure ProcessStagingRecord(var CRMHeaderStaging: Record "CRM Sales Inv. Header Staging")
    var
        LogMgt: Codeunit "CRM Integration Log Mgt.";
        ErrMsg: Text;
        JsonPayload: Text;
        ResponseText: Text;
    begin
        LogMgt.WriteLog('SalesInvoice', 'Push', CRMHeaderStaging."No.", '', Enum::"CRM Integration Status"::Open, 'Processing started.', Database::"CRM Sales Inv. Header Staging", CRMHeaderStaging."Retry Count");

        // Step 1 — Validate mandatory header fields
        ErrMsg := ValidateHeaderMandatoryFields(CRMHeaderStaging);
        if ErrMsg <> '' then begin
            SetHeaderFailed(CRMHeaderStaging, ErrMsg);
            MarkLinesStatus(CRMHeaderStaging."No.", Enum::"CRM Integration Status"::Failed, ErrMsg);
            exit;
        end;

        // Step 2 — Build JSON (header only — lines go through their own API)
        JsonPayload := BuildInvoiceJson(CRMHeaderStaging);

        // Step 3 — Send header to CRM
        if not TrySendToCrm(JsonPayload, ResponseText, ErrMsg) then begin
            SetHeaderFailed(CRMHeaderStaging, ErrMsg);
            MarkLinesStatus(CRMHeaderStaging."No.", Enum::"CRM Integration Status"::Failed, ErrMsg);
            exit;
        end;

        // Step 4 — Mark header Success
        CRMHeaderStaging."Integration Status" := Enum::"CRM Integration Status"::Success;
        CRMHeaderStaging."CRM Invoice ID" := CopyStr(ResponseText, 1, 50);
        CRMHeaderStaging."Processed DateTime" := CurrentDateTime();
        CRMHeaderStaging."Error Message" := '';
        CRMHeaderStaging.Modify();
        LogMgt.WriteLog('SalesInvoice', 'Push', CRMHeaderStaging."No.", '', Enum::"CRM Integration Status"::Success, 'Sales invoice pushed successfully.', Database::"CRM Sales Inv. Header Staging", CRMHeaderStaging."Retry Count");

        // Step 5 — Push each line to the separate Lines API
        PushAllLinesAfterHeaderSuccess(CRMHeaderStaging."No.");
    end;

    // --------------------------------------------------------
    // PRIVATE: Push all lines to CRM after header push succeeds.
    //          Called after header is marked as Success and CRM ID
    //          is captured. Logs completion status.
    // --------------------------------------------------------
    local procedure PushAllLinesAfterHeaderSuccess(DocumentNo: Code[20])
    var
        LogMgt: Codeunit "CRM Integration Log Mgt.";
    begin
        LogMgt.WriteLog('SalesInvoice', 'PushLines', DocumentNo, '', Enum::"CRM Integration Status"::Open, 'Starting to push lines to CRM after header success.', Database::"CRM Sales Inv. Header Staging", 0);

        PushLinesForDocument(DocumentNo);

        LogMgt.WriteLog('SalesInvoice', 'PushLines', DocumentNo, '', Enum::"CRM Integration Status"::Success, 'All lines processed for document.', Database::"CRM Sales Inv. Header Staging", 0);
    end;

    // --------------------------------------------------------
    // PUBLIC: Batch process all Open invoice headers.
    // --------------------------------------------------------
    procedure ProcessAllOpen()
    var
        CRMHeaderStaging: Record "CRM Sales Inv. Header Staging";
        Processed: Integer;
        Failed: Integer;
    begin
        CRMHeaderStaging.SetRange("Integration Status", Enum::"CRM Integration Status"::Open);
        if not CRMHeaderStaging.FindSet(true) then begin
            Message('No open CRM Sales Invoice staging records to process.');
            exit;
        end;

        repeat
            if TryProcess(CRMHeaderStaging) then
                Processed += 1
            else
                Failed += 1;
        until CRMHeaderStaging.Next() = 0;

        Message('Sales Invoice staging batch complete.\nProcessed: %1  |  Failed: %2', Processed, Failed);
    end;

    [TryFunction]
    local procedure TryProcess(var CRMHeaderStaging: Record "CRM Sales Inv. Header Staging")
    begin
        ProcessStagingRecord(CRMHeaderStaging);
    end;

    // --------------------------------------------------------
    // PUBLIC: Push every Open line for a given Document No. to
    //         the Sales Invoice Lines API. Each line is pushed
    //         and marked independently so one bad line doesn't
    //         block the others.
    // --------------------------------------------------------
    // --------------------------------------------------------
    // PRIVATE: Validate mandatory header fields per mapping sheet.
    // --------------------------------------------------------
    local procedure ValidateHeaderMandatoryFields(Rec: Record "CRM Sales Inv. Header Staging"): Text
    var
        ErrBuilder: Text;
    begin
        if Rec."Sell-to Customer No." = '' then
            ErrBuilder += 'Sell-to Customer No. is mandatory. ';
        if Rec."Posting Date" = 0D then
            ErrBuilder += 'Posting Date is mandatory. ';
        if Rec."Tax Area Code" = '' then
            ErrBuilder += 'Tax Area Code is mandatory. ';
        exit(ErrBuilder);
    end;

    // --------------------------------------------------------
    // --------------------------------------------------------
    // PRIVATE: Mandatory-field check for a single line record.
    // --------------------------------------------------------
    local procedure ValidateLineMandatoryFields(Rec: Record "CRM Sales Inv. Line Staging"): Text
    var
        ErrBuilder: Text;
    begin
        if Rec."No." = '' then
            ErrBuilder += 'No. is mandatory. ';
        if Rec."Location Code" = '' then
            ErrBuilder += 'Location Code is mandatory. ';
        if Rec.Quantity = 0 then
            ErrBuilder += 'Quantity is mandatory. ';
        if Rec."Unit of Measure Code" = '' then
            ErrBuilder += 'Unit of Measure Code is mandatory. ';
        if Rec."Tax Area Code" = '' then
            ErrBuilder += 'Tax Area Code is mandatory. ';
        if Rec."Tax Group Code" = '' then
            ErrBuilder += 'Tax Group Code is mandatory. ';
        exit(ErrBuilder);
    end;


    local procedure GetDefaultPriceLevelBinding(): Text
    begin
        exit('/pricelevels(6472e80a-bfff-e211-acb5-00155d602128)');
    end;

    local procedure GetDefaultUomBinding(): Text
    begin
        exit('/uoms(b2f82e2d-98ab-46b5-9577-600f4567fcb7)');
    end;

    // --------------------------------------------------------
    // PRIVATE: Build JSON payload for the header only.
    // --------------------------------------------------------
    local procedure BuildInvoiceJson(Rec: Record "CRM Sales Inv. Header Staging"): Text
    var
        JHeader: JsonObject;
        JsonText: Text;
    begin
        JHeader.Add('name', Rec."No.");
        JHeader.Add('pricelevelid@odata.bind', GetDefaultPriceLevelBinding());
        JHeader.Add('invoicenumber', Rec."No.");

        if Rec."Shipment Date" <> 0D then
            JHeader.Add('datedelivered', Format(Rec."Shipment Date", 0, 9));
        JHeader.Add('duedate', Format(Rec."Due Date", 0, 9));
        if Rec."Posting Date" <> 0D then
            JHeader.Add('lastbackofficesubmit', Format(CreateDateTime(Rec."Posting Date", 103000T), 0, 9));

        JHeader.Add('billto_name', Rec."Bill-to Contact");
        JHeader.Add('billto_line1', Rec."Bill-to Address");
        JHeader.Add('billto_line2', Rec."Bill-to Address 2");
        JHeader.Add('billto_city', Rec."Bill-to City");
        JHeader.Add('billto_stateorprovince', Rec."Bill-to Country/Region Code");
        JHeader.Add('billto_postalcode', Rec."Bill-to Post Code");
        JHeader.Add('billto_country', Rec."Bill-to Country/Region Code");

        JHeader.Add('shipto_name', Rec."Ship-to Contact");
        JHeader.Add('shipto_line1', Rec."Ship-to Address");
        JHeader.Add('shipto_line2', Rec."Ship-to Address 2");
        JHeader.Add('shipto_city', Rec."Ship-to City");
        JHeader.Add('shipto_stateorprovince', Rec."Ship-to Country/Region Code");
        JHeader.Add('shipto_postalcode', Rec."Ship-to Post Code");
        JHeader.Add('shipto_country', Rec."Ship-to Country/Region Code");

        JHeader.Add('wf_billtonavcustomerno', Rec."Bill-to Customer No.");
        JHeader.Add('wf_selltonavcustomerno', Rec."Sell-to Customer No.");
        JHeader.Add('wf_shiptocode', Rec."Ship-to Code");
        JHeader.Add('wf_customerpo', Rec."Order No.");
        JHeader.Add('wf_extdocno', Rec."External Document No.");
        JHeader.Add('description', 'Created via Business Central Web API');

        JHeader.WriteTo(JsonText);
        exit(JsonText);
    end;


    // --------------------------------------------------------
    // PRIVATE: Build JSON for a single line using the CRM Invoice
    //          Line contract supplied for this integration.
    // --------------------------------------------------------
    local procedure BuildLineJson(Rec: Record "CRM Sales Inv. Line Staging"): Text
    var
        JLine: JsonObject;
        JsonText: Text;
        ProductNumber: Text;
    begin
        JLine.Add('invoiceid@odata.bind', StrSubstNo('/invoices(invoicenumber=''%1'')', Rec."Document No."));
        JLine.Add('description', Rec.Description);
        JLine.Add('ispriceoverridden', true);
        JLine.Add('lineitemnumber', Rec."Line No.");
        JLine.Add('priceperunit', Rec."Unit Price Excl. Tax");
        JLine.Add('quantity', Rec.Quantity);
        //JLine.Add('priceperunit', Rec."Unit Price Excl. Tax");
        JLine.Add('baseamount', Rec."Line Amount Excl. Tax");

        JLine.Add('extendedamount', Rec."Amount Including VAT");

        JLine.Add('manualdiscountamount', Rec."Line Discount Amount");

        // Line tax
        JLine.Add(
            'tax',
            Rec."Amount Including VAT" - Rec."Line Amount Excl. Tax");

        // Invoice total tax
        // JLine.Add(
        //     'totaltax',
        //     GetInvoiceTotalTax(Rec."Document No."));


        if Rec."Shipment Date" <> 0D then
            JLine.Add('wf_dateordered', Format(Rec."Shipment Date", 0, 9));

        JLine.Add('wf_unitcost', Rec."Unit Cost");
        JLine.Add('wf_vendorcrossreference', Rec."Vendor Cross Reference No.");
        JLine.Add('wf_vendornumber', Rec."Vendor No.");

        if (Rec.Type = Rec.Type::Item) and (Rec."No." <> '') then begin
            ProductNumber := Rec."No.";
            JLine.Add('productid@odata.bind', StrSubstNo('/products(productnumber=''%1'')', ProductNumber));
            JLine.Add('isproductoverridden', false);
            JLine.Add('uomid@odata.bind', GetDefaultUomBinding());
        end else begin
            JLine.Add('productdescription', Rec.Description);
            JLine.Add('isproductoverridden', true);
        end;

        JLine.WriteTo(JsonText);
        exit(JsonText);
    end;

    // local procedure GetInvoiceTotalTax(DocumentNo: Code[20]): Decimal
    // var
    //     LineStaging: Record "CRM Sales Inv. Line Staging";
    //     TotalTax: Decimal;
    // begin
    //     LineStaging.SetRange("Document No.", DocumentNo);

    //     if LineStaging.FindSet() then
    //         repeat
    //             TotalTax += LineStaging."Amount Including VAT" - LineStaging."Line Amount Excl. Tax";
    //         until LineStaging.Next() = 0;

    //     exit(TotalTax);
    // end;


    // --------------------------------------------------------
    // PRIVATE: Send one line's JSON to the Lines API. Same auth
    //          handling as TrySendToCrm, but reads
    //          "Invoice Lines API URL" instead of "Invoice API URL".
    // --------------------------------------------------------
    local procedure TrySendLineToCrm(JsonPayload: Text; var ResponseText: Text; var ErrMsg: Text): Boolean
    var
        CRMSetup: Record "CRM Integration Setup";
        HttpClient: HttpClient;
        HttpContent: HttpContent;
        ContentHeaders: HttpHeaders;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpHeaders: HttpHeaders;
        CRMEndpointUrl: Text;
        ClientTimeout: Duration;
        Base64Convert: Codeunit "Base64 Convert";
        OAuthClientMgt: Codeunit "CRM OAuth Client Mgt.";
        BasicCredential: Text;
        AccessToken: Text;
    begin
        if not CRMSetup.Get('DEFAULT') then begin
            ErrMsg := 'CRM Integration Setup not found. Open CRM Integration Setup and configure it first.';
            exit(false);
        end;

        CRMEndpointUrl := CRMSetup."Invoice Lines API URL";
        if CRMEndpointUrl = '' then begin
            ErrMsg := 'CRM Integration Setup: Invoice Lines API URL is required.';
            exit(false);
        end;

        if CRMSetup."Use HTTPS Only" and (CopyStr(LowerCase(CRMEndpointUrl), 1, 8) <> 'https://') then begin
            ErrMsg := 'CRM Integration Setup: Invoice Lines API URL must start with https:// when Use HTTPS Only is enabled.';
            exit(false);
        end;

        if CRMSetup."Request Timeout (ms)" > 0 then begin
            ClientTimeout := CRMSetup."Request Timeout (ms)";
            HttpClient.Timeout(ClientTimeout);
        end;

        HttpContent.WriteFrom(JsonPayload);
        HttpContent.GetHeaders(ContentHeaders);
        ContentHeaders.Clear();
        ContentHeaders.Add('Content-Type', 'application/json');
        ContentHeaders.Add('Prefer', 'return=representation');

        HttpRequestMessage.Method := 'POST';
        HttpRequestMessage.SetRequestUri(CRMEndpointUrl);
        HttpRequestMessage.Content := HttpContent;
        HttpRequestMessage.GetHeaders(HttpHeaders);

        case CRMSetup."Auth Type" of
            CRMSetup."Auth Type"::Bearer:
                begin
                    Clear(AccessToken);
                    if not OAuthClientMgt.GetBearerTokenFromClientCredentials(CRMSetup, AccessToken, ErrMsg) then
                        exit(false);
                    HttpHeaders.Add('Authorization', StrSubstNo('Bearer %1', AccessToken));
                end;
            CRMSetup."Auth Type"::Basic:
                begin
                    if (CRMSetup."Username" = '') or (CRMSetup."Password" = '') then begin
                        ErrMsg := 'CRM Integration Setup: Username and Password are required when Auth Type = Basic.';
                        exit(false);
                    end;
                    BasicCredential := Base64Convert.ToBase64(CRMSetup."Username" + ':' + CRMSetup."Password");
                    HttpHeaders.Add('Authorization', 'Basic ' + BasicCredential);
                end;
            CRMSetup."Auth Type"::OAuthClientCredentials:
                begin
                    if not OAuthClientMgt.GetBearerTokenFromClientCredentials(CRMSetup, AccessToken, ErrMsg) then
                        exit(false);
                    HttpHeaders.Add('Authorization', 'Bearer ' + AccessToken);
                end;
        end;

        if not HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then begin
            ErrMsg := 'HTTP request to CRM Lines API failed (network error).';
            exit(false);
        end;

        HttpResponseMessage.Content.ReadAs(ResponseText);

        if not HttpResponseMessage.IsSuccessStatusCode() then begin
            ErrMsg := StrSubstNo('CRM Lines API returned HTTP %1: %2', HttpResponseMessage.HttpStatusCode, ResponseText);
            exit(false);
        end;

        exit(true);
    end;

    // --------------------------------------------------------
    // PUBLIC: Push every Open line for a given Document No. to
    //         the Sales Invoice Lines API. Each line is pushed
    //         and marked independently so one bad line doesn't
    //         block the others.
    // --------------------------------------------------------
    procedure PushLinesForDocument(DocumentNo: Code[20])
    var
        CRMLineStaging: Record "CRM Sales Inv. Line Staging";
    begin
        CRMLineStaging.SetRange("Document No.", DocumentNo);
        CRMLineStaging.SetRange("Integration Status", Enum::"CRM Integration Status"::Open);
        if not CRMLineStaging.FindSet(true) then
            exit;

        repeat
            if not TryPushSingleLine(CRMLineStaging) then
                SetLineFailed(CRMLineStaging, GetLastErrorText());
        until CRMLineStaging.Next() = 0;
    end;

    [TryFunction]
    local procedure TryPushSingleLine(var CRMLineStaging: Record "CRM Sales Inv. Line Staging")
    begin
        PushSingleLine(CRMLineStaging);
    end;

    local procedure PushSingleLine(var CRMLineStaging: Record "CRM Sales Inv. Line Staging")
    var
        LogMgt: Codeunit "CRM Integration Log Mgt.";
        ErrMsg: Text;
        JsonPayload: Text;
        ResponseText: Text;
    begin
        LogMgt.WriteLog('SalesInvoiceLineExt', 'Push', CRMLineStaging."Document No.", Format(CRMLineStaging."Line No."),
            Enum::"CRM Integration Status"::Open, 'Processing started.', Database::"CRM Sales Inv. Line Staging", CRMLineStaging."Retry Count");

        ErrMsg := ValidateLineMandatoryFields(CRMLineStaging);
        if ErrMsg <> '' then begin
            SetLineFailed(CRMLineStaging, ErrMsg);
            exit;
        end;

        JsonPayload := BuildLineJson(CRMLineStaging);

        if not TrySendLineToCrm(JsonPayload, ResponseText, ErrMsg) then begin
            SetLineFailed(CRMLineStaging, ErrMsg);
            exit;
        end;

        CRMLineStaging."Integration Status" := Enum::"CRM Integration Status"::Success;
        CRMLineStaging."CRM Line ID" := CopyStr(ResponseText, 1, 50);
        CRMLineStaging."Processed DateTime" := CurrentDateTime();
        CRMLineStaging."Error Message" := '';
        CRMLineStaging.Modify();

        LogMgt.WriteLog('SalesInvoiceLineExt', 'Push', CRMLineStaging."Document No.", Format(CRMLineStaging."Line No."),
            Enum::"CRM Integration Status"::Success, 'Sales invoice line pushed successfully.', Database::"CRM Sales Inv. Line Staging", CRMLineStaging."Retry Count");
    end;

    // --------------------------------------------------------
    // PUBLIC: Batch-retry every Open line across all documents.
    //         Useful for retrying lines that failed without
    //         needing to re-push the header.
    // --------------------------------------------------------
    procedure ProcessAllOpenLines()
    var
        CRMLineStaging: Record "CRM Sales Inv. Line Staging";
        Processed: Integer;
        Failed: Integer;
    begin
        CRMLineStaging.SetRange("Integration Status", Enum::"CRM Integration Status"::Open);
        if not CRMLineStaging.FindSet(true) then begin
            Message('No open CRM Sales Invoice Line staging records to process.');
            exit;
        end;

        repeat
            if TryPushSingleLine(CRMLineStaging) then
                Processed += 1
            else begin
                SetLineFailed(CRMLineStaging, GetLastErrorText());
                Failed += 1;
            end;
        until CRMLineStaging.Next() = 0;

        Message('Sales Invoice Line staging batch complete.\nProcessed: %1  |  Failed: %2', Processed, Failed);
    end;


    // --------------------------------------------------------
    // PRIVATE: Send header JSON to CRM Invoice API.
    // --------------------------------------------------------
    local procedure TrySendToCrm(JsonPayload: Text; var ResponseText: Text; var ErrMsg: Text): Boolean
    var
        CRMSetup: Record "CRM Integration Setup";
        HttpClient: HttpClient;
        HttpContent: HttpContent;
        ContentHeaders: HttpHeaders;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpHeaders: HttpHeaders;
        CRMEndpointUrl: Text;
        ClientTimeout: Duration;
        Base64Convert: Codeunit "Base64 Convert";
        OAuthClientMgt: Codeunit "CRM OAuth Client Mgt.";
        BasicCredential: Text;
        AccessToken: Text;
    begin
        if not CRMSetup.Get('DEFAULT') then begin
            ErrMsg := 'CRM Integration Setup not found. Open CRM Integration Setup and configure it first.';
            exit(false);
        end;

        CRMEndpointUrl := CRMSetup."Invoice API URL";
        if CRMEndpointUrl = '' then begin
            ErrMsg := 'CRM Integration Setup: Invoice API URL is required.';
            exit(false);
        end;

        if CRMSetup."Use HTTPS Only" and (CopyStr(LowerCase(CRMEndpointUrl), 1, 8) <> 'https://') then begin
            ErrMsg := 'CRM Integration Setup: Invoice API URL must start with https:// when Use HTTPS Only is enabled.';
            exit(false);
        end;

        if CRMSetup."Request Timeout (ms)" > 0 then begin
            ClientTimeout := CRMSetup."Request Timeout (ms)";
            HttpClient.Timeout(ClientTimeout);
        end;

        HttpContent.WriteFrom(JsonPayload);
        HttpContent.GetHeaders(ContentHeaders);
        ContentHeaders.Clear();
        ContentHeaders.Add('Content-Type', 'application/json');
        ContentHeaders.Add('Prefer', 'return=representation');

        HttpRequestMessage.Method := 'POST';
        HttpRequestMessage.SetRequestUri(CRMEndpointUrl);
        HttpRequestMessage.Content := HttpContent;
        HttpRequestMessage.GetHeaders(HttpHeaders);
        case CRMSetup."Auth Type" of
            CRMSetup."Auth Type"::Bearer:
                begin
                    Clear(AccessToken);
                    if not OAuthClientMgt.GetBearerTokenFromClientCredentials(CRMSetup, AccessToken, ErrMsg) then
                        exit(false);
                    HttpHeaders.Add('Authorization', StrSubstNo('Bearer %1', AccessToken));
                end;
            CRMSetup."Auth Type"::Basic:
                begin
                    if (CRMSetup."Username" = '') or (CRMSetup."Password" = '') then begin
                        ErrMsg := 'CRM Integration Setup: Username and Password are required when Auth Type = Basic.';
                        exit(false);
                    end;
                    BasicCredential := Base64Convert.ToBase64(CRMSetup."Username" + ':' + CRMSetup."Password");
                    HttpHeaders.Add('Authorization', 'Basic ' + BasicCredential);
                end;
            CRMSetup."Auth Type"::OAuthClientCredentials:
                begin
                    if not OAuthClientMgt.GetBearerTokenFromClientCredentials(CRMSetup, AccessToken, ErrMsg) then
                        exit(false);
                    HttpHeaders.Add('Authorization', 'Bearer ' + AccessToken);
                end;
        end;

        if not HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then begin
            ErrMsg := 'HTTP request to CRM failed (network error).';
            exit(false);
        end;

        HttpResponseMessage.Content.ReadAs(ResponseText);

        if not HttpResponseMessage.IsSuccessStatusCode() then begin
            ErrMsg := StrSubstNo('CRM returned HTTP %1: %2', HttpResponseMessage.HttpStatusCode, ResponseText);
            exit(false);
        end;

        exit(true);
    end;

    // --------------------------------------------------------
    // PRIVATE: Send one line's JSON to the Lines API. Same auth
    //          handling as TrySendToCrm, but reads
    //          "Invoice Lines API URL" instead of "Invoice API URL".
    // --------------------------------------------------------


    // --------------------------------------------------------
    // PRIVATE: Mark header Failed.
    // --------------------------------------------------------
    local procedure SetHeaderFailed(var Rec: Record "CRM Sales Inv. Header Staging"; ErrMsg: Text)
    var
        LogMgt: Codeunit "CRM Integration Log Mgt.";
    begin
        Rec."Integration Status" := Enum::"CRM Integration Status"::Failed;
        Rec."Error Message" := CopyStr(ErrMsg, 1, 250);
        Rec."Retry Count" += 1;
        Rec."Processed DateTime" := CurrentDateTime();
        Rec.Modify();
        LogMgt.WriteLog('SalesInvoice', 'Push', Rec."No.", '', Enum::"CRM Integration Status"::Failed, ErrMsg, Database::"CRM Sales Inv. Header Staging", Rec."Retry Count");
    end;

    // --------------------------------------------------------
    // PRIVATE: Mark a single line Failed.
    // --------------------------------------------------------
    local procedure SetLineFailed(var Rec: Record "CRM Sales Inv. Line Staging"; ErrMsg: Text)
    var
        LogMgt: Codeunit "CRM Integration Log Mgt.";
    begin
        Rec."Integration Status" := Enum::"CRM Integration Status"::Failed;
        Rec."Error Message" := CopyStr(ErrMsg, 1, 250);
        Rec."Retry Count" += 1;
        Rec."Processed DateTime" := CurrentDateTime();
        Rec.Modify();

        LogMgt.WriteLog('SalesInvoiceLineExt', 'Push', Rec."Document No.", Format(Rec."Line No."),
            Enum::"CRM Integration Status"::Failed, ErrMsg, Database::"CRM Sales Inv. Line Staging", Rec."Retry Count");
    end;

    // --------------------------------------------------------
    // PRIVATE: Bulk-update status on all lines for a Document No.
    //          Used only on header-failure propagation, since a
    //          failed header means the lines can't be pushed
    //          either — there is no point calling the Lines API.
    // --------------------------------------------------------
    local procedure MarkLinesStatus(DocumentNo: Code[20]; Status: Enum "CRM Integration Status"; ErrMsg: Text)
    var
        CRMLineStaging: Record "CRM Sales Inv. Line Staging";
        LogMgt: Codeunit "CRM Integration Log Mgt.";
    begin
        CRMLineStaging.SetRange("Document No.", DocumentNo);
        if CRMLineStaging.FindSet(true) then
            repeat
                CRMLineStaging."Integration Status" := Status;
                CRMLineStaging."Error Message" := CopyStr(ErrMsg, 1, 250);
                CRMLineStaging."Processed DateTime" := CurrentDateTime();
                CRMLineStaging.Modify();
                LogMgt.WriteLog('SalesInvoiceLineExt', 'Push', CRMLineStaging."Document No.", Format(CRMLineStaging."Line No."), Status, ErrMsg, Database::"CRM Sales Inv. Line Staging", 0);
            until CRMLineStaging.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterInsertInvoiceHeader', '', false, false)]
    local procedure OnAfterInsertInvoiceHeader(SalesHeader: Record "Sales Header"; var SalesInvHeader: Record "Sales Invoice Header")
    var
        LogMgt: Codeunit "CRM Integration Log Mgt.";
    begin
        // if SalesInvHeader."No." = '' then
        //     exit;

        // LogMgt.WriteLog('SalesInvoice', 'PostingComplete', SalesInvHeader."No.", '', Enum::"CRM Integration Status"::Open, 'Invoice posted successfully. Starting CRM integration.', Database::"CRM Sales Inv. Header Staging", 0);

        // if not TryStageAndPushPostedInvoice(SalesInvHeader) then
        //     LogAutoPushFailure(SalesInvHeader."No.", GetLastErrorText());
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', false, false)]
    local procedure OnAfterInsertInvoiceHeaders(CommitIsSuppressed: Boolean; SalesHeader: Record "Sales Header"; SalesInvHdrNo: Code[20]; InvtPickPutaway: Boolean; PreviewMode: Boolean; RetRcpHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; SalesShptHdrNo: Code[20]; var CustLedgerEntry: Record "Cust. Ledger Entry"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; WhseReceiv: Boolean; WhseShip: Boolean)
    var
        LogMgt: Codeunit "CRM Integration Log Mgt.";
        SalesInvHeader: Record "Sales Invoice Header";
    begin
        if SalesInvHdrNo = '' then
            exit;

        LogMgt.WriteLog('SalesInvoice', 'Po', SalesInvHdrNo, '', Enum::"CRM Integration Status"::Open, 'Invoice posted successfully. Starting CRM integration.', Database::"CRM Sales Inv. Header Staging", 0);
        if not SalesInvHeader.Get(SalesInvHdrNo) then
            exit;
        if not TryStageAndPushPostedInvoice(SalesInvHeader) then
            LogAutoPushFailure(SalesInvHeader."No.", GetLastErrorText());
    end;


    [TryFunction]
    local procedure TryStageAndPushPostedInvoice(var SalesInvHeader: Record "Sales Invoice Header")
    var
        CRMSalesInvIntMgt: Codeunit "CRM Sales Inv. Int. Mgt.";
    begin
        CRMSalesInvIntMgt.StageAndPushInvoice(SalesInvHeader);
    end;

    local procedure LogAutoPushFailure(InvoiceNo: Code[20]; ErrMsg: Text)
    var
        LogMgt: Codeunit "CRM Integration Log Mgt.";
    begin
        if ErrMsg = '' then
            ErrMsg := 'Automatic post-invoice CRM push failed with an unknown error.';

        LogMgt.WriteLog('SalesInvoice', 'Push', InvoiceNo, '', Enum::"CRM Integration Status"::Failed, CopyStr(ErrMsg, 1, 250), Database::"CRM Sales Inv. Header Staging", 0);
    end;
}
