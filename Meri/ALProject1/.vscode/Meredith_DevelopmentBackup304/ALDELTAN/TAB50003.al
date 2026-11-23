table 50003 "Extended Check Stub"
{
    // MER0001 TLE 04/01/14 Add "Posting Description"


    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; "Journal Template Name"; Code[10])
        {
        }
        field(3; "Journal Batch Name"; Code[10])
        {
        }
        field(4; "Check No."; Text[30])
        {
        }
        field(5; "Vendor No."; Code[20])
        {
        }
        field(6; "Vendor Name"; Text[50])
        {
        }
        field(7; "Check Date"; Date)
        {
        }
        field(8; "Document No."; Code[20])
        {
        }
        field(9; "Invoice Date"; Date)
        {
        }
        field(10; "External Document No."; Code[20])
        {
        }
        field(11; "Gross Amount"; Decimal)
        {
        }
        field(12; "Discount Amount"; Decimal)
        {
        }
        field(13; "Net Amount"; Decimal)
        {
        }
        field(14; "Posting Description"; Text[50])
        {
            Description = 'MER0001';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Check No.", "Vendor No.")
        {
        }
    }

    fieldgroups
    {
    }
}

