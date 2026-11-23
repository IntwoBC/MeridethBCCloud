pageextension 50011 pageextension50011 extends "Sales Invoice Subform"
{
    // <changelog>
    //   <add id="NA0000" dev="ELYNCH" date="2006-02-03" area="ORDERENTRY" feature="607"
    //     releaseversion="NAVNA4.00">Sales Tax Fields</add>
    //   <change id="NA0001" dev="ELYNCH" date="2006-02-21" area="ORDERENTRY" feature="607"
    //     releaseversion="NAVNA4.00">Added AutoReserve Parameter</change>
    // </changelog>
    // 
    // MER0001 TLE 01/21/14 Add "Vendor No."
    layout
    {


        //Unsupported feature: Code Modification on "Type(Control 2).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        NoOnAfterValidate;
        UpdateEditableOnRow;
        UpdateTypeText;
        DeltaUpdateTotals;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*

        #1..4
        */
        //end;
        addafter("Line Discount %")
        {
            field("Vendor No."; rec."Vendor No.")
            {
                ApplicationArea = all;
            }
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "ApproveCalcInvDisc(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "CalcInvDisc(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "ExplodeBOM(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "GetShipment(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "InsertExtendedText(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePage(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "ShowPrices(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "ShowLineDisc(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "SetUpdateAllowed(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateAllowed(PROCEDURE 20)".



    //Unsupported feature: Code Modification on "ValidateAutoReserve(PROCEDURE 19032465)".

    //procedure ValidateAutoReserve();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if Reserve = Reserve::Always then begin
      CurrPage.SaveRecord;
      AutoReserve;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if Reserve = Reserve::Always then begin
      CurrPage.SaveRecord;

      AutoReserve;

    end;
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInsertExtendedText(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "OnCrossReferenceNoOnLookup(PROCEDURE 9)".

}

