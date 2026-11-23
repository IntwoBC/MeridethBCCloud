tableextension 50029 tableextension70000282 extends "Payable Vendor Ledger Entry"
{
    // MER0001 TLE 05/20/14 Add "External Document No."
    fields
    {
        modify("Amount (LCY)")
        {
            Caption = 'Amount (LCY)';
        }
        field(50000; "External Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'MER0001';
        }
    }
}

