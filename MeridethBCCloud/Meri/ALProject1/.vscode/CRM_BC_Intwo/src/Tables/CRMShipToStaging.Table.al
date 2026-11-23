// ============================================================
// Table: CRM Ship-To Staging
// Object ID  : 50101
// Publisher  : Intwo
// Direction  : PULL — CRM sends payload → this staging table
//              → BC Ship-to Address table (Table 222).
// Source Map : BC-CRM_Integration_Field_Mapping
//              _Ship_To_Address_Pull_to_BC_V1_0_latest.xlsx
//
// Design notes:
//   • Primary key is Customer No. + Code (composite), matching
//     the BC Ship-to Address table structure exactly.
//   • "Code" formula note: sheet says "To check with Liza on
//     Formula" — currently populated by codeunit from CRM payload.
//     Sample: 16756 CWAR (first 10 chars of address).
//   • Tax Liable default = true, Tax Area Code is mandatory.
// ============================================================
table 50101 "CRM Ship-To Staging"
{
    Caption = 'CRM Ship-To Staging';
    DataClassification = CustomerContent;
    Permissions = TableData "CRM Ship-To Staging" = RIMD;

    fields
    {
        // --------------------------------------------------
        // Customer No. (Code[20], Mandatory)
        // Sample: C00003
        // Links this ship-to record to a BC Customer.
        // --------------------------------------------------
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            NotBlank = true;
            ToolTip = 'BC Customer No. Foreign key to Customer table. Mandatory. Sample: C00003.';
        }

        // --------------------------------------------------
        // Code (Code[10], Mandatory)
        // Sample: 16756 CWAR
        // Sheet remark: "To check with Liza on Formula"
        // Generated in codeunit if not supplied.
        // --------------------------------------------------
        field(2; Code; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            NotBlank = true;
            ToolTip = 'Ship-to Code. Mandatory. Code[10]. Sample: 16756 CWAR.';
        }

        // --------------------------------------------------
        // Name (Text[100], Mandatory)
        // Sample: California Institution For Women & Men
        // --------------------------------------------------
        field(3; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
            ToolTip = 'Ship-to name. Mandatory. Text[100].';
        }

        // --------------------------------------------------
        // Address (Text[100])
        // Sample: 16756 Chino-Corona Road
        // --------------------------------------------------
        field(4; Address; Text[100])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
            ToolTip = 'Street address. Text[100].';
        }

        // --------------------------------------------------
        // Address 2 (Text[50])
        // Sample: Suite 1
        // --------------------------------------------------
        field(5; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = CustomerContent;
            ToolTip = 'Address line 2. Text[50]. Sample: Suite 1.';
        }

        // --------------------------------------------------
        // City (Text[20])
        // Sample: North Miami Beach
        // Note: BC Ship-to Address.City is Text[30] but mapping
        //       shows length 20 — using 30 to match BC field.
        // --------------------------------------------------
        field(6; City; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
            ToolTip = 'City. Text[30]. Sample: North Miami Beach.';
        }

        // --------------------------------------------------
        // Country/Region Code (Code[10])
        // Sample: US
        // --------------------------------------------------
        field(7; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            DataClassification = CustomerContent;
            ToolTip = 'ISO country code. Code[10]. Sample: US.';
        }

        // --------------------------------------------------
        // Phone No. (Text[30])
        // Sample: (909) 597-1771 x 55
        // --------------------------------------------------
        field(8; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = CustomerContent;
            ToolTip = 'Phone number. Text[30]. Sample: (909) 597-1771 x 55.';
        }

        // --------------------------------------------------
        // Contact (Text[100])
        // Sample: Annex Warehouse
        // --------------------------------------------------
        field(9; Contact; Text[100])
        {
            Caption = 'Contact';
            DataClassification = CustomerContent;
            ToolTip = 'Contact name. Text[100]. Sample: Annex Warehouse.';
        }

        // --------------------------------------------------
        // Email (Text[80])
        // Sample: charity.anti@cdcr.ca.gov
        // --------------------------------------------------
        field(10; Email; Text[80])
        {
            Caption = 'Email';
            DataClassification = CustomerContent;
            ToolTip = 'Email address. Text[80].';
        }

        // --------------------------------------------------
        // Location Code (Code[10])
        // Sample: SAN PEDRO
        // --------------------------------------------------
        field(11; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
            ToolTip = 'Warehouse location code. Code[10]. Sample: SAN PEDRO.';
        }

        // --------------------------------------------------
        // Post Code (Code[20])
        // --------------------------------------------------
        field(12; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            DataClassification = CustomerContent;
            ToolTip = 'Postal / ZIP code. Code[20].';
        }

        // --------------------------------------------------
        // Salesperson Code (Code[20])
        // --------------------------------------------------
        field(13; "Salesperson Code"; Code[20])
        {
            Caption = 'Salesperson Code';
            DataClassification = CustomerContent;
            ToolTip = 'Assigned salesperson. Code[20].';
        }

        // --------------------------------------------------
        // Tax Liable (Boolean, Mandatory)
        // Values: true/false
        // --------------------------------------------------
        field(14; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
            DataClassification = CustomerContent;
            InitValue = true;
            ToolTip = 'Tax liable flag. Mandatory. Default = true.';
        }

        // --------------------------------------------------
        // Tax Area Code (Code[20], Mandatory)
        // Sample: OS
        // --------------------------------------------------
        field(15; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            DataClassification = CustomerContent;
            ToolTip = 'Tax area code. Mandatory. Code[20]. Sample: OS.';
        }
        field(16; State; Code[20])
        {
            Caption = 'State';
            DataClassification = CustomerContent;
            ToolTip = 'State. Code[20].';
        }
       

        // --------------------------------------------------
        // Integration Control Fields
        // --------------------------------------------------
        field(90; "Integration Status"; Enum "CRM Integration Status")
        {
            Caption = 'Integration Status';
            DataClassification = SystemMetadata;
            ToolTip = 'Open / Success / Failed.';
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
    }

    keys
    {
        // Composite PK matching BC Ship-to Address table
        key(PK; "Customer No.", Code)
        {
            Clustered = true;
        }
        key(Status; "Integration Status") { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Customer No.", Code, Name, "Integration Status") { }
    }
}
