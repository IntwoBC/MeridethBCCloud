codeunit 50122 "CRM OAuth Client Mgt."
{
    procedure GetBearerTokenFromClientCredentials(var CRMSetup: Record "CRM Integration Setup"; var AccessToken: Text; var ErrMsg: Text): Boolean
    var
        HttpClient: HttpClient;
        HttpContent: HttpContent;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        ContentHeaders: HttpHeaders;
        ResponseText: Text;
        FormBody: Text;
        TokenJson: JsonObject;
        AccessTokenToken: JsonToken;
        ExpiresInToken: JsonToken;
        ExpiresInSec: Integer;
        RefreshBufferDuration: Duration;
        ExpiresDuration: Duration;
        TokenExpiryAt: DateTime;
    begin
        if TokenIsStillValid(CRMSetup) then begin
            AccessToken := CRMSetup."Auth Token";
            exit(true);
        end;

        if CRMSetup."Token URL" = '' then begin
            ErrMsg := 'CRM Integration Setup: Token URL is required when Auth Type = OAuth Client Credentials.';
            exit(false);
        end;

        if CRMSetup."Client ID" = '' then begin
            ErrMsg := 'CRM Integration Setup: Client ID is required when Auth Type = OAuth Client Credentials.';
            exit(false);
        end;

        if CRMSetup."Client Secret" = '' then begin
            ErrMsg := 'CRM Integration Setup: Client Secret is required when Auth Type = OAuth Client Credentials.';
            exit(false);
        end;

        if CRMSetup."Use HTTPS Only" and (CopyStr(LowerCase(CRMSetup."Token URL"), 1, 8) <> 'https://') then begin
            ErrMsg := 'CRM Integration Setup: Token URL must start with https:// when Use HTTPS Only is enabled.';
            exit(false);
        end;

        FormBody := 'grant_type=client_credentials' +
            '&client_id=' + CRMSetup."Client ID" +
            '&client_secret=' + CRMSetup."Client Secret";

        if CRMSetup."OAuth Scope" <> '' then
            FormBody += '&scope=' + CRMSetup."OAuth Scope";

        HttpContent.WriteFrom(FormBody);
        HttpContent.GetHeaders(ContentHeaders);
        ContentHeaders.Clear();
        ContentHeaders.Add('Content-Type', 'application/x-www-form-urlencoded');

        HttpRequestMessage.Method := 'POST';
        HttpRequestMessage.SetRequestUri(CRMSetup."Token URL");
        HttpRequestMessage.Content := HttpContent;

        if not HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then begin
            ErrMsg := 'OAuth token request failed (network error).';
            exit(false);
        end;

        HttpResponseMessage.Content.ReadAs(ResponseText);

        if not HttpResponseMessage.IsSuccessStatusCode() then begin
            ErrMsg := StrSubstNo('OAuth token request failed with HTTP %1: %2', HttpResponseMessage.HttpStatusCode, ResponseText);
            exit(false);
        end;

        if not TokenJson.ReadFrom(ResponseText) then begin
            ErrMsg := 'OAuth token endpoint returned invalid JSON.';
            exit(false);
        end;

        if not TokenJson.Get('access_token', AccessTokenToken) then begin
            ErrMsg := 'OAuth token response did not contain access_token.';
            exit(false);
        end;

        AccessToken := AccessTokenToken.AsValue().AsText();
        if AccessToken = '' then begin
            ErrMsg := 'OAuth token response contained empty access_token.';
            exit(false);
        end;

        ExpiresInSec := 3600;
        if TokenJson.Get('expires_in', ExpiresInToken) then
            Evaluate(ExpiresInSec, ExpiresInToken.AsValue().AsText());

        ExpiresDuration := ExpiresInSec * 1000;
        TokenExpiryAt := CurrentDateTime() + ExpiresDuration;

        CRMSetup."Auth Token" := CopyStr(AccessToken, 1, MaxStrLen(CRMSetup."Auth Token"));
        CRMSetup."Access Token Expires At" := TokenExpiryAt;
        CRMSetup.Modify(true);

        exit(true);
    end;

    local procedure TokenIsStillValid(CRMSetup: Record "CRM Integration Setup"): Boolean
    var
        BufferSec: Integer;
        RefreshBufferDuration: Duration;
        RefreshCutoff: DateTime;
    begin
        if CRMSetup."Auth Token" = '' then
            exit(false);

        if CRMSetup."Access Token Expires At" = 0DT then
            exit(false);

        BufferSec := CRMSetup."Token Refresh Buffer (sec)";
        if BufferSec < 0 then
            BufferSec := 0;

        RefreshBufferDuration := BufferSec * 1000;
        RefreshCutoff := CurrentDateTime() + RefreshBufferDuration;

        exit(CRMSetup."Access Token Expires At" > RefreshCutoff);
    end;
}
