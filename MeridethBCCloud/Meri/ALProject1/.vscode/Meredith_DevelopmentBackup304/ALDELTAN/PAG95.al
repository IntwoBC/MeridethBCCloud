pageextension 50013 pageextension50013 extends "Sales Quote Subform"
{
    // <changelog>
    //   <add id="NA0000" dev="ELYNCH" date="2006-02-03" area="NASALESTAX" feature="617"
    //     releaseversion="NAVNA4.00">Added fields for NA Sales Tax</add>
    //   <change id="NA0002" dev="ELYNCH" date="2006-02-21" area="ORDERENTRY" feature="607"
    //     releaseversion="NAVNA4.00">Added AutoReserve parameter</change>
    // </changelog>
    // 
    // MER0001 TLE 02/18/14 Add LineAmountCost,"Burden Amount","Vendor No.","Vendor Cross Reference No.","Purchase Order No.","Purch. Order Line No."
    //   Update (F5) to refresh page.
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


        //Unsupported feature: Code Modification on ""No."(Control 4).OnValidate".

        //trigger "(Control 4)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ShowShortcutDimCode(ShortcutDimCode);
        NoOnAfterValidate;
        UpdateEditableOnRow;
        UpdateTypeText;
        DeltaUpdateTotals;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ShowShortcutDimCode(ShortcutDimCode);
        NoOnAfterValidate;



        //IF xRec."No." <> '' THEN
          //RedistributeTotalsOnAfterValidate;


        #3..5
        */
        //end;


        //Unsupported feature: Code Modification on "Quantity(Control 8).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        QuantityOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        QuantityOnAfterValidate;


        // RedistributeTotalsOnAfterValidate;
        */
        //end;


        //Unsupported feature: Code Insertion on ""Unit Cost (LCY)"(Control 18)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        // MER0001 >>
        SendF5;
        // MER0001 <<
        */
        //end;


        //Unsupported feature: Code Modification on ""Unit Price"(Control 12).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DeltaUpdateTotals;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*


        //RedistributeTotalsOnAfterValidate;

        DeltaUpdateTotals;
        */
        //end;
        addafter(ShortcutDimCode8)
        {
            field(LineAmountCost; LineAmountCost)
            {
                ApplicationArea = all;
                Caption = 'Line Amount Cost';
                Editable = false;
            }
            field("Burden Amount"; rec."Burden Amount")
            {
                ApplicationArea = all;
            }
            field("Purchase Order No."; rec."Purchase Order No.")
            {
                ApplicationArea = all;
            }
            field("Purch. Order Line No."; rec."Purch. Order Line No.")
            {
                ApplicationArea = all;
            }
            field("Vendor No."; rec."Vendor No.")
            {
                ApplicationArea = all;
            }
            field("Vendor Cross Reference No."; rec."Vendor Cross Reference No.")
            {
                ApplicationArea = all;
            }
        }
    }

    var
        LineAmountCost: Decimal;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ShowShortcutDimCode(ShortcutDimCode);
    UpdateTypeText;
    SetItemChargeFieldsStyle;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ShowShortcutDimCode(ShortcutDimCode);

    UpdateTypeText;
    SetItemChargeFieldsStyle;
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "ApproveCalcInvDisc(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "CalcInvDisc(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "InsertExtendedText(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateForm(PROCEDURE 12)".



    //Unsupported feature: Code Modification on "QuantityOnAfterValidate(PROCEDURE 19032465)".

    //procedure QuantityOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if Reserve = Reserve::Always then begin
      CurrPage.SaveRecord;
      AutoReserve;
    end;
    DeltaUpdateTotals;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if Reserve = Reserve::Always then begin
      CurrPage.SaveRecord;

      AutoReserve;

    end;
    DeltaUpdateTotals;
    */
    //end;


    //Unsupported feature: Code Modification on "UnitofMeasureCodeOnAfterValida(PROCEDURE 19057939)".

    //procedure UnitofMeasureCodeOnAfterValida();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if Reserve = Reserve::Always then begin
      CurrPage.SaveRecord;
      AutoReserve;
    end;
    DeltaUpdateTotals;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if Reserve = Reserve::Always then begin
      CurrPage.SaveRecord;

      AutoReserve;

    end;
    DeltaUpdateTotals;
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInsertExtendedText(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "OnCrossReferenceNoOnLookup(PROCEDURE 5)".


    procedure SendF5()
    begin
        // BC25: replaces the BC14 WshShell.SendKeys('{F5}') automation (not supported) - refreshes page and factboxes
        if not GuiAllowed then
            exit;
        CurrPage.Update(false);
    end;
}

