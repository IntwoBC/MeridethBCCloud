pageextension 50027 pageextension70000419 extends "Salesperson/Purchaser Card"
{
    // MER0001 TLE 12/06/13 Add "Eligible for Mark Up'
    // MER0001 TLE 01/29/14 Add "Restrict view to self"
    layout
    {
        addafter("Next Task Date")
        {
            field("Eligible for Mark Up"; Rec."Eligible for Mark Up")
            {
                ApplicationArea = all;
            }
            field("Restrict view to self"; Rec."Restrict view to self")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addafter("T&asks")
        {
            action("Sales &Goals")
            {
                Caption = 'Sales &Goals';
                Image = AvailableToPromise;
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Salesperson Goal List";
                RunPageLink = "Salesperson Code" = FIELD(Code);
                RunPageView = SORTING("Salesperson Code", Year, Month);
            }
        }
    }
}

