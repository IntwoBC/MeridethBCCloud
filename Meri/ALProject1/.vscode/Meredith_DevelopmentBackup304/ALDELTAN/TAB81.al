tableextension 50013 tableextension70000706 extends "Gen. Journal Line"
{
    // <changelog>
    //   <add id="NA0000" dev="ELYNCH" date="2006-01-24" area="1099" feature="601"
    //     releaseversion="NAVNA4.00">Added 1099 handling code and new fields 10020, 10021</add>
    //   <change id="NA0001" dev="ELYNCH" date="2006-01-24" area="NASALESTAX" feature="617"
    //     baseversion="NAVNA4.00" releaseversion="NAVNA4.00">Added fields for NA Sales Tax</change>
    //   <change id="NA0002" dev="JNOZZI" date="2006-02-27" area="ELEC. PAY" feature="608"
    //     baseversion="NAVNA4.00" releaseversion="NAVNA4.00">Add North American Electronic Payments functionality. Add
    //     Electronic Payment option to the Bank Payment Type field. Also add fields 10005 (Check Exported), 10006 (Export File
    //     Name), and 10007 (Check Transmitted).</change>
    //   <change id="NA0004" dev="JNOZZI" date="2004-04-16" area="BUG FIX W1"  request="BE-871-531-MH4Z"
    //     baseversion="NAVNA4.00" releaseversion="NAVNA4.00">If copy and paste is done in General Journal, the
    //     dimensions and allocations are not copied. Therefore, we have turned the PasteIsValid property off.</change>
    //   <change id="NA0006" dev="ELYNCH" date="2006-04-03" area="BANK DEP." feature="605"
    //     baseversion="NAVNA4.00" releaseversion="NAVNA4.00">Modify Bank Deposits to use new Cash Receipts
    //     functionality. Add Amount to SumIndex fields in Primary Key.</change>
    //   <change id="NA0007" dev="JNOZZI" date="2006-04-18" area="PAYROLL HR"
    //     baseversion="NAVNA4.00" releaseversion="NAVNA4.00.01">Added Employee option to Bal. Account Type and Source
    //     Type fields</change>
    //   <change id="NA0008" dev="JNOZZI" date="2007-12-10" area="NASALESTAX" feature="31197"
    //     baseversion="NAVNA4.00.01" releaseversion="NAVNA5.00.01">Implement hooks to External Sales Tax Engine. Add STE
    //     Transaction ID field.</change>
    //   <change id="NA0009" dev="ELYNCH" date="2007-10-05" area="PAYROLL HR"
    //     baseversion="NAVNA5.00.01" releaseversion="NAVNA6.00">Removed Employee option from Bal. Account Type and
    //     Source Type fields</change>
    //   <change id="NA0010" dev="V-JOOSTL" date="2009-04-27" area="NASALESTAX" feature="31816"
    //     baseversion="NAVNA6.00" releaseversion="NAVNA6.00.01">Use Tax Modification for US Sales Tax</change>
    //   <add id="NA0011" dev="all-e" date="20010-05-19" area="GST" feature="VSTF173006"
    //     releaseversion="NAVNA7.00">
    //     Electronic GST HST Filing for Canada  Phase II Electronic Filing for NAV 2009 SP1</add>
    //   <change id="NA0012" dev="all-e" date="2010-09-29" area="GST" feature="VSTF231828"
    //     baseversion="NA7.00" releaseversion="NA7.00">
    //     British Columbias and Ontarios sales tax reform</change>
    //   <change id="NA0013" dev="all-e" date="2010-12-07" area="ELEC. PAY" feature="VSTF231871"
    //     baseversion="NA4.00" releaseversion="NA7.00">
    //     ACH Requirement Changes as Mandated by Nacha and OFACT NAV</change>
    //    <add id="NA0014" dev="all-e" date="2011-04-22" area="Elec. Pay" feature="VSTF257818"
    //      releaseversion="NA7.00">Canada 2011 Changes to GST HST Internet File Transfer
    //    </add>
    // </changelog>
    // 
    // MER0001 TLE 01/10/14 Add "Salesperson Commission Amount"
    // MER0002 TLE 03/03/14 Add "Ship-to Address Code"
    // MER0003 TLE 05/29/14 Add Key "Account Type,Account No.,Applies-to Doc. Type,Description"
    // MER0004 TLE 09/22/14 Add Key "Journal Template Name,Journal Batch Name,Document No."
    fields
    {
        modify("VAT %")
        {
            Caption = 'VAT %';
        }
        modify("Amount (LCY)")
        {
            Caption = 'Amount (LCY)';
        }
        modify("Balance (LCY)")
        {
            Caption = 'Balance (LCY)';
        }
        modify("Sales/Purch. (LCY)")
        {
            Caption = 'Sales/Purch. (LCY)';
        }
        modify("Profit (LCY)")
        {
            Caption = 'Profit (LCY)';
        }
        modify("Inv. Discount (LCY)")
        {
            Caption = 'Inv. Discount (LCY)';
        }
        modify("VAT Amount")
        {
            Caption = 'VAT Amount';
        }
        modify("Allocated Amt. (LCY)")
        {
            Caption = 'Allocated Amt. (LCY)';
        }
        modify("Bal. VAT %")
        {
            Caption = 'Bal. VAT %';
        }
        modify("Bal. VAT Amount")
        {
            Caption = 'Bal. VAT Amount';
        }
        modify("VAT Base Amount")
        {
            Caption = 'VAT Base Amount';
        }
        modify("Bal. VAT Base Amount")
        {
            Caption = 'Bal. VAT Base Amount';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'VAT Bus. Posting Group';
        }
        modify("VAT Prod. Posting Group")
        {
            Caption = 'VAT Prod. Posting Group';
        }
        modify("Bal. VAT Bus. Posting Group")
        {
            Caption = 'Bal. VAT Bus. Posting Group';
        }
        modify("Bal. VAT Prod. Posting Group")
        {
            Caption = 'Bal. VAT Prod. Posting Group';
        }
        modify("Source Curr. VAT Base Amount")
        {
            Caption = 'Source Curr. VAT Base Amount';
        }
        modify("Source Curr. VAT Amount")
        {
            Caption = 'Source Curr. VAT Amount';
        }
        modify("VAT Amount (LCY)")
        {
            Caption = 'VAT Amount (LCY)';
        }
        modify("VAT Base Amount (LCY)")
        {
            Caption = 'VAT Base Amount (LCY)';
        }
        modify("Bal. VAT Amount (LCY)")
        {
            Caption = 'Bal. VAT Amount (LCY)';
        }
        modify("Bal. VAT Base Amount (LCY)")
        {
            Caption = 'Bal. VAT Base Amount (LCY)';
        }
        modify("VAT Difference")
        {
            Caption = 'VAT Difference';
        }
        modify("Bal. VAT Difference")
        {
            Caption = 'Bal. VAT Difference';
        }
        modify("VAT Registration No.")
        {
            Caption = 'VAT Registration No.';
        }
        modify("Job Unit Price (LCY)")
        {
            Caption = 'Job Unit Price (LCY)';
        }
        modify("Job Total Price (LCY)")
        {
            Caption = 'Job Total Price (LCY)';
        }
        modify("Job Unit Cost (LCY)")
        {
            Caption = 'Job Unit Cost (LCY)';
        }
        modify("Job Line Disc. Amount (LCY)")
        {
            Caption = 'Job Line Disc. Amount (LCY)';
        }
        modify("Job Total Cost (LCY)")
        {
            Caption = 'Job Total Cost (LCY)';
        }
        modify("Job Line Amount (LCY)")
        {
            Caption = 'Job Line Amount (LCY)';
        }


        //Unsupported feature: Code Modification on ""Account No."(Field 4).OnValidate".

        //trigger "(Field 4)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Account No." <> xRec."Account No." then begin
          ClearAppliedAutomatically;
          Validate("Job No.",'');
        end;

        if xRec."Account Type" in ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"IC Partner"] then
          "IC Partner Code" := '';

        if "Account No." = '' then begin
          CleanLine;
          exit;
        end;

        case "Account Type" of
          "Account Type"::"G/L Account":
            GetGLAccount;
          "Account Type"::Customer:
            GetCustomerAccount;
          "Account Type"::Vendor:
            GetVendorAccount;
          "Account Type"::Employee:
            GetEmployeeAccount;
          "Account Type"::"Bank Account":
            GetBankAccount;
          "Account Type"::"Fixed Asset":
            GetFAAccount;
          "Account Type"::"IC Partner":
            GetICPartnerAccount;
        end;

        Validate("Currency Code");
        Validate("VAT Prod. Posting Group");
        UpdateLineBalance;
        UpdateSource;
        CreateDim(
          DimMgt.TypeToTableID1("Account Type"),"Account No.",
          DimMgt.TypeToTableID1("Bal. Account Type"),"Bal. Account No.",
          DATABASE::Job,"Job No.",
          DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
          DATABASE::Campaign,"Campaign No.");

        Validate("IC Partner G/L Acc. No.",GetDefaultICPartnerGLAccNo);
        ValidateApplyRequirements(Rec);

        case "Account Type" of
          "Account Type"::"G/L Account":
            UpdateAccountID;
          "Account Type"::Customer:
            UpdateCustomerID;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //The code has been merged but contained errors that could prevent import
        //and the code has been put in comments. Use Shift+Ctrl+O to Uncomment
        //IF "Account No." <> xRec."Account No." THEN BEGIN
        //  ClearAppliedAutomatically;
        //  VALIDATE("Job No.",'');
        //END;
        //
        //IF xRec."Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"IC Partner"] THEN
        //  "IC Partner Code" := '';
        //
        ////EFT3.00.13 -
        //IF ("EFT Transaction Entry No." <> 0) AND (xRec."Account No." <> Rec."Account No.") THEN
        //  ERROR(EFTTran004, FIELDCAPTION("Account No."));
        //"EFT Account Number" := '';
        //"Routing Number" := '';
        //"Expiration Month" := '';
        //"Expiration Year" := '';
        //"Check Type" := "Check Type"::" ";
        //Hash := '';
        //"Card Type" := "Card Type"::" ";
        //"Issuer Identification Number" := '';
        //"Protected Account Number" := '';
        ////EFT3.00.13 +
        //IF "Account No." = '' THEN BEGIN
        //  CleanLine;
        //  EXIT;
        //END;
        //
        //CASE "Account Type" OF
        //  "Account Type"::"G/L Account":
        //    GetGLAccount;
        //  "Account Type"::Customer:



        //    GetCustomerAccount;

        //  "Account Type"::Vendor:


        //    GetVendorAccount;
        //  "Account Type"::Employee:
        //    GetEmployeeAccount;

        //  "Account Type"::"Bank Account":




        //    GetBankAccount;

        //  "Account Type"::"Fixed Asset":
        //    GetFAAccount;
        //  "Account Type"::"IC Partner":
        //    GetICPartnerAccount;
        //END;
        //
        //VALIDATE("Currency Code");
        //VALIDATE("VAT Prod. Posting Group");
        //UpdateLineBalance;
        //UpdateSource;
        //CreateDim(
        //  DimMgt.TypeToTableID1("Account Type"),"Account No.",
        //  DimMgt.TypeToTableID1("Bal. Account Type"),"Bal. Account No.",
        //  DATABASE::Job,"Job No.",
        //  DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
        //  DATABASE::Campaign,"Campaign No.");
        //
        //VALIDATE("IC Partner G/L Acc. No.",GetDefaultICPartnerGLAccNo);
        //ValidateApplyRequirements(Rec);
        //
        //CASE "Account Type" OF
        //  "Account Type"::"G/L Account":
        //    UpdateAccountID;
        //  "Account Type"::Customer:
        //    UpdateCustomerID;
        //END;
        */
        //end;


        //Unsupported feature: Code Modification on ""Document Type"(Field 6).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Validate("Payment Terms Code");
        if ("Document Type" = "Document Type"::" ") or
           ("Document Type" = "Document Type"::Invoice) or
           ("Document Type" = "Document Type"::"Credit Memo")
        then
          Validate("IRS 1099 Code")
        else
          "IRS 1099 Amount" := 0;
        if "Account No." <> '' then
          case "Account Type" of
            "Account Type"::Customer:
        #12..33
          end;
        UpdateSalesPurchLCY;
        ValidateApplyRequirements(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        Validate("Payment Terms Code");
        // NA0001.begin
        #2..8
        // NA0001.end
        #9..36


        // IF NOT ("Document Type" IN ["Document Type"::Payment,"Document Type"::Refund]) THEN
         // VALIDATE("Credit Card No.",'');
        //EFT3.00.13 -
        //VALIDATE("EFT Tender Type", 0);
        //VALIDATE("EFT Account Number", '');
        //VALIDATE("Routing Number", '');
        //VALIDATE("Expiration Month", '');
        //VALIDATE("Expiration Year", '');
        //EFT3.00.13 +
        */
        //end;


        //Unsupported feature: Code Modification on ""VAT %"(Field 10).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetCurrency;
        case "VAT Calculation Type" of
          "VAT Calculation Type"::"Normal VAT",
        #4..16
              "VAT Amount" := 0;
              "VAT %" := 0;
            end else begin
              if "Tax Area Code" = '' then
                Clear(TaxArea)
              else
        #23..25
                  Amount -
                  SalesTaxCalculate.CallExternalTaxEngineForJnl(Rec,1)
              else
                "VAT Amount" :=
                  Amount -
                  SalesTaxCalculate.ReverseCalculateTax(
        #32..55

        if "Deferral Code" <> '' then
          Validate("Deferral Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..19
              // NA0008.begin
        #20..28
                // NA0008.end
        #29..58
        */
        //end;


        //Unsupported feature: Code Modification on ""Bal. Account No."(Field 11).OnValidate".

        //trigger  Account No()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Validate("Job No.",'');

        if xRec."Bal. Account Type" in ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,
                                        "Bal. Account Type"::"IC Partner"]
        then
          "IC Partner Code" := '';

        if "Bal. Account No." = '' then begin
          UpdateLineBalance;
          UpdateSource;
          CreateDim(
            DimMgt.TypeToTableID1("Bal. Account Type"),"Bal. Account No.",
            DimMgt.TypeToTableID1("Account Type"),"Account No.",
            DATABASE::Job,"Job No.",
            DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
            DATABASE::Campaign,"Campaign No.");
          if not ("Account Type" in ["Account Type"::Customer,"Account Type"::Vendor]) then
            "Recipient Bank Account" := '';
          if xRec."Bal. Account No." <> '' then begin
            ClearBalancePostingGroups;
            "Bal. Tax Area Code" := '';
            "Bal. Tax Liable" := false;
            "Bal. Tax Group Code" := '';
            ClearCurrencyCode;
          end;
          exit;
        end;

        case "Bal. Account Type" of
          "Bal. Account Type"::"G/L Account":
            GetGLBalAccount;
          "Bal. Account Type"::Customer:
            GetCustomerBalAccount;
          "Bal. Account Type"::Vendor:
            GetVendorBalAccount;
          "Bal. Account Type"::Employee:
            GetEmployeeBalAccount;
          "Bal. Account Type"::"Bank Account":
            GetBankBalAccount;
          "Bal. Account Type"::"Fixed Asset":
            GetFABalAccount;
          "Bal. Account Type"::"IC Partner":
            GetICPartnerBalAccount;
        end;

        Validate("Currency Code");
        Validate("Bal. VAT Prod. Posting Group");
        UpdateLineBalance;
        UpdateSource;
        CreateDim(
          DimMgt.TypeToTableID1("Bal. Account Type"),"Bal. Account No.",
          DimMgt.TypeToTableID1("Account Type"),"Account No.",
          DATABASE::Job,"Job No.",
          DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
          DATABASE::Campaign,"Campaign No.");

        Validate("IC Partner G/L Acc. No.",GetDefaultICPartnerGLAccNo);
        ValidateApplyRequirements(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //The code has been merged but contained errors that could prevent import
        //and the code has been put in comments. Use Shift+Ctrl+O to Uncomment
        //VALIDATE("Job No.",'');
        //
        //IF xRec."Bal. Account Type" IN ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,
        //                                "Bal. Account Type"::"IC Partner"]
        //THEN
        //  "IC Partner Code" := '';
        //
        //IF "Bal. Account No." = '' THEN BEGIN
        //  UpdateLineBalance;
        //  UpdateSource;
        //  CreateDim(
        //    DimMgt.TypeToTableID1("Bal. Account Type"),"Bal. Account No.",
        //    DimMgt.TypeToTableID1("Account Type"),"Account No.",
        //    DATABASE::Job,"Job No.",
        //    DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
        //    DATABASE::Campaign,"Campaign No.");
        //  IF NOT ("Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor]) THEN
        //    "Recipient Bank Account" := '';
        //  IF xRec."Bal. Account No." <> '' THEN BEGIN
        //    ClearBalancePostingGroups;
        //    "Bal. Tax Area Code" := '';
        //    "Bal. Tax Liable" := FALSE;
        //    "Bal. Tax Group Code" := '';
        //  END;
        //  EXIT;
        //END;
        //
        //CASE "Bal. Account Type" OF
        //  "Bal. Account Type"::"G/L Account":
        //    GetGLBalAccount;
        //  "Bal. Account Type"::Customer:




        #7..28


        //    GetVendorBalAccount;
        //  "Bal. Account Type"::Employee:

        //  "Bal. Account Type"::"Bank Account":
        //    GetBankBalAccount;
        //  "Bal. Account Type"::"Fixed Asset":
        //    GetFABalAccount;
        //  "Bal. Account Type"::"IC Partner":
        //    GetICPartnerBalAccount;
        //END;
        //
        //VALIDATE("Currency Code");
        //VALIDATE("Bal. VAT Prod. Posting Group");
        //UpdateLineBalance;
        //UpdateSource;
        //CreateDim(
        //  DimMgt.TypeToTableID1("Bal. Account Type"),"Bal. Account No.",
        //  DimMgt.TypeToTableID1("Account Type"),"Account No.",
        //  DATABASE::Job,"Job No.",
        //  DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
        //  DATABASE::Campaign,"Campaign No.");
        //
        //VALIDATE("IC Partner G/L Acc. No.",GetDefaultICPartnerGLAccNo);
        //ValidateApplyRequirements(Rec);
        */
        //end;


        //Unsupported feature: Code Modification on ""Currency Code"(Field 12).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Bal. Account Type" = "Bal. Account Type"::"Bank Account" then begin
          if BankAcc.Get("Bal. Account No.") and (BankAcc."Currency Code" <> '')then
            BankAcc.TestField("Currency Code","Currency Code");
        #4..28
          "Currency Factor" := 0;
        Validate("Currency Factor");

        if not CustVendAccountNosModified then
          if ("Currency Code" <> xRec."Currency Code") and (Amount <> 0) then
            PaymentToleranceMgt.PmtTolGenJnl(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..31
        if ("Currency Code" <> xRec."Currency Code") and (Amount <> 0) then
          PaymentToleranceMgt.PmtTolGenJnl(Rec);
        */
        //end;


        //Unsupported feature: Code Modification on "Amount(Field 13).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateAmount(true);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*

        //{=======} MODIFIED
        {*GetCurrency;
        IF "Currency Code" = '' THEN
          "Amount (LCY)" := Amount
        ELSE
          "Amount (LCY)" := ROUND(
              CurrExchRate.ExchangeAmtFCYToLCY(
                "Posting Date","Currency Code",
                Amount,"Currency Factor"));

        Amount := ROUND(Amount,Currency."Amount Rounding Precision");
        IF (CurrFieldNo <> 0) AND
           (CurrFieldNo <> FIELDNO("Applies-to Doc. No.")) AND
           ((("Account Type" = "Account Type"::Customer) AND
             ("Account No." <> '') AND (Amount > 0) AND
             (CurrFieldNo <> FIELDNO("Bal. Account No."))) OR
            (("Bal. Account Type" = "Bal. Account Type"::Customer) AND
             ("Bal. Account No." <> '') AND (Amount < 0) AND
             (CurrFieldNo <> FIELDNO("Account No."))))
        THEN
          CustCheckCreditLimit.GenJnlLineCheck(Rec);

        VALIDATE("VAT %");
        VALIDATE("Bal. VAT %");
        // NA0001.begin
        IF ("Document Type" = "Document Type"::" ") OR
           ("Document Type" = "Document Type"::Invoice) OR
           ("Document Type" = "Document Type"::"Credit Memo")
        THEN
          VALIDATE("IRS 1099 Code")
        ELSE
          "IRS 1099 Amount" := 0;
        // NA0001.end
        UpdateLineBalance;
        IF "Deferral Code" <> '' THEN
          VALIDATE("Deferral Code");

        IF (Amount <> xRec.Amount) AND
           (CurrFieldNo <> 0)
        THEN BEGIN
          IF ("Applies-to Doc. No." <> '') OR ("Applies-to ID" <> '') THEN
            SetApplyToAmount;
          PaymentToleranceMgt.PmtTolGenJnl(Rec);
        END;

        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine;
          UpdatePricesFromJobJnlLine;
        END;*}

        ValidateAmount(true);
        */
        //end;


        //Unsupported feature: Code Modification on ""Bal. VAT %"(Field 68).OnValidate".

        //trigger  VAT %"(Field 68)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetCurrency;
        case "Bal. VAT Calculation Type" of
          "Bal. VAT Calculation Type"::"Normal VAT",
        #4..16
              "Bal. VAT Amount" := 0;
              "Bal. VAT %" := 0;
            end else begin
              if "Bal. Tax Area Code" = '' then
                Clear(TaxArea)
              else
        #23..25
                  -(Amount -
                    SalesTaxCalculate.CallExternalTaxEngineForJnl(Rec,1))
              else
                "Bal. VAT Amount" :=
                  -(Amount -
                    SalesTaxCalculate.ReverseCalculateTax(
        #32..51
        "Bal. VAT Base Amount (LCY)" := -("Amount (LCY)" + "Bal. VAT Amount (LCY)");

        UpdateSalesPurchLCY;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..19
              // NA0008.begin
        #20..28
                // NA0008.end
        #29..54
        */
        //end;


        //Unsupported feature: Code Modification on ""VAT Base Amount"(Field 71).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetCurrency;
        "VAT Base Amount" := Round("VAT Base Amount",Currency."Amount Rounding Precision");
        case "VAT Calculation Type" of
        #4..21
              "VAT %" := 0;
              Amount := "VAT Base Amount" + "VAT Amount";
            end else begin
              if "Tax Area Code" = '' then
                Clear(TaxArea)
              else
                TaxArea.Get("Tax Area Code");
              if TaxArea."Use External Tax Engine" then
                "VAT Amount" :=
                  SalesTaxCalculate.CallExternalTaxEngineForJnl(Rec,0)
              else
                "VAT Amount" :=
                  SalesTaxCalculate.CalculateTax(
                    "Tax Area Code","Tax Group Code","Tax Liable","Posting Date",
        #36..43
            end;
        end;
        Validate(Amount);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..24
              // NA0008.begin
        #25..32
                // NA0008.end
        #33..46
        */
        //end;


        //Unsupported feature: Code Modification on ""Bal. VAT Base Amount"(Field 72).OnValidate".

        //trigger  VAT Base Amount"(Field 72)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetCurrency;
        "Bal. VAT Base Amount" := Round("Bal. VAT Base Amount",Currency."Amount Rounding Precision");
        case "Bal. VAT Calculation Type" of
        #4..21
              "Bal. VAT %" := 0;
              Amount := -"Bal. VAT Base Amount" - "Bal. VAT Amount";
            end else begin
              if "Bal. Tax Area Code" = '' then
                Clear(TaxArea)
              else
                TaxArea.Get("Bal. Tax Area Code");
              if TaxArea."Use External Tax Engine" then
                "Bal. VAT Amount" :=
                  SalesTaxCalculate.CallExternalTaxEngineForJnl(Rec,0)
              else
                "Bal. VAT Amount" :=
                  SalesTaxCalculate.CalculateTax(
                    "Bal. Tax Area Code","Bal. Tax Group Code","Bal. Tax Liable",
        #36..43
            end;
        end;
        Validate(Amount);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..24
              // NA0008.begin
        #25..32
                // NA0008.end
        #33..46
        */
        //end;


        //Unsupported feature: Code Modification on ""IRS 1099 Code"(Field 10020).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "IRS 1099 Code" <> '' then begin
          if "Account Type" = "Account Type"::Vendor then
            "IRS 1099 Amount" := Amount
          else
            "IRS 1099 Amount" := -Amount;
        end else
          "IRS 1099 Amount" := 0;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // NA0001.begin
        #1..7
        // NA0001.end
        */
        //end;
        field(50000; "Salesperson Commission Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'MER0001';
        }
        field(50001; "Ship-to Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'MER0002';
        }
    }
    keys
    {
        // key(Key1;"Account Type","Account No.","Applies-to Doc. Type",Description)
        // {
        // }
        // key(Key2;"Journal Template Name","Journal Batch Name","Document No.")
        // {
        // }
    }


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ApprovalsMgmt.OnCancelGeneralJournalLineApprovalRequest(Rec);

    // Lines are deleted 1 by 1, this actually check if this is the last line in the General journal Bach
    #4..19
    if not GenJnlAlloc.IsEmpty then
      GenJnlAlloc.DeleteAll;

    DeferralUtilities.DeferralCodeOnDelete(
      DeferralDocType::"G/L",
      "Journal Template Name",
      "Journal Batch Name",0,'',"Line No.");

    Validate("Incoming Document Entry No.",0);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..22


    #23..28
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "EmptyLine(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateLineBalance(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "SetUpNewLine(PROCEDURE 9)".



    //Unsupported feature: Code Modification on "SetUpNewLine(PROCEDURE 9)".

    //procedure SetUpNewLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GenJnlTemplate.Get("Journal Template Name");
    GenJnlBatch.Get("Journal Template Name","Journal Batch Name");
    GenJnlLine.SetRange("Journal Template Name","Journal Template Name");
    #4..7
      "Document No." := LastGenJnlLine."Document No.";
      if BottomLine and
         (Balance - LastGenJnlLine."Balance (LCY)" = 0) and
         not LastGenJnlLine.EmptyLine and (GenJnlTemplate.Type <> GenJnlTemplate.Type::"Sales Tax")
      then
        IncrementDocumentNo(GenJnlBatch,"Document No.");
    end else begin
    #15..47
    UpdateJournalBatchID;

    OnAfterSetupNewLine(Rec,GenJnlTemplate,GenJnlBatch,LastGenJnlLine,Balance,BottomLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..10
         // NA0011.begin
         // NOT LastGenJnlLine.EmptyLine
         not LastGenJnlLine.EmptyLine and (GenJnlTemplate.Type <> GenJnlTemplate.Type::"Sales Tax")
         // NA0011.end
    #12..50
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "InitNewLine(PROCEDURE 94)".


    //Unsupported feature: Property Modification (Attributes) on "CheckDocNoOnLines(PROCEDURE 78)".


    //Unsupported feature: Property Modification (Attributes) on "CheckDocNoBasedOnNoSeries(PROCEDURE 74)".


    //Unsupported feature: Property Modification (Attributes) on "RenumberDocumentNo(PROCEDURE 68)".


    //Unsupported feature: Property Modification (Attributes) on "SetCurrencyFactor(PROCEDURE 130)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateSource(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "GetFAAddCurrExchRate(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "GetShowCurrencyCode(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "ClearCustVendApplnEntry(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "CheckFixedCurrency(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "CreateDim(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "LookupShortcutDimCode(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "ShowShortcutDimCode(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 26)".


    //Unsupported feature: Property Modification (Attributes) on "GetFAVATSetup(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "GetTemplate(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "LookUpAppliesToDocCust(PROCEDURE 35)".


    //Unsupported feature: Property Modification (Attributes) on "LookUpAppliesToDocVend(PROCEDURE 36)".


    //Unsupported feature: Property Modification (Attributes) on "LookUpAppliesToDocEmpl(PROCEDURE 171)".


    //Unsupported feature: Property Modification (Attributes) on "SetApplyToAmount(PROCEDURE 20)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateApplyRequirements(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "JobTaskIsSet(PROCEDURE 28)".


    //Unsupported feature: Property Modification (Attributes) on "CreateTempJobJnlLine(PROCEDURE 27)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePricesFromJobJnlLine(PROCEDURE 22)".


    //Unsupported feature: Property Modification (Attributes) on "SetHideValidation(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "IsApplied(PROCEDURE 30)".


    //Unsupported feature: Property Modification (Attributes) on "DataCaption(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "GetCustLedgerEntry(PROCEDURE 33)".


    //Unsupported feature: Property Modification (Attributes) on "GetVendLedgerEntry(PROCEDURE 37)".


    //Unsupported feature: Property Modification (Attributes) on "GetEmplLedgerEntry(PROCEDURE 183)".


    //Unsupported feature: Property Modification (Attributes) on "IncludeVATAmount(PROCEDURE 38)".


    //Unsupported feature: Property Modification (Attributes) on "ConvertAmtFCYToLCYForSourceCurrency(PROCEDURE 39)".


    //Unsupported feature: Property Modification (Attributes) on "MatchSingleLedgerEntry(PROCEDURE 40)".


    //Unsupported feature: Property Modification (Attributes) on "GetStyle(PROCEDURE 41)".


    //Unsupported feature: Property Modification (Attributes) on "GetOverdueDateInteractions(PROCEDURE 75)".


    //Unsupported feature: Property Modification (Attributes) on "ClearDataExchangeEntries(PROCEDURE 42)".


    //Unsupported feature: Property Modification (Attributes) on "ClearAppliedGenJnlLine(PROCEDURE 49)".


    //Unsupported feature: Property Modification (Attributes) on "GetIncomingDocumentURL(PROCEDURE 50)".


    //Unsupported feature: Property Modification (Attributes) on "InsertPaymentFileError(PROCEDURE 64)".


    //Unsupported feature: Property Modification (Attributes) on "InsertPaymentFileErrorWithDetails(PROCEDURE 83)".


    //Unsupported feature: Property Modification (Attributes) on "DeletePaymentFileBatchErrors(PROCEDURE 67)".


    //Unsupported feature: Property Modification (Attributes) on "DeletePaymentFileErrors(PROCEDURE 61)".


    //Unsupported feature: Property Modification (Attributes) on "HasPaymentFileErrors(PROCEDURE 24)".


    //Unsupported feature: Property Modification (Attributes) on "HasPaymentFileErrorsInBatch(PROCEDURE 65)".


    //Unsupported feature: Property Modification (Attributes) on "GetAppliesToDocEntryNo(PROCEDURE 63)".


    //Unsupported feature: Property Modification (Attributes) on "GetAppliesToDocDueDate(PROCEDURE 62)".


    //Unsupported feature: Property Modification (Attributes) on "IsCustVendICAdded(PROCEDURE 209)".


    //Unsupported feature: Property Modification (Attributes) on "IsExportedToPaymentFile(PROCEDURE 1020)".


    //Unsupported feature: Property Modification (Attributes) on "IsPaymentJournallLineExported(PROCEDURE 80)".


    //Unsupported feature: Property Modification (Attributes) on "IsAppliedToVendorLedgerEntryExported(PROCEDURE 79)".


    //Unsupported feature: Property Modification (Attributes) on "SetPostingDateAsDueDate(PROCEDURE 77)".


    //Unsupported feature: Property Modification (Attributes) on "CalculatePostingDate(PROCEDURE 76)".


    //Unsupported feature: Property Modification (Attributes) on "ImportBankStatement(PROCEDURE 73)".


    //Unsupported feature: Property Modification (Attributes) on "ExportPaymentFile(PROCEDURE 81)".


    //Unsupported feature: Property Modification (Attributes) on "TotalExportedAmount(PROCEDURE 85)".


    //Unsupported feature: Property Modification (Attributes) on "DrillDownExportedAmount(PROCEDURE 95)".


    //Unsupported feature: Property Modification (Attributes) on "CopyDocumentFields(PROCEDURE 129)".


    //Unsupported feature: Property Modification (Attributes) on "CopyCustLedgEntry(PROCEDURE 134)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromGenJnlAllocation(PROCEDURE 113)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromInvoicePostBuffer(PROCEDURE 112)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromInvoicePostBufferFA(PROCEDURE 111)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromPrepmtInvoiceBuffer(PROCEDURE 110)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromPurchHeader(PROCEDURE 109)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromPurchHeaderPrepmt(PROCEDURE 127)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromPurchHeaderPrepmtPost(PROCEDURE 137)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromPurchHeaderApplyTo(PROCEDURE 107)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromPurchHeaderPayment(PROCEDURE 104)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromSalesHeader(PROCEDURE 103)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromSalesHeaderPrepmt(PROCEDURE 119)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromSalesHeaderPrepmtPost(PROCEDURE 138)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromSalesHeaderApplyTo(PROCEDURE 100)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromSalesHeaderPayment(PROCEDURE 99)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromServiceHeader(PROCEDURE 98)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromServiceHeaderApplyTo(PROCEDURE 97)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromServiceHeaderPayment(PROCEDURE 96)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromPaymentCustLedgEntry(PROCEDURE 205)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromPaymentVendLedgEntry(PROCEDURE 202)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromPaymentEmpLedgEntry(PROCEDURE 1250)".


    //Unsupported feature: Property Modification (Attributes) on "CheckModifyCurrencyCode(PROCEDURE 105)".


    //Unsupported feature: Property Modification (Attributes) on "IsOpenedFromBatch(PROCEDURE 87)".


    //Unsupported feature: Property Modification (Attributes) on "GetDeferralAmount(PROCEDURE 88)".


    //Unsupported feature: Property Modification (Attributes) on "GetDeferralDocType(PROCEDURE 106)".


    //Unsupported feature: Property Modification (Attributes) on "IsForPurchase(PROCEDURE 86)".


    //Unsupported feature: Property Modification (Attributes) on "IsForSales(PROCEDURE 89)".


    //Unsupported feature: Property Modification (Attributes) on "OnCheckGenJournalLinePostRestrictions(PROCEDURE 90)".


    //Unsupported feature: Property Modification (Attributes) on "OnCheckGenJournalLinePrintCheckRestrictions(PROCEDURE 92)".


    //Unsupported feature: Property Modification (Attributes) on "OnMoveGenJournalLine(PROCEDURE 93)".


    //Unsupported feature: Property Modification (Attributes) on "IncrementDocumentNo(PROCEDURE 120)".


    //Unsupported feature: Property Modification (Attributes) on "NeedCheckZeroAmount(PROCEDURE 196)".


    //Unsupported feature: Property Modification (Attributes) on "IsRecurring(PROCEDURE 199)".



    //Unsupported feature: Code Modification on "GetCustomerAccount(PROCEDURE 47)".

    //procedure GetCustomerAccount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Cust.Get("Account No.");
    Cust.CheckBlockedCustOnJnls(Cust,"Document Type",false);
    CheckICPartner(Cust."IC Partner Code","Account Type","Account No.");
    #4..21
      then
        Error('');
    Validate("Payment Terms Code");
    CheckPaymentTolerance;

    OnAfterAccountNoOnValidateGetCustomerAccount(Rec,Cust,CurrFieldNo);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..24
    //CheckPaymentTolerance;

    OnAfterAccountNoOnValidateGetCustomerAccount(Rec,Cust,CurrFieldNo);
    */
    //end;


    //Unsupported feature: Code Modification on "GetCustomerBalAccount(PROCEDURE 122)".

    //procedure GetCustomerBalAccount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Cust.Get("Bal. Account No.");
    Cust.CheckBlockedCustOnJnls(Cust,"Document Type",false);
    CheckICPartner(Cust."IC Partner Code","Bal. Account Type","Bal. Account No.");
    #4..24
      then
        Error('');
    Validate("Payment Terms Code");
    CheckPaymentTolerance;

    OnAfterAccountNoOnValidateGetCustomerBalAccount(Rec,Cust,CurrFieldNo);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..27
    //CheckPaymentTolerance;

    OnAfterAccountNoOnValidateGetCustomerBalAccount(Rec,Cust,CurrFieldNo);
    */
    //end;


    //Unsupported feature: Code Modification on "GetVendorAccount(PROCEDURE 115)".

    //procedure GetVendorAccount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Vend.Get("Account No.");
    Vend.CheckBlockedVendOnJnls(Vend,"Document Type",false);
    CheckICPartner(Vend."IC Partner Code","Account Type","Account No.");
    #4..27
      then
        Error('');
    Validate("Payment Terms Code");
    CheckPaymentTolerance;

    OnAfterAccountNoOnValidateGetVendorAccount(Rec,Vend,CurrFieldNo);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..30
    //CheckPaymentTolerance;

    OnAfterAccountNoOnValidateGetVendorAccount(Rec,Vend,CurrFieldNo);
    */
    //end;


    //Unsupported feature: Code Modification on "GetVendorBalAccount(PROCEDURE 123)".

    //procedure GetVendorBalAccount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Vend.Get("Bal. Account No.");
    Vend.CheckBlockedVendOnJnls(Vend,"Document Type",false);
    CheckICPartner(Vend."IC Partner Code","Bal. Account Type","Bal. Account No.");
    #4..25
      then
        Error('');
    Validate("Payment Terms Code");
    CheckPaymentTolerance;

    OnAfterAccountNoOnValidateGetVendorBalAccount(Rec,Vend,CurrFieldNo);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..28
    //CheckPaymentTolerance;

    OnAfterAccountNoOnValidateGetVendorBalAccount(Rec,Vend,CurrFieldNo);
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "CreateFAAcquisitionLines(PROCEDURE 131)".


    //Unsupported feature: Property Modification (Attributes) on "SetAccountNoFromFilter(PROCEDURE 135)".


    //Unsupported feature: Property Modification (Attributes) on "GetNewLineNo(PROCEDURE 136)".


    //Unsupported feature: Property Modification (Attributes) on "VoidPaymentFile(PROCEDURE 139)".


    //Unsupported feature: Property Modification (Attributes) on "TransmitPaymentFile(PROCEDURE 142)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateSalesPersonPurchaserCode(PROCEDURE 298)".


    //Unsupported feature: Property Modification (Attributes) on "CheckIfPrivacyBlocked(PROCEDURE 208)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSetupNewLine(PROCEDURE 161)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterClearCustApplnEntryFields(PROCEDURE 212)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterClearEmplApplnEntryFields(PROCEDURE 218)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterClearVendApplnEntryFields(PROCEDURE 213)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromCustLedgEntry(PROCEDURE 181)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromGenJnlAllocation(PROCEDURE 182)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromSalesHeader(PROCEDURE 160)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromSalesHeaderPrepmt(PROCEDURE 195)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromSalesHeaderPrepmtPost(PROCEDURE 197)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromSalesHeaderApplyTo(PROCEDURE 200)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromSalesHeaderPayment(PROCEDURE 201)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromPurchHeader(PROCEDURE 141)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromPurchHeaderPrepmt(PROCEDURE 186)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromPurchHeaderPrepmtPost(PROCEDURE 187)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromPurchHeaderApplyTo(PROCEDURE 192)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromPurchHeaderPayment(PROCEDURE 194)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromServHeader(PROCEDURE 163)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromServHeaderApplyTo(PROCEDURE 203)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromServHeaderPayment(PROCEDURE 204)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromInvPostBuffer(PROCEDURE 144)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromInvPostBufferFA(PROCEDURE 184)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromPrepmtInvBuffer(PROCEDURE 148)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetGLAccount(PROCEDURE 145)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetGLBalAccount(PROCEDURE 147)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetCustomerAccount(PROCEDURE 149)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetCustomerBalAccount(PROCEDURE 152)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetVendorAccount(PROCEDURE 150)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetVendorBalAccount(PROCEDURE 153)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetEmployeeAccount(PROCEDURE 189)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetEmployeeBalAccount(PROCEDURE 179)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetBankAccount(PROCEDURE 155)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetBankBalAccount(PROCEDURE 154)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetFAAccount(PROCEDURE 157)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetFABalAccount(PROCEDURE 156)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetICPartnerAccount(PROCEDURE 159)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetICPartnerBalAccount(PROCEDURE 158)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateTempJobJnlLine(PROCEDURE 151)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCreateTempJobJnlLine(PROCEDURE 162)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdatePricesFromJobJnlLine(PROCEDURE 166)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateDimTableIDs(PROCEDURE 164)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateFAAcquisitionLines(PROCEDURE 245)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterClearPostingGroups(PROCEDURE 168)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterClearBalPostingGroups(PROCEDURE 169)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetCustLedgerEntry(PROCEDURE 234)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetEmplLedgerEntry(PROCEDURE 237)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetVendLedgerEntry(PROCEDURE 236)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterValidateApplyRequirements(PROCEDURE 207)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckDirectPosting(PROCEDURE 220)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSetAmountWithRemaining(PROCEDURE 233)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSetJournalLineFieldsFromApplication(PROCEDURE 231)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateDocumentTypeAndAppliesToFields(PROCEDURE 221)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckDirectPosting(PROCEDURE 219)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeLookUpAppliesToDocCust(PROCEDURE 214)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeLookUpAppliesToDocEmpl(PROCEDURE 216)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeLookUpAppliesToDocVend(PROCEDURE 215)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeSetAmountWithCustLedgEntry(PROCEDURE 232)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeSetAmountWithVendLedgEntry(PROCEDURE 230)".


    //Unsupported feature: Property Modification (Attributes) on "OnLookUpAppliesToDocCustOnAfterSetFilters(PROCEDURE 235)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeValidateBalGenBusPostingGroup(PROCEDURE 248)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeValidateBalGenPostingType(PROCEDURE 246)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeValidateBalGenProdPostingGroup(PROCEDURE 249)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeValidateGenBusPostingGroup(PROCEDURE 240)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeValidateGenPostingType(PROCEDURE 244)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeValidateGenProdPostingGroup(PROCEDURE 241)".


    //Unsupported feature: Property Modification (Attributes) on "OnGetFAVATSetupOnBeforeCheckGLAcc(PROCEDURE 247)".


    //Unsupported feature: Property Modification (Attributes) on "OnGetCustLedgerEntryOnAfterAssignCustomerNo(PROCEDURE 242)".


    //Unsupported feature: Property Modification (Attributes) on "OnGetVendLedgerEntryOnAfterAssignVendorNo(PROCEDURE 243)".


    //Unsupported feature: Property Modification (Attributes) on "OnLookUpAppliesToDocCustOnAfterUpdateDocumentTypeAndAppliesTo(PROCEDURE 225)".


    //Unsupported feature: Property Modification (Attributes) on "OnLookUpAppliesToDocEmplOnAfterSetFilters(PROCEDURE 239)".


    //Unsupported feature: Property Modification (Attributes) on "OnLookUpAppliesToDocEmplOnAfterUpdateDocumentTypeAndAppliesTo(PROCEDURE 229)".


    //Unsupported feature: Property Modification (Attributes) on "OnLookUpAppliesToDocVendOnAfterSetFilters(PROCEDURE 238)".


    //Unsupported feature: Property Modification (Attributes) on "OnLookUpAppliesToDocVendOnAfterUpdateDocumentTypeAndAppliesTo(PROCEDURE 227)".


    //Unsupported feature: Property Modification (Attributes) on "OnUpdateLineBalanceOnAfterAssignBalanceLCY(PROCEDURE 226)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateAmountOnAfterAssignAmountLCY(PROCEDURE 222)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateBalVATPctOnAfterAssignBalVATAmountLCY(PROCEDURE 224)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateAccountID(PROCEDURE 1166)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateCustomerID(PROCEDURE 175)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateAppliesToInvoiceID(PROCEDURE 167)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateGraphContactId(PROCEDURE 170)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateJournalBatchID(PROCEDURE 173)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePaymentMethodId(PROCEDURE 198)".


    //Unsupported feature: Property Modification (Attributes) on "OnGenJnlLineGetVendorAccount(PROCEDURE 1217)".


    procedure GetAccountNumber() AccountNumber: Code[19]
    begin
        //EFT4.00.02 -
        /**EFTSetup.GET;
        IF ("Account Number Protection Type" = "Account Number Protection Type"::Encryption) OR
           (NOT ("EFT Tender Type" IN ["EFT Tender Type"::"Credit Card", "EFT Tender Type"::Check])) THEN
          AccountNumber := CryptoMgt.Decrypt("Protected Account Number", EFTSetup.GetEncryptionKey, "Encryption Salt")
        ELSE IF ("Account Number Protection Type" = "Account Number Protection Type"::"Remote Storage") AND
                ("EFT Tender Type" = "EFT Tender Type"::"Credit Card") THEN
          AccountNumber := RemoteStorageMgt.GetCreditCardAccountNumber("Protected Account Number")
        ELSE IF ("Account Number Protection Type" = "Account Number Protection Type"::"Remote Storage") AND
                ("EFT Tender Type" = "EFT Tender Type"::Check) THEN
          AccountNumber := RemoteStorageMgt.GetDemandDepositAccountNumber("Protected Account Number");**/
        //EFT4.00.02 +

    end;

    //  procedure MakeEFTPayment()
    //   var
    //       GenJnlLine: Record "Gen. Journal Line";
    //       DocType: Integer;
    //   begin
    //       TestField("Account Type", "Account Type"::Customer);
    //       TestField("Account No.");
    //       TestField(Amount);
    //       {*TESTFIELD("EFT Transaction Entry No.", 0);
    //      IF "EFT Tender Type" <> "EFT Tender Type"::" " THEN BEGIN
    //         TESTFIELD("EFT Account Number");
    //         IF "EFT Tender Type" = "EFT Tender Type"::"Credit Card" THEN BEGIN
    //           TESTFIELD("Expiration Month");
    //           TESTFIELD("Expiration Year");
    //           TESTFIELD("Routing Number", '');
    //         END ELSE IF "EFT Tender Type" = "EFT Tender Type"::Check THEN BEGIN
    //           TESTFIELD("Routing Number");
    //           TESTFIELD("Expiration Month", '');
    //           TESTFIELD("Expiration Year", '');
    //         END ELSE
    //           TESTFIELD("Routing Number", '');
    //         IF EFTTerminal.GetCurrentTerminal(TRUE) THEN BEGIN
    //           IF "Document Type" = "Document Type"::Payment THEN BEGIN
    //             IF Amount >= 0 THEN
    //               ERROR(Text011, FIELDCAPTION(Amount));
    //             DocType := StoreDocTypeMethod."Document Type"::"10"
    //           END ELSE IF "Document Type" = "Document Type"::Refund THEN BEGIN
    //             IF Amount <= 0 THEN
    //               ERROR(Text012, FIELDCAPTION(Amount));
    //             DocType := StoreDocTypeMethod."Document Type"::"11";
    //           END;
    //       //EFT4.00.01 -
    //           StoreDocTypeMethod.GET(EFTTerminal."Store No.",
    //                                  DocType,
    //                                  "EFT Tender Type",
    //                                  StoreDocTypeMethod."Transaction Type"::"0");
    //       //EFT4.00.01 +
    //           EFTTran.INIT;
    //           EFTTran.VALIDATE("Method Code", StoreDocTypeMethod."Method Code");
    //           EFTTran.VALIDATE("Document Type", EFTTran."Document Type"::"9");
    //           EFTTran.VALIDATE("Sell-to Customer No.", "Account No.");
    //           EFTTran.INSERT(TRUE);
    //           EFTTran.VALIDATE("Currency Code", "Currency Code");
    //           EFTTran.VALIDATE("Transaction Amount", ABS(Amount));
    //       //EFT4.00.00 -
    //           IF "EFT Customer Link Line No." <> 0 THEN BEGIN
    //             EFTTran.VALIDATE("Customer Link Type", "EFT Customer Link Type");
    //             EFTTran.VALIDATE("Customer Link No.", "EFT Customer Link No.");
    //             EFTTran.VALIDATE("Customer Link Line No.", "EFT Customer Link Line No.");
    //           END ELSE BEGIN
    //             EFTTran.VALIDATE("Routing Number", "Routing Number");
    //             EFTTran.VALIDATE("Account Number", GetAccountNumber);
    //             EFTTran.VALIDATE("Expiration Month", "Expiration Month");
    //             EFTTran.VALIDATE("Expiration Year", "Expiration Year");
    //           END;
    //       //EFT4.00.00 +
    //           EFTTran.MODIFY(TRUE);
    //           EFTSubmit.RUN(EFTTran);
    //       //EFT4.00.02.02 -
    //           IF EFTTran."Transaction Status" IN [EFTTran."Transaction Status"::"4",
    //                                               EFTTran."Transaction Status"::"5",
    //                                               EFTTran."Transaction Status"::"1",
    //                                               EFTTran."Transaction Status"::"2"] THEN BEGIN
    //       //EFT4.00.02.02 +
    //             IF EFTTran."Method Type" IN [EFTTran."Method Type"::"3",
    //                                          EFTTran."Method Type"::"5"] THEN BEGIN
    //               GenJnlLine.SETCURRENTKEY("EFT Store No.", "EFT Terminal No.", "EFT Transaction Entry No.");
    //               GenJnlLine.SETRANGE("EFT Store No.", EFTTran."Store No.");
    //               GenJnlLine.SETRANGE("EFT Terminal No.", EFTTran."Terminal No.");
    //               GenJnlLine.SETRANGE("EFT Transaction Entry No.", EFTTran."Entry No.");
    //               GenJnlLine.DELETEALL(TRUE);
    //               VALIDATE("EFT Store No.", EFTTran."Store No.");
    //               VALIDATE("EFT Terminal No.", EFTTran."Terminal No.");
    //               VALIDATE("EFT Transaction Entry No.", EFTTran."Entry No.");
    //               MODIFY(TRUE);
    //       //EFT4.00.02 -
    //               IF EFTSettleTran."Transaction Status" = EFTSettleTran."Transaction Status"::"4" THEN
    //                 EFTGenJnlMgt.SuggestCashReceiptSummary(EFTTran,
    //                                                        EFTTran."Gateway No.",
    //                                                        EFTTran."Gateway Account No.",
    //                                                        EFTTran."Account Type",
    //                                                        "Posting Date",
    //                                                        EFTTran."Batch No.");
    //       //EFT4.00.02 +
    //             END ELSE IF EFTTran."Method Type" = EFTTran."Method Type"::"1" THEN BEGIN
    //               IF EFTTran."Transaction Status" = EFTTran."Transaction Status"::"4" THEN BEGIN
    //                 EFTMgt.CreateSettleTransaction(EFTTran, EFTSettleTran);
    //                 EFTSubmit.RUN(EFTSettleTran);
    //                 IF EFTSettleTran."Transaction Status" IN [EFTSettleTran."Transaction Status"::"4",
    //                                                           EFTSettleTran."Transaction Status"::"1"] THEN BEGIN
    //                   GenJnlLine.SETCURRENTKEY("EFT Store No.", "EFT Terminal No.", "EFT Transaction Entry No.");
    //                   GenJnlLine.SETRANGE("EFT Store No.", EFTSettleTran."Store No.");
    //                   GenJnlLine.SETRANGE("EFT Terminal No.", EFTSettleTran."Terminal No.");
    //                   GenJnlLine.SETRANGE("EFT Transaction Entry No.", EFTSettleTran."Entry No.");
    //                   GenJnlLine.DELETEALL(TRUE);
    //                   VALIDATE("EFT Store No.", EFTSettleTran."Store No.");
    //                   VALIDATE("EFT Terminal No.", EFTSettleTran."Terminal No.");
    //                   VALIDATE("EFT Transaction Entry No.", EFTSettleTran."Entry No.");
    //                   MODIFY(TRUE);
    //       //EFT4.00.02 -
    //                   IF EFTSettleTran."Transaction Status" = EFTSettleTran."Transaction Status"::"4" THEN
    //                     EFTGenJnlMgt.SuggestCashReceiptSummary(EFTSettleTran,
    //                                                            EFTSettleTran."Gateway No.",
    //                                                            EFTSettleTran."Gateway Account No.",
    //                                                            EFTSettleTran."Account Type",
    //                                                            "Posting Date",
    //                                                            EFTSettleTran."Batch No.");
    //       //EFT4.00.02 +
    //                 END;
    //               END ELSE BEGIN
    //                 EFTSettleTran.SETCURRENTKEY("Store No.", "Gateway No.", "Gateway Account No.", "Original Reference Number");
    //                 EFTSettleTran.SETRANGE("Store No.", EFTTran."Store No.");
    //                 EFTSettleTran.SETRANGE("Original Reference Number", EFTTran."Reference Number");
    //                 EFTSettleTran.SETRANGE("Method Type", EFTSettleTran."Method Type"::"2");
    //                 EFTSettleTran.SETFILTER("Transaction Status", '%1|%2', EFTSettleTran."Transaction Status"::"4",
    //                                                                        EFTSettleTran."Transaction Status"::"2");
    //                 IF EFTSettleTran.FINDLAST THEN BEGIN
    //                   GenJnlLine.SETCURRENTKEY("EFT Store No.", "EFT Terminal No.", "EFT Transaction Entry No.");
    //                   GenJnlLine.SETRANGE("EFT Store No.", EFTSettleTran."Store No.");
    //                   GenJnlLine.SETRANGE("EFT Terminal No.", EFTSettleTran."Terminal No.");
    //                   GenJnlLine.SETRANGE("EFT Transaction Entry No.", EFTSettleTran."Entry No.");
    //                   GenJnlLine.DELETEALL(TRUE);
    //                   VALIDATE("EFT Store No.", EFTSettleTran."Store No.");
    //                   VALIDATE("EFT Terminal No.", EFTSettleTran."Terminal No.");
    //                   VALIDATE("EFT Transaction Entry No.", EFTSettleTran."Entry No.");
    //                   MODIFY(TRUE);
    //       //EFT4.00.02 -
    //                   IF EFTSettleTran."Transaction Status" = EFTSettleTran."Transaction Status"::"4" THEN
    //                     EFTGenJnlMgt.SuggestCashReceiptSummary(EFTSettleTran,
    //                                                            EFTSettleTran."Gateway No.",
    //                                                            EFTSettleTran."Gateway Account No.",
    //                                                            EFTSettleTran."Account Type",
    //                                                            "Posting Date",
    //                                                            EFTSettleTran."Batch No.");
    //       //EFT4.00.02 +
    //                 END;
    //               END;
    //             END;
    //           END;
    //         END;
    //       END;

    // end;


    //Unsupported feature: Property Modification (TextConstString) on "Text009(Variable 1009)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text009 : ENU=USD;ESM=$;FRC=$;ENC=CAD;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text009 : ENU=LCY;ESM=$;FRC=$;ENC=CAD;
    //Variable type has not been exported.

    var
        EFTText001: Label 'Invalid Account Number.';
        EFTText002: Label 'Expired Card.';
        EFTText003: Label 'is not valid';
        EFTTran004: Label '%1 cannot be changed when there is a linked EFT Transaction.';
        EFTText005: Label '%1 may not be manually entered when Tokenization is in use. You must use the lookup button to select an Account.';
        EFTText006: Label '%1 may not be used when the Data Protection Type is No Storage in EFT Setup.';
}

