pageextension 50032 pageextension70000689 extends "Purchase Prices"
{
    // MER0001 TLE 02/04/14 Add "Marked up Cost"
    layout
    {
        addafter("Ending Date")
        {
            field("Marked up Cost"; Rec."Marked up Cost")
            {
                ApplicationArea = all;
            }
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "SetRecFilters(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "CheckFilters(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "GetSelectionFilter(PROCEDURE 5)".

}

