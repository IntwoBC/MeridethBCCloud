tableextension 50004 tableextension70000200 extends "Cust. Ledger Entry"
{
    // <changelog>
    //   <add id="NA0003" dev="JNOZZI" date="2005-03-24" area="BANK DEP." feature="605"  request="2252"
    //     releaseversion="NAVNA4.00.01">Add new key (with KeyGroups=&quot;NavDep&quot;) for use when navigating on a
    //     Deposit document.</add>
    // </changelog>
    // 
    // MER0001 TLE 12/06/13 Add "Commission Recorded",Commissionable,"Salesperson Commission Amount"
    // MER0002 TLE 03/03/14 Add "Ship-to Code"
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
        modify("Sales (LCY)")
        {
            Caption = 'Sales (LCY)';
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
        modify("Pmt. Tolerance (LCY)")
        {
            Caption = 'Pmt. Tolerance (LCY)';
        }
        field(50000; "Commission Recorded"; Boolean)
        {
            Description = 'MER0001';
            DataClassification = ToBeClassified;
        }
        field(50001; Commissionable; Decimal)
        {
            Description = 'MER0001';
            DataClassification = ToBeClassified;
        }
        field(50002; "Salesperson Commission Amount"; Decimal)
        {
            Description = 'MER0001';
            DataClassification = ToBeClassified;
        }
        field(50003; "Ship-to Code"; Code[10])
        {
            Description = 'MER0002';
            DataClassification = ToBeClassified;
        }
        // field(37028300; "EFT Store No."; Code[10])
        // {
        //     Caption = 'EFT Store No.';
        //     DataClassification = ToBeClassified;
        //     //TableRelation = Table37028302;
        // }
        // field(37028301; "EFT Terminal No."; Code[10])
        // {
        //     Caption = 'EFT Terminal No.';
        //     DataClassification = ToBeClassified;
        //     //TableRelation = Table37028303.Field2 WHERE (Field1=FIELD("EFT Store No."));
        // }
        // field(37028302; "EFT Transaction Entry No."; Integer)
        // {
        //     BlankZero = true;
        //     DataClassification = ToBeClassified;
        //     Caption = 'EFT Transaction Entry No.';
        //     //TableRelation = IF ("EFT Transaction Archive Status"=CONST(" ")) Table37028310.Field3 WHERE (Field1=FIELD("EFT Store No."),
        //     //Field2=FIELD("EFT Terminal No."))
        //     // ELSE IF ("EFT Transaction Archive Status"=CONST(Archived)) Table37028357.Field3 WHERE (Field1=FIELD("EFT Store No."),
        //     // Field2=FIELD("EFT Terminal No."));
        // }
        // field(37028304; "EFT Transaction Archive Status"; Option)
        // {
        //     Caption = 'EFT Transaction Archive Status';
        //     Editable = false;
        //     OptionCaption = ' ,Archived,Purged';
        //     OptionMembers = " ",Archived,Purged;
        //     DataClassification = ToBeClassified;
        // }
    }
    // keys
    // {
    //  key(;"EFT Store No.","EFT Terminal No.","EFT Transaction Entry No.",Open)
    //  {
    //  }
    //  }

    //Unsupported feature: Property Modification (Attributes) on "ShowDoc(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "ShowPostedDocAttachment(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "HasPostedDocAttachment(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "DrillDownOnEntries(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "DrillDownOnEntries(PROCEDURE 1)".

    //procedure DrillDownOnEntries();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CustLedgEntry.Reset;
    DtldCustLedgEntry.CopyFilter("Customer No.",CustLedgEntry."Customer No.");
    DtldCustLedgEntry.CopyFilter("Currency Code",CustLedgEntry."Currency Code");
    DtldCustLedgEntry.CopyFilter("Initial Entry Global Dim. 1",CustLedgEntry."Global Dimension 1 Code");
    DtldCustLedgEntry.CopyFilter("Initial Entry Global Dim. 2",CustLedgEntry."Global Dimension 2 Code");
    DtldCustLedgEntry.CopyFilter("Initial Entry Due Date",CustLedgEntry."Due Date");
    CustLedgEntry.SetCurrentKey("Customer No.","Posting Date");
    CustLedgEntry.SetRange(Open,true);
    OnBeforeDrillDownEntries(CustLedgEntry,DtldCustLedgEntry);
    PAGE.Run(0,CustLedgEntry);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8

    OnBeforeDrillDownEntries(CustLedgEntry,DtldCustLedgEntry);
    PAGE.Run(0,CustLedgEntry);
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "DrillDownOnOverdueEntries(PROCEDURE 4)".



    //Unsupported feature: Code Modification on "DrillDownOnOverdueEntries(PROCEDURE 4)".

    //procedure DrillDownOnOverdueEntries();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CustLedgEntry.Reset;
    DtldCustLedgEntry.CopyFilter("Customer No.",CustLedgEntry."Customer No.");
    DtldCustLedgEntry.CopyFilter("Currency Code",CustLedgEntry."Currency Code");
    #4..6
    CustLedgEntry.SetFilter("Date Filter",'..%1',WorkDate);
    CustLedgEntry.SetFilter("Due Date",'<%1',WorkDate);
    CustLedgEntry.SetFilter("Remaining Amount",'<>%1',0);
    OnBeforeDrillDownOnOverdueEntries(CustLedgEntry,DtldCustLedgEntry);
    PAGE.Run(0,CustLedgEntry);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..9

    OnBeforeDrillDownOnOverdueEntries(CustLedgEntry,DtldCustLedgEntry);
    PAGE.Run(0,CustLedgEntry);
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "GetOriginalCurrencyFactor(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "GetAdjustedCurrencyFactor(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "SetStyle(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "SetApplyToFilters(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "SetAmountToApply(PROCEDURE 35)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromGenJnlLine(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromCVLedgEntryBuffer(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "RecalculateAmounts(PROCEDURE 26)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyCustLedgerEntryFromGenJnlLine(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyCustLedgerEntryFromCVLedgEntryBuffer(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "ExportEDocument(PROCEDURE 1020000)".


    //Unsupported feature: Property Modification (Attributes) on "RequestStampEDocument(PROCEDURE 1020001)".


    //Unsupported feature: Property Modification (Attributes) on "CancelEDocument(PROCEDURE 1020002)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterShowDoc(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeDrillDownEntries(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeDrillDownOnOverdueEntries(PROCEDURE 13)".

}

