pageextension 50014 pageextension50014 extends "Sales Cr. Memo Subform"
{
    // <changelog>
    //   <add id="NA0000" dev="ELYNCH" date="2006-02-03" area="NASALESTAX" feature="617"
    //     releaseversion="NAVNA4.00">Added fields for NA Sales Tax</add>
    //   <change id="NA0002" dev="ELYNCH" date="2006-02-21" area="ORDERENTRY" feature="607"
    //     releaseversion="NAVNA4.00">Added AutoReserve parameter</change>
    // </changelog>
    // 
    // MER0001 TLE 02/12/14 Add "Burden Amount","Vendor No.","Vendor Cross Reference No."
    // MER0002 TLE 04/22/14 SendF5
    layout
    {


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


        //Unsupported feature: Code Insertion on ""Unit Cost (LCY)"(Control 70)".

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
            field("Line Amount Cost"; rec."Line Amount Cost")
            {
                ApplicationArea = all;
                Caption = 'Line Amount Cost';
            }
            field("Burden Amount"; rec."Burden Amount")
            {
                ApplicationArea = all;
            }
            field("Vendor No."; rec."Vendor No.")
            {
                ApplicationArea = all;

                trigger OnValidate()
                begin
                    // MER0002 >>
                    SendF5;
                    // MER0002 <<
                end;
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
    SetItemChargeFieldsStyle
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ShowShortcutDimCode(ShortcutDimCode);

    UpdateTypeText;
    SetItemChargeFieldsStyle
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "ApproveCalcInvDisc(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "CalcInvDisc(PROCEDURE 60)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateForm(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInsertExtendedText(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "OnCrossReferenceNoOnLookup(PROCEDURE 4)".


    procedure SendF5()
    begin
        // BC25: replaces the BC14 WshShell.SendKeys('{F5}') automation (not supported) - refreshes page and factboxes
        if not GuiAllowed then
            exit;
        CurrPage.Update(false);
    end;
}

