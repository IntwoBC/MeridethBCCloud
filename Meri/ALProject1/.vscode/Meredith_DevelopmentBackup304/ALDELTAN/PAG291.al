pageextension 50022 pageextension70000285 extends "Req. Worksheet"
{
    // MER0001 TLE 12/17/13 Add "Sales Order No.", "Sales Order Line No."
    layout
    {
        addafter("Planning Flexibility")
        {
            field("Sales Order No."; rec."Sales Order No.")
            {
                ApplicationArea = all;
            }
            field("Sales Order Line No."; rec."Sales Order Line No.")
            {
                ApplicationArea = all;
            }
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "OnBeforeOpenReqWorksheet(PROCEDURE 1)".

}

