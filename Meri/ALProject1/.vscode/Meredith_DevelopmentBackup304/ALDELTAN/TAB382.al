tableextension 50044 tableextension70000322 extends "CV Ledger Entry Buffer"
{
    fields
    {
        modify("Original Amt. (LCY)")
        {
            Caption = 'Original Amt. (LCY)';
        }
        modify("Remaining Amt. (LCY)")
        {
            Caption = 'Remaining Amt. (LCY)';
        }
        modify("Amount (LCY)")
        {
            Caption = 'Amount (LCY)';
        }
        modify("Sales/Purchase (LCY)")
        {
            Caption = 'Sales/Purchase (LCY)';
        }
        modify("Profit (LCY)")
        {
            Caption = 'Profit (LCY)';
        }
        modify("Inv. Discount (LCY)")
        {
            Caption = 'Inv. Discount (LCY)';
        }
        modify("Pmt. Disc. Given (LCY)")
        {
            Caption = 'Pmt. Disc. Given (LCY)';
        }
        modify("Closed by Amount (LCY)")
        {
            Caption = 'Closed by Amount (LCY)';
        }
        modify("Debit Amount (LCY)")
        {
            Caption = 'Debit Amount (LCY)';
        }
        modify("Credit Amount (LCY)")
        {
            Caption = 'Credit Amount (LCY)';
        }
        modify("Rounding Amount (LCY)")
        {
            Caption = 'Rounding Amount (LCY)';
        }
        modify("Pmt. Tolerance (LCY)")
        {
            Caption = 'Pmt. Tolerance (LCY)';
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
             //// TableRelation = Table37028303.Field2 WHERE (Field1=FIELD("EFT Store No."));
         }
         field(37028302; "EFT Transaction Entry No."; Integer)
         {
             DataClassification = ToBeClassified;
             BlankZero = true;
             Caption = 'EFT Transaction Entry No.';
             // TableRelation = Table37028310.Field3 WHERE (Field1=FIELD("EFT Store No."),
             // Field2=FIELD("EFT Terminal No."));
         }*/
    }

    //Unsupported feature: Property Modification (Attributes) on "CopyFromCustLedgEntry(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromVendLedgEntry(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromEmplLedgEntry(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "RecalculateAmounts(PROCEDURE 41)".


    //Unsupported feature: Property Modification (Attributes) on "SetClosedFields(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromCustLedgerEntry(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromVendLedgerEntry(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromEmplLedgerEntry(PROCEDURE 3)".

}

