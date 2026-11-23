tableextension 50045 tableextension70000323 extends "Detailed CV Ledg. Entry Buffer"
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
        modify("VAT Amount (LCY)")
        {
            Caption = 'VAT Amount (LCY)';
        }
        /* field(37028300; "EFT Store No."; Code[10])
         {
             DataClassification = ToBeClassified;
             Caption = 'EFT Store No.';
             //TableRelation = Table37028302;
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
             //TableRelation = Table37028310.Field3 WHERE (Field1=FIELD("EFT Store No."),
             // Field2=FIELD("EFT Terminal No."));
         }*/
    }

    //Unsupported feature: Property Modification (Attributes) on "InsertDtldCVLedgEntry(PROCEDURE 53)".


    //Unsupported feature: Property Modification (Attributes) on "CopyPostingGroupsFromVATEntry(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromGenJnlLine(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "InitFromGenJnlLine(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromCVLedgEntryBuf(PROCEDURE 20)".


    //Unsupported feature: Property Modification (Attributes) on "InitDtldCVLedgEntryBuf(PROCEDURE 26)".


    //Unsupported feature: Property Modification (Attributes) on "FindVATEntry(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromGenJnlLine(PROCEDURE 1001)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromCVLedgEntryBuf(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInsertDtldCVLedgEntry(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "OnInsertDtldCVLedgEntryOnBeforeInsert(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "OnInsertDtldCVLedgEntryOnBeforeModify(PROCEDURE 6)".

}

