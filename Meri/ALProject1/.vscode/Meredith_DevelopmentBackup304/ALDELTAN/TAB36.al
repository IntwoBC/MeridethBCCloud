tableextension 50007 tableextension70000304 extends "Sales Header"
{
    // <changelog>
    //   <add id="NA0001" dev="ELYNCH" date="2004-03-26" area="NASALESTAX" feature="617"
    //     releaseversion="NAVUS3.70.00.44">Added field and code for NA Sales Tax</add>
    //   <change id="NA0002" dev="ELYNCH" date="2006-04-11" area="NA ADDRESS" feature="293"
    //     baseversion="NAVUS3.70.00.44" releaseversion="NAVNA5.00">Populate State field (County) from ZIP code table
    //     </change>
    //   <change id="NA0006" dev="MBAHADUR" date="2007-12-03" area="NASALESTAX" feature="31623"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA5.00.01">Fix Prepayments - added a new boolean field 12600
    //     &quot;Prepmt. Include Tax&quot; in the table.</change>
    //   <change id="NA0007" dev="JNOZZI" date="2007-12-19" area="NASALESTAX" feature="31197"
    //     baseversion="NAVNA5.00.01" releaseversion="NAVNA5.00.01">Add &quot;STE Transaction ID&quot; for Sales Tax
    //     Engine.</change>
    //   <change id="NA0008" dev="ELYNCH" date="2008-05-14" area="NASALESTAX" feature="36490"
    //     baseversion="NAVNA5.00.02" releaseversion="NAVNA6.00">Tax Exemption No. was not populated from cust.</change>
    // </changelog>
    // 
    // MER0001 TLE 11/11/13 - Popup customer notes.
    // MER0002 TLE 12/06/13 - Add "Total Cost","Total Burden Amount","Total Commission Amount","Salesperson Commission Amount",
    //   "Salesperson Order Fee","Salesperson Misc. Charge","Salesperson Commission Rate","Credit Card Charges"
    // MER0003 TLE 01/05/14 - Change "Salesperson Code" w "Ship-to Code"
    // MER0004 TLE 01/20/14 - ExtractFreightExpenses
    // MER0005 TLE 03/11/14 - CalcSalespersonOrderFee
    // MER0006 CH  04/01/14 - New fields Total Outstanding Line Amount & Total Outstanding Line Cost
    // MER0007 TLE 04/03/14 - Bug fix in CalcSalesperson Order Fee
    // MER0008 TLE 04/03/14 - UpdateCommissions use table "Document Commission Charges" instead of header level fields.
    // MER0009 TLE 04/07/14 - Fix CalcSalesperson Order fee.
    // MER0010 TLE 04/08/14 - Fix ExtractFreightExpenses
    // MER0011 TLE 04/08/14 - Include tax on Credit Card Charges.
    // MER0012 TLE 04/10/14 - No Slsperson Comm Amt on CM's.
    // MER0013 TLE 04/16/14 - UpdateCommissions. Different formula for Credit Memos.
    // MER0014 TLE 04/18/14 - Cleanup UpdateCommissions
    // MER0015 TLE 05/05/14 - CalcSalespersonOrderFee. Suppress calc for Credit Memo.
    // MER0016 TLE 05/08/14 - Add CRM Customer name (removed)
    // MER0017 TLE 05/09/14 - UpdateCommissions,CalcSalespersonOrderFee for Sales Return Orders
    fields
    {
        modify("Bill-to Name")
        {
            Caption = 'Bill-to Name';
        }
        modify("Bill-to Name 2")
        {
            Caption = 'Bill-to Name 2';
        }
        modify("Bill-to Address")
        {
            Caption = 'Bill-to Address';
        }
        modify("Bill-to Address 2")
        {
            Caption = 'Bill-to Address 2';
        }
        modify("Bill-to City")
        {
            Caption = 'Bill-to City';
        }
        modify("Bill-to Contact")
        {
            Caption = 'Bill-to Contact';
        }

        //Unsupported feature: Property Modification (Data type) on ""Your Reference"(Field 11)".

        modify("Amount Including VAT")
        {
            Caption = 'Amount Including VAT';
        }
        modify("VAT Registration No.")
        {
            Caption = 'VAT Registration No.';
        }
        modify("VAT Country/Region Code")
        {
            Caption = 'VAT Country/Region Code';
        }
        modify("Bill-to Post Code")
        {
            Caption = 'Bill-to Post Code';
        }
        modify("Bill-to County")
        {
            Caption = 'Bill-to County';
        }
        modify("Bill-to Country/Region Code")
        {
            Caption = 'Bill-to Country/Region Code';
        }
        modify("Sell-to Post Code")
        {
            Caption = 'Sell-to Post Code';
        }
        modify("Sell-to County")
        {
            Caption = 'Sell-to County';
        }
        modify("Ship-to Post Code")
        {
            Caption = 'Ship-to Post Code';
        }
        modify("Ship-to County")
        {
            Caption = 'Ship-to County';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'VAT Bus. Posting Group';
        }
        modify("Bill-to IC Partner Code")
        {
            Caption = 'Bill-to IC Partner Code';
        }
        modify("Payment Method Code")
        {
            trigger OnAfterValidate()
            var
                TempSalesLine: Record "Sales Line" temporary;
            begin
                // BC14 Table 36 field 104 MER0008: UpdateCommissions(tempSalesLine) - credit card charges depend on the payment method
                if (Rec."No." <> '') and not Rec.IsTemporary() then
                    Rec.UpdateCommissions(TempSalesLine);
            end;
        }


        //Unsupported feature: Code Insertion (VariableCollection) on ""Sell-to Customer No."(Field 2).OnValidate".

        //trigger (Variable: CommentLine)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;



        //Unsupported feature: Code Modification on ""Sell-to Customer No."(Field 2).OnValidate".

        //trigger "(Field 2)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckCreditLimitIfLineNotInsertedYet;
        if "No." = '' then
          InitRecord;
        #4..18
          if Confirmed then begin
            SalesLine.SetRange("Document Type","Document Type");
            SalesLine.SetRange("Document No.","No.");
            if "Sell-to Customer No." = '' then begin
              if SalesLine.FindFirst then
                Error(
                  Text005,
                  FieldCaption("Sell-to Customer No."));
              Init;
              OnValidateSellToCustomerNoAfterInit(Rec,xRec);
              SalesSetup.Get;
        #30..59
        GetCust("Sell-to Customer No.");

        Cust.CheckBlockedCustOnDocs(Cust,"Document Type",false,false);
        GLSetup.Get;
        if GLSetup."VAT in Use" then
          Cust.TestField("Gen. Bus. Posting Group");
        CopySellToCustomerAddressFieldsFromCustomer(Cust);

        if "Sell-to Customer No." = xRec."Sell-to Customer No." then
          if ShippedSalesLinesExist or ReturnReceiptExist then begin
        #70..95
        if not SkipSellToContact then
          UpdateSellToCont("Sell-to Customer No.");

        if "No." <> '' then
          StandardCodesMgt.CheckShowSalesRecurringLinesNotification(Rec);

        if (xRec."Sell-to Customer No." <> '') and (xRec."Sell-to Customer No." <> "Sell-to Customer No.") then
          RecallModifyAddressNotification(GetModifyCustomerAddressNotificationId);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..21
        //EFT3.00.10 -
            //EFTTran.SETCURRENTKEY("Document Type", "Document No.");
           // EFTTran.SETRANGE("Document Type", "Document Type");
            //EFTTran.SETRANGE("Document No.", "No.");
        //EFT3.00.10 +
        #22..26
        //EFT3.00.10 -
             // IF NOT EFTTran.ISEMPTY THEN
               // ERROR(EFTText003, FIELDCAPTION("Sell-to Customer No."));
        //EFT3.00.10 +
        #27..62
        //NA0002.begin
        #63..65


        CopySellToCustomerAddressFieldsFromCustomer(Cust);



        {* IF NOT SkipSellToContact THEN
          "Sell-to Contact" := Cust.Contact;
        "Gen. Bus. Posting Group" := Cust."Gen. Bus. Posting Group";
        "VAT Bus. Posting Group" := Cust."VAT Bus. Posting Group";
        "Tax Area Code" := Cust."Tax Area Code";
        "Tax Liable" := Cust."Tax Liable";
        "Tax Exemption No." := Cust."Tax Exemption No.";    // NA0008
        "VAT Registration No." := Cust."VAT Registration No.";
        "VAT Country/Region Code" := Cust."Country/Region Code";
        "Shipping Advice" := Cust."Shipping Advice";
        "Responsibility Center" := UserSetupMgt.GetRespCenter(0,Cust."Responsibility Center");
        VALIDATE("Location Code",UserSetupMgt.GetLocation(0,Cust."Location Code","Responsibility Center"));*}

        #67..98

        #99..101

        if (xRec."Sell-to Customer No." <> '') and (xRec."Sell-to Customer No." <> "Sell-to Customer No.") then
          RecallModifyAddressNotification(GetModifyCustomerAddressNotificationId);
        */
        //end;


        //Unsupported feature: Code Modification on ""Bill-to Customer No."(Field 4).OnValidate".

        //trigger "(Field 4)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        BilltoCustomerNoChanged := xRec."Bill-to Customer No." <> "Bill-to Customer No.";
        if BilltoCustomerNoChanged then
          if xRec."Bill-to Customer No." = '' then
            InitRecord
          else begin
            if GetHideValidationDialog or not GuiAllowed then
              Confirmed := true
            else
              Confirmed := Confirm(ConfirmChangeQst,false,BillToCustomerTxt);
            if Confirmed then begin
              SalesLine.SetRange("Document Type","Document Type");
              SalesLine.SetRange("Document No.","No.");

              CheckShipmentInfo(SalesLine,true);
              CheckPrepmtInfo(SalesLine);
              CheckReturnInfo(SalesLine,true);

              SalesLine.Reset;
            end else
              "Bill-to Customer No." := xRec."Bill-to Customer No.";
          end;

        GetCust("Bill-to Customer No.");
        Cust.CheckBlockedCustOnDocs(Cust,"Document Type",false,false);
        Cust.TestField("Customer Posting Group");
        PostingSetupMgt.CheckCustPostingGroupReceivablesAccount("Customer Posting Group");
        CheckCreditLimit;
        CopyBillToCustomerAddressFieldsFromCustomer(Cust);

        if not BilltoCustomerNoChanged then
          if ShippedSalesLinesExist then begin
            TestField("Customer Disc. Group",xRec."Customer Disc. Group");
            TestField("Currency Code",xRec."Currency Code");
          end;

        CreateDim(
          DATABASE::Customer,"Bill-to Customer No.",
          DATABASE::"Salesperson/Purchaser","Salesperson Code",
          DATABASE::Campaign,"Campaign No.",
          DATABASE::"Responsibility Center","Responsibility Center",
          DATABASE::"Customer Template","Bill-to Customer Template Code");

        Validate("Payment Terms Code");
        Validate("Prepmt. Payment Terms Code");
        Validate("Payment Method Code");
        Validate("Currency Code");
        Validate("Prepayment %");

        if (xRec."Sell-to Customer No." = "Sell-to Customer No.") and
           (xRec."Bill-to Customer No." <> "Bill-to Customer No.")
        then begin
          RecreateSalesLines(BillToCustomerTxt);
          BilltoCustomerNoChanged := false;
        end;
        if not SkipBillToContact then
          UpdateBillToCont("Bill-to Customer No.");

        "Bill-to IC Partner Code" := Cust."IC Partner Code";
        "Send IC Document" := ("Bill-to IC Partner Code" <> '') and ("IC Direction" = "IC Direction"::Outgoing);

        if (xRec."Bill-to Customer No." <> '') and (xRec."Bill-to Customer No." <> "Bill-to Customer No.") then
          RecallModifyAddressNotification(GetModifyBillToCustomerAddressNotificationId);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*


        //TestStatusOpen;
        //BilltoCustomerNoChanged := xRec."Bill-to Customer No." <> "Bill-to Customer No.";
        //IF BilltoCustomerNoChanged THEN
        //  IF xRec."Bill-to Customer No." = '' THEN
        //    InitRecord
        //  ELSE BEGIN
        //    IF GetHideValidationDialog OR NOT GUIALLOWED THEN
        //      Confirmed := TRUE
        //    ELSE
        //      Confirmed := CONFIRM(ConfirmChangeQst,FALSE,BillToCustomerTxt);
        //    IF Confirmed THEN BEGIN
        //      SalesLine.SETRANGE("Document Type","Document Type");
        //      SalesLine.SETRANGE("Document No.","No.");



        //GetCust("Bill-to Customer No.");
        //Cust.CheckBlockedCustOnDocs(Cust,"Document Type",FALSE,FALSE);
        //Cust.TESTFIELD("Customer Posting Group");
        //PostingSetupMgt.CheckCustPostingGroupReceivablesAccount("Customer Posting Group");
        //CheckCreditLimit;
        //CopyBillToCustomerAddressFieldsFromCustomer(Cust);




        //IF NOT BilltoCustomerNoChanged THEN
        //  IF ShippedSalesLinesExist THEN BEGIN
        //    TESTFIELD("Customer Disc. Group",xRec."Customer Disc. Group");
        //    TESTFIELD("Currency Code",xRec."Currency Code");
        //  END;
        //
        //CreateDim(
        //  DATABASE::Customer,"Bill-to Customer No.",
        //  DATABASE::"Salesperson/Purchaser","Salesperson Code",
        //  DATABASE::Campaign,"Campaign No.",
        //  DATABASE::"Responsibility Center","Responsibility Center",
        //  DATABASE::"Customer Template","Bill-to Customer Template Code");
        //
        //VALIDATE("Payment Terms Code");
        //VALIDATE("Prepmt. Payment Terms Code");
        //VALIDATE("Payment Method Code");
        //VALIDATE("Currency Code");
        //VALIDATE("Prepayment %");




        //IF (xRec."Sell-to Customer No." = "Sell-to Customer No.") AND
        //   (xRec."Bill-to Customer No." <> "Bill-to Customer No.")
        //THEN BEGIN
        //  RecreateSalesLines(BillToCustomerTxt);
        //  BilltoCustomerNoChanged := FALSE;
        //END;
        //IF NOT SkipBillToContact THEN
        //  UpdateBillToCont("Bill-to Customer No.");

        ////IF (xRec."Bill-to Customer No." <> '') AND (xRec."Bill-to Customer No." <> "Bill-to Customer No.") THEN
        ////  RecallModifyAddressNotification(GetModifyBillToCustomerAddressNotificationId);
        */
        //end;


        //Unsupported feature: Code Insertion on ""Your Reference"(Field 11)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        //EFT4.00.04 -
        {*IF CheckEFTPermission THEN BEGIN
          EFTTerminal.GetCurrentTerminal(TRUE);
          EFTStore.GET(EFTTerminal."Store No.");
          IF EFTStore."ChargeLogic Connect Store No." <> '' THEN
            EFTTransactionRetrieval.RetrieveForSales(EFTTerminal."Store No.", "Your Reference", "Document Type", "No.");
        END;*}
        //EFT4.00.04 +
        */
        //end;


        //Unsupported feature: Code Modification on ""Ship-to Code"(Field 12).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if ("Document Type" = "Document Type"::Order) and
           (xRec."Ship-to Code" <> "Ship-to Code")
        then begin
          SalesLine.SetRange("Document Type",SalesLine."Document Type"::Order);
          SalesLine.SetRange("Document No.","No.");
          SalesLine.SetFilter("Purch. Order Line No.",'<>0');
          if not SalesLine.IsEmpty then
            Error(
              Text006,
              FieldCaption("Ship-to Code"));
          SalesLine.Reset;
        end;

        if not IsCreditDocType then
          if "Ship-to Code" <> '' then begin
            if xRec."Ship-to Code" <> '' then
              begin
              GetCust("Sell-to Customer No.");
              if Cust."Location Code" <> '' then
                Validate("Location Code",Cust."Location Code");
              "Tax Area Code" := Cust."Tax Area Code";
            end;
            ShipToAddr.Get("Sell-to Customer No.","Ship-to Code");
            CopyShipToCustomerAddressFieldsFromShipToAddr(ShipToAddr);
          end else
            if "Sell-to Customer No." <> '' then begin
              GetCust("Sell-to Customer No.");
              CopyShipToCustomerAddressFieldsFromCustomer(Cust);
            end;

        GetShippingTime(FieldNo("Ship-to Code"));

        if (xRec."Sell-to Customer No." = "Sell-to Customer No.") and
           (xRec."Ship-to Code" <> "Ship-to Code")
        then
          if (xRec."VAT Country/Region Code" <> "VAT Country/Region Code") or
             (xRec."Tax Area Code" <> "Tax Area Code")
          then
            RecreateSalesLines(FieldCaption("Ship-to Code"))
          else begin
            if xRec."Shipping Agent Code" <> "Shipping Agent Code" then
              MessageIfSalesLinesExist(FieldCaption("Shipping Agent Code"));
            if xRec."Shipping Agent Service Code" <> "Shipping Agent Service Code" then
              MessageIfSalesLinesExist(FieldCaption("Shipping Agent Service Code"));
            if xRec."Tax Liable" <> "Tax Liable" then
              Validate("Tax Liable");
          end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //The code has been merged but contained errors that could prevent import
        //and the code has been put in comments. Use Shift+Ctrl+O to Uncomment
        //IF ("Document Type" = "Document Type"::Order) AND
        //   (xRec."Ship-to Code" <> "Ship-to Code")
        //THEN BEGIN
        //  SalesLine.SETRANGE("Document Type",SalesLine."Document Type"::Order);
        //  SalesLine.SETRANGE("Document No.","No.");
        //  SalesLine.SETFILTER("Purch. Order Line No.",'<>0');
        //  IF NOT SalesLine.ISEMPTY THEN
        //    ERROR(
        //      Text006,
        //      FIELDCAPTION("Ship-to Code"));
        //  SalesLine.RESET;
        //END;
        //


        #13..30

        //      CopyShipToCustomerAddressFieldsFromCustomer(Cust);

        //      "Ship-to Contact" := Cust.Contact;
        //      "Shipment Method Code" := Cust."Shipment Method Code";
        //      //NA0002.begin
        //      IF NOT SellToCustTemplate.GET("Sell-to Customer Template Code") THEN BEGIN
        //        "Tax Area Code" := Cust."Tax Area Code";
        //        "Tax Liable" := Cust."Tax Liable";
        //      END;
        //      //NA0002.end
        //      IF Cust."Location Code" <> '' THEN
        //        VALIDATE("Location Code",Cust."Location Code");
        //      "Shipping Agent Code" := Cust."Shipping Agent Code";
        //      "Shipping Agent Service Code" := Cust."Shipping Agent Service Code";
        //    END;
        //
        //GetShippingTime(FIELDNO("Ship-to Code"));
        //
        //IF (xRec."Sell-to Customer No." = "Sell-to Customer No.") AND
        //   (xRec."Ship-to Code" <> "Ship-to Code")
        //THEN
        //  IF (xRec."VAT Country/Region Code" <> "VAT Country/Region Code") OR
        //     (xRec."Tax Area Code" <> "Tax Area Code")
        //  THEN
        //    RecreateSalesLines(FIELDCAPTION("Ship-to Code"))
        //  ELSE BEGIN
        //    IF xRec."Shipping Agent Code" <> "Shipping Agent Code" THEN
        //      MessageIfSalesLinesExist(FIELDCAPTION("Shipping Agent Code"));
        //    IF xRec."Shipping Agent Service Code" <> "Shipping Agent Service Code" THEN
        //      MessageIfSalesLinesExist(FIELDCAPTION("Shipping Agent Service Code"));
        //    IF xRec."Tax Liable" <> "Tax Liable" THEN
        //      VALIDATE("Tax Liable");
        //  END;
        //
        //// MER0003 >>
        //IF "Ship-to Code" <> '' THEN
        //  VALIDATE("Salesperson Code",ShipToAddr."Salesperson Code")
        //ELSE BEGIN
        //  IF Customer.GET("Sell-to Customer No.") THEN
        //    VALIDATE("Salesperson Code",Customer."Salesperson Code");
        //END;
        //
        //CLEAR("Salesperson Commission %");
        //IF Salesperson.GET("Salesperson Code") THEN
        //  "Salesperson Commission %" := Salesperson."Commission %";
        //// MER0003 <<
        */
        //end;


        //Unsupported feature: Code Modification on ""Bal. Account No."(Field 55).OnValidate".

        //trigger  Account No()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Bal. Account No." <> '' then
          case "Bal. Account Type" of
            "Bal. Account Type"::"G/L Account":
        #4..12
                BankAcc.TestField("Currency Code","Currency Code");
              end;
          end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..15
        //EFT3.00.07 -
        if "Bal. Account No." <> '' then begin
          //CALCFIELDS("Net Amount Settled (LCY)", "Net Amount Authorized (LCY)");
          //TESTFIELD("Net Amount Settled (LCY)", 0);
          //TESTFIELD("Net Amount Authorized (LCY)", 0);
        //EFT4.00.04 -
          if CheckEFTPermission then begin
        //EFT4.00.04 +
            //EFTTran.SETCURRENTKEY("Document Type", "Document No.");
           // EFTTran.SETRANGE("Document Type", "Document Type");
            //EFTTran.SETRANGE("Document No.", "No.");
           // EFTTran.SETRANGE("Transaction Status", EFTTran."Transaction Status"::"0", EFTTran."Transaction Status"::"2");
            //IF NOT EFTTran.ISEMPTY THEN
             // FIELDERROR("Bal. Account No.", EFTText002);
          end;
        end;
        //EFT3.00.07 +
        */
        //end;


        //Unsupported feature: Code Modification on ""Bill-to Country/Region Code"(Field 87).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ModifyBillToCustomerAddress;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*

        ModifyBillToCustomerAddress;
        */
        //end;


        //Unsupported feature: Code Modification on ""Sell-to Country/Region Code"(Field 90).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        UpdateShipToAddressFromSellToAddress(FieldNo("Ship-to Country/Region Code"));
        ModifyCustomerAddress;
        Validate("Ship-to Country/Region Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        if ("Sell-to Country/Region Code" <> xRec."Sell-to Country/Region Code") and (xRec."Sell-to Country/Region Code" <> '') then
          //PostCode.ClearFields("Sell-to City","Sell-to Post Code","Sell-to County");
         begin
           "Sell-to City" :='';
           "Sell-to Post Code":='';
           "Sell-to County":='';
           end;
        */
        //end;


        //Unsupported feature: Code Insertion on ""Ship-to Country/Region Code"(Field 93)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        if ("Ship-to Country/Region Code" <> xRec."Ship-to Country/Region Code") and (xRec."Ship-to Country/Region Code" <> '') then
          //PostCode.ClearFields("Ship-to City","Ship-to Post Code","Ship-to County");
          begin
            "Ship-to City" :='';
            "Ship-to Post Code":='';
            "Ship-to County":='';
            end;
        */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""Payment Method Code"(Field 104).OnValidate".

        //trigger (Variable: tempSalesLine)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on ""Payment Method Code"(Field 104).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PaymentMethod.Init;
        if "Payment Method Code" <> '' then
          PaymentMethod.Get("Payment Method Code");
        #4..8
          "Direct Debit Mandate ID" := '';
        "Bal. Account Type" := PaymentMethod."Bal. Account Type";
        "Bal. Account No." := PaymentMethod."Bal. Account No.";
        if "Bal. Account No." <> '' then begin
          TestField("Applies-to Doc. No.",'');
          TestField("Applies-to ID",'');
          Clear("Payment Service Set ID");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..11
        //EFT3.00.07 -
        if "Bal. Account No." <> '' then begin
         // CALCFIELDS("Net Amount Settled (LCY)", "Net Amount Authorized (LCY)");
         // TESTFIELD("Net Amount Settled (LCY)", 0);
         // TESTFIELD("Net Amount Authorized (LCY)", 0);
        //EFT4.00.04 -
          if CheckEFTPermission then begin
        //EFT4.00.04 +
            //EFTTran.SETCURRENTKEY("Document Type", "Document No.");
           // EFTTran.SETRANGE("Document Type", "Document Type");
           // EFTTran.SETRANGE("Document No.", "No.");
           // EFTTran.SETRANGE("Transaction Status", EFTTran."Transaction Status"::"0", EFTTran."Transaction Status"::"2");
            //IF NOT EFTTran.ISEMPTY THEN
             // FIELDERROR("Bal. Account No.", EFTText002);
          end;
        end;
        //EFT3.00.07 +
        //EFT4.00.02.03 -
        //IF "Payment Method Code" <> xRec."Payment Method Code" THEN
         // VALIDATE("EFT Tender Type", PaymentMethod."EFT Tender Type");
        //EFT4.00.02.03 +
        #12..16

        // MER0008 >>
        UpdateCommissions(tempSalesLine);
        // MER0008 <<
        */
        //end;


        //Unsupported feature: Code Modification on ""Tax Liable"(Field 115).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        UpdateSalesLinesByFieldNo(FieldNo("Tax Liable"),false);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*

        TestStatusOpen;
        UpdateSalesLinesByFieldNo(FieldNo("Tax Liable"),false);
        */
        //end;


        //Unsupported feature: Code Modification on ""Sell-to Customer Template Code"(Field 5051).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestField("Document Type","Document Type"::Quote);
        TestStatusOpen;

        #4..17
          end;
        end;

        if SellToCustTemplate.Get("Sell-to Customer Template Code") then
          CopyFromSellToCustTemplate(SellToCustTemplate);

        if not InsertMode and
           ((xRec."Sell-to Customer Template Code" <> "Sell-to Customer Template Code") or
            (xRec."Currency Code" <> "Currency Code"))
        then
          RecreateSalesLines(FieldCaption("Sell-to Customer Template Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..20

        #21..23

        #24..28
        */
        //end;


        //Unsupported feature: Code Modification on ""Bill-to Customer Template Code"(Field 5054).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestField("Document Type","Document Type"::Quote);
        TestStatusOpen;

        #4..25
          "Customer Price Group" := BillToCustTemplate."Customer Price Group";
          "Customer Disc. Group" := BillToCustTemplate."Customer Disc. Group";
          "Allow Line Disc." := BillToCustTemplate."Allow Line Disc.";
          "Tax Area Code" := BillToCustTemplate."Tax Area Code";
          "Tax Liable" := BillToCustTemplate."Tax Liable";
          Validate("Payment Terms Code",BillToCustTemplate."Payment Terms Code");
          Validate("Payment Method Code",BillToCustTemplate."Payment Method Code");
          "Prices Including VAT" := BillToCustTemplate."Prices Including VAT";
        #34..47
           (xRec."Bill-to Customer Template Code" <> "Bill-to Customer Template Code")
        then
          RecreateSalesLines(FieldCaption("Bill-to Customer Template Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..28
          //NA0002.begin
          "Tax Area Code" := BillToCustTemplate."Tax Area Code";
          "Tax Liable" := BillToCustTemplate."Tax Liable";
          //NA0002.end
        #31..50
        */
        //end;


        //Unsupported feature: Code Modification on ""Prepmt. Include Tax"(Field 12600).OnValidate".

        //trigger  Include Tax"(Field 12600)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if IsPrepmtInvoicePosted then
          Error(PrepmtInvoiceExistsErr,FieldCaption("Prepmt. Include Tax"));
        if xRec."Prepmt. Include Tax" = "Prepmt. Include Tax" then
          exit;
        if not "Prepmt. Include Tax" then
        #6..9
        if GLSetup."LCY Code" = "Currency Code" then
          exit;
        Error(PrepmtIncludeTaxErr,FieldCaption("Prepmt. Include Tax"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #3..12
        */
        //end;
        field(50001; "Total Burden Amount"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Burden Amount" WHERE("Document Type" = FIELD("Document Type"),
                                                                  "Document No." = FIELD("No."),
                                                                  Type = CONST(Item)));
            Description = 'MER0002';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "Salesperson Commission Amount"; Decimal)
        {
            CalcFormula = Sum("Document Commission Charges"."Salesperson Commission Amount" WHERE("Document Type" = FIELD("Document Type"),
                                                                                                   "No." = FIELD("No.")));
            Description = 'MER0002';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50006; "Salesperson Order Fee"; Decimal)
        {
            CalcFormula = Sum("Document Commission Charges"."Salesperson Order Fee" WHERE("Document Type" = FIELD("Document Type"),
                                                                                           "No." = FIELD("No.")));
            Description = 'MER0002';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                tempSalesLine: Record "Sales Line" temporary;
            begin
            end;
        }
        field(50007; "Salesperson Misc. Charge"; Decimal)
        {
            CalcFormula = Sum("Document Commission Charges"."Salesperson Misc. Charge" WHERE("Document Type" = FIELD("Document Type"),
                                                                                              "No." = FIELD("No.")));
            Description = 'MER0002';
            FieldClass = FlowField;

            trigger OnValidate()
            var
                tempSalesLine: Record "Sales Line" temporary;
            begin
            end;
        }
        field(50008; "Salesperson Commission %"; Decimal)
        {
            Description = 'MER0002';
            Editable = false;
            FieldClass = Normal;
            DataClassification = ToBeClassified;
        }
        field(50010; "Credit Card Charges"; Decimal)
        {
            CalcFormula = Sum("Document Commission Charges"."Credit Card Charges" WHERE("Document Type" = FIELD("Document Type"),
                                                                                         "No." = FIELD("No.")));
            Description = 'MER0002';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                tempSalesLine: Record "Sales Line" temporary;
            begin
            end;
        }
        field(50011; "Total Outstanding Line Amount"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Line Amount Price" WHERE("Document Type" = FIELD("Document Type"),
                                                                      "Document No." = FIELD("No.")));
            Caption = 'Total Outstanding Line Amount';
            Description = 'MER0006';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50012; "Total Outstanding Line Cost"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Line Amount Cost" WHERE("Document Type" = FIELD("Document Type"),
                                                                     "Document No." = FIELD("No.")));
            Caption = 'Total Outstanding Line Cost';
            Description = 'MER0006';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50013; "VARStreet Order No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                SalesHeader: Record "Sales Header";
                SalesInvoiceHeader: Record "Sales Invoice Header";
            begin
                SalesHeader.SetRange("VARStreet Order No.", "VARStreet Order No.");
                if SalesHeader.Count > 1 then
                    Error('VARStreet Order No. %1 already exists.', "VARStreet Order No.");

                SalesInvoiceHeader.SetRange("VARStreet Order No.", "VARStreet Order No.");
                if SalesInvoiceHeader.FindFirst then
                    Error('VARStreet Order No. %1 already exists and has been invoiced.', "VARStreet Order No.");
            end;
        }
    }
    // keys
    // {
    //     key(Key1; "Bill-to Customer No.")
    //     {
    //     }
    //     key(Key2; "Document Type", "Your Reference")
    //     {
    //     }
    // }


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if not UserSetupMgt.CheckRespCenter(0,"Responsibility Center") then
      Error(
        Text022,
    #4..33
    SalesCommentLine.SetRange("No.","No.");
    SalesCommentLine.DeleteAll;

    if "Tax Area Code" <> '' then begin
      SalesTaxDifference.Reset;
      SalesTaxDifference.SetRange("Document Product Area",SalesTaxDifference."Document Product Area"::Sales);
    #40..52

    if IdentityManagement.IsInvAppId and CustInvoiceDisc.Get(SalesHeader."Invoice Disc. Code") then
      CustInvoiceDisc.Delete; // Cleanup of autogenerated cust. invoice discounts
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*

    #1..36
    //NA0002.begin
    #37..55
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "InitInsert(PROCEDURE 61)".


    //Unsupported feature: Property Modification (Attributes) on "InitRecord(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "AssistEdit(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "TestNoSeries(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "GetNoSeriesCode(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "ConfirmDeletion(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "SalesLinesExist(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "MessageIfSalesLinesExist(PROCEDURE 5)".



    //Unsupported feature: Code Modification on "MessageIfSalesLinesExist(PROCEDURE 5)".

    //procedure MessageIfSalesLinesExist();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if SalesLinesExist and not GetHideValidationDialog then begin
      MessageText := StrSubstNo(LinesNotUpdatedMsg,ChangedFieldName);
      MessageText := StrSubstNo(SplitMessageTxt,MessageText,Text019);
      Message(MessageText);
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*

    #1..5
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "PriceMessageIfSalesLinesExist(PROCEDURE 7)".



    //Unsupported feature: Code Modification on "PriceMessageIfSalesLinesExist(PROCEDURE 7)".

    //procedure PriceMessageIfSalesLinesExist();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if SalesLinesExist and not GetHideValidationDialog then begin
      MessageText := StrSubstNo(LinesNotUpdatedMsg,ChangedFieldName);
      if "Currency Code" <> '' then
        MessageText := StrSubstNo(SplitMessageTxt,MessageText,AffectExchangeRateMsg);
      Message(MessageText);
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*

    #1..6
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "UpdateCurrencyFactor(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "SetHideValidationDialog(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "GetHideValidationDialog(PROCEDURE 123)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateSalesLines(PROCEDURE 15)".



    //Unsupported feature: Code Modification on "UpdateSalesLines(PROCEDURE 15)".

    //procedure UpdateSalesLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Field.SetRange(TableNo,DATABASE::"Sales Header");
    Field.SetRange("Field Caption",ChangedFieldName);
    Field.SetFilter(ObsoleteState,'<>%1',Field.ObsoleteState::Removed);
    Field.Find('-');
    if Field.Next <> 0 then
      Error(DuplicatedCaptionsNotAllowedErr);
    UpdateSalesLinesByFieldNo(Field."No.",AskQuestion);

    OnAfterUpdateSalesLines(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*



    //and the code has been put in comments. Use Shift+Ctrl+O to Uncomment
    //IF NOT SalesLinesExist THEN
    //  EXIT;
    //
    //NotRunningOnSaaS := TRUE;
    //CASE ChangedFieldName OF
    //  FIELDCAPTION("Shipping Agent Code"),
    //  FIELDCAPTION("Shipping Agent Service Code"):
    //    NotRunningOnSaaS := NOT PermissionManager.SoftwareAsAService;
    //END;
    //IF AskQuestion THEN BEGIN
    //  Question := STRSUBSTNO(
    //      Text031 +
    //      Text032,ChangedFieldName);
    //  IF GUIALLOWED THEN
    //    IF NotRunningOnSaaS THEN
    //      IF DIALOG.CONFIRM(Question,TRUE) THEN
    //        CASE ChangedFieldName OF
    //          FIELDCAPTION("Shipment Date"),
    //          FIELDCAPTION("Shipping Agent Code"),
    //          FIELDCAPTION("Shipping Agent Service Code"),
    //          FIELDCAPTION("Shipping Time"),
    //          FIELDCAPTION("Requested Delivery Date"),
    //          FIELDCAPTION("Promised Delivery Date"),
    //          FIELDCAPTION("Outbound Whse. Handling Time"):
    //            ConfirmResvDateConflict;
    //        END
    //      ELSE
    //        EXIT
    //    ELSE
    //      ConfirmResvDateConflict;
    //END;
    //
    //SalesLine.LOCKTABLE;
    //MODIFY;
    //
    //SalesLine.RESET;
    //SalesLine.SETRANGE("Document Type","Document Type");
    //SalesLine.SETRANGE("Document No.","No.");
    //IF SalesLine.FINDSET THEN
    //  REPEAT
    //    CASE ChangedFieldName OF
    //      FIELDCAPTION("Shipment Date"):
    //        IF SalesLine."No." <> '' THEN
    //          SalesLine.VALIDATE("Shipment Date","Shipment Date");
    //      FIELDCAPTION("Currency Factor"):
    //        IF SalesLine.Type <> SalesLine.Type::" " THEN BEGIN
    //          SalesLine.VALIDATE("Unit Price");
    //          SalesLine.VALIDATE("Unit Cost (LCY)");
    //          IF SalesLine."Job No." <> '' THEN
    //            JobTransferLine.FromSalesHeaderToPlanningLine(SalesLine,"Currency Factor");
    //        END;
    //      FIELDCAPTION("Transaction Type"):
    //        SalesLine.VALIDATE("Transaction Type","Transaction Type");
    //      FIELDCAPTION("Transport Method"):
    //        SalesLine.VALIDATE("Transport Method","Transport Method");
    //      FIELDCAPTION("Exit Point"):
    //        SalesLine.VALIDATE("Exit Point","Exit Point");
    //      FIELDCAPTION(Area):
    //        SalesLine.VALIDATE(Area,Area);
    //      FIELDCAPTION("Transaction Specification"):
    //        SalesLine.VALIDATE("Transaction Specification","Transaction Specification");
    //      FIELDCAPTION("Shipping Agent Code"):
    //        SalesLine.VALIDATE("Shipping Agent Code","Shipping Agent Code");
    //      FIELDCAPTION("Shipping Agent Service Code"):
    //        IF SalesLine."No." <> '' THEN
    //          SalesLine.VALIDATE("Shipping Agent Service Code","Shipping Agent Service Code");
    //      FIELDCAPTION("Shipping Time"):
    //        IF SalesLine."No." <> '' THEN
    //          SalesLine.VALIDATE("Shipping Time","Shipping Time");
    //      FIELDCAPTION("Prepayment %"):
    //        IF SalesLine."No." <> '' THEN
    //          SalesLine.VALIDATE("Prepayment %","Prepayment %");
    //      FIELDCAPTION("Requested Delivery Date"):
    //        IF SalesLine."No." <> '' THEN
    //          SalesLine.VALIDATE("Requested Delivery Date","Requested Delivery Date");
    //      FIELDCAPTION("Promised Delivery Date"):
    //        IF SalesLine."No." <> '' THEN
    //          SalesLine.VALIDATE("Promised Delivery Date","Promised Delivery Date");
    //      FIELDCAPTION("Outbound Whse. Handling Time"):
    //        IF SalesLine."No." <> '' THEN
    //          SalesLine.VALIDATE("Outbound Whse. Handling Time","Outbound Whse. Handling Time");*}

   // #1..8

    OnAfterUpdateSalesLines(Rec);
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "UpdateSalesLinesByFieldNo(PROCEDURE 154)".


    //Unsupported feature: Property Modification (Attributes) on "CreateDim(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "CheckCustomerCreated(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "CheckCreditMaxBeforeInsert(PROCEDURE 28)".


    //Unsupported feature: Property Modification (Attributes) on "CreateInvtPutAwayPick(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "CreateTask(PROCEDURE 30)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateShipToAddress(PROCEDURE 31)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDocDim(PROCEDURE 32)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateAllLineDim(PROCEDURE 34)".


    //Unsupported feature: Property Modification (Attributes) on "LookupAdjmtValueEntries(PROCEDURE 37)".


    //Unsupported feature: Property Modification (Attributes) on "GetCustomerVATRegistrationNumber(PROCEDURE 63)".


    //Unsupported feature: Property Modification (Attributes) on "GetCustomerVATRegistrationNumberLbl(PROCEDURE 62)".


    //Unsupported feature: Property Modification (Attributes) on "GetCustomerGlobalLocationNumber(PROCEDURE 164)".


    //Unsupported feature: Property Modification (Attributes) on "GetCustomerGlobalLocationNumberLbl(PROCEDURE 161)".


    //Unsupported feature: Property Modification (Attributes) on "GetPstdDocLinesToRevere(PROCEDURE 39)".


    //Unsupported feature: Property Modification (Attributes) on "CalcInvDiscForHeader(PROCEDURE 45)".


    //Unsupported feature: Property Modification (Attributes) on "SetSecurityFilterOnRespCenter(PROCEDURE 43)".


    //Unsupported feature: Property Modification (Attributes) on "InventoryPickConflict(PROCEDURE 46)".


    //Unsupported feature: Property Modification (Attributes) on "WhseShpmntConflict(PROCEDURE 52)".


    //Unsupported feature: Property Modification (Attributes) on "CheckItemAvailabilityInLines(PROCEDURE 142)".


    //Unsupported feature: Property Modification (Attributes) on "QtyToShipIsZero(PROCEDURE 49)".


    //Unsupported feature: Property Modification (Attributes) on "IsApprovedForPosting(PROCEDURE 53)".


    //Unsupported feature: Property Modification (Attributes) on "IsApprovedForPostingBatch(PROCEDURE 54)".


    //Unsupported feature: Property Modification (Attributes) on "GetLegalStatement(PROCEDURE 60)".


    //Unsupported feature: Property Modification (Attributes) on "SendToPosting(PROCEDURE 57)".


    //Unsupported feature: Property Modification (Attributes) on "CancelBackgroundPosting(PROCEDURE 48)".


    //Unsupported feature: Property Modification (Attributes) on "EmailRecords(PROCEDURE 135)".


    //Unsupported feature: Property Modification (Attributes) on "GetDocTypeTxt(PROCEDURE 140)".


    //Unsupported feature: Property Modification (Attributes) on "LinkSalesDocWithOpportunity(PROCEDURE 79)".


    //Unsupported feature: Property Modification (Attributes) on "SynchronizeAsmHeader(PROCEDURE 56)".


    //Unsupported feature: Property Modification (Attributes) on "CheckShippingAdvice(PROCEDURE 55)".


    //Unsupported feature: Property Modification (Attributes) on "TryGetFilterCustNoRange(PROCEDURE 128)".


    //Unsupported feature: Property Modification (Attributes) on "InvoicedLineExists(PROCEDURE 156)".


    //Unsupported feature: Property Modification (Attributes) on "CreateDimSetForPrepmtAccDefaultDim(PROCEDURE 73)".


    //Unsupported feature: Property Modification (Attributes) on "OpenSalesOrderStatistics(PROCEDURE 70)".


    //Unsupported feature: Property Modification (Attributes) on "GetCardpageID(PROCEDURE 58)".


    //Unsupported feature: Property Modification (Attributes) on "CheckAvailableCreditLimit(PROCEDURE 67)".


    //Unsupported feature: Property Modification (Attributes) on "SetStatus(PROCEDURE 99)".


    //Unsupported feature: Property Modification (Attributes) on "OnCheckSalesPostRestrictions(PROCEDURE 115)".


    //Unsupported feature: Property Modification (Attributes) on "OnCustomerCreditLimitExceeded(PROCEDURE 74)".


    //Unsupported feature: Property Modification (Attributes) on "OnCustomerCreditLimitNotExceeded(PROCEDURE 76)".


    //Unsupported feature: Property Modification (Attributes) on "OnCheckSalesReleaseRestrictions(PROCEDURE 81)".


    //Unsupported feature: Property Modification (Attributes) on "CheckSalesReleaseRestrictions(PROCEDURE 162)".


    //Unsupported feature: Property Modification (Attributes) on "DeferralHeadersExist(PROCEDURE 82)".


    //Unsupported feature: Property Modification (Attributes) on "SetSellToCustomerFromFilter(PROCEDURE 186)".


    //Unsupported feature: Property Modification (Attributes) on "CopySellToCustomerFilter(PROCEDURE 44)".


    //Unsupported feature: Property Modification (Attributes) on "BatchConfirmUpdateDeferralDate(PROCEDURE 130)".


    //Unsupported feature: Property Modification (Attributes) on "GetSelectedPaymentServicesText(PROCEDURE 84)".


    //Unsupported feature: Property Modification (Attributes) on "SetDefaultPaymentServices(PROCEDURE 86)".


    //Unsupported feature: Property Modification (Attributes) on "ChangePaymentServiceSetting(PROCEDURE 87)".


    //Unsupported feature: Property Modification (Attributes) on "IsCreditDocType(PROCEDURE 110)".


    //Unsupported feature: Property Modification (Attributes) on "HasSellToAddress(PROCEDURE 94)".


    //Unsupported feature: Property Modification (Attributes) on "HasShipToAddress(PROCEDURE 103)".


    //Unsupported feature: Property Modification (Attributes) on "HasBillToAddress(PROCEDURE 95)".


    //Unsupported feature: Property Modification (Attributes) on "SetShipToAddress(PROCEDURE 117)".



    //Unsupported feature: Code Modification on "ShipToAddressEqualsOldSellToAddress(PROCEDURE 51)".

    //procedure ShipToAddressEqualsOldSellToAddress();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    exit(IsShipToAddressEqualToSellToAddress(xRec,Rec));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*

    exit(IsShipToAddressEqualToSellToAddress(xRec,Rec));
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "ShipToAddressEqualsSellToAddress(PROCEDURE 111)".


    //Unsupported feature: Property Modification (Attributes) on "CopySellToAddressToShipToAddress(PROCEDURE 112)".


    //Unsupported feature: Property Modification (Attributes) on "CopySellToAddressToBillToAddress(PROCEDURE 92)".


    //Unsupported feature: Property Modification (Attributes) on "ConfirmCloseUnposted(PROCEDURE 104)".


    //Unsupported feature: Property Modification (Attributes) on "InitFromSalesHeader(PROCEDURE 109)".


    //Unsupported feature: Property Modification (Attributes) on "SetWorkDescription(PROCEDURE 120)".


    //Unsupported feature: Property Modification (Attributes) on "GetWorkDescription(PROCEDURE 114)".


    //Unsupported feature: Property Modification (Attributes) on "GetWorkDescriptionWorkDescriptionCalculated(PROCEDURE 160)".


    //Unsupported feature: Property Modification (Attributes) on "SetAllowSelectNoSeries(PROCEDURE 100)".


    //Unsupported feature: Property Modification (Attributes) on "SelltoCustomerNoOnAfterValidate(PROCEDURE 125)".


    //Unsupported feature: Property Modification (Attributes) on "SelectSalesHeaderCustomerTemplate(PROCEDURE 127)".


    //Unsupported feature: Property Modification (Attributes) on "RecallModifyAddressNotification(PROCEDURE 148)".


    //Unsupported feature: Property Modification (Attributes) on "GetModifyCustomerAddressNotificationId(PROCEDURE 193)".


    //Unsupported feature: Property Modification (Attributes) on "GetModifyBillToCustomerAddressNotificationId(PROCEDURE 191)".


    //Unsupported feature: Property Modification (Attributes) on "SetModifyCustomerAddressNotificationDefaultState(PROCEDURE 89)".


    //Unsupported feature: Property Modification (Attributes) on "SetModifyBillToCustomerAddressNotificationDefaultState(PROCEDURE 91)".


    //Unsupported feature: Property Modification (Attributes) on "DontNotifyCurrentUserAgain(PROCEDURE 141)".


    //Unsupported feature: Property Modification (Attributes) on "HasDifferentSellToAddress(PROCEDURE 195)".


    //Unsupported feature: Property Modification (Attributes) on "HasDifferentBillToAddress(PROCEDURE 192)".


    //Unsupported feature: Property Modification (Attributes) on "HasDifferentShipToAddress(PROCEDURE 1059)".


    //Unsupported feature: Property Modification (Attributes) on "ShowInteractionLogEntries(PROCEDURE 131)".


    //Unsupported feature: Property Modification (Attributes) on "GetBillToNo(PROCEDURE 132)".


    //Unsupported feature: Property Modification (Attributes) on "GetCurrencySymbol(PROCEDURE 146)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateSalesPersonOnSalesHeader(PROCEDURE 218)".


    //Unsupported feature: Property Modification (Attributes) on "TestQuantityShippedField(PROCEDURE 190)".


    //Unsupported feature: Property Modification (Attributes) on "TestStatusOpen(PROCEDURE 134)".


    //Unsupported feature: Property Modification (Attributes) on "SuspendStatusCheck(PROCEDURE 133)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitRecord(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitNoSeries(PROCEDURE 35)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckCreditLimitCondition(PROCEDURE 290)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterConfirmSalesPrice(PROCEDURE 183)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterRecreateSalesLine(PROCEDURE 152)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterDeleteAllTempSalesLines(PROCEDURE 155)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInsertTempSalesLine(PROCEDURE 158)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetNoSeriesCode(PROCEDURE 166)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetPostingNoSeriesCode(PROCEDURE 175)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetPrepaymentPostingNoSeriesCode(PROCEDURE 178)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterTestNoSeries(PROCEDURE 136)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateShipToAddress(PROCEDURE 137)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateCurrencyFactor(PROCEDURE 180)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAppliesToDocNoOnLookup(PROCEDURE 163)".


    //Unsupported feature: Property Modification (Attributes) on "OnUpdateSalesLineByChangedFieldName(PROCEDURE 139)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateDimTableIDs(PROCEDURE 138)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterValidateShortcutDimCode(PROCEDURE 176)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateSalesLine(PROCEDURE 147)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSalesQuoteAccepted(PROCEDURE 143)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterChangePricesIncludingVAT(PROCEDURE 187)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSendSalesHeader(PROCEDURE 144)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSetFieldsBilltoCustomer(PROCEDURE 151)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterTransferExtendedTextForSalesLineRecreation(PROCEDURE 145)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromSellToCustTemplate(PROCEDURE 184)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopySellToAddressToShipToAddress(PROCEDURE 198)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopySellToAddressToBillToAddress(PROCEDURE 200)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopySellToCustomerAddressFieldsFromCustomer(PROCEDURE 177)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyShipToCustomerAddressFieldsFromCustomer(PROCEDURE 173)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyShipToCustomerAddressFieldsFromShipToAddr(PROCEDURE 174)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckCreditLimit(PROCEDURE 196)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeGetNoSeriesCode(PROCEDURE 309)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeGetPostingNoSeriesCode(PROCEDURE 212)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInitInsert(PROCEDURE 208)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInitRecord(PROCEDURE 210)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdateCurrencyFactor(PROCEDURE 153)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeRecreateSalesLines(PROCEDURE 197)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeSalesLineByChangedFieldNo(PROCEDURE 168)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeSalesLineInsert(PROCEDURE 169)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeTestNoSeries(PROCEDURE 213)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeSetSecurityFilterOnRespCenter(PROCEDURE 207)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdateSalesLinesByFieldNo(PROCEDURE 303)".


    //Unsupported feature: Property Modification (Attributes) on "OnCopySelltoCustomerAddressFieldsFromCustomerOnAfterAssignRespCenter(PROCEDURE 182)".


    //Unsupported feature: Property Modification (Attributes) on "OnCreateSalesLineOnAfterAssignType(PROCEDURE 185)".


    //Unsupported feature: Property Modification (Attributes) on "OnInitInsertOnBeforeInitRecord(PROCEDURE 179)".


    //Unsupported feature: Property Modification (Attributes) on "OnUpdateBillToCustOnAfterSalesQuote(PROCEDURE 188)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateBilltoCustomerTemplateCodeBeforeRecreateSalesLines(PROCEDURE 171)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateSellToCustomerNoAfterInit(PROCEDURE 206)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterTestQuantityShippedField(PROCEDURE 189)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeTestStatusOpen(PROCEDURE 202)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterTestStatusOpen(PROCEDURE 201)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateBillToCont(PROCEDURE 199)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateSellToCont(PROCEDURE 203)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateSellToCust(PROCEDURE 204)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateSalesLines(PROCEDURE 205)".


    //Unsupported feature: Property Modification (Attributes) on "OnRecreateSalesLinesOnBeforeConfirm(PROCEDURE 211)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidatePricesIncludingVATOnBeforeSalesLineModify(PROCEDURE 214)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateShippingAgentCodeOnBeforeUpdateLines(PROCEDURE 215)".


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
          AccountNumber := RemoteStorageMgt.GetDemandDepositAccountNumber("Protected Account Number");
        //EFT4.00.02 +**/

    end;

    procedure MakeEFTPayment()
    begin
        //EFT4.00.02 -
        //MakeEFTPaymentForAmount(0);
        //EFT4.00.02 +
    end;

    procedure MakeEFTPaymentForAmount(TransactionAmount: Decimal)
    begin
        //EFT4.00.02
        //     IF "EFT Tender Type" <> "EFT Tender Type"::" " THEN BEGIN
        //       TESTFIELD("Account Number");
        //       IF "EFT Tender Type" = "EFT Tender Type"::"Credit Card" THEN BEGIN
        //         TESTFIELD("Expiration Month");
        //         TESTFIELD("Expiration Year");
        //         TESTFIELD("Routing Number", '');
        //       END ELSE IF "EFT Tender Type" = "EFT Tender Type"::Check THEN BEGIN
        //         TESTFIELD("Routing Number");
        //         TESTFIELD("Expiration Month", '');
        //         TESTFIELD("Expiration Year", '');
        //       END ELSE
        //         TESTFIELD("Routing Number", '');
        //       IF EFTTerminal.GetCurrentTerminal(TRUE) THEN BEGIN
        //         StoreDocTypeMethod.GET(EFTTerminal."Store No.",
        //                                "Document Type",
        //                                "EFT Tender Type",
        //                                StoreDocTypeMethod."Transaction Type"::"0");
        //         EFTTran.INIT;
        //     //EFT4.00.01.12 -
        //         EFTTran.VALIDATE("Store No.", EFTTerminal."Store No.");
        //         EFTTran.VALIDATE("Terminal No.", EFTTerminal."No.");
        //     //EFT4.00.01.12 +
        //         EFTTran.VALIDATE("Method Code", StoreDocTypeMethod."Method Code");
        //         EFTTran.VALIDATE("Document Type", "Document Type");
        //         EFTTran.VALIDATE("Document No.", "No.");
        //         IF EFTTran.GetAmountDue > 0 THEN BEGIN
        //           EFTTran.INSERT(TRUE);
        //           IF TransactionAmount > 0 THEN BEGIN
        //             IF TransactionAmount < EFTTran."Transaction Amount" THEN
        //               EFTTran.VALIDATE("Transaction Amount", TransactionAmount);
        //           END;
        //           EFTTran.VALIDATE("Routing Number", "Routing Number");
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
        //           EFTTran.VALIDATE("Expiration Month", "Expiration Month");
        //           EFTTran.VALIDATE("Expiration Year", "Expiration Year");
        //           EFTTran.MODIFY(TRUE);
        //           EFTSubmit.RUN(EFTTran);
        //         END;
        //       END;
        //     END;

    end;

    procedure CheckEFTPermission(): Boolean
    var
        LicensePermission: Record "License Permission";
    begin
        LicensePermission.SetRange("Object Type", LicensePermission."Object Type"::Table);
        //LicensePermission.SetRange("Object Number", DATABASE::Table37028310);
        LicensePermission.SetRange("Execute Permission", LicensePermission."Execute Permission"::Yes);
        exit(not LicensePermission.IsEmpty);
    end;

    procedure UpdateCommissions(pSalesLine: Record "Sales Line")
    var
        SalesLine2: Record "Sales Line";
        Salesperson: Record "Salesperson/Purchaser";
        PaymentMethod2: Record "Payment Method";
        SalesHeader3: Record "Sales Header";
        DocCommChgs: Record "Document Commission Charges";
        GrossProfit: Decimal;
        lLineAmountPrice: Decimal;
        lLineAmountCost: Decimal;
        lTotalBurdenAmount: Decimal;
        TaxAmt: Decimal;
        Paymentmethod: Record "Payment Method";
    begin
        // MER0014 >>
        if not Salesperson.Get("Salesperson Code") then
            Clear(Salesperson);

        SalesLine2.SetRange("Document Type", "Document Type");
        SalesLine2.SetRange("Document No.", "No.");
        SalesLine2.SetFilter("Line No.", '<>%1', pSalesLine."Line No.");
        if SalesLine2.FindSet then
            repeat
                lLineAmountPrice += SalesLine2."Qty. to Invoice" * SalesLine2."Unit Price";
                lLineAmountCost += SalesLine2."Qty. to Invoice" * SalesLine2."Unit Cost";

                if Salesperson."Eligible for Mark Up" then
                    lTotalBurdenAmount += SalesLine2."Burden Amount";
                TaxAmt += SalesLine2."Amount Including VAT" - SalesLine2.Amount;
            until SalesLine2.Next = 0;

        lLineAmountPrice += pSalesLine."Qty. to Invoice" * pSalesLine."Unit Price";
        lLineAmountCost += pSalesLine."Qty. to Invoice" * pSalesLine."Unit Cost";
        if Salesperson."Eligible for Mark Up" then
            lTotalBurdenAmount += pSalesLine."Burden Amount";
        TaxAmt += pSalesLine."Amount Including VAT" - pSalesLine.Amount;

        SalesSetup.Get;

        if not DocCommChgs.Get("Document Type", "No.") then begin
            Clear(DocCommChgs);
            DocCommChgs.Init;
            DocCommChgs."Document Type" := "Document Type";
            DocCommChgs."No." := "No.";
            DocCommChgs.Insert(true);
        end;

        // MER0015 >>
        // MER0017 >>
        //IF "Document Type" IN ["Document Type"::"Credit Memo"] THEN
        if "Document Type" in ["Document Type"::"Credit Memo", "Document Type"::"Return Order"] then
            // MER0017 <<
            DocCommChgs."Credit Card Charges" := 0
        else begin
            // MER0015 >>
            if not PaymentMethod.Get("Payment Method Code") then
                DocCommChgs."Credit Card Charges" := 0
            else begin
                //if PaymentMethod."EFT Tender Type" = PaymentMethod."EFT Tender Type"::"Credit Card" then begin
                //    DocCommChgs."Credit Card Charges" := (lLineAmountPrice + TaxAmt) * SalesSetup."Credit Card Charges Rate" * 0.01;
                // end else
                //    DocCommChgs."Credit Card Charges" := 0;
            end;
            // MER0015 >>
        end;
        // MER0015 <<

        DocCommChgs."Salesperson Order Fee" := CalcSalespersonOrderFee;

        // MER0017 >>
        //IF "Document Type" IN ["Document Type"::"Credit Memo"] THEN
        if "Document Type" in ["Document Type"::"Credit Memo", "Document Type"::"Return Order"] then
            // MER0017 <<
            GrossProfit := lLineAmountPrice - lLineAmountCost - lTotalBurdenAmount
        else
            GrossProfit := lLineAmountPrice - lLineAmountCost - lTotalBurdenAmount - DocCommChgs."Credit Card Charges" - DocCommChgs."Salesperson Order Fee";

        // MER0017 >>
        if "Document Type" in ["Document Type"::"Credit Memo"] then //original kept
                                                                    //IF "Document Type" IN ["Document Type"::"Credit Memo","Document Type"::"Return Order"] THEN
                                                                    // MER0017 <<
            DocCommChgs."Salesperson Commission Amount" := GrossProfit * Salesperson."Commission %" * 0.01
        else
            DocCommChgs."Salesperson Commission Amount" := GrossProfit * Salesperson."Commission %" * 0.01 - DocCommChgs."Salesperson Misc. Charge";

        DocCommChgs.Modify;
        // MER0014 >>
    end;

    procedure ExtractFreightExpenses()
    var
        tempSalesLine: Record "Sales Line" temporary;
        SalesLine2: Record "Sales Line";
        PurchLine: Record "Purchase Line";
        LastLineNo: Integer;
        UnitCost: Decimal;
    begin
        // MER0004 >>
        SalesSetup.Get;

        SalesLine2.Reset;
        SalesLine2.SetRange("Document Type", "Document Type");
        SalesLine2.SetRange("Document No.", "No.");
        SalesLine2.SetRange(Type, SalesLine2.Type::Item);
        SalesLine2.SetFilter("Purchase Order No.", '<>%1', '');
        if SalesLine2.FindSet then
            repeat
                tempSalesLine.Reset;
                tempSalesLine.SetRange("Purchase Order No.", SalesLine2."Purchase Order No.");
                if not tempSalesLine.Find('-') then begin
                    tempSalesLine := SalesLine2;
                    tempSalesLine.Insert;
                end;
            until SalesLine2.Next = 0;

        tempSalesLine.Reset;

        if tempSalesLine.FindSet then
            repeat
                Clear(UnitCost);

                PurchLine.Reset;
                PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
                PurchLine.SetRange("Document No.", tempSalesLine."Purchase Order No.");
                PurchLine.SetRange(Type, PurchLine.Type::"G/L Account");
                PurchLine.SetRange("No.", SalesSetup."G/L Freight Expense Account");
                if PurchLine.FindSet then
                    repeat
                        UnitCost += PurchLine."Unit Cost (LCY)";
                    until PurchLine.Next = 0;

                // MER0010 >>
                if UnitCost > 0 then begin
                    // MER0010 <<
                    SalesLine2.Reset;
                    SalesLine2.SetRange("Document Type", "Document Type");
                    SalesLine2.SetRange("Document No.", "No.");
                    SalesLine2.SetRange(Type, SalesLine2.Type::"G/L Account");
                    SalesLine2.SetRange("No.", SalesSetup."G/L Freight Revenue Account");
                    SalesLine2.SetRange("Vendor No.", PurchLine."Buy-from Vendor No.");

                    if not SalesLine2.Find('-') then begin
                        SalesLine2.Reset;
                        SalesLine2.SetRange("Document Type", "Document Type");
                        SalesLine2.SetRange("Document No.", "No.");
                        SalesLine2.Find('+');
                        LastLineNo := SalesLine2."Line No.";

                        Clear(SalesLine2);
                        SalesLine2.Init;
                        SalesLine2."Document Type" := "Document Type";
                        SalesLine2."Document No." := "No.";
                        SalesLine2."Line No." := LastLineNo + 10000;
                        SalesLine2.Insert(true);

                        SalesLine2.Validate(Type, SalesLine2.Type::"G/L Account");
                        SalesLine2.Validate("No.", SalesSetup."G/L Freight Revenue Account");
                        SalesLine2.Validate(Quantity, 1);
                        SalesLine2."Vendor No." := PurchLine."Buy-from Vendor No.";
                        SalesLine2.Modify;
                    end;

                    SalesLine2.Validate("Unit Cost (LCY)", UnitCost);
                    SalesLine2.Modify;
                    // MER0010 >>
                end;
            // MER0010 <<
            until tempSalesLine.Next = 0;
        // MER0004 <<
    end;

    procedure CalcSalespersonOrderFee(): Decimal
    var
        SalesLine2: Record "Sales Line";
        LastPurchOrderNo: Code[20];
        PurchOrderCount: Integer;
        LastVendorNo: Code[20];
        VendorCount: Integer;
        tempVendor: Record Vendor temporary;
    begin
        // MER0015 >>
        // MER0017 >>
        //IF "Document Type" IN ["Document Type"::"Credit Memo"] THEN
        if "Document Type" in ["Document Type"::"Credit Memo", "Document Type"::"Return Order"] then
            // MER0017 <<
            exit(0);
        // MER0015 <<

        // MER0005 >>
        SalesSetup.Get;
        SalesLine2.Reset;
        SalesLine2.SetCurrentKey("Document Type", "Document No.", "Purchase Order No.");
        SalesLine2.SetRange("Document Type", "Document Type");
        SalesLine2.SetRange("Document No.", "No.");
        // MER0007 >>
        //SalesLine.SETFILTER("Vendor No.",'<>%1','');
        SalesLine2.SetFilter("Vendor No.", '<>%1', '');
        // MER0007 <<
        if SalesLine2.FindSet then
            repeat
                // MER0009 >>
                //IF LastVendorNo <> SalesLine2."Vendor No." THEN
                //  VendorCount += 1;
                //LastVendorNo := SalesLine2."Vendor No.";
                if not tempVendor.Get(SalesLine2."Vendor No.") then begin
                    tempVendor."No." := SalesLine2."Vendor No.";
                    tempVendor.Insert;
                end;
            // MER0009 <<
            until SalesLine2.Next = 0;

        // MER0009 >>
        //IF VendorCount > 0 THEN
        //  EXIT(SalesSetup."Salesperson Order Fee Base" + SalesSetup."Slsperson Order Fee Additional" * (VendorCount - 1))
        if tempVendor.Count > 0 then
            exit(SalesSetup."Salesperson Order Fee Base" + SalesSetup."Slsperson Order Fee Additional" * (tempVendor.Count - 1))
        // MER0009 <<
        else
            exit(0);
        // MER0005 <<
    end;

    var
        CommentLine: Record "Comment Line";
        myMessage: Text[1024];
    // Salesperson: Record "Salesperson/Purchaser";

    var
        Customer: Record Customer;
        Salesperson: Record "Salesperson/Purchaser";

    var
        tempSalesLine: Record "Sales Line" temporary;


    //Unsupported feature: Property Modification (TextConstString) on "Text024(Variable 1024)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text024 : ENU=You have modified the %1 field. The recalculation of tax may cause penny differences, so you must check the amounts afterward. Do you want to update the %2 field on the lines to reflect the new value of %1?;ESM=Ha modificado el campo %1. El nuevo cálculo de IVA puede tener alguna diferencia, por lo que debería comprobar los importes. ¿Desea actualizar el campo %2 en la líneas para reflejar el nuevo valor de %1?;FRC=Vous avez modifié le champ %1. Le nouveau calcul de la TVA va engendrer de petites différences. Veuillez vérifier les montants. Souhaitez-vous mettre à jour le champ %2 sur les lignes pour refléter la nouvelle valeur de %1 ?;ENC=You have modified the %1 field. The recalculation of tax may cause penny differences, so you must check the amounts afterwards. Do you want to update the %2 field on the lines to reflect the new value of %1?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text024 : ENU=You have modified the %1 field. The recalculation of VAT may cause penny differences, so you must check the amounts afterward. Do you want to update the %2 field on the lines to reflect the new value of %1?;ESM=Ha modificado el campo %1. El nuevo cálculo de IVA puede tener alguna diferencia, por lo que debería comprobar los importes. ¿Desea actualizar el campo %2 en la líneas para reflejar el nuevo valor de %1?;FRC=Vous avez modifié le champ %1. Le nouveau calcul de la TVA va engendrer de petites différences. Veuillez vérifier les montants. Souhaitez-vous mettre à jour le champ %2 sur les lignes pour refléter la nouvelle valeur de %1 ?;ENC=You have modified the %1 field. The recalculation of tax may cause penny differences, so you must check the amounts afterwards. Do you want to update the %2 field on the lines to reflect the new value of %1?;
    //Variable type has not been exported.

    var
        EFTText001: Label 'must be 0';
        EFTText002: Label 'must be blank because unsubmitted EFT Transactions exist';
        EFTText003: Label 'You cannot reset %1 because the document has one or more EFT Transactions.';
        EFTText008: Label 'Invalid Account Number.';
        EFTText009: Label 'Expired Card.';
        EFTText010: Label 'is not valid';
        EFTText011: Label '%1 may not be manually entered when Tokenization is in use. You must use the lookup button to select an Account.';
        EFTText012: Label '%1 may not be used when the Data Protection Type is No Storage in EFT Setup.';
}

