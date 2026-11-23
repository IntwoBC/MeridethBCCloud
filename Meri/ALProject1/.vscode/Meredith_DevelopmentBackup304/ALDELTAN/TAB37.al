tableextension 50008 tableextension70000312 extends "Sales Line"
{
    // <changelog>
    //   <add id="NA0001" dev="ELYNCH" date="2006-02-10" area="NASALESTAX" feature="617"
    //     releaseversion="NAVUS3.70.01">Added functions and code for NA Sales Tax</add>
    //   <change id="NA0002" dev="ELYNCH" date="2006-02-21" area="ORDERENTRY" feature="607"
    //     releaseversion="NAVUS3.70.01">Added field and code for Package Tracking</change>
    //   <change id="NA0003" dev="ELYNCH" date="2006-02-21" area="ORDERENTRY" feature="607"
    //     baseversion="NAVUS3.70.01" releaseversion="NAVUS3.70.01.45">changed Autoreserve function</change>
    //   <change id="NA0005" dev="JNOZZI" date="2007-12-06" area="NASALESTAX" feature="31197"
    //     baseversion="NAVUS3.70.01.45" releaseversion="NAVNA5.00.01">Test to make sure that Tax Area on the line has
    //     the same &quot;Use External Tax Engine&quot; status as the Tax Area on the header. Modify CalcSalesTaxLines to call
    //     external engine as necessary.</change>
    //   <add id="NA0006" dev="ALL-E" date="2010-08-03" area="PREPAYMENT" feature="VSTF174678"
    //     releaseversion="NA7.00">Prepayment amount is not adjusted properly when Sales Order is posted partially</add>
    //   <change id="NA0007" dev="ALL-E" date="2010-08-03" area="PREPAYMENT" feature="VSTF113614"
    //     baseversion="NA7.00" releaseversion="NA7.00">Currency Code blank does not exist</change>
    //   <change id="NA0008" dev="v-jefwu" date="2011-03-08" area="PREPAYMENT" feature="VSTF251991"
    //     baseversion="NA7.00" releaseversion="NA7.00">Prepayment Credit Memo Posting results in an error</change>
    //   <change id="NA0009" dev="v-fawan" date="2011-06-24" area="NASALESTAX" feature="VSTF267848"
    //     baseversion="NA7.00" releaseversion="NA7.00">
    //     You can get an error saying "You must reopen the document since this will affect Sales Tax"
    //     when creating a Sales Line in NA even though the order is open</change>
    // </changelog>
    // 
    // MER0001 TLE 12/06/13 Add "Line Amount Cost","Burden Amount","Vendor No."
    // MER0002 TLE 01/07/14 Call UpdateCommissions
    // MER0003 TLE 01/13/14 GetUnitCost - Find Vendor with best Unit Cost.
    // MER0004 TLE 01/31/14 Add "Vendor Cross Reference No."
    // MER0005 TLE 02/09/14 Default to Drop Ship.
    // MER0006 TLE 03/11/14 Add key Document Type,Document No.,Purchase Order No.
    // MER0007 CH  04/01/14 Add LineAmountPrice and LineAmountCost fields
    // MER0008 TLE 04/03/14 Restructure UpdateCommissions
    // MER0009 TLE 04/18/14 Call UpdateCommissions on Vendor No. - OnValidate.
    // MER0010 TLE 04/22/14 Set LineAmountCost Editable = No.. Clear("Burden Amount")
    // MER0011 MT  02/24/16 GUIALLOWED
    fields
    {
        modify("Unit Cost (LCY)")
        {
            Caption = 'Unit Cost (LCY)';
            trigger OnAfterValidate()
            begin
                // BC14 Table 37 field 23 MER0008
                MERUpdateCommissions();
            end;
        }
        modify("Qty. to Invoice")
        {
            trigger OnAfterValidate()
            begin
                // BC14 Table 37 field 17 MER0008
                MERUpdateCommissions();
            end;
        }
        modify("Unit Price")
        {
            trigger OnAfterValidate()
            begin
                // BC14 Table 37 field 22 MER0008
                MERUpdateCommissions();
            end;
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
        modify("Outstanding Amount (LCY)")
        {
            Caption = 'Outstanding Amount (LCY)';
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
        modify("Prepmt. Amt. Incl. VAT")
        {
            Caption = 'Prepmt. Amt. Incl. VAT';
        }
        modify("Prepmt. VAT Base Amt.")
        {
            Caption = 'Prepmt. VAT Base Amt.';
        }
        modify("Prepayment VAT %")
        {
            Caption = 'Prepayment VAT %';
        }
        modify("Prepmt. VAT Calc. Type")
        {
            Caption = 'Prepmt. VAT Calc. Type';
        }
        modify("Prepayment VAT Identifier")
        {
            Caption = 'Prepayment VAT Identifier';
        }
        modify("Prepmt. Amount Inv. Incl. VAT")
        {
            Caption = 'Prepmt. Amount Inv. Incl. VAT';
        }
        modify("Prepmt. Amount Inv. (LCY)")
        {
            Caption = 'Prepmt. Amount Inv. (LCY)';
        }
        modify("Prepayment VAT Difference")
        {
            Caption = 'Prepayment VAT Difference';
        }
        modify("Prepmt VAT Diff. to Deduct")
        {
            Caption = 'Prepmt VAT Diff. to Deduct';
        }
        modify("Prepmt VAT Diff. Deducted")
        {
            Caption = 'Prepmt VAT Diff. Deducted';
        }
        modify("Return Rcd. Not Invd. (LCY)")
        {
            Caption = 'Return Rcd. Not Invd. (LCY)';
        }


        //Unsupported feature: Code Modification on ""No."(Field 6).OnValidate".

        //trigger "(Field 6)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetSalesSetup;
        if SalesSetup."Create Item from Item No." then
          "No." := FindRecordMgt.FindNoFromTypedValue(Type,"No.",not "System-Created Entry");

        TestJobPlanningLine;
        TestStatusOpen;
        CheckItemAvailable(FieldNo("No."));

        if (xRec."No." <> "No.") and (Quantity <> 0) then begin
          TestField("Qty. to Asm. to Order (Base)",0);
        #11..14
          OnValidateNoOnAfterVerifyChange(Rec,xRec);
        end;

        TestField("Qty. Shipped Not Invoiced",0);
        TestField("Quantity Shipped",0);
        TestField("Shipment No.",'');

        TestField("Prepmt. Amt. Inv.",0);

        TestField("Return Qty. Rcd. Not Invd.",0);
        TestField("Return Qty. Received",0);
        #26..116

        UpdateItemCrossRef;

        PostingSetupMgt.CheckGenPostingSetupSalesAccount("Gen. Bus. Posting Group","Gen. Prod. Posting Group");
        PostingSetupMgt.CheckGenPostingSetupCOGSAccount("Gen. Bus. Posting Group","Gen. Prod. Posting Group");
        PostingSetupMgt.CheckVATPostingSetupSalesAccount("VAT Bus. Posting Group","VAT Prod. Posting Group");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*


        //The code has been merged but contained errors that could prevent import
        //and the code has been put in comments. Use Shift+Ctrl+O to Uncomment
        //"No." := FindRecordMgt.FindNoFromTypedValue(Type,"No.",NOT "System-Created Entry");
        //
        //TestJobPlanningLine;
        //TestStatusOpen;
        //CheckItemAvailable(FIELDNO("No."));
        //
        //IF (xRec."No." <> "No.") AND (Quantity <> 0) THEN BEGIN
        //  TESTFIELD("Qty. to Asm. to Order (Base)",0);
        //  CALCFIELDS("Reserved Qty. (Base)");
        //  TESTFIELD("Reserved Qty. (Base)",0);
        //  IF Type = Type::Item THEN
        //    WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
        //END;
        //
        //TESTFIELD("Qty. Shipped Not Invoiced",0);
        //TESTFIELD("Quantity Shipped",0);
        //TESTFIELD("Shipment No.",'');
        //
        //TESTFIELD("Prepmt. Amt. Inv.",0);
        //
        //TESTFIELD("Return Qty. Rcd. Not Invd.",0);
        //TESTFIELD("Return Qty. Received",0);
        //TESTFIELD("Return Receipt No.",'');
        //
        //IF "No." = '' THEN
        //  ATOLink.DeleteAsmFromSalesLine(Rec);
        //CheckAssocPurchOrder(FIELDCAPTION("No."));
        //AddOnIntegrMgt.CheckReceiptOrderStatus(Rec);
        //
        //TempSalesLine := Rec;
        //INIT;
        //IF xRec."Line Amount" <> 0 THEN
        //  "Recalculate Invoice Disc." := TRUE;
        //Type := TempSalesLine.Type;
        //"No." := TempSalesLine."No.";
        //OnValidateNoOnCopyFromTempSalesLine(Rec,TempSalesLine);
        //IF "No." = '' THEN
        //  EXIT;
        //
        //IF HasTypeToFillMandatoryFields THEN
        //  Quantity := TempSalesLine.Quantity;
        //
        //"System-Created Entry" := TempSalesLine."System-Created Entry";
        //GetSalesHeader;
        //InitHeaderDefaults(SalesHeader);
        //CALCFIELDS("Substitution Available");
        //
        //"Promised Delivery Date" := SalesHeader."Promised Delivery Date";
        //"Requested Delivery Date" := SalesHeader."Requested Delivery Date";
        //"Shipment Date" :=
        //  CalendarMgmt.CalcDateBOC(
        //    '',SalesHeader."Shipment Date",CalChange."Source Type"::Location,"Location Code",'',
        //    CalChange."Source Type"::"Shipping Agent","Shipping Agent Code","Shipping Agent Service Code",FALSE);
        //UpdateDates;
        //
        //OnAfterAssignHeaderValues(Rec,SalesHeader);
        //
        //CASE Type OF
        //  Type::" ":

        #1..4

        //    CopyFromStandardText;



        #8..17


        //    CopyFromItem;


        //{=======} MODIFIED
        //  Type::Resource:
        //    CopyFromResource;
        //  Type::"Fixed Asset":
        //    CopyFromFixedAsset;
        //  Type::"Charge (Item)":
        //    CopyFromItemCharge;
        //END;
        //
        //OnAfterAssignFieldsForNo(Rec,xRec,SalesHeader);
        //
        //IF HasTypeToFillMandatoryFields AND (Type <> Type::"Fixed Asset") THEN
        //  VALIDATE("VAT Prod. Posting Group");
        //
        //UpdatePrepmtSetupFields;
        //
        //IF HasTypeToFillMandatoryFields THEN BEGIN
        //  VALIDATE("Unit of Measure Code");
        //  IF Quantity <> 0 THEN BEGIN
        //    InitOutstanding;
        //    IF "Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"] THEN
        //      InitQtyToReceive
        //    ELSE
        //      InitQtyToShip;
        //    InitQtyToAsm;
        //    UpdateWithWarehouseShip;
        //  END;
        //  UpdateUnitPrice(FIELDNO("No."));
        //END;
        //
        //IF NOT ISTEMPORARY THEN
        //  CreateDim(
        //    DimMgt.TypeToTableID3(Type),"No.",
        //    DATABASE::Job,"Job No.",
        //    DATABASE::"Responsibility Center","Responsibility Center");
        //
        //IF "No." <> xRec."No." THEN BEGIN
        //  IF Type = Type::Item THEN
        //    IF (Quantity <> 0) AND ItemExists(xRec."No.") THEN BEGIN
        //      ReserveSalesLine.VerifyChange(Rec,xRec);
        //      WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
        //    END;
        //  GetDefaultBin;
        //  AutoAsmToOrder;
        //  DeleteItemChargeAssgnt("Document Type","Document No.","Line No.");
        //  IF Type = Type::"Charge (Item)" THEN
        //    DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");
        //END;
        //
        //UpdateItemCrossRef;
        //
        #23..119

        //PostingSetupMgt.CheckGenPostingSetupSalesAccount("Gen. Bus. Posting Group","Gen. Prod. Posting Group");
        //PostingSetupMgt.CheckGenPostingSetupCOGSAccount("Gen. Bus. Posting Group","Gen. Prod. Posting Group");
        //PostingSetupMgt.CheckVATPostingSetupSalesAccount("VAT Bus. Posting Group","VAT Prod. Posting Group");
        */
        //end;


        //Unsupported feature: Code Modification on ""Shipment Date"(Field 10).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
        if CurrFieldNo <> 0 then
          AddOnIntegrMgt.CheckReceiptOrderStatus(Rec);

        if "Shipment Date" <> 0D then begin
          if CurrFieldNo in [
                             FieldNo("Planned Shipment Date"),
                             FieldNo("Planned Delivery Date"),
                             FieldNo("Shipment Date"),
                             FieldNo("Shipping Time"),
                             FieldNo("Outbound Whse. Handling Time"),
                             FieldNo("Requested Delivery Date")]
          then
            CheckItemAvailable(FieldNo("Shipment Date"));

          if ("Shipment Date" < WorkDate) and HasTypeToFillMandatoryFields then
            if not (GetHideValidationDialog or HasBeenShown) and GuiAllowed then begin
              Message(
                Text014,
                FieldCaption("Shipment Date"),"Shipment Date",WorkDate);
              HasBeenShown := true;
            end;
        end;

        AutoAsmToOrder;
        if (xRec."Shipment Date" <> "Shipment Date") and
           (Quantity <> 0) and
           not StatusCheckSuspended
        then
          CheckDateConflict.SalesLineCheck(Rec,CurrFieldNo <> 0);

        if not PlannedShipmentDateCalculated then
          "Planned Shipment Date" := CalcPlannedShptDate(FieldNo("Shipment Date"));
        if not PlannedDeliveryDateCalculated then
          "Planned Delivery Date" := CalcPlannedDeliveryDate(FieldNo("Shipment Date"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //The code has been merged but contained errors that could prevent import
        //and the code has been put in comments. Use Shift+Ctrl+O to Uncomment
        //TestStatusOpen;
        //WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
        //IF CurrFieldNo <> 0 THEN
        //  AddOnIntegrMgt.CheckReceiptOrderStatus(Rec);
        //
        //IF "Shipment Date" <> 0D THEN BEGIN
        //  IF CurrFieldNo IN [
        //                     FIELDNO("Planned Shipment Date"),
        //                     FIELDNO("Planned Delivery Date"),
        //                     FIELDNO("Shipment Date"),
        //                     FIELDNO("Shipping Time"),
        //                     FIELDNO("Outbound Whse. Handling Time"),
        //                     FIELDNO("Requested Delivery Date")]
        //  THEN
        //    CheckItemAvailable(FIELDNO("Shipment Date"));
        //

        //  IF ("Shipment Date" < WORKDATE) AND HasTypeToFillMandatoryFields THEN
        //    IF NOT (GetHideValidationDialog OR HasBeenShown) AND GUIALLOWED THEN BEGIN

        //      MESSAGE(
        //        Text014,
        //        FIELDCAPTION("Shipment Date"),"Shipment Date",WORKDATE);
        //      HasBeenShown := TRUE;
        //    END;
        //END;
        //
        //AutoAsmToOrder;
        //IF (xRec."Shipment Date" <> "Shipment Date") AND
        //   (Quantity <> 0) AND
        //   NOT StatusCheckSuspended
        //THEN
        //  CheckDateConflict.SalesLineCheck(Rec,CurrFieldNo <> 0);
        //
        //IF NOT PlannedShipmentDateCalculated THEN
        //  "Planned Shipment Date" := CalcPlannedShptDate(FIELDNO("Shipment Date"));
        //IF NOT PlannedDeliveryDateCalculated THEN
        //  "Planned Delivery Date" := CalcPlannedDeliveryDate(FIELDNO("Shipment Date"));
        */
        //end;


        //Unsupported feature: Code Modification on ""Qty. to Invoice"(Field 17).OnValidate".

        //trigger  to Invoice"(Field 17)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Qty. to Invoice" = MaxQtyToInvoice then
          InitQtyToInvoice
        else
        #4..16
        "VAT Difference" := 0;
        CalcInvDiscToInvoice;
        CalcPrepaymentToDeduct;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..19

        // MER0008 >>
        //// MER0002 >>
        //CLEAR(LineAmountPrice);
        //CLEAR(LineAmountCost);
        //CLEAR(GrossProfit);
        //CLEAR(NetProfit);
        //CLEAR(TaxAmt);
        //SalesHeader.UpdateCommissions(Rec, LineAmountPrice, LineAmountCost, GrossProfit, NetProfit,TaxAmt,FALSE);
        SalesHeader.UpdateCommissions(Rec);
        //// MER0002 <<
        // MER0008 <<
        */
        //end;


        //Unsupported feature: Code Modification on ""Unit Price"(Field 22).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if ("Prepmt. Amt. Inv." <> 0) and
           ("Unit Price" <> xRec."Unit Price") and not IsServiceCharge
        then
          FieldError("Unit Price",StrSubstNo(Text1020001,xRec."Unit Price"));
        Validate("Line Discount %");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*

        // TestJobPlanningLine;
        // TestStatusOpen;
        // NA0008.begin

        #1..3

          FieldError("Unit Price",StrSubstNo(Text1020001,xRec."Unit Price"));

        Validate("Line Discount %");

        // MER0008 >>
        //// MER0002 >>
        //CLEAR(LineAmountPrice);
        //CLEAR(LineAmountCost);
        //CLEAR(GrossProfit);
        //CLEAR(NetProfit);
        //CLEAR(TaxAmt);
        //SalesHeader.UpdateCommissions(Rec, LineAmountPrice, LineAmountCost, GrossProfit, NetProfit,TaxAmt,FALSE);
        SalesHeader.UpdateCommissions(Rec);
        //// MER0002 <<
        // MER0008 <<
        */
        //end;


        //Unsupported feature: Code Modification on ""Unit Cost (LCY)"(Field 23).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if (CurrFieldNo = FieldNo("Unit Cost (LCY)")) and
           ("Unit Cost (LCY)" <> xRec."Unit Cost (LCY)")
        then
        #4..31
              Currency."Unit-Amount Rounding Precision")
        end else
          "Unit Cost" := "Unit Cost (LCY)";
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..34

        // MER0008 >>
        //// MER0002 >>
        //CLEAR(LineAmountPrice);
        //CLEAR(LineAmountCost);
        //CLEAR(GrossProfit);
        //CLEAR(NetProfit);
        //CLEAR(TaxAmt);
        //SalesHeader.UpdateCommissions(Rec, LineAmountPrice, LineAmountCost, GrossProfit, NetProfit,TaxAmt,FALSE);
        SalesHeader.UpdateCommissions(Rec);
        //// MER0002 <<
        // MER0008 <<
        */
        //end;


        //Unsupported feature: Code Modification on ""Appl.-to Item Entry"(Field 38).OnValidate".

        //trigger -to Item Entry"(Field 38)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Appl.-to Item Entry" <> 0 then begin
          AddOnIntegrMgt.CheckReceiptOrderStatus(Rec);

        #4..20

          "Location Code" := ItemLedgEntry."Location Code";
          if not ItemLedgEntry.Open then
            Message(Text042,"Appl.-to Item Entry");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..23
            //MER0011>>
            if GuiAllowed then
            //MER0011<<
            Message(Text042,"Appl.-to Item Entry");
        end;
        */
        //end;


        //Unsupported feature: Code Modification on ""Shortcut Dimension 1 Code"(Field 40).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
        ATOLink.UpdateAsmDimFromSalesLine(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
        */
        //end;


        //Unsupported feature: Code Modification on ""Shortcut Dimension 2 Code"(Field 41).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
        ATOLink.UpdateAsmDimFromSalesLine(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
        */
        //end;


        //Unsupported feature: Code Modification on ""Tax Area Code"(Field 85).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetSalesHeader;
        SalesHeader.TestField(Status,SalesHeader.Status::Open);
        if "Tax Area Code" <> '' then begin
        #4..18
              TableCaption,
              SalesHeader.TableCaption);
        end;
        UpdateAmounts;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // NA0005.begin
        #1..21
        // NA0005.end
        UpdateAmounts;
        */
        //end;


        //Unsupported feature: Code Modification on ""VAT Prod. Posting Group"(Field 90).OnValidate".

        //trigger  Posting Group"(Field 90)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        VATPostingSetup.Get("VAT Bus. Posting Group","VAT Prod. Posting Group");
        "VAT Difference" := 0;

        GetSalesHeader;
        "VAT %" := VATPostingSetup."VAT %";
        "VAT Calculation Type" := VATPostingSetup."VAT Calculation Type";
        "VAT Identifier" := VATPostingSetup."VAT Identifier";
        "VAT Clause Code" := VATPostingSetup."VAT Clause Code";
        case "VAT Calculation Type" of
          "VAT Calculation Type"::"Reverse Charge VAT",
          "VAT Calculation Type"::"Sales Tax":
        #13..22
              "Unit Price" * (100 + "VAT %") / (100 + xRec."VAT %"),
              Currency."Unit-Amount Rounding Precision");
        UpdateAmounts;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..8
        #10..25
        */
        //end;


        //Unsupported feature: Code Modification on ""Prepayment %"(Field 109).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        UpdatePrepmtSetupFields;

        if HasTypeToFillMandatoryFields then
          UpdateAmounts;
        UpdateBaseAmounts(Amount,"Amount Including VAT","VAT Base Amount");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3

        if HasTypeToFillMandatoryFields then

          UpdateAmounts;
        UpdateBaseAmounts(Amount,"Amount Including VAT","VAT Base Amount");
        */
        //end;


        //Unsupported feature: Code Modification on ""Unit of Measure Code"(Field 5407).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestJobPlanningLine;
        TestStatusOpen;
        GLSetup.Get;
        #4..36
              GetItem(Item);
              GetUnitCost;
              UpdateUnitPrice(FieldNo("Unit of Measure Code"));
              CheckItemAvailable(FieldNo("Unit of Measure Code"));
              "Gross Weight" := Item."Gross Weight" * "Qty. per Unit of Measure";
              "Net Weight" := Item."Net Weight" * "Qty. per Unit of Measure";
              "Unit Volume" := Item."Unit Volume" * "Qty. per Unit of Measure";
        #44..64
            "Qty. per Unit of Measure" := 1;
        end;
        Validate(Quantity);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..39
        #41..67
        if Type = Type::Item then
          CheckItemAvailable(FieldNo("Unit of Measure Code"));
        */
        //end;
        field(50001; "Burden Amount"; Decimal)
        {
            Description = 'MER0001';
            DataClassification = ToBeClassified;
        }
        field(50002; "Vendor No."; Code[10])
        {
            Description = 'MER0001';
            DataClassification = ToBeClassified;

            trigger OnLookup()
            var
                PurchPrice2: Record "Purchase Price";
                myPurchPriceList: Page "MER Purchase Price List";
                SalesHeader3: Record "Sales Header";
            begin
                // = BC14 Table 37 field 50002 OnLookup (MER0001/MER0009)
                // BC25: uses table 7012 "Purchase Price" (where the BC14 prices and "Marked up Cost" are), as BC14 did
                SalesHeader3.Get(Rec."Document Type", Rec."Document No.");

                PurchPrice2.Reset();
                PurchPrice2.SetRange("Item No.", Rec."No.");
                PurchPrice2.SetFilter("Ending Date", '%1|>=%2', 0D, SalesHeader3."Posting Date");
                PurchPrice2.SetRange("Starting Date", 0D, SalesHeader3."Posting Date");
                PurchPrice2.SetFilter("Currency Code", '%1|%2', Rec."Currency Code", '');
                PurchPrice2.SetFilter("Unit of Measure Code", '%1|%2', Rec."Unit of Measure Code", '');
                if PurchPrice2.IsEmpty() then
                    exit;

                myPurchPriceList.SetTableView(PurchPrice2);
                myPurchPriceList.LookupMode(true);
                if myPurchPriceList.RunModal() = Action::LookupOK then begin
                    myPurchPriceList.GetRecord(PurchPrice2);
                    Rec.Validate("Vendor No.", PurchPrice2."Vendor No.");
                    Rec.Validate("Unit Cost (LCY)", PurchPrice2."Direct Unit Cost");
                    Rec."Variant Code" := PurchPrice2."Variant Code";
                    Rec."Vendor Cross Reference No." := MERFindVendorReference(PurchPrice2."Variant Code", true);
                end;

                // MER0009 >>
                Rec.UpdateAmounts();
                MERUpdateCommissions();
                // MER0009 <<
            end;

            trigger OnValidate()
            var
                PurchPrice2: Record "Purchase Price";
                SalesHeader: Record "Sales Header";
            begin
                // = BC14 Table 37 field 50002 OnValidate (MER0001/MER0009)
                Rec.TestField(Type, Rec.Type::Item);
                Rec.GetItem(Item);
                // BC25 fix: GetSalesHeader() fills the base table's own variable, so read the header here
                SalesHeader.Get(Rec."Document Type", Rec."Document No.");

                PurchPrice2.Reset();
                PurchPrice2.SetRange("Item No.", Rec."No.");
                PurchPrice2.SetRange("Vendor No.", Rec."Vendor No.");
                PurchPrice2.SetFilter("Ending Date", '%1|>=%2', 0D, SalesHeader."Posting Date");
                PurchPrice2.SetFilter("Variant Code", '%1|%2', Rec."Variant Code", '');
                PurchPrice2.SetRange("Starting Date", 0D, SalesHeader."Posting Date");
                PurchPrice2.SetFilter("Currency Code", '%1|%2', Rec."Currency Code", '');
                PurchPrice2.SetFilter("Unit of Measure Code", '%1|%2', Rec."Unit of Measure Code", '');
                if PurchPrice2.FindFirst() then
                    Rec.Validate("Unit Cost (LCY)", PurchPrice2."Direct Unit Cost")
                else
                    Rec.Validate("Unit Cost (LCY)", Item."Unit Cost");

                Rec."Vendor Cross Reference No." := MERFindVendorReference('', false);

                // MER0009 >>
                Rec.UpdateAmounts();
                MERUpdateCommissions();
                // MER0009 <<
            end;
        }
        field(50003; "Vendor Cross Reference No."; Code[20])
        {
            Description = 'MER0004';
            DataClassification = ToBeClassified;
        }
        field(50004; "Line Amount Price"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Importe';
            Description = 'MER0007';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(50005; "Line Amount Cost"; Decimal)
        {
            Description = 'MER0007';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        // field(37028300; "EFT Store No."; Code[10])
        // {
        //     DataClassification = ToBeClassified;
        // }
        // field(37028301; "EFT Terminal No."; Code[10])
        // {
        //     DataClassification = ToBeClassified;
        // }
        // field(37028302; "EFT Entry No."; Integer)
        // {
        //     DataClassification = ToBeClassified;
        // }
    }
    // keys
    // {

    //     //Unsupported feature: Property Modification (SumIndexFields) on ""Document Type",Type,"No.","Variant Code","Drop Shipment","Location Code","Shipment Date"(Key)".


    //     //Unsupported feature: Property Modification (SumIndexFields) on ""Document Type",Type,"No.","Variant Code","Drop Shipment","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code","Location Code","Shipment Date"(Key)".

    //     key(Key1; "Document Type", "Document No.", "Purchase Order No.")
    //     {
    //     }
    // }

    //Unsupported feature: Property Modification (Attributes) on "InitOutstanding(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "InitOutstandingAmount(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "InitQtyToShip(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "InitQtyToReceive(PROCEDURE 5803)".


    //Unsupported feature: Property Modification (Attributes) on "InitQtyToInvoice(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "MaxQtyToInvoice(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "MaxQtyToInvoiceBase(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "CalcLineAmount(PROCEDURE 163)".


    //Unsupported feature: Property Modification (Attributes) on "SetSalesHeader(PROCEDURE 24)".


    //Unsupported feature: Property Modification (Attributes) on "GetSalesHeader(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateUnitPrice(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "FindResUnitCost(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePrepmtSetupFields(PROCEDURE 102)".


    //Unsupported feature: Variable Insertion (Variable: PurchPrice2) (VariableCollection) on "UpdateAmounts(PROCEDURE 3)".


    //Unsupported feature: Variable Insertion (Variable: Salesperson) (VariableCollection) on "UpdateAmounts(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateAmounts(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "UpdateAmounts(PROCEDURE 3)".

    //procedure UpdateAmounts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if Type = Type::" " then
      exit;
    GetSalesHeader;
    #4..9
    end;
    if "Line Amount" <> Round(Quantity * "Unit Price",Currency."Amount Rounding Precision") - "Line Discount Amount" then begin
      "Line Amount" := Round(Quantity * "Unit Price",Currency."Amount Rounding Precision") - "Line Discount Amount";
      "VAT Difference" := 0;
      LineAmountChanged := true;
    end;
    if (CurrFieldNo <> 0) and (SalesHeader.Status = SalesHeader.Status::Released) then
      Error(Text1020000);
    if (("Tax Group Code" = '') and (xRec."Tax Group Code" <> ''))
    #19..21
      "Amount Including VAT" := 0;
    end;

    if not "Prepayment Line" then
      UpdatePrepmtAmounts;

    OnAfterUpdateAmounts(Rec,xRec,CurrFieldNo);

    UpdateVATAmounts;
    #31..33
    if Type = Type::"Charge (Item)" then
      UpdateItemChargeAssgnt;

    if Quantity < xRec.Quantity then begin
      SalesCrMemoHdr.SetCurrentKey("Prepayment Order No.");
      SalesCrMemoHdr.SetRange("Prepayment Order No.","Document No.");
      if SalesCrMemoHdr.FindFirst then begin
        SalesCrMemoHdr.CalcFields(Amount);
        if ("Prepmt. Amt. Inv." <> 0) and ("Prepayment %" <> 0) then
          if "Line Amount" <> xRec."Line Amount" - SalesCrMemoHdr.Amount * 100 / "Prepayment %" then
            FieldError("Line Amount",StrSubstNo(Text1020001,xRec."Line Amount"));
      end;
    end;
    CalcPrepaymentToDeduct;
    if VATBaseAmount <> "Amount Including VAT" then
      LineAmountChanged := true;
    #50..53
    end;

    OnAfterUpdateAmountsDone(Rec,xRec,CurrFieldNo);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..12
      // MER0007 >> TLE
      "Line Amount Price" := Round("Qty. to Invoice" * "Unit Price",Currency."Amount Rounding Precision") - "Line Discount Amount";
      // MER0009 >>
      //"Line Amount Cost" := ROUND("Qty. to Invoice" * "Unit Cost",Currency."Amount Rounding Precision");
      // MER0009 <<
      // MER0007 << TLE
    #13..15

    #16..24
    //{=======} MODIFIED
    {*IF NOT "Prepayment Line" THEN BEGIN
      IF "Prepayment %" <> 0 THEN BEGIN
        IF Quantity < 0 THEN
          FIELDERROR(Quantity,STRSUBSTNO(Text047,FIELDCAPTION("Prepayment %")));
        IF "Unit Price" < 0 THEN
          FIELDERROR("Unit Price",STRSUBSTNO(Text047,FIELDCAPTION("Prepayment %")));
      END;
      IF SalesHeader."Document Type" <> SalesHeader."Document Type"::Invoice THEN BEGIN
        "Prepayment VAT Difference" := 0;
        IF NOT PrePaymentLineAmountEntered THEN
          "Prepmt. Line Amount" := ROUND("Line Amount" * "Prepayment %" / 100,Currency."Amount Rounding Precision");
        IF "Prepmt. Line Amount" < "Prepmt. Amt. Inv." THEN
          FIELDERROR("Prepmt. Line Amount",STRSUBSTNO(Text049,"Prepmt. Amt. Inv."));
        PrePaymentLineAmountEntered := FALSE;
        IF "Prepmt. Line Amount" <> 0 THEN BEGIN
          RemLineAmountToInvoice :=
            ROUND("Line Amount" * (Quantity - "Quantity Invoiced") / Quantity,Currency."Amount Rounding Precision");
          IF RemLineAmountToInvoice < ("Prepmt. Line Amount" - "Prepmt Amt Deducted") THEN
            FIELDERROR("Prepmt. Line Amount",STRSUBSTNO(Text045,RemLineAmountToInvoice + "Prepmt Amt Deducted"));
        END;
      END ELSE
        IF (CurrFieldNo <> 0) AND ("Line Amount" <> xRec."Line Amount") AND
           ("Prepmt. Amt. Inv." <> 0) AND ("Prepayment %" = 100)
        THEN BEGIN
          IF "Line Amount" < xRec."Line Amount" THEN
            FIELDERROR("Line Amount",STRSUBSTNO(Text044,xRec."Line Amount"));
          FIELDERROR("Line Amount",STRSUBSTNO(Text045,xRec."Line Amount"));
        END;
    END;*}


    #25..27

    #28..36
    // NA0008.begin
    #37..41

    #42..44

      end;
    end;
    // NA0008.end
    #47..56
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "UpdateVATAmounts(PROCEDURE 38)".


    //Unsupported feature: Property Modification (Attributes) on "CheckItemAvailable(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "ShowReservation(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "ShowReservationEntries(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "AutoReserve(PROCEDURE 11)".



    //Unsupported feature: Code Modification on "AutoReserve(PROCEDURE 11)".

    //procedure AutoReserve();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TestField(Type,Type::Item);
    TestField("No.");

    ReserveSalesLine.ReservQuantity(Rec,QtyToReserve,QtyToReserveBase);
    if QtyToReserveBase <> 0 then begin
    #6..17
    end;

    OnAfterAutoReserve(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //The code has been merged but contained errors that could prevent import
    //and the code has been put in comments. Use Shift+Ctrl+O to Uncomment
    //TESTFIELD(Type,Type::Item);
    //TESTFIELD("No.");
    //
    //ReserveSalesLine.ReservQuantity(Rec,QtyToReserve,QtyToReserveBase);
    //IF QtyToReserveBase <> 0 THEN BEGIN
    //  ReservMgt.SetSalesLine(Rec);
    //  TESTFIELD("Shipment Date");
    //  ReservMgt.AutoReserve(FullAutoReservation,'',"Shipment Date",QtyToReserve,QtyToReserveBase);
    //  FIND;



    #3..20
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "AutoAsmToOrder(PROCEDURE 82)".


    //Unsupported feature: Property Modification (Attributes) on "CalcPlannedDeliveryDate(PROCEDURE 92)".


    //Unsupported feature: Property Modification (Attributes) on "CalcPlannedShptDate(PROCEDURE 93)".


    //Unsupported feature: Property Modification (Attributes) on "CalcShipmentDate(PROCEDURE 111)".


    //Unsupported feature: Property Modification (Attributes) on "SignedXX(PROCEDURE 20)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "OpenItemTrackingLines(PROCEDURE 6500)".


    //Unsupported feature: Property Modification (Attributes) on "CreateDim(PROCEDURE 26)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "LookupShortcutDimCode(PROCEDURE 28)".


    //Unsupported feature: Property Modification (Attributes) on "ShowShortcutDimCode(PROCEDURE 27)".


    //Unsupported feature: Property Modification (Attributes) on "SelectMultipleItems(PROCEDURE 180)".


    //Unsupported feature: Property Modification (Attributes) on "ShowItemSub(PROCEDURE 30)".


    //Unsupported feature: Property Modification (Attributes) on "ShowNonstock(PROCEDURE 32)".


    //Unsupported feature: Property Modification (Attributes) on "GetCaptionClass(PROCEDURE 34)".


    //Unsupported feature: Variable Insertion (Variable: PurchPrice) (VariableCollection) on "GetUnitCost(PROCEDURE 5808)".


    //Unsupported feature: Variable Insertion (Variable: PurchPriceCalcMgt) (VariableCollection) on "GetUnitCost(PROCEDURE 5808)".


    //Unsupported feature: Variable Insertion (Variable: TempPurchPrice) (VariableCollection) on "GetUnitCost(PROCEDURE 5808)".


    //Unsupported feature: Variable Insertion (Variable: BestPurchPrice) (VariableCollection) on "GetUnitCost(PROCEDURE 5808)".


    //Unsupported feature: Property Modification (Attributes) on "GetUnitCost(PROCEDURE 5808)".



    //Unsupported feature: Code Modification on "GetUnitCost(PROCEDURE 5808)".

    //procedure GetUnitCost();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TestField(Type,Type::Item);
    TestField("No.");
    GetItem(Item);
    #4..6
    else
      Validate("Unit Cost (LCY)",Item."Unit Cost" * "Qty. per Unit of Measure");

    OnAfterGetUnitCost(Rec,Item);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..9
    {* {=======} MODIFIED

    // MER0003 >>
    CLEAR("Vendor Cross Reference No.");
    GetSalesHeader;
    //Upgrade 2018 NAV
    //PurchPriceCalcMgt.FindPurchPrice(TempPurchPrice,'',"No.","Variant Code","Unit of Measure Code","Currency Code",SalesHeader."Posting Date",FALSE);
    IF TempPurchPrice.FINDSET THEN BEGIN
      REPEAT
        IF (BestPurchPrice."Direct Unit Cost" = 0) OR (TempPurchPrice."Direct Unit Cost" < BestPurchPrice."Direct Unit Cost") THEN
          BestPurchPrice := TempPurchPrice;
      UNTIL TempPurchPrice.NEXT = 0;
      VALIDATE("Vendor No.",BestPurchPrice."Vendor No.");
      VALIDATE("Unit Cost (LCY)",BestPurchPrice."Direct Unit Cost");
    END;*}
    // MER0003 <<


    OnAfterGetUnitCost(Rec,Item);
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "ShowItemChargeAssgnt(PROCEDURE 5801)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateItemChargeAssgnt(PROCEDURE 5807)".


    //Unsupported feature: Property Modification (Attributes) on "TestStatusOpen(PROCEDURE 33)".



    //Unsupported feature: Code Modification on "TestStatusOpen(PROCEDURE 33)".

    //procedure TestStatusOpen();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if StatusCheckSuspended then
      exit;

    GetSalesHeader;
    OnBeforeTestStatusOpen(Rec,SalesHeader);

    if not "System-Created Entry" then
      if HasTypeToFillMandatoryFields then
        SalesHeader.TestField(Status,SalesHeader.Status::Open);

    OnAfterTestStatusOpen(Rec,SalesHeader);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4

    OnBeforeTestStatusOpen(Rec,SalesHeader);

    #6..11
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "SuspendStatusCheck(PROCEDURE 39)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateVATOnLines(PROCEDURE 36)".


    //Unsupported feature: Property Modification (Attributes) on "CalcVATAmountLines(PROCEDURE 35)".


    //Unsupported feature: Property Modification (Attributes) on "GetCPGInvRoundAcc(PROCEDURE 71)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateWithWarehouseShip(PROCEDURE 41)".



    //Unsupported feature: Code Modification on "CheckWarehouse(PROCEDURE 46)".

    //procedure CheckWarehouse();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GetLocation("Location Code");
    if "Location Code" = '' then begin
      WhseSetup.Get;
    #4..78

    case ShowDialog of
      ShowDialog::Message:
        Message(Text016 + Text017,DialogText,FieldCaption("Line No."),"Line No.");
      ShowDialog::Error:
        Error(Text016,DialogText,FieldCaption("Line No."),"Line No.");
    end;

    HandleDedicatedBin(true);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..81
        //MER0011>>
        if GuiAllowed then
        //MER0011<<
    #82..87
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "GetItemTranslation(PROCEDURE 42)".


    //Unsupported feature: Property Modification (Attributes) on "PriceExists(PROCEDURE 44)".


    //Unsupported feature: Property Modification (Attributes) on "LineDiscExists(PROCEDURE 45)".


    //Unsupported feature: Property Modification (Attributes) on "RowID1(PROCEDURE 47)".


    //Unsupported feature: Property Modification (Attributes) on "GetATOBin(PROCEDURE 89)".


    //Unsupported feature: Property Modification (Attributes) on "IsInbound(PROCEDURE 97)".


    //Unsupported feature: Property Modification (Attributes) on "CheckAssocPurchOrder(PROCEDURE 51)".


    //Unsupported feature: Property Modification (Attributes) on "CrossReferenceNoLookUp(PROCEDURE 53)".


    //Unsupported feature: Property Modification (Attributes) on "ItemExists(PROCEDURE 54)".


    //Unsupported feature: Property Modification (Attributes) on "IsShipment(PROCEDURE 55)".


    //Unsupported feature: Property Modification (Attributes) on "SetHideValidationDialog(PROCEDURE 57)".


    //Unsupported feature: Property Modification (Attributes) on "CalcPrepaymentToDeduct(PROCEDURE 63)".


    //Unsupported feature: Property Modification (Attributes) on "IsFinalInvoice(PROCEDURE 116)".


    //Unsupported feature: Property Modification (Attributes) on "GetLineAmountToHandle(PROCEDURE 117)".


    //Unsupported feature: Property Modification (Attributes) on "GetLineAmountExclVAT(PROCEDURE 349)".


    //Unsupported feature: Property Modification (Attributes) on "GetLineAmountInclVAT(PROCEDURE 351)".


    //Unsupported feature: Property Modification (Attributes) on "SetHasBeenShown(PROCEDURE 59)".


    //Unsupported feature: Property Modification (Attributes) on "BlockDynamicTracking(PROCEDURE 58)".


    //Unsupported feature: Property Modification (Attributes) on "InitQtyToShip2(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "ShowLineComments(PROCEDURE 61)".


    //Unsupported feature: Property Modification (Attributes) on "SetDefaultQuantity(PROCEDURE 62)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePrePaymentAmounts(PROCEDURE 64)".


    //Unsupported feature: Property Modification (Attributes) on "ZeroAmountLine(PROCEDURE 65)".


    //Unsupported feature: Property Modification (Attributes) on "FilterLinesWithItemToPlan(PROCEDURE 69)".


    //Unsupported feature: Property Modification (Attributes) on "FindLinesWithItemToPlan(PROCEDURE 66)".


    //Unsupported feature: Property Modification (Attributes) on "LinesWithItemToPlanExist(PROCEDURE 67)".


    //Unsupported feature: Property Modification (Attributes) on "AsmToOrderExists(PROCEDURE 72)".


    //Unsupported feature: Property Modification (Attributes) on "FullQtyIsForAsmToOrder(PROCEDURE 74)".


    //Unsupported feature: Property Modification (Attributes) on "QtyBaseOnATO(PROCEDURE 86)".


    //Unsupported feature: Property Modification (Attributes) on "QtyAsmRemainingBaseOnATO(PROCEDURE 90)".


    //Unsupported feature: Property Modification (Attributes) on "QtyToAsmBaseOnATO(PROCEDURE 88)".


    //Unsupported feature: Property Modification (Attributes) on "IsAsmToOrderAllowed(PROCEDURE 77)".


    //Unsupported feature: Property Modification (Attributes) on "IsAsmToOrderRequired(PROCEDURE 81)".


    //Unsupported feature: Property Modification (Attributes) on "CheckAsmToOrder(PROCEDURE 85)".


    //Unsupported feature: Property Modification (Attributes) on "ShowAsmToOrderLines(PROCEDURE 80)".


    //Unsupported feature: Property Modification (Attributes) on "FindOpenATOEntry(PROCEDURE 96)".


    //Unsupported feature: Property Modification (Attributes) on "RollUpAsmCost(PROCEDURE 83)".


    //Unsupported feature: Property Modification (Attributes) on "RollupAsmPrice(PROCEDURE 84)".


    //Unsupported feature: Property Modification (Attributes) on "OutstandingInvoiceAmountFromShipment(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "IsShippedReceivedItemDimChanged(PROCEDURE 113)".


    //Unsupported feature: Property Modification (Attributes) on "ConfirmShippedReceivedItemDimChange(PROCEDURE 114)".


    //Unsupported feature: Property Modification (Attributes) on "InitType(PROCEDURE 91)".


    //Unsupported feature: Property Modification (Attributes) on "CalcSalesTaxLines(PROCEDURE 1020000)".



    //Unsupported feature: Code Modification on "CalcSalesTaxLines(PROCEDURE 1020000)".

    //procedure CalcSalesTaxLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if SalesHeader."Tax Area Code" = '' then
      exit;
    TaxArea.Get(SalesHeader."Tax Area Code");
    SalesTaxCalculate.StartSalesTaxCalculation; // clear temp table

    if TaxArea."Use External Tax Engine" then
      SalesTaxCalculate.CallExternalTaxEngineForSales(SalesHeader,true)
    else begin
      with SalesLine do begin
        SetRange("Document Type",SalesHeader."Document Type");
        SetRange("Document No.",SalesHeader."No.");
    #12..16
          until Next = 0;
      end;
      SalesTaxCalculate.EndSalesTaxCalculation(SalesHeader."Posting Date");
    end;
    SalesLine2.CopyFilters(SalesLine);
    SalesTaxCalculate.DistTaxOverSalesLines(SalesLine);
    SalesLine.CopyFilters(SalesLine2);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // NA0005.begin
    #1..3
    // NA0005.end
    //NA0001.begin
    SalesTaxCalculate.StartSalesTaxCalculation; // clear temp table

    // NA0005.begin
    #6..8
      // NA0005.end
    #9..19
    end;  // NA0005
    #21..23
    // NA0001.end
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "CheckLocationOnWMS(PROCEDURE 101)".


    //Unsupported feature: Property Modification (Attributes) on "IsNonInventoriableItem(PROCEDURE 195)".


    //Unsupported feature: Property Modification (Attributes) on "IsInventoriableItem(PROCEDURE 196)".


    //Unsupported feature: Property Modification (Attributes) on "CalcAmountIncludingTax(PROCEDURE 1020003)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateLineDiscountPercent(PROCEDURE 226)".


    //Unsupported feature: Property Modification (Attributes) on "HasTypeToFillMandatoryFields(PROCEDURE 103)".


    //Unsupported feature: Property Modification (Attributes) on "GetDeferralAmount(PROCEDURE 104)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePriceDescription(PROCEDURE 147)".


    //Unsupported feature: Property Modification (Attributes) on "DefaultDeferralCode(PROCEDURE 109)".


    //Unsupported feature: Property Modification (Attributes) on "IsCreditDocType(PROCEDURE 110)".


    //Unsupported feature: Property Modification (Attributes) on "CanEditUnitOfMeasureCode(PROCEDURE 115)".


    //Unsupported feature: Property Modification (Attributes) on "InsertFreightLine(PROCEDURE 121)".


    //Unsupported feature: Property Modification (Attributes) on "IsLookupRequested(PROCEDURE 119)".


    //Unsupported feature: Property Modification (Attributes) on "TestItemFields(PROCEDURE 120)".


    //Unsupported feature: Property Modification (Attributes) on "CalculateNotShippedInvExlcVatLCY(PROCEDURE 118)".


    //Unsupported feature: Property Modification (Attributes) on "ClearSalesHeader(PROCEDURE 124)".


    //Unsupported feature: Property Modification (Attributes) on "GetDocumentTypeDescription(PROCEDURE 156)".


    //Unsupported feature: Property Modification (Attributes) on "FormatType(PROCEDURE 149)".


    //Unsupported feature: Property Modification (Attributes) on "RenameNo(PROCEDURE 133)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePlanned(PROCEDURE 151)".


    //Unsupported feature: Property Modification (Attributes) on "AssignedItemCharge(PROCEDURE 153)".


    //Unsupported feature: Property Modification (Attributes) on "CalcPlannedDate(PROCEDURE 218)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignFieldsForNo(PROCEDURE 158)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignHeaderValues(PROCEDURE 134)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignStdTxtValues(PROCEDURE 135)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignGLAccountValues(PROCEDURE 138)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignItemValues(PROCEDURE 136)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignItemChargeValues(PROCEDURE 137)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignResourceValues(PROCEDURE 139)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignFixedAssetValues(PROCEDURE 140)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignItemUOM(PROCEDURE 141)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignResourceUOM(PROCEDURE 143)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAutoReserve(PROCEDURE 208)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromItem(PROCEDURE 230)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterFilterLinesWithItemToPlan(PROCEDURE 217)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterFindResUnitCost(PROCEDURE 214)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetUnitCost(PROCEDURE 172)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitQtyToAsm(PROCEDURE 223)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateUnitPrice(PROCEDURE 126)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCalcInvDiscToInvoice(PROCEDURE 220)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCalcVATAmountLines(PROCEDURE 190)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckAssocPurchOrder(PROCEDURE 175)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckItemAvailable(PROCEDURE 225)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCopyFromItem(PROCEDURE 222)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCrossReferenceNoAssign(PROCEDURE 193)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeGetDefaultBin(PROCEDURE 216)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInitQtyToAsm(PROCEDURE 221)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeTestStatusOpen(PROCEDURE 205)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdateUnitPrice(PROCEDURE 127)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdateVATAmounts(PROCEDURE 206)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeValidateReturnReasonCode(PROCEDURE 227)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeVerifyReservedQty(PROCEDURE 145)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitHeaderDefaults(PROCEDURE 161)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitOutstanding(PROCEDURE 215)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitOutstandingQty(PROCEDURE 202)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitOutstandingAmount(PROCEDURE 132)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitQtyToInvoice(PROCEDURE 128)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitQtyToShip(PROCEDURE 129)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitQtyToReceive(PROCEDURE 130)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCalcVATAmountLines(PROCEDURE 170)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetLineAmountToHandle(PROCEDURE 171)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateAmounts(PROCEDURE 152)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateAmountsDone(PROCEDURE 165)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateDates(PROCEDURE 200)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateVATAmounts(PROCEDURE 199)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateVATOnLines(PROCEDURE 162)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateDimTableIDs(PROCEDURE 164)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterShowItemSub(PROCEDURE 166)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterValidateReturnReasonCode(PROCEDURE 174)".


    //Unsupported feature: Property Modification (Attributes) on "OnShowItemChargeAssgntOnBeforeCalcItemCharge(PROCEDURE 194)".


    //Unsupported feature: Property Modification (Attributes) on "OnUpdateUnitPriceOnBeforeFindPrice(PROCEDURE 191)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateLocationCodeOnBeforeSetShipmentDate(PROCEDURE 201)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateTypeOnAfterCheckItem(PROCEDURE 188)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateTypeOnCopyFromTempSalesLine(PROCEDURE 167)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateNoOnAfterVerifyChange(PROCEDURE 187)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateNoOnCopyFromTempSalesLine(PROCEDURE 168)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateNoOnBeforeInitRec(PROCEDURE 31)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateNoOnBeforeUpdateDates(PROCEDURE 210)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateVariantCodeOnAfterChecks(PROCEDURE 213)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterTestStatusOpen(PROCEDURE 169)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSetDefaultQuantity(PROCEDURE 176)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateTotalAmounts(PROCEDURE 68)".


    //Unsupported feature: Property Modification (Attributes) on "OnGetDeferralPostDate(PROCEDURE 159)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAutoAsmToOrder(PROCEDURE 179)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeAutoAsmToOrder(PROCEDURE 178)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterBlanketOrderLookup(PROCEDURE 182)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeBlanketOrderLookup(PROCEDURE 184)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCalcPlannedDeliveryDate(PROCEDURE 203)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeOpenItemTrackingLines(PROCEDURE 212)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckCreditLimitCondition(PROCEDURE 185)".


    //Unsupported feature: Property Modification (Attributes) on "OnUpdateAmountOnBeforeCheckCreditLimit(PROCEDURE 207)".


    //Unsupported feature: Property Modification (Attributes) on "OnCrossReferenceNoLookupOnBeforeValidateUnitPrice(PROCEDURE 228)".


    var
        Purchasing: Record Purchasing;

    var
        tempSalesLine: Record "Sales Line" temporary;


    //Unsupported feature: Property Modification (TextConstString) on "Text054(Variable 1023)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text054 : ENU=Canceled.;ESM=Cancelado.;FRC=Annulé.;ENC=Cancelled.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text054 : ENU=Cancelled.;ESM=Cancelado.;FRC=Annulé.;ENC=Cancelled.;
    //Variable type has not been exported.

    local procedure MERUpdateCommissions()
    var
        SalesHeader: Record "Sales Header";
    begin
        // BC14: SalesHeader.UpdateCommissions(Rec) from the Sales Line triggers (MER0002/MER0008/MER0009)
        if Rec.IsTemporary() then
            exit;
        if SalesHeader.Get(Rec."Document Type", Rec."Document No.") then
            SalesHeader.UpdateCommissions(Rec);
    end;

    local procedure MERFindVendorReference(VariantCode: Code[10]; FilterVariant: Boolean): Code[20]
    var
        ItemReference: Record "Item Reference";
    begin
        // BC14 used table 5717 "Item Cross Reference" - BC25 "Item Reference"
        ItemReference.SetRange("Item No.", Rec."No.");
        ItemReference.SetRange("Reference Type", ItemReference."Reference Type"::Vendor);
        ItemReference.SetRange("Reference Type No.", Rec."Vendor No.");
        if FilterVariant then
            ItemReference.SetRange("Variant Code", VariantCode);
        if ItemReference.FindFirst() then
            exit(CopyStr(ItemReference."Reference No.", 1, 20));
        exit('');
    end;

    var
        Item: Record Item;
}

