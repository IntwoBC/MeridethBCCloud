pageextension 50031 pageextension70000665 extends "Posted Return Receipt Subform"
{
    // MER0001 TLE 05/09/14 Add "Vendor No.","Vendor Cross Reference No.","Burden Amount"
    layout
    {
        addafter("Shortcut Dimension 2 Code")
        {
            field("Vendor No."; Rec."Vendor No.")
            {
                ApplicationArea = all;
            }
            field("Vendor Cross Reference No."; Rec."Vendor Cross Reference No.")
            {
                ApplicationArea = all;
            }
            field("Burden Amount"; Rec."Burden Amount")
            {
                ApplicationArea = all;
            }
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "ShowDocumentLineTracking(PROCEDURE 14)".

}

