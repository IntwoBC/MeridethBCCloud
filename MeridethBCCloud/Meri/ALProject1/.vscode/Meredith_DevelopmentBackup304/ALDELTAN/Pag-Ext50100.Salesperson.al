pageextension 50002 pageextension50002 extends "Salespersons/Purchasers"
{
    // MER0001 TLE 12/06/13 Add "Eligible for Mark Up"
    layout
    {
        addafter("Phone No.")
        {
            field("Eligible for Mark Up"; rec."Eligible for Mark Up")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("T&asks")
        {
            action("Sales &Goals")
            {
                ApplicationArea = All;
                Caption = 'Sales &Goals';
                Image = AvailableToPromise;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Salesperson Goal List";
                RunPageLink = "Salesperson Code" = FIELD(Code);
                RunPageView = SORTING("Salesperson Code", Year, Month);
            }
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "GetSelectionFilter(PROCEDURE 1)".

}

