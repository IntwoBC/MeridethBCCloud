tableextension 50017 tableextension70000041 extends "Sales Shipment Line"
{
    // <changelog>
    //   <add id="NA0001" dev="ELYNCH" date="2006-02-09" area="ORDERENTRY" feature="607"
    //     releaseversion="NAVUS3.10.01">Added field, key and code for Package Tracking</add>
    // </changelog>
    // 
    // MER0001 CH  04/04/14 Add LineAmountPrice and LineAmountCost fields
    fields
    {
        modify("Unit Cost (LCY)")
        {
            Caption = 'Unit Cost (LCY)';
        }
        modify("VAT %")
        {
            Caption = 'VAT %';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'VAT Bus. Posting Group';
        }
        modify("VAT Prod. Posting Group")
        {
            Caption = 'VAT Prod. Posting Group';
        }
        modify("VAT Base Amount")
        {
            Caption = 'VAT Base Amount';
        }
        field(50004; "Line Amount Price"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'LineAmountPrice';
            Description = 'MER0001';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(50005; "Line Amount Cost"; Decimal)
        {
            Caption = 'LineAmountCost';
            Description = 'MER0001';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {

        //Unsupported feature: Property Insertion (SumIndexFields) on ""Document No.","Line No."(Key)".


        //Unsupported feature: Property Insertion (SumIndexFields) on ""Blanket Order No.","Blanket Order Line No."(Key)".


        //Unsupported feature: Property Insertion (SumIndexFields) on ""Item Shpt. Entry No."(Key)".


        //Unsupported feature: Property Insertion (SumIndexFields) on ""Sell-to Customer No."(Key)".


        //Unsupported feature: Property Insertion (SumIndexFields) on ""Bill-to Customer No."(Key)".


        //Unsupported feature: Property Insertion (SumIndexFields) on ""Document No.","Package Tracking No."(Key)".

    }

    //Unsupported feature: Property Modification (Attributes) on "GetCurrencyCode(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "ShowItemTrackingLines(PROCEDURE 6500)".


    //Unsupported feature: Property Modification (Attributes) on "InsertInvLineFromShptLine(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "CalcShippedSaleNotReturned(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "FilterPstdDocLnItemLedgEntries(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "ShowItemSalesInvLines(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "StartTrackingSite(PROCEDURE 10000)".



    //Unsupported feature: Code Modification on "StartTrackingSite(PROCEDURE 10000)".

    //procedure StartTrackingSite();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesShptHeader.Get("Document No.");
    SalesShptHeader.StartTrackingSite("Package Tracking No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //NA0001.begin
    SalesShptHeader.Get("Document No.");
    SalesShptHeader.StartTrackingSite("Package Tracking No.");
    //NA0001.end
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "ShowLineComments(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "ShowAsmToOrder(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "ShowShortcutDimCode(PROCEDURE 27)".


    //Unsupported feature: Property Modification (Attributes) on "AsmToShipmentExists(PROCEDURE 72)".


    //Unsupported feature: Property Modification (Attributes) on "InitFromSalesLine(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "FormatType(PROCEDURE 144)".


    //Unsupported feature: Property Modification (Attributes) on "GetCaptionClass(PROCEDURE 34)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterClearSalesLineValues(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitFromSalesLine(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInsertInvLineFromShptLine(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInsertInvLineFromShptLine(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInsertInvLineFromShptLineBeforeInsertTextLine(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCodeInsertInvLineFromShptLine(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "OnInsertInvLineFromShptLineOnAfterUpdatePrepaymentsAmounts(PROCEDURE 20)".

}

