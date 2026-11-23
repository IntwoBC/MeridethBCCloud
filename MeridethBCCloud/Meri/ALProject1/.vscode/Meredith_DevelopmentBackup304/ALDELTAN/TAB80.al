tableextension 50012 tableextension70000704 extends "Gen. Journal Template"
{
    // <changelog>
    //   <add id="NA0001" dev="ELYNCH" date="2005-04-03" area="REPORTS PP" feature="620"
    //     releaseversion="NAVNA4.00">Add NA Test Report for Payment Journal.</add>
    //   <change id="NA0002" dev="ELYNCH" date="2006-04-03" area="BANK DEP." feature="605"
    //     baseversion="NAVNA4.00" releaseversion="NAVNA4.00.01">Add &quot;Deposits&quot; to the list of options in the
    //     Type field. This in 1 more than 4.00</change>
    //   <change id="NA0003" dev="JNOZZI" date="2006-04-18" area="PAYROLL HR"
    //     baseversion="NAVNA4.00.01" releaseversion="NAVNA4.00.01">Add &quot;Payroll Accrual&quot; to the list of
    //     options in the Type field. This in 1 more than 4.00</change>
    //   <add id="NA0004" dev="all-e" date="2010-05-19" area="GST" feature="VSTF173006"
    //     releaseversion="NAVNA7.00">
    //     Electronic GST HST Filing for Canada  Phase II Electronic Filing for NAV 2009 SP1</add>
    //   <change id="NA0005" dev="all-e" date="2010-07-19" area="GST" feature="VSTF204685"
    //     baseversion="NAVNA7.00" releaseversion="NAVNA7.00">
    //     Sales Tax Journal page is not available on RTC</change>
    // </changelog>
    fields
    {
        modify("Copy VAT Setup to Jnl. Lines")
        {
            Caption = 'Copy VAT Setup to Jnl. Lines';
        }
        modify("Allow VAT Difference")
        {
            Caption = 'Allow VAT Difference';
        }


        //Unsupported feature: Code Modification on "Type(Field 9).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "Test Report ID" := REPORT::"General Journal - Test";
        "Posting Report ID" := REPORT::"G/L Register";
        SourceCodeSetup.Get;
        #4..25
            begin
              "Source Code" := SourceCodeSetup."Payment Journal";
              "Page ID" := PAGE::"Payment Journal";
              "Test Report ID" := REPORT::"Payment Journal - Test";
            end;
          Type::Assets:
            begin
        #33..42
              "Source Code" := SourceCodeSetup."Job G/L Journal";
              "Page ID" := PAGE::"Job G/L Journal";
            end;
          Type::"Payroll Accrual":
            begin
            end;
          Type::Deposits:
            begin
              "Source Code" := SourceCodeSetup.Deposits;
              "Page ID" := PAGE::Deposit;
              "Test Report ID" := REPORT::"Deposit Test Report";
              "Posting Report ID" := REPORT::Deposit;
              "Bal. Account Type" := "Bal. Account Type"::"Bank Account";
            end;
          Type::"Sales Tax":
            begin
              "Page ID" := PAGE::"Sales Tax Journal";
            end;
        end;

        if Recurring then
          "Page ID" := PAGE::"Recurring General Journal";

        OnAfterValidateType(Rec,SourceCodeSetup);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..28
              "Test Report ID" := REPORT::"Payment Journal - Test";   // NA0001
        #30..45
          // NA0003.begin
        #46..48
          // NA0003.end
          // NA0002.begin
        #49..56
          // NA0002.end
          // NA0005.begin
        #57..60
          // NA0005.end
        #61..66
        */
        //end;


        //Unsupported feature: Code Modification on ""Bal. Account Type"(Field 19).OnValidate".

        //trigger  Account Type"(Field 19)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if Type = Type::Deposits then
          if "Bal. Account Type" <> "Bal. Account Type"::"Bank Account" then begin
            "Bal. Account Type" := "Bal. Account Type"::"Bank Account";
            Error(USText000,FieldCaption(Type),Type,FieldCaption("Bal. Account Type"),"Bal. Account Type");
          end;
        "Bal. Account No." := '';
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // NA0002.begin
        #1..5
        // NA0002.end
        "Bal. Account No." := '';
        */
        //end;
    }


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GenJnlAlloc.SetRange("Journal Template Name",Name);
    GenJnlAlloc.DeleteAll;
    GenJnlLine.SetRange("Journal Template Name",Name);
    GenJnlLine.DeleteAll(true);
    GenJnlBatch.SetRange("Journal Template Name",Name);
    GenJnlBatch.DeleteAll;
    DepositHeader.SetCurrentKey("Journal Template Name","Journal Batch Name");
    DepositHeader.SetRange("Journal Template Name",Name);
    DepositHeader.DeleteAll(true);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    // NA0002.begin
    #7..9
    // NA0002.end
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "OnAfterValidateType(PROCEDURE 1)".

}

