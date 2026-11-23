page 50111 "CRM Integration Setup"
{
    PageType = Card;
    Caption = 'CRM Integration Setup';
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CRM Integration Setup";

    layout
    {
        area(Content)
        {
            group(Endpoints)
            {
                Caption = 'CRM Endpoints';
                field("Item API URL"; Rec."Item API URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Endpoint used for BC to CRM Item push.';
                }
                field("Invoice API URL"; Rec."Invoice API URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Endpoint used for BC to CRM Sales Invoice push.';
                }
                field("Invoice Lines API URL"; Rec."Invoice Lines API URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Endpoint used for BC to CRM Sales Invoice Line push.';
                }
                field("Request Timeout (ms)"; Rec."Request Timeout (ms)")
                {
                    ApplicationArea = All;
                    ToolTip = 'HTTP request timeout in milliseconds.';
                }
                field("Use HTTPS Only"; Rec."Use HTTPS Only")
                {
                    ApplicationArea = All;
                    ToolTip = 'If enabled, endpoints must start with https://.';
                }
            }

            group(Authentication)
            {
                Caption = 'Authentication';

                field("Auth Type"; Rec."Auth Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }

                group("Bearer Authentication")
                {
                    Caption = 'Bearer Authentication';
                    Enabled = Rec."Auth Type" = Rec."Auth Type"::Bearer;
                    field("Auth Token"; Rec."Auth Token")
                    {
                        ApplicationArea = All;
                        ExtendedDatatype = Masked;
                    }
                }
                group("Basic Authentication")
                {
                    Caption = 'Basic Authentication';
                    Enabled = Rec."Auth Type" = Rec."Auth Type"::Basic;
                    field("Username"; Rec."Username")
                    {
                        ApplicationArea = All;
                    }
                    field("Password"; Rec."Password")
                    {
                        ApplicationArea = All;
                        ExtendedDatatype = Masked;
                    }
                }
                group("OAuth Authentication")
                {
                    Caption = 'OAuth Authentication';
                    Enabled = Rec."Auth Type" = Rec."Auth Type"::OAuthClientCredentials;
                    field("Token URL"; Rec."Token URL")
                    {
                        ApplicationArea = All;
                    }
                    field("Client ID"; Rec."Client ID")
                    {
                        ApplicationArea = All;
                    }
                    field("Client Secret"; Rec."Client Secret")
                    {
                        ApplicationArea = All;
                        ExtendedDatatype = Masked;
                    }
                    field("OAuth Scope"; Rec."OAuth Scope")
                    {
                        ApplicationArea = All;
                    }
                    field("Token Refresh Buffer (sec)"; Rec."Token Refresh Buffer (sec)")
                    {
                        ApplicationArea = All;
                    }
                    field("Access Token Expires At"; Rec."Access Token Expires At")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                }
            }
        }
    }

    var
        ShowBearerFields: Boolean;
        ShowBasicFields: Boolean;
        ShowOAuthFields: Boolean;

    trigger OnOpenPage()
    begin
        EnsureDefaultRecord();
        UpdateAuthVisibility();
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateAuthVisibility();
    end;

    local procedure EnsureDefaultRecord()
    begin
        if Rec.Get('DEFAULT') then
            exit;

        Rec.Init();
        Rec."Primary Key" := 'DEFAULT';
        Rec.Insert(true);
        Commit();
        Rec.Get('DEFAULT');
    end;

    local procedure UpdateAuthVisibility()
    begin
        ShowBearerFields := Rec."Auth Type" = Rec."Auth Type"::Bearer;
        ShowBasicFields := Rec."Auth Type" = Rec."Auth Type"::Basic;
        ShowOAuthFields := Rec."Auth Type" = Rec."Auth Type"::OAuthClientCredentials;
    end;
}
