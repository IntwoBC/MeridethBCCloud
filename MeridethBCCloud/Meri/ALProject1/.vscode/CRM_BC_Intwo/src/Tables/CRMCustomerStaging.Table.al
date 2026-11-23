// ============================================================
// Table: CRM Customer Staging
// Object ID  : 50100
// Publisher  : Intwo
// Direction  : PULL — CRM sends payload → this staging table
//              → BC Customer table (Table 18).
// Source Map : BC-CRM_Integration_Field_Mapping
//              _Customer_Master_Pull_to_BC_V1_0latest.xlsx
//
// Design notes:
//   • Every field mirrors the exact BC type/length from the
//     mapping sheet so CopyStr lengths are consistent.
//   • Mandatory fields per sheet are enforced in the codeunit,
//     not here, to allow partial saves and reprocessing.
//   • Hardcoded defaults (GEN, TRADE, CREDITCARD, Tax Liable=true)
//     are applied in the codeunit as per "Intwo Remarks" column.
// ============================================================
table 50100 "CRM Customer Staging"
{
    Caption = 'CRM Customer Staging';
    DataClassification = ToBeClassified;

    fields
    {
        // --------------------------------------------------
        // PRIMARY KEY — BC No. (Code[20], Mandatory)
        // Sample data from sheet: C05056
        // --------------------------------------------------
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            NotBlank = true;
            ToolTip = 'BC Customer No. (Code[20]). Mandatory. Sample: C05056.';
        }

        // --------------------------------------------------
        // Name (Text[100], Mandatory)
        // Sample: Arnold Mireles Elementary Academy
        // --------------------------------------------------
        field(2; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
            ToolTip = 'Customer Name. Mandatory. Text[100].';
        }

        // --------------------------------------------------
        // Name 2 (Text[50])
        // Sample: Lf Kingman Place
        // --------------------------------------------------
        field(3; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
            DataClassification = ToBeClassified;
            ToolTip = 'Secondary name line. Text[50].';
        }

        // --------------------------------------------------
        // Credit Limit (LCY) (Decimal)
        // Field length listed as 50 in sheet — BC type is Decimal
        // Sample: 25000
        // --------------------------------------------------
        field(4; "Credit Limit (LCY)"; Decimal)
        {
            Caption = 'Credit Limit (LCY)';
            DataClassification = ToBeClassified;
            MinValue = 0;
            ToolTip = 'Credit limit in local currency. Decimal. Sample: 25000.';
        }

        // --------------------------------------------------
        // Address (Text[100])
        // Sample: 9000 S EXCHANGE AVE
        // --------------------------------------------------
        field(5; Address; Text[100])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;
            ToolTip = 'Street address line 1. Text[100].';
        }

        // --------------------------------------------------
        // Address 2 (Text[50])
        // Sample: 107 PACIFIC HALL
        // --------------------------------------------------
        field(6; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = ToBeClassified;
            ToolTip = 'Street address line 2. Text[50].';
        }

        // --------------------------------------------------
        // Country/Region Code (Code[10])
        // Sample: US
        // --------------------------------------------------
        field(7; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            DataClassification = ToBeClassified;
            ToolTip = 'ISO country code. Code[10]. Sample: US.';
        }

        // --------------------------------------------------
        // City (Text[30])
        // Sample: North Miami Bch
        // --------------------------------------------------
        field(8; City; Text[30])
        {
            Caption = 'City';
            DataClassification = ToBeClassified;
            ToolTip = 'City. Text[30]. Sample: North Miami Bch.';
        }

        // --------------------------------------------------
        // Contact (Text[100])
        // --------------------------------------------------
        field(9; Contact; Text[100])
        {
            Caption = 'Contact';
            DataClassification = ToBeClassified;
            ToolTip = 'Primary contact name. Text[100].';
        }

        // --------------------------------------------------
        // Email (Text[80])
        // --------------------------------------------------
        field(10; Email; Text[80])
        {
            Caption = 'Email';
            DataClassification = ToBeClassified;
            ToolTip = 'Email address. Text[80].';
        }

        // --------------------------------------------------
        // Post Code (Code[20])
        // --------------------------------------------------
        field(11; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            DataClassification = ToBeClassified;
            ToolTip = 'Postal / ZIP code. Code[20].';
        }

        // --------------------------------------------------
        // VAT Registration No. (Text[20])
        // Sample: E9997-7109-07
        // --------------------------------------------------
        field(12; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';
            DataClassification = ToBeClassified;
            ToolTip = 'VAT/tax registration number. Text[20]. Sample: E9997-7109-07.';
        }

        // --------------------------------------------------
        // Tax Liable (Boolean, Mandatory)
        // Sheet remark: "In BC, by default it should be True"
        // --------------------------------------------------
        field(13; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
            DataClassification = ToBeClassified;
            InitValue = true;
            ToolTip = 'Tax liable flag. Mandatory. Default = true per Intwo spec.';
        }

        // --------------------------------------------------
        // Tax Area Code (Code[20], Mandatory)
        // Sample: LA
        // --------------------------------------------------
        field(14; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            DataClassification = ToBeClassified;
            ToolTip = 'Tax area code. Mandatory. Code[20]. Sample: LA.';
        }

        // --------------------------------------------------
        // Tax Identification Type (Option, Mandatory)
        // Values: Legal Entity / Natural Person
        // --------------------------------------------------
        field(15; "Tax Identification Type"; Option)
        {
            Caption = 'Tax Identification Type';
            DataClassification = ToBeClassified;
            OptionMembers = "Legal Entity","Natural Person";
            OptionCaption = 'Legal Entity,Natural Person';
            ToolTip = 'Tax identification type. Mandatory. Legal Entity or Natural Person.';
        }

        // --------------------------------------------------
        // Registration No. (Text[50])
        // --------------------------------------------------
        field(16; "Registration No."; Text[50])
        {
            Caption = 'Registration No.';
            DataClassification = ToBeClassified;
            ToolTip = 'Company registration number. Text[50].';
        }

        // --------------------------------------------------
        // Gen. Business Posting Group (Code[20], Mandatory)
        // Sheet remark: "In BC, hardcode it to GEN"
        // --------------------------------------------------
        field(17; "Gen. Business Posting Group"; Code[20])
        {
            Caption = 'Gen. Business Posting Group';
            DataClassification = ToBeClassified;
            InitValue = 'GEN';
            ToolTip = 'General business posting group. Mandatory. Hardcoded default: GEN.';
        }

        // --------------------------------------------------
        // Customer Posting Group (Code[20], Mandatory)
        // Sheet remark: "In BC, hardcode it to TRADE"
        // --------------------------------------------------
        field(18; "Customer Posting Group"; Code[20])
        {
            Caption = 'Customer Posting Group';
            DataClassification = ToBeClassified;
            InitValue = 'TRADE';
            ToolTip = 'Customer posting group. Mandatory. Hardcoded default: TRADE.';
        }

        // --------------------------------------------------
        // Currency Code (Code[10], Mandatory)
        // --------------------------------------------------
        // field(19; "Currency Code"; Code[10])
        // {
        //     Caption = 'Currency Code';
        //     DataClassification = ToBeClassified;
        //     ToolTip = 'Transaction currency code. Mandatory. Code[10].';
        // }

        // --------------------------------------------------
        // Payment Terms Code (Code[10])
        // Sample: N30
        // --------------------------------------------------
        field(20; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            DataClassification = ToBeClassified;
            ToolTip = 'Payment terms. Code[10]. Sample: N30.';
        }

        // --------------------------------------------------
        // Phone No. (Text[30])
        // --------------------------------------------------
        field(21; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = ToBeClassified;
            ToolTip = 'Phone number. Text[30].';
        }

        // --------------------------------------------------
        // Salesperson Code (Code[20])
        // --------------------------------------------------
        field(22; "Salesperson Code"; Code[20])
        {
            Caption = 'Salesperson Code';
            DataClassification = ToBeClassified;
            ToolTip = 'Assigned salesperson. Code[20].';
        }

        // --------------------------------------------------
        // Payment Method Code (Code[10])
        // Sample: CREDITCARD  — default per mapping sheet
        // --------------------------------------------------
        field(23; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            DataClassification = ToBeClassified;
            InitValue = 'CREDITCARD';
            ToolTip = 'Payment method. Code[10]. Default: CREDITCARD.';
        }

        // --------------------------------------------------
        // Ship-to Code (Code[10])
        // --------------------------------------------------
        field(24; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            DataClassification = ToBeClassified;
            ToolTip = 'Default ship-to code. Code[10].';
        }

        // --------------------------------------------------
        // Integration Control Fields (not from CRM payload)
        // --------------------------------------------------

        // Integration Status (Mandatory per sheet)
        field(90; "Integration Status"; Enum "CRM Integration Status")
        {
            Caption = 'Integration Status';
            DataClassification = ToBeClassified;
            ToolTip = 'Open / Success / Failed. Updated after BC processing.';
        }

        // Last error message when status = Failed
        field(91; "Error Message"; Text[250])
        {
            Caption = 'Error Message';
            DataClassification = ToBeClassified;
            ToolTip = 'Error detail when Integration Status = Failed.';
        }

        // Timestamps for audit trail
        field(92; "Created DateTime"; DateTime)
        {
            Caption = 'Created DateTime';
            DataClassification = ToBeClassified;
        }

        field(93; "Processed DateTime"; DateTime)
        {
            Caption = 'Processed DateTime';
            DataClassification = ToBeClassified;
        }

        // Retry counter — incremented on each failed attempt
        field(94; "Retry Count"; Integer)
        {
            Caption = 'Retry Count';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
         field(19; State; Code[20])
        {
            Caption = 'State';
            DataClassification = CustomerContent;
            ToolTip = 'State. Code[20].';
        }
        field(25; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = ToBeClassified;
            ToolTip = 'Location Code. Code[10].';
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        // Secondary key to quickly filter Open/Failed records for Job Queue
        key(Status; "Integration Status") { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Name, "Integration Status") { }
    }
}
