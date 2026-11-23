tableextension 50039 tableextension70000619 extends "Return Receipt Line"
{
    // <changelog>
    //   <add id="NA0001" dev="ELYNCH" date="2006-02-21" area="ORDERENTRY" feature="607"
    //     releaseversion="NAVUS3.01">Added field and code for Package Tracking</add>
    // </changelog>
    // 
    // MER0001 TLE 05/28/14 Add Fields 50001..50005
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
        field(50001; "Burden Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'MER0001';
        }
        field(50002; "Vendor No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'MER0001';
        }
        field(50003; "Vendor Cross Reference No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'MER0001';
        }
        field(50004; "Line Amount Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'MER0001';
        }
        field(50005; "Line Amount Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'MER0001';
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "GetCurrencyCode(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "ShowItemTrackingLines(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "InsertInvLineFromRetRcptLine(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "FilterPstdDocLnItemLedgEntries(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "ShowItemSalesCrMemoLines(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "ShowLineComments(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "InitFromSalesLine(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFieldsFromReturnReceiptLine(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitFromSalesLine(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "OnAftertInsertInvLineFromRetRcptLine(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInsertInvLineFromRetRcptLine(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInsertInvLineFromRetRcptLineBeforeInsertTextLine(PROCEDURE 12)".

}

