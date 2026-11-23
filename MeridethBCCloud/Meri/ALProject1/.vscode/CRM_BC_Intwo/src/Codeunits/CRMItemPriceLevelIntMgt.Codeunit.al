// ============================================================
// Codeunit: CRM Item Price Level Int. Mgt.
// Object ID  : 50107
// Publisher  : Intwo
// Direction  : PUSH — CRM product price level insert.
// ============================================================
codeunit 50107 "CRM Item Price Level Int. Mgt."
{
    TableNo = "CRM Item Price Level Staging";

    procedure StageAndPushItemPriceLevel(var CRMPriceLevelStaging: Record "CRM Item Price Level Staging")
    var
        IsNew: Boolean;
    begin
        IsNew := not CRMPriceLevelStaging.Get(CRMPriceLevelStaging."Item No.", CRMPriceLevelStaging."Price Level Code");
        if IsNew then begin
            CRMPriceLevelStaging.Init();
            CRMPriceLevelStaging."Created DateTime" := CurrentDateTime();
        end;

        CRMPriceLevelStaging."Integration Status" := Enum::"CRM Integration Status"::Open;
        CRMPriceLevelStaging."Latest Method" := 'POST';
        CRMPriceLevelStaging."Error Message" := '';

        if IsNew then
            CRMPriceLevelStaging.Insert(true)
        else
            CRMPriceLevelStaging.Modify(true);

        Commit();
        ProcessStagingRecord(CRMPriceLevelStaging);
    end;

    procedure ProcessStagingRecord(var CRMPriceLevelStaging: Record "CRM Item Price Level Staging")
    var
        LogMgt: Codeunit "CRM Integration Log Mgt.";
        JsonPayload: Text;
        ResponseText: Text;
        ErrMsg: Text;
    begin
        LogMgt.WriteLog(
            'PriceLevel', 'Push', CRMPriceLevelStaging."Item No.",
            CRMPriceLevelStaging."Price Level Code",
            Enum::"CRM Integration Status"::Open,
            'Processing price level insert.',
            Database::"CRM Item Price Level Staging",
            CRMPriceLevelStaging."Retry Count");

        if CRMPriceLevelStaging."Item No." = '' then begin
            SetFailed(CRMPriceLevelStaging, 'Item No. is mandatory.');
            exit;
        end;

        JsonPayload := BuildPriceLevelJson(CRMPriceLevelStaging);

        if not TrySendPriceLevelToCrm(JsonPayload, ResponseText, ErrMsg) then begin
            SetFailed(CRMPriceLevelStaging, ErrMsg);
            exit;
        end;

        CRMPriceLevelStaging."Integration Status" := Enum::"CRM Integration Status"::Success;
        CRMPriceLevelStaging."CRM Record ID" := CopyStr(ResponseText, 1, 50);
        CRMPriceLevelStaging."Processed DateTime" := CurrentDateTime();
        CRMPriceLevelStaging."Error Message" := '';
        CRMPriceLevelStaging.Modify(true);

        LogMgt.WriteLog(
            'PriceLevel', 'Push', CRMPriceLevelStaging."Item No.",
            CRMPriceLevelStaging."Price Level Code",
            Enum::"CRM Integration Status"::Success,
            'Price level inserted successfully.',
            Database::"CRM Item Price Level Staging",
            CRMPriceLevelStaging."Retry Count");
    end;

    local procedure BuildPriceLevelJson(CRMPriceLevelStaging: Record "CRM Item Price Level Staging"): Text
    var
        JObject: JsonObject;
        JsonText: Text;
        ProductNumber: Text;
        UoMId: Text;
        PriceLevelId: Text;
        Item: Record Item;
        AmountValue: Decimal;
    begin
        ProductNumber := CRMPriceLevelStaging."Product No.";
        if ProductNumber = '' then
            ProductNumber := CRMPriceLevelStaging."Item No.";
        if ProductNumber = '' then
            Error('Product number is mandatory for CRM price-level insert.');

        UoMId := CRMPriceLevelStaging."UoM CRM ID";
        if UoMId = '' then
            UoMId := 'b2f82e2d-98ab-46b5-9577-600f4567fcb7';

        PriceLevelId := CRMPriceLevelStaging."Price Level CRM ID";
        if PriceLevelId = '' then
            PriceLevelId := '6472e80a-bfff-e211-acb5-00155d602128';

        AmountValue := CRMPriceLevelStaging.Amount;
        if AmountValue = 0 then
            if Item.Get(CRMPriceLevelStaging."Item No.") then
                AmountValue := Item."Unit Price";

        JObject.Add('amount', AmountValue);
        JObject.Add('roundingpolicycode', 1);
        JObject.Add('pricingmethodcode', 1);
        JObject.Add('quantitysellingcode', 1);
        JObject.Add('productid@odata.bind', '/products(productnumber=''' + ProductNumber + ''')');
        JObject.Add('uomid@odata.bind', '/uoms(' + UoMId + ')');
        JObject.Add('pricelevelid@odata.bind', '/pricelevels(' + PriceLevelId + ')');
        JObject.WriteTo(JsonText);
        exit(JsonText);
    end;

    procedure PatchPriceLevel(var CRMPriceLevelStaging: Record "CRM Item Price Level Staging")
    var
        LogMgt: Codeunit "CRM Integration Log Mgt.";
        JsonPayload: Text;
        ResponseText: Text;
        ErrMsg: Text;
        ProductPriceLevelId: Text;
        ExistingStaging: Record "CRM Item Price Level Staging";
        IsNew: Boolean;
    begin
        if CRMPriceLevelStaging."Item No." = '' then
            Error('Item No. is mandatory.');

        IsNew := not ExistingStaging.Get(CRMPriceLevelStaging."Item No.", CRMPriceLevelStaging."Price Level Code");
        if IsNew then
            CRMPriceLevelStaging."Created DateTime" := CurrentDateTime();

        CRMPriceLevelStaging."Integration Status" := Enum::"CRM Integration Status"::Open;
        CRMPriceLevelStaging."Latest Method" := 'PATCH';
        CRMPriceLevelStaging."Error Message" := '';

        if IsNew then
            CRMPriceLevelStaging.Insert(true)
        else
            CRMPriceLevelStaging.Modify(true);

        LogMgt.WriteLog(
            'PriceLevel', 'Patch', CRMPriceLevelStaging."Item No.", CRMPriceLevelStaging."Price Level Code",
            Enum::"CRM Integration Status"::Open,
            'Processing price level PATCH.',
            Database::"CRM Item Price Level Staging",
            CRMPriceLevelStaging."Retry Count");

        Commit();

        if not GetProductPriceLevelIdFromCrm(CRMPriceLevelStaging, ProductPriceLevelId, ErrMsg) then begin
            SetFailedForPatch(CRMPriceLevelStaging, ErrMsg);
            exit;
        end;

        JsonPayload := BuildUpdatePriceLevelJson(CRMPriceLevelStaging);

        if not TryPatchPriceLevelToCrm(JsonPayload, ResponseText, ErrMsg, ProductPriceLevelId) then begin
            SetFailedForPatch(CRMPriceLevelStaging, ErrMsg);
            exit;
        end;

        CRMPriceLevelStaging."Integration Status" := Enum::"CRM Integration Status"::Success;
        CRMPriceLevelStaging."CRM Record ID" := CopyStr(ProductPriceLevelId, 1, 50);
        CRMPriceLevelStaging."Processed DateTime" := CurrentDateTime();
        CRMPriceLevelStaging."Error Message" := '';
        CRMPriceLevelStaging.Modify(true);

        LogMgt.WriteLog(
            'PriceLevel', 'Patch', CRMPriceLevelStaging."Item No.", CRMPriceLevelStaging."Price Level Code",
            Enum::"CRM Integration Status"::Success,
            'Price level updated successfully via PATCH.',
            Database::"CRM Item Price Level Staging",
            CRMPriceLevelStaging."Retry Count");
    end;

    local procedure BuildUpdatePriceLevelJson(CRMPriceLevelStaging: Record "CRM Item Price Level Staging"): Text
    var
        JObject: JsonObject;
        JsonText: Text;
        Item: Record Item;
        AmountValue: Decimal;
    begin
        AmountValue := CRMPriceLevelStaging.Amount;
        if AmountValue = 0 then
            if Item.Get(CRMPriceLevelStaging."Item No.") then
                AmountValue := Item."Unit Price";

        JObject.Add('amount', AmountValue);
        // JObject.Add('roundingpolicycode', CRMPriceLevelStaging."Rounding Policy Code");
        // JObject.Add('pricingmethodcode', CRMPriceLevelStaging."Pricing Method Code");
        // JObject.Add('quantitysellingcode', CRMPriceLevelStaging."Quantity Selling Code");
        JObject.Add('roundingpolicycode', 1);
        JObject.Add('pricingmethodcode', 1);
        JObject.Add('quantitysellingcode', 1);
        JObject.WriteTo(JsonText);
        exit(JsonText);
    end;

    local procedure GetProductPriceLevelIdFromCrm(CRMPriceLevelStaging: Record "CRM Item Price Level Staging"; var ProductPriceLevelId: Text; var ErrMsg: Text): Boolean
    var
        CRMSetup: Record "CRM Integration Setup";
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        ContentHeaders: HttpHeaders;
        Base64Convert: Codeunit "Base64 Convert";
        OAuthClientMgt: Codeunit "CRM OAuth Client Mgt.";
        AccessToken: Text;
        JsonObject: JsonObject;
        JsonArray: JsonArray;
        JsonToken: JsonToken;
        JsonObjectItem: JsonObject;
        ProductNumber: Text;
        CRMEndpointUrl: Text;
        ResponseText: Text;
    begin
        ProductNumber := CRMPriceLevelStaging."Product No.";
        if ProductNumber = '' then
            ProductNumber := CRMPriceLevelStaging."Item No.";
        if ProductNumber = '' then begin
            ErrMsg := 'Product number is mandatory to locate the CRM product price level.';
            exit(false);
        end;

        if not CRMSetup.Get('DEFAULT') then begin
            ErrMsg := 'CRM Integration Setup not found. Open CRM Integration Setup and configure it first.';
            exit(false);
        end;

        CRMEndpointUrl := 'https://mrd-dev.crm.dynamics.com/api/data/v9.2/productpricelevels?$select=productpricelevelid,amount&$expand=productid($select=productid,productnumber)&$filter=productid/productnumber eq ''' + ProductNumber + '''';
        if CRMSetup."Use HTTPS Only" and (CopyStr(LowerCase(CRMEndpointUrl), 1, 8) <> 'https://') then begin
            ErrMsg := 'CRM price level endpoint must start with https://.';
            exit(false);
        end;

        if CRMSetup."Request Timeout (ms)" > 0 then
            HttpClient.Timeout(CRMSetup."Request Timeout (ms)");

        HttpRequestMessage.Method := 'GET';
        HttpRequestMessage.SetRequestUri(CRMEndpointUrl);
        HttpRequestMessage.GetHeaders(HttpHeaders);

        case CRMSetup."Auth Type" of
            CRMSetup."Auth Type"::Bearer,
            CRMSetup."Auth Type"::OAuthClientCredentials:
                begin
                    if not OAuthClientMgt.GetBearerTokenFromClientCredentials(CRMSetup, AccessToken, ErrMsg) then
                        exit(false);
                    HttpHeaders.Add('Authorization', 'Bearer ' + AccessToken);
                end;
            CRMSetup."Auth Type"::Basic:
                begin
                    if (CRMSetup."Username" = '') or (CRMSetup."Password" = '') then begin
                        ErrMsg := 'Username and password are required for basic auth.';
                        exit(false);
                    end;
                    HttpHeaders.Add('Authorization', 'Basic ' + Base64Convert.ToBase64(CRMSetup."Username" + ':' + CRMSetup."Password"));
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

        if not JsonObject.ReadFrom(ResponseText) then begin
            ErrMsg := 'Unable to parse CRM response for product price level lookup.';
            exit(false);
        end;

        if JsonObject.Get('value', JsonToken) and JsonToken.IsArray() then begin
            JsonArray := JsonToken.AsArray();
            if JsonArray.Count > 0 then begin
                if JsonArray.Get(0, JsonToken) and JsonToken.IsObject() then begin
                    JsonObjectItem := JsonToken.AsObject();
                    if JsonObjectItem.Get('productpricelevelid', JsonToken) and JsonToken.IsValue() then begin
                        ProductPriceLevelId := JsonToken.AsValue().AsText();
                        if ProductPriceLevelId <> '' then
                            exit(true);
                    end;
                end;
            end;
        end;

        ErrMsg := StrSubstNo('CRM product price level not found for product number %1.', ProductNumber);
        exit(false);
    end;

    local procedure GetPatchPriceLevelEndpointUrl(CRMEndpointUrl: Text; ProductPriceLevelId: Text): Text
    begin
        if ProductPriceLevelId = '' then
            Error('Product price level ID is required for PATCH endpoint.');

        CRMEndpointUrl := 'https://mrd-dev.crm.dynamics.com/api/data/v9.2/productpricelevels(' + ProductPriceLevelId + ')?$select=productpricelevelid,amount,productid';
        exit(CRMEndpointUrl);
    end;

    local procedure TryPatchPriceLevelToCrm(JsonPayload: Text; var ResponseText: Text; var ErrMsg: Text; ProductPriceLevelId: Text): Boolean
    var
        CRMSetup: Record "CRM Integration Setup";
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpHeaders: HttpHeaders;
        ContentHeaders: HttpHeaders;
        HttpContent: HttpContent;
        Base64Convert: Codeunit "Base64 Convert";
        OAuthClientMgt: Codeunit "CRM OAuth Client Mgt.";
        AccessToken: Text;
        CRMEndpointUrl: Text;
    begin
        if ProductPriceLevelId = '' then begin
            ErrMsg := 'Product price level ID is required to perform PATCH.';
            exit(false);
        end;

        if not CRMSetup.Get('DEFAULT') then begin
            ErrMsg := 'CRM Integration Setup not found. Open CRM Integration Setup and configure it first.';
            exit(false);
        end;

        CRMEndpointUrl := GetPatchPriceLevelEndpointUrl('', ProductPriceLevelId);
        if CRMSetup."Use HTTPS Only" and (CopyStr(LowerCase(CRMEndpointUrl), 1, 8) <> 'https://') then begin
            ErrMsg := 'CRM price level endpoint must start with https://.';
            exit(false);
        end;

        if CRMSetup."Request Timeout (ms)" > 0 then
            HttpClient.Timeout(CRMSetup."Request Timeout (ms)");

        HttpContent.WriteFrom(JsonPayload);
        HttpContent.GetHeaders(ContentHeaders);
        ContentHeaders.Clear();
        ContentHeaders.Add('Content-Type', 'application/json');

        HttpRequestMessage.Method := 'PATCH';
        HttpRequestMessage.SetRequestUri(CRMEndpointUrl);
        HttpRequestMessage.Content := HttpContent;

        HttpRequestMessage.GetHeaders(HttpHeaders);
        case CRMSetup."Auth Type" of
            CRMSetup."Auth Type"::Bearer,
            CRMSetup."Auth Type"::OAuthClientCredentials:
                begin
                    if not OAuthClientMgt.GetBearerTokenFromClientCredentials(CRMSetup, AccessToken, ErrMsg) then
                        exit(false);
                    HttpHeaders.Add('Authorization', 'Bearer ' + AccessToken);
                end;
            CRMSetup."Auth Type"::Basic:
                begin
                    if (CRMSetup."Username" = '') or (CRMSetup."Password" = '') then begin
                        ErrMsg := 'Username and password are required for basic auth.';
                        exit(false);
                    end;
                    HttpHeaders.Add('Authorization', 'Basic ' + Base64Convert.ToBase64(CRMSetup."Username" + ':' + CRMSetup."Password"));
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

    local procedure SetFailedForPatch(var CRMPriceLevelStaging: Record "CRM Item Price Level Staging"; ErrMsg: Text)
    var
        LogMgt: Codeunit "CRM Integration Log Mgt.";
    begin
        CRMPriceLevelStaging."Integration Status" := Enum::"CRM Integration Status"::Failed;
        CRMPriceLevelStaging."Error Message" := CopyStr(ErrMsg, 1, 250);
        CRMPriceLevelStaging."Retry Count" += 1;
        CRMPriceLevelStaging."Processed DateTime" := CurrentDateTime();
        CRMPriceLevelStaging.Modify(true);

        LogMgt.WriteLog(
            'PriceLevel', 'Patch', CRMPriceLevelStaging."Item No.", CRMPriceLevelStaging."Price Level Code",
            Enum::"CRM Integration Status"::Failed,
            ErrMsg,
            Database::"CRM Item Price Level Staging",
            CRMPriceLevelStaging."Retry Count");
    end;

    local procedure TrySendPriceLevelToCrm(JsonPayload: Text; var ResponseText: Text; var ErrMsg: Text): Boolean
    var
        CRMSetup: Record "CRM Integration Setup";
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        ContentHeaders: HttpHeaders;
        Base64Convert: Codeunit "Base64 Convert";
        OAuthClientMgt: Codeunit "CRM OAuth Client Mgt.";
        BasicCredential: Text;
        AccessToken: Text;
        CRMEndpointUrl: Text;
    begin
        if not CRMSetup.Get('DEFAULT') then begin
            ErrMsg := 'CRM Integration Setup not found. Open CRM Integration Setup and configure it first.';
            exit(false);
        end;

        CRMEndpointUrl := 'https://mrd-dev.crm.dynamics.com/api/data/v9.2/productpricelevels';

        if CRMSetup."Use HTTPS Only" and (CopyStr(LowerCase(CRMEndpointUrl), 1, 8) <> 'https://') then begin
            ErrMsg := 'CRM price level endpoint must start with https://.';
            exit(false);
        end;

        if CRMSetup."Request Timeout (ms)" > 0 then
            HttpClient.Timeout(CRMSetup."Request Timeout (ms)");

        HttpContent.WriteFrom(JsonPayload);
        HttpContent.GetHeaders(ContentHeaders);
        ContentHeaders.Clear();
        ContentHeaders.Add('Content-Type', 'application/json');

        HttpRequestMessage.Method := 'POST';
        HttpRequestMessage.SetRequestUri(CRMEndpointUrl);
        HttpRequestMessage.Content := HttpContent;
        HttpRequestMessage.GetHeaders(HttpHeaders);

        case CRMSetup."Auth Type" of
            CRMSetup."Auth Type"::Bearer,
            CRMSetup."Auth Type"::OAuthClientCredentials:
                begin
                    if not OAuthClientMgt.GetBearerTokenFromClientCredentials(CRMSetup, AccessToken, ErrMsg) then
                        exit(false);

                    HttpHeaders.Add('Authorization', 'Bearer ' + AccessToken);
                end;
            CRMSetup."Auth Type"::Basic:
                begin
                    if (CRMSetup."Username" = '') or (CRMSetup."Password" = '') then begin
                        ErrMsg := 'Username and password are required for basic auth.';
                        exit(false);
                    end;

                    BasicCredential := Base64Convert.ToBase64(CRMSetup."Username" + ':' + CRMSetup."Password");
                    HttpHeaders.Add('Authorization', 'Basic ' + BasicCredential);
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

    local procedure SetFailed(var CRMPriceLevelStaging: Record "CRM Item Price Level Staging"; ErrMsg: Text)
    var
        LogMgt: Codeunit "CRM Integration Log Mgt.";
    begin
        CRMPriceLevelStaging."Integration Status" := Enum::"CRM Integration Status"::Failed;
        CRMPriceLevelStaging."Error Message" := CopyStr(ErrMsg, 1, 250);
        CRMPriceLevelStaging."Retry Count" += 1;
        CRMPriceLevelStaging."Processed DateTime" := CurrentDateTime();
        CRMPriceLevelStaging.Modify(true);

        LogMgt.WriteLog(
            'PriceLevel', 'Push',
            CRMPriceLevelStaging."Item No.",
            CRMPriceLevelStaging."Price Level Code",
            Enum::"CRM Integration Status"::Failed,
            ErrMsg,
            Database::"CRM Item Price Level Staging",
            CRMPriceLevelStaging."Retry Count");
    end;
}
