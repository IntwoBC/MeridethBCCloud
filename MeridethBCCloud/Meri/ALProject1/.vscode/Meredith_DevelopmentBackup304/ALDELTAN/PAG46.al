pageextension 50010 pageextension46 extends "Sales Order Subform"
{
    // <changelog>
    //   <add id="NA0001" dev="ELYNCH" date="2006-02-07" area="NASALESTAX" feature="617"
    //     releaseversion="NAVNA4.00">Added fields for NA Sales Tax</add>
    //   <change id="NA0002" dev="ELYNCH" date="2006-02-21" area="ORDERENTRY" feature="607"
    //     releaseversion="NAVNA4.00">Added field for Package Tracking</change>
    //   <change id="NA0003" dev="ELYNCH" date="2006-02-21" area="ORDERENTRY" feature="607"
    //     releaseversion="NAVNA4.00">Added AutoReserve Parameter</change>
    // </changelog>
    // 
    // MER0001 TLE 01/20/14 Add LineAmountCost,"Burden Amount","Vendor No.","Purchase Order No.","Purch. Order Line No."
    //   Update (F5) to refresh page.
    // MER0002 TLE 01/31/14 Add "Vendor Cross Reference No."
    // MER0003 TLE 04/18/14 Additional SendF5
    // MER0004 MT  02/24/16 Only do SendF5 if GUIALLOWED
    layout
    {


        //Unsupported feature: Code Modification on "Type(Control 2).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        NoOnAfterValidate;
        SetLocationCodeMandatory;
        UpdateEditableOnRow;
        UpdateTypeText;
        DeltaUpdateTotals;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*

        #1..5
        */
        //end;


        //Unsupported feature: Code Modification on "Quantity(Control 8).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        QuantityOnAfterValidate;
        DeltaUpdateTotals;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        QuantityOnAfterValidate;


        //RedistributeTotalsOnAfterValidate;

        DeltaUpdateTotals;
        */
        //end;


        //Unsupported feature: Code Insertion on ""Unit Cost (LCY)"(Control 38)".

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


        //Unsupported feature: Code Insertion on ""Qty. to Invoice"(Control 22)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        // MER0001 >>
        SendF5;
        // MER0001 <<
        */
        //end;
        addafter("Line No.")
        {
            field("Line Amount Cost"; rec."Line Amount Cost")
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

                trigger OnValidate()
                begin
                    // MER0003 >>
                    SendF5;
                    // MER0003 <<
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


    //Unsupported feature: Property Modification (Attributes) on "CalcInvDisc(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "ExplodeBOM(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "OpenPurchOrderForm(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "OpenSpecialPurchOrderForm(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "InsertExtendedText(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "ShowNonstockItems(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "ShowTracking(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "ItemChargeAssgnt(PROCEDURE 5800)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateForm(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "ShowPrices(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "ShowLineDisc(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "OrderPromisingLine(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDocumentLineTracking(PROCEDURE 26)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterQuantityOnAfterValidate(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInsertExtendedText(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "OnCrossReferenceNoOnLookup(PROCEDURE 7)".


    procedure SendF5()
    begin
        // BC25: replaces the BC14 WshShell.SendKeys('{F5}') automation (not supported) - refreshes page and factboxes
        if not GuiAllowed then
            exit;
        CurrPage.Update(false);
    end;
}

