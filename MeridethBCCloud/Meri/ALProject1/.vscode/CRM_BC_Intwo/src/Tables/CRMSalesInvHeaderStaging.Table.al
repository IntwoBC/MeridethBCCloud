// ============================================================
// Table: CRM Sales Inv. Header Staging
// Object ID  : 50103
// Publisher  : Intwo
// Direction  : PUSH — BC Posted Sales Invoice Header is staged
//              here, then pushed to CRM via API.
// Source Map : BC-CRM_Integration_Field_Mapping
//              _Sales_Invoice_Push_from_BC.xlsx
//              Section: 112-POSTED SALES INVOICE-HEADER
//
// Design notes:
//   • Mirrors BC table 112 "Sales Invoice Header" field by field.
//   • Mandatory fields (Posting Date, Sell-to Customer No.,
//     Tax Area Code, Tax Liable) validated in codeunit.
//   • One header record → multiple line records in Table 50104.
// ============================================================
table 50103 "CRM Sales Inv. Header Staging"
{
    Caption = 'CRM Sales Inv. Header Staging';
    DataClassification = CustomerContent;

    fields
    {
        // --------------------------------------------------
        // No. (Code[20], Mandatory)
        // Posted Sales Invoice No. — e.g. SINV-00001
        // --------------------------------------------------
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            NotBlank = true;
            ToolTip = 'Posted Sales Invoice No. Mandatory. Code[20].';
        }

        // --------------------------------------------------
        // Sell-to Customer No. (Code[20], Mandatory)
        // --------------------------------------------------
        field(2; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            DataClassification = CustomerContent;
            ToolTip = 'Sell-to Customer No. Mandatory. Code[20].';
        }

        // --------------------------------------------------
        // Bill-to address fields (from mapping sheet)
        // --------------------------------------------------
        field(3; "Bill-to City"; Text[30])
        {
            Caption = 'Bill-to City';
            DataClassification = CustomerContent;
            ToolTip = 'Bill-to City. Text[30].';
        }

        field(4; "Bill-to Country/Region Code"; Code[10])
        {
            Caption = 'Bill-to Country/Region Code';
            DataClassification = CustomerContent;
            ToolTip = 'Bill-to Country/Region Code. Code[10].';
        }

        field(5; "Bill-to Address"; Text[100])
        {
            Caption = 'Bill-to Address';
            DataClassification = CustomerContent;
            ToolTip = 'Bill-to Address line 1. Text[100].';
        }

        field(6; "Bill-to Address 2"; Text[50])
        {
            Caption = 'Bill-to Address 2';
            DataClassification = CustomerContent;
            ToolTip = 'Bill-to Address line 2. Text[50].';
        }

        field(7; "Bill-to Contact"; Text[100])
        {
            Caption = 'Bill-to Contact';
            DataClassification = CustomerContent;
            ToolTip = 'Bill-to Contact name. Text[100].';
        }

        field(8; "Bill-to Post Code"; Code[20])
        {
            Caption = 'Bill-to Post Code';
            DataClassification = CustomerContent;
            ToolTip = 'Bill-to Postal Code. Code[20].';
        }

        // --------------------------------------------------
        // Shipment Date (Date)
        // --------------------------------------------------
        field(9; "Shipment Date"; Date)
        {
            Caption = 'Shipment Date';
            DataClassification = CustomerContent;
            ToolTip = 'Shipment date. Date.';
        }

        // --------------------------------------------------
        // Ship-to address fields
        // --------------------------------------------------
        field(10; "Ship-to City"; Text[30])
        {
            Caption = 'Ship-to City';
            DataClassification = CustomerContent;
            ToolTip = 'Ship-to City. Text[30].';
        }

        field(11; "Ship-to Country/Region Code"; Code[10])
        {
            Caption = 'Ship-to Country/Region Code';
            DataClassification = CustomerContent;
            ToolTip = 'Ship-to Country/Region Code. Code[10].';
        }

        field(12; "Ship-to Address"; Text[100])
        {
            Caption = 'Ship-to Address';
            DataClassification = CustomerContent;
            ToolTip = 'Ship-to Address line 1. Text[100].';
        }

        field(13; "Ship-to Address 2"; Text[50])
        {
            Caption = 'Ship-to Address 2';
            DataClassification = CustomerContent;
            ToolTip = 'Ship-to Address line 2. Text[50].';
        }

        field(14; "Ship-to Contact"; Text[100])
        {
            Caption = 'Ship-to Contact';
            DataClassification = CustomerContent;
            ToolTip = 'Ship-to Contact name. Text[100].';
        }

        field(15; "Ship-to Post Code"; Code[20])
        {
            Caption = 'Ship-to Post Code';
            DataClassification = CustomerContent;
            ToolTip = 'Ship-to Postal Code. Code[20].';
        }

        // --------------------------------------------------
        // Bill-to Customer No. (Code[20])
        // --------------------------------------------------
        field(16; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            DataClassification = CustomerContent;
            ToolTip = 'Bill-to Customer No. Code[20].';
        }

        // --------------------------------------------------
        // Order No. (Code[20])
        // Original sales order reference
        // --------------------------------------------------
        field(17; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            DataClassification = CustomerContent;
            ToolTip = 'Originating Sales Order No. Code[20].';
        }

        // --------------------------------------------------
        // Posting Date (Date, Mandatory)
        // --------------------------------------------------
        field(18; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
            ToolTip = 'Invoice posting date. Mandatory. Date.';
        }

        // --------------------------------------------------
        // External Document No. (Code[35])
        // --------------------------------------------------
        field(19; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
            DataClassification = CustomerContent;
            ToolTip = 'External reference (PO number). Code[35].';
        }

        // --------------------------------------------------
        // Currency Code (Code[10])
        // --------------------------------------------------
        field(20; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = CustomerContent;
            ToolTip = 'Invoice currency. Code[10].';
        }

        // --------------------------------------------------
        // Payment Terms Code (Code[10])
        // --------------------------------------------------
        field(21; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            DataClassification = CustomerContent;
            ToolTip = 'Payment terms. Code[10].';
        }

        // --------------------------------------------------
        // Payment Method Code (Code[10])
        // --------------------------------------------------
        field(22; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            DataClassification = CustomerContent;
            ToolTip = 'Payment method. Code[10].';
        }

        // --------------------------------------------------
        // Tax Liable (Boolean, Mandatory)
        // --------------------------------------------------
        field(23; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
            DataClassification = CustomerContent;
            ToolTip = 'Tax liable flag. Mandatory.';
        }

        // --------------------------------------------------
        // Tax Area Code (Code[20], Mandatory)
        // --------------------------------------------------
        field(24; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            DataClassification = CustomerContent;
            ToolTip = 'Tax area code. Mandatory. Code[20].';
        }

        // --------------------------------------------------
        // Location Code (Code[10])
        // --------------------------------------------------
        field(25; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
            ToolTip = 'Warehouse location. Code[10].';
        }

        // --------------------------------------------------
        // Ship-to Code (Code[10])
        // --------------------------------------------------
        field(26; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            DataClassification = CustomerContent;
            ToolTip = 'Ship-to address code. Code[10].';
        }

        // --------------------------------------------------
        // Integration Control Fields
        // --------------------------------------------------
        field(90; "Integration Status"; Enum "CRM Integration Status")
        {
            Caption = 'Integration Status';
            DataClassification = SystemMetadata;
            ToolTip = 'Open / Success / Failed. Updated after CRM push.';
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

        // CRM Invoice ID returned after successful push
        field(95; "CRM Invoice ID"; Text[50])
        {
            Caption = 'CRM Invoice ID';
            DataClassification = SystemMetadata;
            ToolTip = 'CRM invoice record ID returned after a successful push.';
        }
        field(96; "Due Date"; Date)
        {
            Caption = 'Due Date';
            DataClassification = CustomerContent;
            ToolTip = 'Invoice due date. Date.';
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Customer; "Sell-to Customer No.") { }
        key(Status; "Integration Status") { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Sell-to Customer No.", "Posting Date", "Integration Status") { }
    }
}
