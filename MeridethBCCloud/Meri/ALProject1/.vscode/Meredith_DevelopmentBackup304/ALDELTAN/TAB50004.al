table 50004 "Document Commission Charges"
{

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(3; "Salesperson Commission Amount"; Decimal)
        {
        }
        field(4; "Salesperson Order Fee"; Decimal)
        {
        }
        field(5; "Salesperson Misc. Charge"; Decimal)
        {
        }
        field(6; "Credit Card Charges"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Document Type", "No.")
        {
        }
    }

    fieldgroups
    {
    }
}

