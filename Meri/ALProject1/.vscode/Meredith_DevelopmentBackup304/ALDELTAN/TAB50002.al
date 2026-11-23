table 50002 "SIL SCrML Union"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; Type; Option)
        {
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        }
        field(4; "No."; Code[20])
        {
        }
        field(5; "Shipment Date"; Date)
        {
        }
        field(6; Description; Text[50])
        {
        }
        field(7; Quantity; Decimal)
        {
        }
        field(8; "Unit Price"; Decimal)
        {
        }
        field(9; "Unit Cost (LCY)"; Decimal)
        {
        }
        field(10; "Vendor No."; Code[20])
        {
        }
        field(11; "Sell-to Customer No."; Code[20])
        {
        }
        field(12; "Salesperson Code"; Code[10])
        {
        }
        field(13; "Vendor Cross Reference No."; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

