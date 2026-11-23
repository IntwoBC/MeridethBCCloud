// ============================================================
// Codeunit: CRM Item Int. Mgt.
// Object ID  : 50102
// Publisher  : Intwo
// Direction  : PUSH — BC Item (Table 27) → CRM Item Staging
//              → CRM via outbound API call.
// Source Map : BC-CRM_Integration_Field_Mapping
//              _Item_Master_Push_from_BC.xlsx (27-ITEM)
//
// Processing logic:
//   1. Read BC Item record(s).
//   2. Stage into CRM Item Staging (insert/update).
//   3. Build JSON payload matching CRM contract.
//   4. POST to CRM API endpoint (HttpClient).
//   5. Update staging status based on CRM response.
//
// NOTE: The actual CRM endpoint URL / auth must be supplied via
//       the "CRM Integration Setup" table (see Setup codeunit).
//       This codeunit calls a stub HTTP send that should be
//       wired to your CRM's real REST endpoint and auth scheme.
// ============================================================
codeunit 50102 "CRM Item Int. Mgt."
{
    TableNo = Item;

    trigger OnRun()
    begin
        // Called by Job Queue per Item record (with filters), or
        // manually via StageAndPushItem.
        StageAndPushItem(Rec);
    end;

    // --------------------------------------------------------
    // PUBLIC: Stage a single BC Item and push it to CRM.
    // --------------------------------------------------------
    procedure StageAndPushItem(var Item: Record Item)
    var
        CRMItemStaging: Record "CRM Item Staging";
        IsNew: Boolean;
    begin
        // Step 1 — Upsert staging record from BC Item
        IsNew := not CRMItemStaging.Get(Item."No.");
        if IsNew then begin
            CRMItemStaging.Init();
            CRMItemStaging."No." := Item."No.";
            CRMItemStaging."Created DateTime" := CurrentDateTime();
        end;

        // Map BC Item fields → staging (exact field mapping from sheet)
        CRMItemStaging.Description := CopyStr(Item.Description, 1, 100);
        CRMItemStaging."Item Category Code" := Item."Item Category Code";
        CRMItemStaging."Unit Cost" := Item."Unit Cost";
        CRMItemStaging."Base Unit of Measure" := Item."Base Unit of Measure";
        CRMItemStaging."Integration Status" := Enum::"CRM Integration Status"::Open;
        CRMItemStaging."Latest Method" := 'POST';
        CRMItemStaging."Error Message" := '';

        if IsNew then
            CRMItemStaging.Insert(true)
        else
            CRMItemStaging.Modify(true);

        Commit(); // Persist Open status before attempting push

        // Step 2 — Push to CRM
        ProcessStagingRecord(CRMItemStaging);
    end;

    // --------------------------------------------------------
    // PUBLIC: Push a single staged Item record to CRM.
    // --------------------------------------------------------
    procedure ProcessStagingRecord(var CRMItemStaging: Record "CRM Item Staging")
    var
        LogMgt: Codeunit "CRM Integration Log Mgt.";
        JsonPayload: Text;
        ResponseText: Text;
        Success: Boolean;
        ErrMsg: Text;
    begin
        LogMgt.WriteLog('Item', 'Push', CRMItemStaging."No.", '', Enum::"CRM Integration Status"::Open, 'Processing started.', Database::"CRM Item Staging", CRMItemStaging."Retry Count");

        // Step 1 — Validate mandatory fields
        if CRMItemStaging."No." = '' then begin
            SetFailed(CRMItemStaging, 'No. is mandatory.');
            exit;
        end;

        // Step 2 — Build JSON payload
        JsonPayload := BuildItemJson(CRMItemStaging);

        // Step 3 — Send to CRM (wire to real endpoint in TrySendToCrm)
        Success := TrySendToCrm(JsonPayload, ResponseText, ErrMsg);

        if not Success then begin
            SetFailed(CRMItemStaging, ErrMsg);
            exit;
        end;

        // Step 4 — Mark Success, store CRM-returned record ID if present
        CRMItemStaging."Integration Status" := Enum::"CRM Integration Status"::Success;
        CRMItemStaging."CRM Record ID" := CopyStr(ResponseText, 1, 50);
        CRMItemStaging."Processed DateTime" := CurrentDateTime();
        CRMItemStaging."Error Message" := '';
        CRMItemStaging.Modify();
        LogMgt.WriteLog('Item', 'Push', CRMItemStaging."No.", '', Enum::"CRM Integration Status"::Success, 'Item pushed successfully.', Database::"CRM Item Staging", CRMItemStaging."Retry Count");
    end;

    procedure UpdateItemToCrm(var Item: Record Item)
    var
        CRMItemStaging: Record "CRM Item Staging";
        LogMgt: Codeunit "CRM Integration Log Mgt.";
        JsonPayload: Text;
        ResponseText: Text;
        Success: Boolean;
        ErrMsg: Text;
        IsNew: Boolean;
    begin
        if Item."No." = '' then
            Error('Item No. is mandatory.');

        IsNew := not CRMItemStaging.Get(Item."No.");
        if IsNew then begin
            CRMItemStaging.Init();
            CRMItemStaging."No." := Item."No.";
            CRMItemStaging."Created DateTime" := CurrentDateTime();
        end;

        CRMItemStaging.Description := CopyStr(Item.Description, 1, 100);
        CRMItemStaging."Item Category Code" := Item."Item Category Code";
        CRMItemStaging."Unit Cost" := Item."Unit Cost";
        CRMItemStaging."Base Unit of Measure" := Item."Base Unit of Measure";
        CRMItemStaging."Integration Status" := Enum::"CRM Integration Status"::Open;
        CRMItemStaging."Latest Method" := 'PATCH';
        CRMItemStaging."Error Message" := '';

        if IsNew then
            CRMItemStaging.Insert(true)
        else
            CRMItemStaging.Modify(true);

        LogMgt.WriteLog('Item', 'Patch', CRMItemStaging."No.", '', Enum::"CRM Integration Status"::Open, 'Processing started.', Database::"CRM Item Staging", CRMItemStaging."Retry Count");

        Commit();

        JsonPayload := BuildUpdateItemJson(CRMItemStaging);

        Success := TryPatchToCrm(JsonPayload, ResponseText, ErrMsg, CRMItemStaging);
        if not Success then begin
            CRMItemStaging."Integration Status" := Enum::"CRM Integration Status"::Failed;
            CRMItemStaging."Error Message" := CopyStr(ErrMsg, 1, 250);
            CRMItemStaging."Retry Count" += 1;
            CRMItemStaging."Processed DateTime" := CurrentDateTime();
            CRMItemStaging.Modify();
            LogMgt.WriteLog('Item', 'Patch', CRMItemStaging."No.", '', Enum::"CRM Integration Status"::Failed, ErrMsg, Database::"CRM Item Staging", CRMItemStaging."Retry Count");
            Error(ErrMsg);
        end;

        CRMItemStaging."Integration Status" := Enum::"CRM Integration Status"::Success;
        if ResponseText <> '' then
            CRMItemStaging."CRM Record ID" := CopyStr(ResponseText, 1, 50);
        CRMItemStaging."Processed DateTime" := CurrentDateTime();
        CRMItemStaging."Error Message" := '';
        CRMItemStaging.Modify();
        LogMgt.WriteLog('Item', 'Patch', CRMItemStaging."No.", '', Enum::"CRM Integration Status"::Success, 'Item updated successfully via PATCH.', Database::"CRM Item Staging", CRMItemStaging."Retry Count");
    end;

    procedure DeleteItemFromCrm(var Item: Record Item)
    var
        CRMItemStaging: Record "CRM Item Staging";
        LogMgt: Codeunit "CRM Integration Log Mgt.";
        ResponseText: Text;
        Success: Boolean;
        ErrMsg: Text;
        IsNew: Boolean;
    begin
        if Item."No." = '' then
            Error('Item No. is mandatory.');

        IsNew := not CRMItemStaging.Get(Item."No.");
        if IsNew then begin
            CRMItemStaging.Init();
            CRMItemStaging."No." := Item."No.";
            CRMItemStaging."Created DateTime" := CurrentDateTime();
        end;

        CRMItemStaging.Description := CopyStr(Item.Description, 1, 100);
        CRMItemStaging."Item Category Code" := Item."Item Category Code";
        CRMItemStaging."Unit Cost" := Item."Unit Cost";
        CRMItemStaging."Base Unit of Measure" := Item."Base Unit of Measure";
        CRMItemStaging."Integration Status" := Enum::"CRM Integration Status"::Open;
        CRMItemStaging."Latest Method" := 'DELETE';
        CRMItemStaging."Error Message" := '';

        if IsNew then
            CRMItemStaging.Insert(true)
        else
            CRMItemStaging.Modify(true);

        LogMgt.WriteLog('Item', 'Delete', CRMItemStaging."No.", '', Enum::"CRM Integration Status"::Open, 'Processing started.', Database::"CRM Item Staging", CRMItemStaging."Retry Count");
        Commit();

        Success := TryDeleteToCrm(ResponseText, ErrMsg, CRMItemStaging);
        if not Success then begin
            CRMItemStaging."Integration Status" := Enum::"CRM Integration Status"::Failed;
            CRMItemStaging."Error Message" := CopyStr(ErrMsg, 1, 250);
            CRMItemStaging."Retry Count" += 1;
            CRMItemStaging."Processed DateTime" := CurrentDateTime();
            CRMItemStaging.Modify();
            LogMgt.WriteLog('Item', 'Delete', CRMItemStaging."No.", '', Enum::"CRM Integration Status"::Failed, ErrMsg, Database::"CRM Item Staging", CRMItemStaging."Retry Count");
            Error(ErrMsg);
        end;

        CRMItemStaging."Integration Status" := Enum::"CRM Integration Status"::Success;
        CRMItemStaging."Processed DateTime" := CurrentDateTime();
        CRMItemStaging."Error Message" := '';
        CRMItemStaging.Modify();
        LogMgt.WriteLog('Item', 'Delete', CRMItemStaging."No.", '', Enum::"CRM Integration Status"::Success, 'Item deleted successfully via DELETE.', Database::"CRM Item Staging", CRMItemStaging."Retry Count");
    end;

    // --------------------------------------------------------
    // PUBLIC: Batch push all Open Item staging records.
    // --------------------------------------------------------
    procedure ProcessAllOpen()
    var
        CRMItemStaging: Record "CRM Item Staging";
        Processed: Integer;
        Failed: Integer;
    begin
        CRMItemStaging.SetRange("Integration Status", Enum::"CRM Integration Status"::Open);
        if not CRMItemStaging.FindSet(true) then begin
            Message('No open CRM Item staging records to process.');
            exit;
        end;

        repeat
            if TryProcess(CRMItemStaging) then
                Processed += 1
            else
                Failed += 1;
        until CRMItemStaging.Next() = 0;

        Message('Item staging batch complete.\nProcessed: %1  |  Failed: %2', Processed, Failed);
    end;

    [TryFunction]
    local procedure TryProcess(var CRMItemStaging: Record "CRM Item Staging")
    begin
        ProcessStagingRecord(CRMItemStaging);
    end;

    // --------------------------------------------------------
    // PRIVATE: Build the outbound JSON payload for CRM.
    //          Field names use camelCase per typical REST contract;
    //          adjust to match your CRM's actual schema.
    // --------------------------------------------------------
    local procedure BuildItemJson(CRMItemStaging: Record "CRM Item Staging"): Text
    var
        JObject: JsonObject;
        JsonText: Text;
    begin

        JObject.Add('productnumber', CRMItemStaging."No.");
        JObject.Add('description', CRMItemStaging.Description);
        JObject.Add('wf_itemcategory', CRMItemStaging."Item Category Code");
        JObject.Add('standardcost', CRMItemStaging."Unit Cost");
        //    JObject.Add('price', CRMItemStaging."Unit Cost" * 1.33);
        //   JObject.Add('wf_productgroup', 'Sample'); // Example; adjust as needed     
        // JObject.Add('wf_itemcategory', CRMItemStaging."Item Category Code");

        JObject.Add('defaultuomid@odata.bind', '/uoms(b2f82e2d-98ab-46b5-9577-600f4567fcb7)');
        JObject.Add('defaultuomscheduleid@odata.bind', '/uomschedules(7a222c89-e501-4949-a7bb-99ce64f9b6a6)');
        // Example markup; adjust as needed
        JObject.WriteTo(JsonText);
        exit(JsonText);
    end;

    local procedure BuildUpdateItemJson(CRMItemStaging: Record "CRM Item Staging"): Text
    var
        JObject: JsonObject;
        JsonText: Text;
    begin
        JObject.Add('description', CRMItemStaging.Description);
        // JObject.Add('price', CRMItemStaging."Unit Cost");
        JObject.Add('name', CRMItemStaging.Description);
        JObject.Add('standardcost', CRMItemStaging."Unit Cost");
        JObject.Add('wf_productgroup', 'Sample');
        JObject.Add('wf_itemcategory', CRMItemStaging."Item Category Code");
        JObject.WriteTo(JsonText);
        exit(JsonText);
    end;

    local procedure GetPatchItemEndpointUrl(CRMEndpointUrl: Text; CRMItemStaging: Record "CRM Item Staging"): Text
    var
        QuestionMarkPos: Integer;
    begin
        QuestionMarkPos := StrPos(CRMEndpointUrl, '?');
        if QuestionMarkPos > 0 then
            CRMEndpointUrl := CopyStr(CRMEndpointUrl, 1, QuestionMarkPos - 1);

        CRMEndpointUrl := CRMEndpointUrl + '(productnumber=''' + CRMItemStaging."No." + ''')';
        exit(CRMEndpointUrl);
    end;

    local procedure TryPatchToCrm(JsonPayload: Text; var ResponseText: Text; var ErrMsg: Text; var CRMItemStaging: Record "CRM Item Staging"): Boolean
    var
        CRMSetup: Record "CRM Integration Setup";
        HttpClient: HttpClient;
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        ContentHeaders: HttpHeaders;
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

        CRMEndpointUrl := CRMSetup."Item API URL";
        if CRMEndpointUrl = '' then begin
            ErrMsg := 'CRM Integration Setup: Item API URL is required.';
            exit(false);
        end;

        if CRMSetup."Use HTTPS Only" and (CopyStr(LowerCase(CRMEndpointUrl), 1, 8) <> 'https://') then begin
            ErrMsg := 'CRM Integration Setup: Item API URL must start with https:// when Use HTTPS Only is enabled.';
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

        HttpRequestMessage.Method := 'PATCH';
        HttpRequestMessage.SetRequestUri(GetPatchItemEndpointUrl(CRMEndpointUrl, CRMItemStaging));
        HttpRequestMessage.Content := HttpContent;

        HttpRequestMessage.GetHeaders(HttpHeaders);
        case CRMSetup."Auth Type" of
            CRMSetup."Auth Type"::Bearer:
                begin
                    Clear(AccessToken);

                    if not OAuthClientMgt.GetBearerTokenFromClientCredentials(CRMSetup, AccessToken, ErrMsg) then
                        exit(false);

                    HttpHeaders.Add('Authorization', StrSubstNo('Bearer %1', AccessToken));
                    if CRMSetup."Auth Token" = '' then begin
                        ErrMsg := 'CRM Integration Setup: Auth Token is required when Auth Type = Bearer.';
                        exit(false);
                    end;
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

    local procedure GetDeleteItemEndpointUrl(CRMEndpointUrl: Text; CRMItemStaging: Record "CRM Item Staging"): Text
    var
        QuestionMarkPos: Integer;
    begin
        QuestionMarkPos := StrPos(CRMEndpointUrl, '?');
        if QuestionMarkPos > 0 then
            CRMEndpointUrl := CopyStr(CRMEndpointUrl, 1, QuestionMarkPos - 1);

        CRMEndpointUrl := CRMEndpointUrl + '(productnumber=''' + CRMItemStaging."No." + ''')';
        exit(CRMEndpointUrl);
    end;

    local procedure TryDeleteToCrm(var ResponseText: Text; var ErrMsg: Text; var CRMItemStaging: Record "CRM Item Staging"): Boolean
    var
        CRMSetup: Record "CRM Integration Setup";
        HttpClient: HttpClient;
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        ContentHeaders: HttpHeaders;
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

        CRMEndpointUrl := CRMSetup."Item API URL";
        if CRMEndpointUrl = '' then begin
            ErrMsg := 'CRM Integration Setup: Item API URL is required.';
            exit(false);
        end;

        if CRMSetup."Use HTTPS Only" and (CopyStr(LowerCase(CRMEndpointUrl), 1, 8) <> 'https://') then begin
            ErrMsg := 'CRM Integration Setup: Item API URL must start with https:// when Use HTTPS Only is enabled.';
            exit(false);
        end;

        if CRMSetup."Request Timeout (ms)" > 0 then begin
            ClientTimeout := CRMSetup."Request Timeout (ms)";
            HttpClient.Timeout(ClientTimeout);
        end;

        HttpRequestMessage.Method := 'DELETE';
        HttpRequestMessage.SetRequestUri(GetDeleteItemEndpointUrl(CRMEndpointUrl, CRMItemStaging));

        HttpRequestMessage.GetHeaders(HttpHeaders);
        case CRMSetup."Auth Type" of
            CRMSetup."Auth Type"::Bearer:
                begin
                    Clear(AccessToken);

                    if not OAuthClientMgt.GetBearerTokenFromClientCredentials(CRMSetup, AccessToken, ErrMsg) then
                        exit(false);

                    HttpHeaders.Add('Authorization', StrSubstNo('Bearer %1', AccessToken));
                    if CRMSetup."Auth Token" = '' then begin
                        ErrMsg := 'CRM Integration Setup: Auth Token is required when Auth Type = Bearer.';
                        exit(false);
                    end;
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
    // PRIVATE: Send JSON to CRM REST endpoint via HttpClient.
    //          Returns true/false; sets ResponseText or ErrMsg.
    //
    //          IMPORTANT: Replace the placeholder URL and auth
    //          header below with your CRM's real values, ideally
    //          read from a "CRM Integration Setup" config table
    //          rather than hardcoded.
    // --------------------------------------------------------
    local procedure TrySendToCrm(JsonPayload: Text; var ResponseText: Text; var ErrMsg: Text): Boolean
    var
        CRMSetup: Record "CRM Integration Setup";
        HttpClient: HttpClient;
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        ContentHeaders: HttpHeaders;
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

        CRMEndpointUrl := CRMSetup."Item API URL";
        if CRMEndpointUrl = '' then begin
            ErrMsg := 'CRM Integration Setup: Item API URL is required.';
            exit(false);
        end;

        if CRMSetup."Use HTTPS Only" and (CopyStr(LowerCase(CRMEndpointUrl), 1, 8) <> 'https://') then begin
            ErrMsg := 'CRM Integration Setup: Item API URL must start with https:// when Use HTTPS Only is enabled.';
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
                    if CRMSetup."Auth Token" = '' then begin
                        ErrMsg := 'CRM Integration Setup: Auth Token is required when Auth Type = Bearer.';
                        exit(false);
                    end;
                    //     HttpHeaders.Add('Authorization', StrSubstNo('Bearer %1', AccessToken));
                    //   HttpHeaders.Add('Authorization', 'Bearer ' + CRMSetup."Auth Token");
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

    local procedure SetFailed(var CRMItemStaging: Record "CRM Item Staging"; ErrMsg: Text)
    var
        LogMgt: Codeunit "CRM Integration Log Mgt.";
    begin
        CRMItemStaging."Integration Status" := Enum::"CRM Integration Status"::Failed;
        CRMItemStaging."Error Message" := CopyStr(ErrMsg, 1, 250);
        CRMItemStaging."Retry Count" += 1;
        CRMItemStaging."Processed DateTime" := CurrentDateTime();
        CRMItemStaging.Modify();
        LogMgt.WriteLog('Item', 'Push', CRMItemStaging."No.", '', Enum::"CRM Integration Status"::Failed, ErrMsg, Database::"CRM Item Staging", CRMItemStaging."Retry Count");
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterItemInsert(var Rec: Record Item; RunTrigger: Boolean)
    begin
        if Rec."No." = '' then
            exit;
        if RunTrigger = true then begin //for invoice 
            if not TryAutoStageAndPushItem(Rec) then
                LogAutoPushFailure(Rec."No.", GetLastErrorText());
        end;
        // if not TryAutoStageAndPushItem(Rec) then
        //     LogAutoPushFailure(Rec."No.", GetLastErrorText());
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterItemModify(var Rec: Record Item; var xRec: Record Item; RunTrigger: Boolean)
    begin
        if Rec."No." = '' then
            exit;
        if RunTrigger = true then begin  //for invoice
            if not TryAutoUpdateOrPushItem(Rec) then
                LogAutoPushFailure(Rec."No.", GetLastErrorText());
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnAfterItemDelete(var Rec: Record Item; RunTrigger: Boolean)
    begin
        if Rec."No." = '' then
            exit;

        if not TryAutoDeleteItem(Rec) then
            LogAutoPushFailure(Rec."No.", GetLastErrorText());
    end;

    [TryFunction]
    local procedure TryAutoStageAndPushItem(var Item: Record Item)
    var
        CRMItemIntMgt: Codeunit "CRM Item Int. Mgt.";
    begin
        CRMItemIntMgt.StageAndPushItem(Item);
    end;

    [TryFunction]
    local procedure TryAutoUpdateOrPushItem(var Item: Record Item)
    var
        CRMItemStaging: Record "CRM Item Staging";
        CRMItemIntMgt: Codeunit "CRM Item Int. Mgt.";
    begin
        //  if CRMItemStaging.Get(Item."No.") and (CRMItemStaging."CRM Record ID" <> '') then
        if CRMItemStaging.Get(Item."No.") and (CRMItemStaging."Integration Status" = Enum::"CRM Integration Status"::Success) then
            CRMItemIntMgt.UpdateItemToCrm(Item)
        else
            CRMItemIntMgt.StageAndPushItem(Item);
    end;

    [TryFunction]
    local procedure TryAutoDeleteItem(var Item: Record Item)
    var
        CRMItemStaging: Record "CRM Item Staging";
        CRMItemIntMgt: Codeunit "CRM Item Int. Mgt.";
    begin
        //  if CRMItemStaging.Get(Item."No.") and (CRMItemStaging."CRM Record ID" <> '') then
        if CRMItemStaging.Get(Item."No.") and (CRMItemStaging."Integration Status" = Enum::"CRM Integration Status"::Success) then
            CRMItemIntMgt.DeleteItemFromCrm(Item);
    end;

    local procedure LogAutoPushFailure(ItemNo: Code[20]; ErrMsg: Text)
    var
        LogMgt: Codeunit "CRM Integration Log Mgt.";
    begin
        if ErrMsg = '' then
            ErrMsg := 'Automatic item CRM push failed with an unknown error.';

        LogMgt.WriteLog('Item', 'Push', ItemNo, '', Enum::"CRM Integration Status"::Failed, CopyStr(ErrMsg, 1, 250), Database::"CRM Item Staging", 0);
    end;
}
