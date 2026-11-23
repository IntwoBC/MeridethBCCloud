tableextension 50021 tableextension70000048 extends "Sales Cr.Memo Line"
{
    // <changelog>
    //   <add id="NA0001" dev="ELYNCH" date="2006-02-21" area="ORDERENTRY" feature="607"
    //     releaseversion="NAVUS3.01">Added field for Package Tracking</add>
    // </changelog>
    // 
    // MER0001 CH (TLE) 04/08/14 Add "Line Amount Price" and "Line Amount Cost"
    // MER0002 TLE 04/10/14 Add "Burden Amount","Vendor No.","Vendor Cross Ref. No."
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
        modify("Amount Including VAT")
        {
            Caption = 'Amount Including VAT';
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
        modify("VAT Difference")
        {
            Caption = 'VAT Difference';
        }
        modify("VAT Identifier")
        {
            Caption = 'VAT Identifier';
        }
        field(50001; "Burden Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'MER0002';
        }
        field(50002; "Vendor No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'MER0002';
        }
        field(50003; "Vendor Cross Reference No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'MER0002';
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


    //Unsupported feature: Property Modification (Attributes) on "CalcVATAmountLines(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "GetLineAmountExclVAT(PROCEDURE 149)".


    //Unsupported feature: Property Modification (Attributes) on "GetLineAmountInclVAT(PROCEDURE 151)".


    //Unsupported feature: Property Modification (Attributes) on "GetCaptionClass(PROCEDURE 34)".


    //Unsupported feature: Property Modification (Attributes) on "RowID1(PROCEDURE 44)".


    //Unsupported feature: Property Modification (Attributes) on "GetReturnRcptLines(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "GetItemLedgEntries(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "FilterPstdDocLineValueEntries(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "ShowItemReturnRcptLines(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "ShowLineComments(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "ShowShortcutDimCode(PROCEDURE 27)".


    //Unsupported feature: Property Modification (Attributes) on "InitFromSalesLine(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDeferrals(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "GetDocumentType(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "HasTypeToFillMandatoryFields(PROCEDURE 103)".


    //Unsupported feature: Property Modification (Attributes) on "FormatType(PROCEDURE 144)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitFromSalesLine(PROCEDURE 10)".

}

