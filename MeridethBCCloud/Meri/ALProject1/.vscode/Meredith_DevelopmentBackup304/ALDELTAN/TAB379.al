tableextension 50043 tableextension70000318 extends "Detailed Cust. Ledg. Entry"
{
    fields
    {
        modify("Amount (LCY)")
        {
            Caption = 'Amount (LCY)';
        }
        modify("Debit Amount (LCY)")
        {
            Caption = 'Debit Amount (LCY)';
        }
        modify("Credit Amount (LCY)")
        {
            Caption = 'Credit Amount (LCY)';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'VAT Bus. Posting Group';
        }
        modify("VAT Prod. Posting Group")
        {
            Caption = 'VAT Prod. Posting Group';
        }
        /*
        field(37028300; "EFT Store No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'EFT Store No.';
            // TableRelation = Table37028302;
        }
        field(37028301; "EFT Terminal No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'EFT Terminal No.';
            //TableRelation = Table37028303.Field2 WHERE (Field1=FIELD("EFT Store No."));
        }
        field(37028302; "EFT Transaction Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
            Caption = 'EFT Transaction Entry No.';
            //TableRelation = IF ("EFT Transaction Archive Status"=CONST(" ")) Table37028310.Field3 WHERE (Field1=FIELD("EFT Store No."),
            //Field2=FIELD("EFT Terminal No."))
            //  ELSE IF ("EFT Transaction Archive Status"=CONST(Archived)) Table37028357.Field3 WHERE (Field1=FIELD("EFT Store No."),
            // Field2=FIELD("EFT Terminal No."));
        }
        field(37028304; "EFT Transaction Archive Status"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'EFT Transaction Archive Status';
            Editable = false;
            OptionCaption = ' ,Archived,Purged';
            OptionMembers = " ",Archived,Purged;
        }*/
    }
    keys
    {
        // key(Key1; "EFT Store No.", "EFT Terminal No.", "EFT Transaction Entry No.")
        // {
        // }
    }

    //Unsupported feature: Property Modification (Attributes) on "UpdateDebitCredit(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "SetZeroTransNo(PROCEDURE 87)".


    //Unsupported feature: Property Modification (Attributes) on "GetUnrealizedGainLossAmount(PROCEDURE 2)".

}

