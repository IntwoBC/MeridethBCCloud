// ============================================================
// Table: CRM Sales Inv. Line Staging
// Object ID  : 50104
// Publisher  : Intwo
// Direction  : PUSH — BC Posted Sales Invoice Lines staged here
//              then pushed to CRM alongside the header record.
// Source Map : BC-CRM_Integration_Field_Mapping
//              _Sales_Invoice_Push_from_BC.xlsx
//              Section: 113-POSTED SALES INVOICE-LINES
//
// Design notes:
//   • Composite PK: Document No. + Line No. (mirrors BC table 113).
//   • Document No. is a FK to CRM Sales Inv. Header Staging (50103).
//   • All mandatory fields from sheet are validated in codeunit.
//   • "Vendor Cross Reference No." and "Vendor No." are optional
//     informational fields from BC side.
// ============================================================
table 50104 "CRM Sales Inv. Line Staging"
{
    Caption = 'CRM Sales Inv. Line Staging';
    DataClassification = CustomerContent;

    fields
    {
        // --------------------------------------------------
        // Document No. (Code[20], Mandatory)
        // Links to CRM Sales Inv. Header Staging."No."
        // Sheet remark: "Header No."
        // --------------------------------------------------
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
            NotBlank = true;
            ToolTip = 'Posted Sales Invoice No. (Header reference). Mandatory. Code[20].';
        }

        // --------------------------------------------------
        // Line No. (Integer, Mandatory)
        // Sequence number within the invoice (10000, 20000, ...)
        // --------------------------------------------------
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
            MinValue = 1;
            ToolTip = 'Line sequence number. Mandatory. Integer.';
        }

        // --------------------------------------------------
        // Type (Option, Mandatory)
        // BC options: "" | Item | Resource | G/L Account | ...
        // --------------------------------------------------
        field(3; Type; Option)
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            OptionMembers = " ",Item,"G/L Account",Resource,"Fixed Asset","Charge (Item)";
            OptionCaption = ' ,Item,G/L Account,Resource,Fixed Asset,Charge (Item)';
            ToolTip = 'Line type. Mandatory. Usually Item for product lines.';
        }

        // --------------------------------------------------
        // No. (Code[20], Mandatory)
        // Item No. / G/L Account No. depending on Type
        // --------------------------------------------------
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            ToolTip = 'Item No. or G/L Account No. Mandatory. Code[20].';
        }

        // --------------------------------------------------
        // Description (Text[100])
        // --------------------------------------------------
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            ToolTip = 'Line description. Text[100].';
        }

        // --------------------------------------------------
        // Location Code (Code[10], Mandatory)
        // --------------------------------------------------
        field(6; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
            ToolTip = 'Warehouse location. Mandatory. Code[10].';
        }

        // --------------------------------------------------
        // Quantity (Decimal, Mandatory)
        // --------------------------------------------------
        field(7; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
            ToolTip = 'Invoiced quantity. Mandatory. Decimal.';
        }

        // --------------------------------------------------
        // Unit of Measure Code (Code[10], Mandatory)
        // --------------------------------------------------
        field(8; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            DataClassification = CustomerContent;
            ToolTip = 'Unit of measure. Mandatory. Code[10].';
        }

        // --------------------------------------------------
        // Unit Price Excl. Tax (Decimal, Mandatory)
        // BC field: "Unit Price" on posted lines
        // --------------------------------------------------
        field(9; "Unit Price Excl. Tax"; Decimal)
        {
            Caption = 'Unit Price Excl. Tax';
            DataClassification = CustomerContent;
            ToolTip = 'Unit price excluding tax. Mandatory. Decimal.';
        }

        // --------------------------------------------------
        // Shipment Date (Date)
        // --------------------------------------------------
        field(10; "Shipment Date"; Date)
        {
            Caption = 'Shipment Date';
            DataClassification = CustomerContent;
            ToolTip = 'Shipment date for this line. Date.';
        }

        // --------------------------------------------------
        // Unit Cost (Decimal)
        // --------------------------------------------------
        field(11; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            DataClassification = CustomerContent;
            ToolTip = 'Unit cost at time of invoice. Decimal.';
        }

        // --------------------------------------------------
        // Vendor Cross Reference No. (Code[20])
        // Optional — vendor's item number
        // --------------------------------------------------
        field(12; "Vendor Cross Reference No."; Code[20])
        {
            Caption = 'Vendor Cross Reference No.';
            DataClassification = CustomerContent;
            ToolTip = 'Vendor cross-reference item number. Code[20].';
        }

        // --------------------------------------------------
        // Vendor No. (Code[10])
        // Note: BC Vendor No. is Code[20]; mapping shows 10 —
        //       using Code[20] to match BC table safely.
        // --------------------------------------------------
        field(13; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = CustomerContent;
            ToolTip = 'Vendor No. linked to the item. Code[20].';
        }

        // --------------------------------------------------
        // Tax Area Code (Code[20], Mandatory)
        // --------------------------------------------------
        field(14; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            DataClassification = CustomerContent;
            ToolTip = 'Tax area code. Mandatory. Code[20].';
        }

        // --------------------------------------------------
        // Tax Group Code (Code[20], Mandatory)
        // --------------------------------------------------
        field(15; "Tax Group Code"; Code[20])
        {
            Caption = 'Tax Group Code';
            DataClassification = CustomerContent;
            ToolTip = 'Tax group code. Mandatory. Code[20].';
        }

        // --------------------------------------------------
        // Line Amount Excl. Tax (Decimal, Mandatory)
        // BC field: "Line Amount"
        // --------------------------------------------------
        field(16; "Line Amount Excl. Tax"; Decimal)
        {
            Caption = 'Line Amount Excl. Tax';
            DataClassification = CustomerContent;
            ToolTip = 'Line amount excluding tax. Mandatory. Decimal.';
        }

        // --------------------------------------------------
        // Amount Including VAT (Decimal, Mandatory)
        // BC field: "Amount Including VAT"
        // --------------------------------------------------
        field(17; "Amount Including VAT"; Decimal)
        {
            Caption = 'Amount Including VAT';
            DataClassification = CustomerContent;
            ToolTip = 'Amount including VAT/tax. Mandatory. Decimal.';
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

        field(92; "Processed DateTime"; DateTime)
        {
            Caption = 'Processed DateTime';
            DataClassification = SystemMetadata;
        }
        field(93; "CRM Line ID"; Text[50])
        {
            Caption = 'CRM Line ID';
            DataClassification = SystemMetadata;
            ToolTip = 'ID returned by CRM after the line is created via the Lines API.';
        }
        field(94; "Retry Count"; Integer)
        {
            Caption = 'Retry Count';
            DataClassification = SystemMetadata;
        }
        field(95; "Line Discount Amount"; Decimal)
        {
            Caption = 'Line Discount Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Total discount amount for the line. Decimal.';
        }
    }

    keys
    {
        // Composite PK matching BC table 113
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Status; "Integration Status") { }
        key(DocNo; "Document No.") { }
    }
}
