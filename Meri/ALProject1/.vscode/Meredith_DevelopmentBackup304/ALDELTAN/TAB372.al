tableextension 50031 tableextension70000314 extends "Payment Buffer"
{
    // MER0001 TLE 05/20/14 Add "External Document No."
    fields
    {
        field(50000; "External Document No."; Code[20])
        {
            Description = 'MER0001';
        }
    }
}

