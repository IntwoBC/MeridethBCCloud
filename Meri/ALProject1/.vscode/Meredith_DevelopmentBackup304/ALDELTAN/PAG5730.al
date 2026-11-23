pageextension 50028 pageextension70000516 extends "Item Categories"
{
    // MER0001 TLE 01/07/14 Add "Burden Rate"
    layout
    {
        addafter("Code")
        {
            field("   "; Rec."Burden Rate")
            {
                ApplicationArea = all;
                Caption = '<Burden Rate>';
            }
        }
    }
    actions
    {
        addfirst(reporting)
        {
            action("Item Burden Rate by Item Category")
            {
                Caption = 'Item Burden Rate by Item Category';
                Image = "Report";
                Promoted = true;
                RunObject = Report "Item Burden Rate by Item Cat.";
                ApplicationArea = all;
            }
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "GetSelectionFilter(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "SetSelection(PROCEDURE 1)".

}

