// ============================================================
// Table: CRM Item Staging
// Object ID  : 50102
// Publisher  : Intwo
// Direction  : PUSH — BC Item data is read and staged here,
//              then the codeunit pushes it to CRM via API.
// Source Map : BC-CRM_Integration_Field_Mapping
//              _Item_Master_Push_from_BC.xlsx  (object 27-ITEM)
//
// Design notes:
//   • This table holds BC Item data ready to be sent to CRM.
//   • The codeunit reads BC Item table and populates this table,
//     then calls the CRM API endpoint.
//   • Integration Status tracks the outbound push result.
//   • Fields exactly match the mapping sheet columns.
// ============================================================
table 50102 "CRM Item Staging"
{
    Caption = 'CRM Item Staging';
    DataClassification = CustomerContent;

    fields
    {
        // --------------------------------------------------
        // No. (Code[20], Mandatory)
        // BC Item No. — primary key from BC Item table.
        // --------------------------------------------------
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            NotBlank = true;
            ToolTip = 'BC Item No. Mandatory. Code[20]. Primary key.';
        }

        // --------------------------------------------------
        // Description (Text[100])
        // BC Item.Description
        // --------------------------------------------------
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            ToolTip = 'Item description. Text[100].';
        }

        // --------------------------------------------------
        // Item Category Code (Code[20])
        // BC Item.Item Category Code — maps to CRM product category
        // --------------------------------------------------
        field(3; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            DataClassification = CustomerContent;
            ToolTip = 'Item category. Code[20].';
        }

        // --------------------------------------------------
        // Unit Cost (Decimal)
        // BC Item.Unit Cost — maps to CRM product list price
        // --------------------------------------------------
        field(4; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            DataClassification = CustomerContent;
            MinValue = 0;
            ToolTip = 'Unit cost. Decimal. Copied from BC Item.Unit Cost.';
        }

        // --------------------------------------------------
        // Base Unit of Measure (Code[10])
        // BC Item.Base Unit of Measure
        // --------------------------------------------------
        field(5; "Base Unit of Measure"; Code[10])
        {
            Caption = 'Base Unit of Measure';
            DataClassification = CustomerContent;
            ToolTip = 'Base unit of measure. Code[10].';
        }

        // --------------------------------------------------
        // Integration Status (Boolean/Enum, Mandatory per sheet)
        // Tracks outbound push result: Open/Success/Failed
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

        // CRM Record ID returned after successful push
        // Stored for future update/delete operations
        field(95; "CRM Record ID"; Text[50])
        {
            Caption = 'CRM Record ID';
            DataClassification = SystemMetadata;
            ToolTip = 'CRM product/item ID returned after a successful push.';
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
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Status; "Integration Status") { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Description, "Integration Status") { }
    }
}
