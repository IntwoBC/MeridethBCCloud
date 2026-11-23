pageextension 50026 pageextension70000472 extends "Dimension Values"
{
    // MDI0001 TLE 07/09/14 Add "Is GSA"
    layout
    {
        addafter("Consolidation Code")
        {
            field("Is GSA"; Rec."Is GSA")
            {
                ApplicationArea = all;
            }
        }
    }
}

