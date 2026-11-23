tableextension 50002 tableextension70000095 extends "Salesperson/Purchaser"
{
    // MER0001 TLE 12/06/13 Add "Eligible for Mark Up"
    // MER0002 TLE 01/29/14 Add "Restrict view to self"
    fields
    {
        modify("Estimated Value (LCY)")
        {
            Caption = 'Estimated Value (LCY)';
        }
        modify("Calcd. Current Value (LCY)")
        {
            Caption = 'Calcd. Current Value (LCY)';
        }
        modify("Cost (LCY)")
        {
            Caption = 'Cost (LCY)';
        }
        modify("Avg. Estimated Value (LCY)")
        {
            Caption = 'Avg. Estimated Value (LCY)';
        }
        modify("Avg.Calcd. Current Value (LCY)")
        {
            Caption = 'Avg.Calcd. Current Value (LCY)';
        }
        field(50000; "Eligible for Mark Up"; Boolean)
        {
            // Description = 'MER0001';
            DataClassification = ToBeClassified;

        }
        field(50001; "Restrict view to self"; Boolean)
        {
            //Description = 'MER0002';
            DataClassification = ToBeClassified;
        }
    }
}

