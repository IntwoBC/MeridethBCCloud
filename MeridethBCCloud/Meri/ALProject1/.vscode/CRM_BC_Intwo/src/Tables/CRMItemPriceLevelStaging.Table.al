// ============================================================
// Table: CRM Item Price Level Staging
// Object ID  : 50106
// Publisher  : Intwo
// Direction  : PUSH — BC / CRM price level staging 
//              record for outbound CRM insert.
// ============================================================
table 50106 "CRM Item Price Level Staging"
{
    Caption = 'CRM Item Price Level Staging';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
            ToolTip = 'BC Item No. or CRM product number used for price level insert.';
            NotBlank = true;
        }

        field(2; "Price Level Code"; Code[20])
        {
            Caption = 'Price Level Code';
            DataClassification = CustomerContent;
            ToolTip = 'Price level code used to identify the CRM price level.';
        }

        field(3; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
            MinValue = 0;
            ToolTip = 'Price level amount to send to CRM.';
        }

        field(4; "Rounding Policy Code"; Integer)
        {
            Caption = 'Rounding Policy Code';
            DataClassification = CustomerContent;
            ToolTip = 'CRM rounding policy code for the price level.';
        }

        field(5; "Pricing Method Code"; Integer)
        {
            Caption = 'Pricing Method Code';
            DataClassification = CustomerContent;
            ToolTip = 'CRM pricing method code for the price level.';
        }

        field(6; "Quantity Selling Code"; Integer)
        {
            Caption = 'Quantity Selling Code';
            DataClassification = CustomerContent;
            ToolTip = 'CRM quantity selling code for the price level.';
        }

        field(7; "Product No."; Code[30])
        {
            Caption = 'Product No.';
            DataClassification = CustomerContent;
            ToolTip = 'Product number used for CRM productid@odata.bind.';
        }

        field(8; "UoM CRM ID"; Text[50])
        {
            Caption = 'UoM CRM ID';
            DataClassification = CustomerContent;
            ToolTip = 'GUID for CRM UoM used in uomid@odata.bind.';
        }

        field(9; "Price Level CRM ID"; Text[50])
        {
            Caption = 'Price Level CRM ID';
            DataClassification = CustomerContent;
            ToolTip = 'GUID for CRM price level used in pricelevelid@odata.bind.';
        }

        field(90; "Integration Status"; Enum "CRM Integration Status")
        {
            Caption = 'Integration Status';
            DataClassification = SystemMetadata;
        }

        field(91; "Error Message"; Text[250])
        {
            Caption = 'Error Message';
            DataClassification = SystemMetadata;
        }

        field(92; "Created DateTime"; DateTime)
        {
            Caption = 'Created DateTime';
            DataClassification = SystemMetadata;
        }

        field(93; "Processed DateTime"; DateTime)
        {
            Caption = 'Processed DateTime';
            DataClassification = SystemMetadata;
        }

        field(94; "Retry Count"; Integer)
        {
            Caption = 'Retry Count';
            DataClassification = SystemMetadata;
            MinValue = 0;
        }

        field(95; "CRM Record ID"; Text[50])
        {
            Caption = 'CRM Record ID';
            DataClassification = SystemMetadata;
            ToolTip = 'CRM record ID returned after a successful insert.';
        }

        field(96; "Latest Method"; Text[10])
        {
            Caption = 'Latest Method';
            DataClassification = SystemMetadata;
            ToolTip = 'Latest CRM request method used for this staging record.';
        }
    }

    keys
    {
        key(PK; "Item No.", "Price Level Code")
        {
            Clustered = true;
        }

        key(Status; "Integration Status") { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Item No.", "Price Level Code", "Integration Status") { }
    }
}
