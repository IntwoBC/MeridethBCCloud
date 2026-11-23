table 50105 "CRM Integration Setup"
{
    Caption = 'CRM Integration Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
            NotBlank = true;
        }

        field(10; "Item API URL"; Text[250])
        {
            Caption = 'Item API URL';
            DataClassification = CustomerContent;
        }

        field(11; "Invoice API URL"; Text[250])
        {
            Caption = 'Invoice API URL';
            DataClassification = CustomerContent;
        }

        field(20; "Auth Type"; Option)
        {
            Caption = 'Auth Type';
            DataClassification = CustomerContent;
            OptionMembers = None,Bearer,Basic,OAuthClientCredentials;
            OptionCaption = 'None,Bearer,Basic,OAuth Client Credentials';
            InitValue = None;
        }

        field(21; "Auth Token"; Text[2048])
        {
            Caption = 'Auth Token';
            DataClassification = CustomerContent;
        }

        field(22; "Username"; Text[100])
        {
            Caption = 'Username';
            DataClassification = CustomerContent;
        }

        field(23; "Password"; Text[100])
        {
            Caption = 'Password';
            DataClassification = CustomerContent;
        }

        field(30; "Request Timeout (ms)"; Integer)
        {
            Caption = 'Request Timeout (ms)';
            DataClassification = CustomerContent;
            InitValue = 60000;
            MinValue = 1;
        }

        field(31; "Use HTTPS Only"; Boolean)
        {
            Caption = 'Use HTTPS Only';
            DataClassification = CustomerContent;
            InitValue = true;
        }

        field(32; "Token URL"; Text[250])
        {
            Caption = 'Token URL';
            DataClassification = CustomerContent;
        }

        field(33; "Client ID"; Text[150])
        {
            Caption = 'Client ID';
            DataClassification = CustomerContent;
        }

        field(34; "Client Secret"; Text[250])
        {
            Caption = 'Client Secret';
            DataClassification = CustomerContent;
        }

        field(35; "OAuth Scope"; Text[250])
        {
            Caption = 'OAuth Scope';
            DataClassification = CustomerContent;
        }

        field(36; "Access Token Expires At"; DateTime)
        {
            Caption = 'Access Token Expires At';
            DataClassification = SystemMetadata;
        }

        field(37; "Token Refresh Buffer (sec)"; Integer)
        {
            Caption = 'Token Refresh Buffer (sec)';
            DataClassification = CustomerContent;
            InitValue = 120;
            MinValue = 0;
        }
        field(13; "Invoice Lines API URL"; Text[250])
        {
            Caption = 'Invoice Lines API URL';
            DataClassification = CustomerContent;
            ToolTip = 'Separate endpoint used to push Sales Invoice Lines independently of the header.';
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
