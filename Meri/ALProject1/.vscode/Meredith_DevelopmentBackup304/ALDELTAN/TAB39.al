tableextension 50010 tableextension70000324 extends "Purchase Line"
{
    // <changelog>
    //   <add id="NA0001" dev="ELYNCH" date="2006-01-24" area="1099" feature="601"
    //     releaseversion="NAVUS3.70.00.27">1099 functionality</add>
    //   <change id="NA0002" dev="ELYNCH" date="2006-01-26" area="NASALESTAX" feature="617"
    //     releaseversion="NAVUS3.70.00.27">Added functions and code for NA Sales Tax</change>
    //   <change id="NA0003" dev="ELYNCH" date="2006-01-26" area="BUG FIX W1"  request=""
    //     baseversion="NAVUS3.70.00.27" releaseversion="NAVNA4.00">Add check on CurrFieldno not equal 0 in
    //     UpdateUnitCost and UpdateSalesCost</change>
    //   <change id="NA0004" dev="JNOZZI" date="2006-08-14" area="NASALESTAX"  request="1087"
    //     baseversion="NAVNA4.00" releaseversion="NAVNA5.00">Only update Tax Area Code from Location Card if Location
    //     allows it, otherwise, update from header.</change>
    //   <change id="NA0005" dev="JNOZZI" date="2007-09-04" area="NASALESTAX"  request="24744"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA5.00.00.01">Canadian Sales Tax changes - Added field 10017
    //     Updated Defaults for Tax Area Code to use the new Vendor Location table, or alternatively, use the Vendor Card (based on
    //     the Purchases and Payables Setup).</change>
    //   <change id="NA0007" dev="JNOZZI" date="2007-12-06" area="NASALESTAX" feature="31197"
    //     baseversion="NAVNA5.00.01" releaseversion="NAVNA5.00.01">Test to make sure that Tax Area on the line has the
    //     same &quot;Use External Tax Engine&quot; status as the Tax Area on the header. Modify CalcSalesTaxLines to call external
    //     engine as necessary.</change>
    //   <add id="NA0008" dev="all-e" date="20010-05-19" area="GST" feature="VSTF173006"
    //     releaseversion="NAVNA7.00">
    //     Electronic GST HST Filing for Canada  Phase II Electronic Filing for NAV 2009 SP1</add>
    //   <change id="NA0009" dev="all-e" date="2010-09-29" area="GST" feature="VSTF231828"
    //     baseversion="NA7.00" releaseversion="NA7.00">
    //     British Columbias and Ontarios sales tax reform</change>
    //   <change id="NA0010" dev="v-jefwu" date="2011-02-22" area="GST" feature="VSTF251991"
    //     baseversion="NA7.00" releaseversion="NA7.00">Prepayment Credit Memo Posting results in an error</change>
    //    <add id="NA0011" dev="all-e" date="2011-04-22" area="Elec. Pay" feature="VSTF257818"
    //      releaseversion="NA7.00">Canada 2011 Changes to GST HST Internet File Transfer
    //    </add>
    // </changelog>
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
        modify("Unit Price (LCY)")
        {
            Caption = 'Unit Price (LCY)';
        }
        modify("Pay-to Vendor No.")
        {
            Caption = 'Pay-to Vendor No.';
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
        modify("Amt. Rcd. Not Invoiced (LCY)")
        {
            Caption = 'Amt. Rcd. Not Invoiced (LCY)';
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
        modify("Outstanding Amt. Ex. VAT (LCY)")
        {
            Caption = 'Outstanding Amt. Ex. VAT (LCY)';
        }
        modify("A. Rcd. Not Inv. Ex. VAT (LCY)")
        {
            Caption = 'A. Rcd. Not Inv. Ex. VAT (LCY)';
        }
        modify("Job Unit Price (LCY)")
        {
            Caption = 'Job Unit Price (LCY)';
        }
        modify("Job Total Price (LCY)")
        {
            Caption = 'Job Total Price (LCY)';
        }
        modify("Job Line Amount (LCY)")
        {
            Caption = 'Job Line Amount (LCY)';
        }
        modify("Job Line Disc. Amount (LCY)")
        {
            Caption = 'Job Line Disc. Amount (LCY)';
        }
        modify("Return Shpd. Not Invd. (LCY)")
        {
            Caption = 'Return Shpd. Not Invd. (LCY)';
        }


        //Unsupported feature: Code Modification on ""No."(Field 6).OnValidate".

        //trigger "(Field 6)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetPurchSetup;
        if PurchSetup."Create Item from Item No." then
          "No." := FindRecordMgt.FindNoFromTypedValue(Type,"No.",not "System-Created Entry");

        TestStatusOpen;
        TestField("Qty. Rcd. Not Invoiced",0);
        TestField("Quantity Received",0);
        TestField("Receipt No.",'');

        TestField("Prepmt. Amt. Inv.",0);

        TestReturnFieldsZero;

        if "Drop Shipment" then
          Error(
            Text001,
            FieldCaption("No."),"Sales Order No.");

        if "Special Order" then
          Error(
            Text001,
            FieldCaption("No."),"Special Order Sales No.");

        if "Prod. Order No." <> '' then
          Error(
            Text044,
            FieldCaption(Type),FieldCaption("Prod. Order No."),"Prod. Order No.");

        OnValidateNoOnAfterChecks(Rec,xRec,CurrFieldNo);

        if "No." <> xRec."No." then begin
          if (Quantity <> 0) and ItemExists(xRec."No.") then begin
            ReservePurchLine.VerifyChange(Rec,xRec);
            CalcFields("Reserved Qty. (Base)");
            TestField("Reserved Qty. (Base)",0);
            if Type = Type::Item then
              WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
            OnValidateNoOnAfterVerifyChange(Rec,xRec);
          end;
          if Type = Type::Item then
            DeleteItemChargeAssgnt("Document Type","Document No.","Line No.");
          if Type = Type::"Charge (Item)" then
            DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");
        end;

        OnValidateNoOnBeforeInitRec(Rec,xRec,CurrFieldNo);
        TempPurchLine := Rec;
        Init;
        if xRec."Line Amount" <> 0 then
          "Recalculate Invoice Disc." := true;
        Type := TempPurchLine.Type;
        "No." := TempPurchLine."No.";
        OnValidateNoOnCopyFromTempPurchLine(Rec,TempPurchLine);
        if "No." = '' then
          exit;

        if HasTypeToFillMandatoryFields then begin
          Quantity := TempPurchLine.Quantity;
          "Outstanding Qty. (Base)" := TempPurchLine."Outstanding Qty. (Base)";
        end;

        "System-Created Entry" := TempPurchLine."System-Created Entry";
        GetPurchHeader;
        InitHeaderDefaults(PurchHeader);
        UpdateLeadTimeFields;
        UpdateDates;

        OnAfterAssignHeaderValues(Rec,PurchHeader);

        case Type of
          Type::" ":
            CopyFromStandardText;
          Type::"G/L Account":
            CopyFromGLAccount;
          Type::Item:
            CopyFromItem;
          3:
            Error(Text003);
          Type::"Fixed Asset":
            CopyFromFixedAsset;
          Type::"Charge (Item)":
            CopyFromItemCharge;
        end;

        OnAfterAssignFieldsForNo(Rec,xRec,PurchHeader);

        if HasTypeToFillMandatoryFields and not (Type = Type::"Fixed Asset") then
          Validate("VAT Prod. Posting Group");

        UpdatePrepmtSetupFields;

        if HasTypeToFillMandatoryFields then begin
          Quantity := xRec.Quantity;
          OnValidateNoOnAfterAssignQtyFromXRec(Rec,TempPurchLine);
          Validate("Unit of Measure Code");
          if Quantity <> 0 then begin
            InitOutstanding;
            if "Document Type" in ["Document Type"::"Return Order","Document Type"::"Credit Memo"] then
              InitQtyToShip
            else
              InitQtyToReceive;
          end;
          UpdateWithWarehouseReceive;
          UpdateDirectUnitCost(FieldNo("No."));
          if xRec."Job No." <> '' then
            Validate("Job No.",xRec."Job No.");
          "Job Line Type" := xRec."Job Line Type";
          if xRec."Job Task No." <> '' then begin
            Validate("Job Task No.",xRec."Job Task No.");
            if "No." = xRec."No." then
              Validate("Job Planning Line No.",xRec."Job Planning Line No.");
          end;
        end;

        CreateDim(
          DimMgt.TypeToTableID3(Type),"No.",
          DATABASE::Job,"Job No.",
          DATABASE::"Responsibility Center","Responsibility Center",
          DATABASE::"Work Center","Work Center No.");

        PurchHeader.Get("Document Type","Document No.");
        UpdateItemReference;

        GetDefaultBin;

        if JobTaskIsSet then begin
          CreateTempJobJnlLine(true);
          UpdateJobPrices;
          UpdateDimensionsFromJobTask;
        end;

        PostingSetupMgt.CheckGenPostingSetupPurchAccount("Gen. Bus. Posting Group","Gen. Prod. Posting Group");
        PostingSetupMgt.CheckVATPostingSetupPurchAccount("VAT Bus. Posting Group","VAT Prod. Posting Group");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*

        //{=======} MODIFIED
        //The code has been merged but contained errors that could prevent import
        //and the code has been put in comments. Use Shift+Ctrl+O to Uncomment
        //"No." := FindRecordMgt.FindNoFromTypedValue(Type,"No.",NOT "System-Created Entry");
        //
        //TestStatusOpen;
        //TESTFIELD("Qty. Rcd. Not Invoiced",0);
        //TESTFIELD("Quantity Received",0);
        //TESTFIELD("Receipt No.",'');
        //
        //TESTFIELD("Prepmt. Amt. Inv.",0);
        //
        //TestReturnFieldsZero;
        //
        //IF "Drop Shipment" THEN
        //  ERROR(
        //    Text001,
        //    FIELDCAPTION("No."),"Sales Order No.");
        //
        //IF "Special Order" THEN
        //  ERROR(
        //    Text001,
        //    FIELDCAPTION("No."),"Special Order Sales No.");
        //
        //IF "Prod. Order No." <> '' THEN
        //  ERROR(
        //    Text044,
        //    FIELDCAPTION(Type),FIELDCAPTION("Prod. Order No."),"Prod. Order No.");
        //
        //IF "No." <> xRec."No." THEN BEGIN
        //  IF (Quantity <> 0) AND ItemExists(xRec."No.") THEN BEGIN
        //    ReservePurchLine.VerifyChange(Rec,xRec);
        //    CALCFIELDS("Reserved Qty. (Base)");
        //    TESTFIELD("Reserved Qty. (Base)",0);
        //    IF Type = Type::Item THEN
        //      WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
        //  END;
        //  IF Type = Type::Item THEN
        //    DeleteItemChargeAssgnt("Document Type","Document No.","Line No.");
        //  IF Type = Type::"Charge (Item)" THEN
        //    DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");
        //END;
        //TempPurchLine := Rec;
        //INIT;
        //IF xRec."Line Amount" <> 0 THEN
        //  "Recalculate Invoice Disc." := TRUE;
        //Type := TempPurchLine.Type;
        //"No." := TempPurchLine."No.";
        //OnValidateNoOnCopyFromTempPurchLine(Rec,TempPurchLine);
        //IF "No." = '' THEN
        //  EXIT;
        //
        //IF HasTypeToFillMandatoryFields THEN BEGIN
        //  Quantity := TempPurchLine.Quantity;
        //  "Outstanding Qty. (Base)" := TempPurchLine."Outstanding Qty. (Base)";
        //END;
        //
        //"System-Created Entry" := TempPurchLine."System-Created Entry";
        //GetPurchHeader;

        #1..4



        //InitHeaderDefaults(PurchHeader);

        //UpdateLeadTimeFields;
        //UpdateDates;
        //
        //OnAfterAssignHeaderValues(Rec,PurchHeader);
        //
        //CASE Type OF
        //  Type::" ":


        //    CopyFromStandardText;


        #28..56


        //    CopyFromFixedAsset;
        #61..131

        //  Type::"Charge (Item)":
        //    CopyFromItemCharge;
        //END;
        //
        //OnAfterAssignFieldsForNo(Rec,xRec,PurchHeader);
        //
        //IF HasTypeToFillMandatoryFields AND NOT (Type = Type::"Fixed Asset") THEN
        //  VALIDATE("VAT Prod. Posting Group");
        //
        //UpdatePrepmtSetupFields;
        //
        //IF HasTypeToFillMandatoryFields THEN BEGIN
        //  Quantity := xRec.Quantity;
        //  VALIDATE("Unit of Measure Code");
        //  IF Quantity <> 0 THEN BEGIN
        //    InitOutstanding;
        //    IF "Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"] THEN
        //      InitQtyToShip
        //    ELSE
        //      InitQtyToReceive;
        //  END;
        //  UpdateWithWarehouseReceive;
        //  UpdateDirectUnitCost(FIELDNO("No."));
        //  IF xRec."Job No." <> '' THEN
        //    VALIDATE("Job No.",xRec."Job No.");
        //  "Job Line Type" := xRec."Job Line Type";
        //  IF xRec."Job Task No." <> '' THEN BEGIN
        //    VALIDATE("Job Task No.",xRec."Job Task No.");
        //    IF "No." = xRec."No." THEN
        //      VALIDATE("Job Planning Line No.",xRec."Job Planning Line No.");
        //  END;
        //END;
        //
        //IF NOT ISTEMPORARY THEN
        //  CreateDim(
        //    DimMgt.TypeToTableID3(Type),"No.",
        //    DATABASE::Job,"Job No.",
        //    DATABASE::"Responsibility Center","Responsibility Center",
        //    DATABASE::"Work Center","Work Center No.");
        //
        //PurchHeader.GET("Document Type","Document No.");
        //UpdateItemReference;
        //
        //GetDefaultBin;
        //
        //IF JobTaskIsSet THEN BEGIN
        //  CreateTempJobJnlLine(TRUE);
        //  UpdateJobPrices;
        //END;
        //
        //PostingSetupMgt.CheckGenPostingSetupPurchAccount("Gen. Bus. Posting Group","Gen. Prod. Posting Group");
        //PostingSetupMgt.CheckVATPostingSetupPurchAccount("VAT Bus. Posting Group","VAT Prod. Posting Group");
        */
        //end;


        //Unsupported feature: Code Modification on ""Location Code"(Field 7).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;

        if "Location Code" <> '' then
        #4..43
        if Type = Type::Item then
          UpdateDirectUnitCost(FieldNo("Location Code"));

        PurchSetup.Get;
        if PurchSetup."Use Vendor's Tax Area Code" then begin
          Vend.Get("Buy-from Vendor No.");
        #50..53
        else
          if not VendorLocation.Get("Buy-from Vendor No.","Location Code") then
            VendorLocation."Business Presence" := true;
        if "Location Code" = '' then begin
          if InvtSetup.Get then
            "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
          GetPurchHeader;
          if PurchSetup."Use Vendor's Tax Area Code" and ("Tax Area Code" <> '') then begin
            Validate("Tax Area Code");
            VendorLocation."Business Presence" := true;
        #64..69
            "Provincial Tax Area Code" := PurchHeader."Provincial Tax Area Code"
          else
            "Provincial Tax Area Code" := '';
        end else begin
          if Location.Get("Location Code") then begin
            "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";
            if Location."Do Not Use For Tax Calculation" then begin
              GetPurchHeader;
              Location."Tax Area Code" := PurchHeader."Tax Area Code";
              Location."Provincial Tax Area Code" := PurchHeader."Provincial Tax Area Code";
            end;
            if PurchSetup."Use Vendor's Tax Area Code" and ("Tax Area Code" <> '') then begin
              Validate("Tax Area Code");
              VendorLocation."Business Presence" := true;
        #84..89
              "Provincial Tax Area Code" := Location."Provincial Tax Area Code"
            else
              "Provincial Tax Area Code" := '';
          end;
        end;

        UpdateLeadTimeFields;
        #97..100

        if "Document Type" = "Document Type"::"Return Order" then
          ValidateReturnReasonCode(FieldNo("Location Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..46
        // NA0005.begin
        #47..56
        // NA0005.end
        #57..59
          //NA0002.begin
          // NA0004.begin
          // CompanyInfo.GET;
          // VALIDATE("Tax Area Code", CompanyInfo."Tax Area Code");
          // NA0004.end
          // NA0004.begin
          GetPurchHeader;
          // NA0005.begin
          // VALIDATE("Tax Area Code", PurchHeader."Tax Area Code");
          // NA0005.end
          // NA0005.begin
        #61..72
          // NA0005.end
          // NA0004.end
        #73..75
            // NA0004.begin
        #76..78
              Location."Provincial Tax Area Code" := PurchHeader."Provincial Tax Area Code";  // NA0005
            end;
            // NA0004.end
            // NA0005.begin
            // VALIDATE("Tax Area Code", Location."Tax Area Code");
            // NA0005.end
            // NA0005.begin
        #81..92
            // NA0005.end
          end;
          //NA0002.end
        #94..103
        */
        //end;


        //Unsupported feature: Code Modification on ""Direct Unit Cost"(Field 22).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if ("Prepmt. Amt. Inv." <> 0) and
           ("Direct Unit Cost" <> xRec."Direct Unit Cost") and not IsServiceCharge
        then
          FieldError("Direct Unit Cost",StrSubstNo(Text1020005,xRec."Direct Unit Cost"));
        Validate("Line Discount %");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // NA0010.begin
        #1..3

          FieldError("Direct Unit Cost",StrSubstNo(Text1020005,xRec."Direct Unit Cost"));

        Validate("Line Discount %");
        */
        //end;


        //Unsupported feature: Code Modification on ""Job No."(Field 45).OnValidate".

        //trigger "(Field 45)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestField("Drop Shipment",false);
        TestField("Special Order",false);
        TestField("Receipt No.",'');
        if "Document Type" = "Document Type"::Order then
          TestField("Quantity Received",0);

        if ReservEntryExist then
          TestField("Job No.",'');

        if "Job No." <> xRec."Job No." then begin
          Validate("Job Task No.",'');
          Validate("Job Planning Line No.",0);
        #13..31
          DimMgt.TypeToTableID3(Type),"No.",
          DATABASE::"Responsibility Center","Responsibility Center",
          DATABASE::"Work Center","Work Center No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..6


        #7..9

        #10..34
        */
        //end;


        //Unsupported feature: Code Modification on ""Tax Area Code"(Field 85).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetPurchHeader;
        TestStatusOpen;
        TestExpenseCapitalize;
        if "Tax Area Code" = '' then
          Clear(TaxArea)
        else begin
          TaxArea.Get("Tax Area Code");
          PurchHeader.TestField("Tax Area Code");
        #9..21
              TableCaption,
              PurchHeader.TableCaption);
        end;
        UpdateAmounts;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //NA0002.begin
        #1..3
        //NA0002.end
        // NA0005.begin
        if "Tax Area Code" = '' then
          Clear(TaxArea)
          // NA0007.begin
          // ELSE
          // TaxArea.GET("Tax Area Code");
          // NA0007.end
          // NA0007.begin
        #6..24
        // NA0007.end
        // NA0005.end
        UpdateAmounts;
        */
        //end;


        //Unsupported feature: Code Modification on ""Tax Liable"(Field 86).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetPurchHeader;
        TestStatusOpen;
        UpdateAmounts;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //NA0002.begin
        GetPurchHeader;

        TestStatusOpen;

        UpdateAmounts;
        */
        //end;


        //Unsupported feature: Code Modification on ""Tax Group Code"(Field 87).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetPurchHeader;
        TestStatusOpen;
        TestExpenseCapitalize;
        UpdateAmounts;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //NA0002.begin
        #1..3
        //NA0002.end
        UpdateAmounts;
        */
        //end;


        //Unsupported feature: Code Modification on ""Use Tax"(Field 88).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetPurchHeader;
        TestStatusOpen;
        TestExpenseCapitalize;
        if "Use Tax" then
          "Tax Liable" := true
        else
          "Tax Liable" := PurchHeader."Tax Liable";
        UpdateAmounts;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //NA0002.begin
        #1..7
        //NA0002.end
        UpdateAmounts;
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


        //Unsupported feature: Code Modification on ""GST/HST"(Field 10025).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if ("GST/HST" = "GST/HST"::Acquisition) and ((Type <> Type::"Fixed Asset") and (Type <> Type::"G/L Account")) then
          Error(Text10100);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // NA0008.begin
        if ("GST/HST" = "GST/HST"::Acquisition) and ((Type <> Type::"Fixed Asset") and (Type <> Type::"G/L Account")) then
          Error(Text10100);
        // NA0008.end
        */
        //end;
    }


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TestStatusOpen;
    CheckForTaxDifferences;

    if (Quantity <> 0) and ItemExists("No.") then begin
      ReservePurchLine.DeleteLine(Rec);
    #6..78
      DeferralUtilities.DeferralCodeOnDelete(
        DeferralUtilities.GetPurchDeferralDocType,'','',
        "Document Type","Document No.","Line No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TestStatusOpen;
    //NA0002.begin
    CheckForTaxDifferences;


    //NA0002.end
    //IF NOT StatusCheckSuspended AND (PurchHeader.Status = PurchHeader.Status::Released) AND
    //   (Type IN [Type::"G/L Account",Type::"Charge (Item)"])
    //THEN
    //  VALIDATE(Quantity,0);

    #3..81
    */
    //end;


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TestStatusOpen;
    if Quantity <> 0 then begin
      OnBeforeVerifyReservedQty(Rec,xRec,0);
      ReservePurchLine.VerifyQuantity(Rec,xRec);
    end;
    LockTable;
    PurchHeader."No." := '';
    if ("Deferral Code" <> '') and (GetDeferralAmount <> 0) then
      UpdateDeferralAmounts;
    "IRS 1099 Liable" := (PurchHeader."IRS 1099 Code" <> '');
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7

    if ("Deferral Code" <> '') and (GetDeferralAmount <> 0) then
      UpdateDeferralAmounts;

    "IRS 1099 Liable" := (PurchHeader."IRS 1099 Code" <> '');
    //NA0001.end
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "InitOutstanding(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "InitOutstandingAmount(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "InitQtyToReceive(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "InitQtyToShip(PROCEDURE 5803)".


    //Unsupported feature: Property Modification (Attributes) on "InitQtyToInvoice(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "MaxQtyToInvoice(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "MaxQtyToInvoiceBase(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "CalcInvDiscToInvoice(PROCEDURE 33)".


    //Unsupported feature: Property Modification (Attributes) on "CalcLineAmount(PROCEDURE 163)".


    //Unsupported feature: Property Modification (Attributes) on "SetPurchHeader(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateDirectUnitCost(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateUnitCost(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateAmounts(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "UpdateAmounts(PROCEDURE 3)".

    //procedure UpdateAmounts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if Type = Type::" " then
      exit;
    GetPurchHeader;

    VATBaseAmount := "Amount Including VAT";
    "Recalculate Invoice Disc." := true;

    if "Line Amount" <> xRec."Line Amount" then begin
      "VAT Difference" := 0;
    #10..77

    InitOutstandingAmount;

    if Type = Type::"Charge (Item)" then
      UpdateItemChargeAssgnt;

    if (Quantity < xRec.Quantity) and ("Prepmt. Amt. Inv." <> 0) then begin
      PurchCrMemoHeader.SetCurrentKey("Prepayment Order No.");
    #86..93
    CalcPrepaymentToDeduct;

    OnAfterUpdateAmountsDone(Rec,xRec,CurrFieldNo);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //The code has been merged but contained errors that could prevent import
    //and the code has been put in comments. Use Shift+Ctrl+O to Uncomment
    //IF Type = Type::" " THEN
    //  EXIT;
    //GetPurchHeader;
    //
    //VATBaseAmount := "Amount Including VAT";
    //"Recalculate Invoice Disc." := TRUE;
    //
    //IF "Line Amount" <> xRec."Line Amount" THEN BEGIN
    //  "VAT Difference" := 0;
    //  LineAmountChanged := TRUE;
    //END;
    //IF "Line Amount" <> ROUND(Quantity * "Direct Unit Cost",Currency."Amount Rounding Precision") - "Line Discount Amount" THEN BEGIN
    //  "Line Amount" :=
    //    ROUND(Quantity * "Direct Unit Cost",Currency."Amount Rounding Precision") - "Line Discount Amount";
    //  "VAT Difference" := 0;
    //  LineAmountChanged := TRUE;
    //END;
    //
    //IF PurchHeader.Status = PurchHeader.Status::Released THEN
    //  //NA0002.begin
    //  IF PurchHeader."Tax Area Code" = '' THEN
    //    UpdateVATAmounts
    //  ELSE
    //    IF CurrFieldNo <> 0 THEN
    //      ERROR(Text1020002);
    //IF (CurrFieldNo <> 0) AND ("Tax Area Code" <> '') THEN
    //  CheckForTaxDifferences;
    ////NA0002.end
    //
    //IF (("Tax Group Code" = '') AND (xRec."Tax Group Code" <> ''))
    //   OR (("Tax Area Code" = '') AND (xRec."Tax Area Code" <> '')) THEN
    //BEGIN
    //  Amount := 0;
    //  "Amount Including VAT" := 0;
    //END;
    //
    //IF NOT "Prepayment Line" THEN BEGIN
    //  IF "Prepayment %" <> 0 THEN BEGIN
    //    IF Quantity < 0 THEN
    //      FIELDERROR(Quantity,STRSUBSTNO(Text043,FIELDCAPTION("Prepayment %")));
    //    IF "Direct Unit Cost" < 0 THEN
    //      FIELDERROR("Direct Unit Cost",STRSUBSTNO(Text043,FIELDCAPTION("Prepayment %")));
    //  END;
    //  IF PurchHeader."Document Type" <> PurchHeader."Document Type"::Invoice THEN BEGIN
    //    "Prepayment VAT Difference" := 0;
    //    IF NOT PrePaymentLineAmountEntered THEN
    //      "Prepmt. Line Amount" := ROUND("Line Amount" * "Prepayment %" / 100,Currency."Amount Rounding Precision");
    //    IF "Prepmt. Line Amount" < "Prepmt. Amt. Inv." THEN
    //      FIELDERROR("Prepmt. Line Amount",STRSUBSTNO(Text037,"Prepmt. Amt. Inv."));
    //    PrePaymentLineAmountEntered := FALSE;
    //    IF "Prepmt. Line Amount" <> 0 THEN BEGIN
    //      RemLineAmountToInvoice :=
    //        ROUND("Line Amount" * (Quantity - "Quantity Invoiced") / Quantity,Currency."Amount Rounding Precision");
    //      IF RemLineAmountToInvoice < ("Prepmt. Line Amount" - "Prepmt Amt Deducted") THEN
    //        FIELDERROR("Prepmt. Line Amount",STRSUBSTNO(Text039,RemLineAmountToInvoice + "Prepmt Amt Deducted"));
    //    END;
    //  END ELSE
    //    IF (CurrFieldNo <> 0) AND ("Line Amount" <> xRec."Line Amount") AND
    //       ("Prepmt. Amt. Inv." <> 0) AND ("Prepayment %" = 100)
    //    THEN BEGIN
    //      IF "Line Amount" < xRec."Line Amount" THEN
    //        FIELDERROR("Line Amount",STRSUBSTNO(Text038,xRec."Line Amount"));
    //      FIELDERROR("Line Amount",STRSUBSTNO(Text039,xRec."Line Amount"));
    //    END;
    //END;
    //
    //OnAfterUpdateAmounts(Rec);
    //
    //UpdateVATAmounts;
    //IF VATBaseAmount <> "Amount Including VAT" THEN
    //  LineAmountChanged := TRUE;
    //
    //IF LineAmountChanged THEN BEGIN
    //  UpdateDeferralAmounts;
    //  LineAmountChanged := FALSE;
    //END;
    //
    //InitOutstandingAmount;
    //
    //IF Type = Type::"Charge (Item)" THEN
    //  UpdateItemChargeAssgnt;

    //
    //IF (Quantity < xRec.Quantity) AND ("Prepmt. Amt. Inv." <> 0) THEN BEGIN


    //{=======} MODIFIED
    //  PurchCrMemoHeader.SETCURRENTKEY("Prepayment Order No.");
    //  PurchCrMemoHeader.SETRANGE("Prepayment Order No.","Document No.");
    //  IF PurchCrMemoHeader.FINDFIRST THEN BEGIN
    //    PurchCrMemoHeader.CALCFIELDS(Amount);
    #7..80

    //    IF ("Prepmt. Amt. Inv." <> 0) AND ("Prepayment %" <> 0) THEN
    //      IF "Line Amount" <> xRec."Line Amount" - PurchCrMemoHeader.Amount * 100 / "Prepayment %" THEN
    //        FIELDERROR("Line Amount",STRSUBSTNO(Text1020005,xRec."Line Amount"));


    #83..96
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "UpdateVATAmounts(PROCEDURE 38)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePrepmtSetupFields(PROCEDURE 102)".



    //Unsupported feature: Code Modification on "UpdateSalesCost(PROCEDURE 6)".

    //procedure UpdateSalesCost();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    case true of
      "Sales Order Line No." <> 0:
        // Drop Shipment
    #4..15
    SalesOrderLine."Unit Cost (LCY)" := "Unit Cost (LCY)" * SalesOrderLine."Qty. per Unit of Measure" / "Qty. per Unit of Measure";
    SalesOrderLine."Unit Cost" := "Unit Cost" * SalesOrderLine."Qty. per Unit of Measure" / "Qty. per Unit of Measure";
    SalesOrderLine.Validate("Unit Cost (LCY)");
    if CurrFieldNo <> 0 then
      SalesOrderLine.Modify;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..18
    if CurrFieldNo <> 0 then      //NA0003
      SalesOrderLine.Modify;
    //NA0003
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "UpdateUOMQtyPerStockQty(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "SelectMultipleItems(PROCEDURE 180)".


    //Unsupported feature: Property Modification (Attributes) on "ShowReservation(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "ShowReservationEntries(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "GetDate(PROCEDURE 28)".


    //Unsupported feature: Property Modification (Attributes) on "Signed(PROCEDURE 20)".


    //Unsupported feature: Property Modification (Attributes) on "BlanketOrderLookup(PROCEDURE 36)".


    //Unsupported feature: Property Modification (Attributes) on "BlockDynamicTracking(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "OpenItemTrackingLines(PROCEDURE 6500)".


    //Unsupported feature: Property Modification (Attributes) on "CreateDim(PROCEDURE 26)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "LookupShortcutDimCode(PROCEDURE 30)".


    //Unsupported feature: Property Modification (Attributes) on "ShowShortcutDimCode(PROCEDURE 27)".


    //Unsupported feature: Property Modification (Attributes) on "ShowItemChargeAssgnt(PROCEDURE 5801)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateItemChargeAssgnt(PROCEDURE 5807)".


    //Unsupported feature: Property Modification (Attributes) on "CheckItemChargeAssgnt(PROCEDURE 5800)".


    //Unsupported feature: Property Modification (Attributes) on "GetCaptionClass(PROCEDURE 34)".


    //Unsupported feature: Property Modification (Attributes) on "TestStatusOpen(PROCEDURE 37)".



    //Unsupported feature: Code Modification on "TestStatusOpen(PROCEDURE 37)".

    //procedure TestStatusOpen();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeTestStatusOpen(Rec,PurchHeader);

    if StatusCheckSuspended then
      exit;
    GetPurchHeader;
    if not "System-Created Entry" then
      if HasTypeToFillMandatoryFields then
        PurchHeader.TestField(Status,PurchHeader.Status::Open);

    OnAfterTestStatusOpen(Rec,PurchHeader);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5

    if not "System-Created Entry" then
      if HasTypeToFillMandatoryFields then

    #8..10
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "SuspendStatusCheck(PROCEDURE 42)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateLeadTimeFields(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "GetUpdateBasicDates(PROCEDURE 43)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateDates(PROCEDURE 39)".


    //Unsupported feature: Property Modification (Attributes) on "InternalLeadTimeDays(PROCEDURE 35)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateVATOnLines(PROCEDURE 32)".


    //Unsupported feature: Property Modification (Attributes) on "CalcVATAmountLines(PROCEDURE 24)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateWithWarehouseReceive(PROCEDURE 41)".


    //Unsupported feature: Property Modification (Attributes) on "GetItemTranslation(PROCEDURE 44)".


    //Unsupported feature: Property Modification (Attributes) on "AdjustDateFormula(PROCEDURE 48)".


    //Unsupported feature: Property Modification (Attributes) on "RowID1(PROCEDURE 49)".


    //Unsupported feature: Property Modification (Attributes) on "IsInbound(PROCEDURE 75)".


    //Unsupported feature: Property Modification (Attributes) on "CrossReferenceNoLookUp(PROCEDURE 51)".


    //Unsupported feature: Property Modification (Attributes) on "ItemExists(PROCEDURE 52)".


    //Unsupported feature: Property Modification (Attributes) on "CalcPrepaymentToDeduct(PROCEDURE 59)".


    //Unsupported feature: Property Modification (Attributes) on "IsFinalInvoice(PROCEDURE 116)".


    //Unsupported feature: Property Modification (Attributes) on "GetLineAmountToHandle(PROCEDURE 117)".


    //Unsupported feature: Property Modification (Attributes) on "JobTaskIsSet(PROCEDURE 61)".


    //Unsupported feature: Property Modification (Attributes) on "CreateTempJobJnlLine(PROCEDURE 55)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateJobPrices(PROCEDURE 69)".


    //Unsupported feature: Property Modification (Attributes) on "JobSetCurrencyFactor(PROCEDURE 54)".


    //Unsupported feature: Property Modification (Attributes) on "SetUpdateFromVAT(PROCEDURE 58)".


    //Unsupported feature: Property Modification (Attributes) on "InitQtyToReceive2(PROCEDURE 57)".


    //Unsupported feature: Property Modification (Attributes) on "ClearQtyIfBlank(PROCEDURE 88)".


    //Unsupported feature: Property Modification (Attributes) on "ShowLineComments(PROCEDURE 62)".


    //Unsupported feature: Property Modification (Attributes) on "SetDefaultQuantity(PROCEDURE 63)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePrePaymentAmounts(PROCEDURE 65)".


    //Unsupported feature: Property Modification (Attributes) on "SetVendorItemNo(PROCEDURE 64)".


    //Unsupported feature: Property Modification (Attributes) on "ZeroAmountLine(PROCEDURE 66)".


    //Unsupported feature: Property Modification (Attributes) on "FilterLinesWithItemToPlan(PROCEDURE 70)".


    //Unsupported feature: Property Modification (Attributes) on "FindLinesWithItemToPlan(PROCEDURE 68)".


    //Unsupported feature: Property Modification (Attributes) on "LinesWithItemToPlanExist(PROCEDURE 67)".


    //Unsupported feature: Property Modification (Attributes) on "GetVPGInvRoundAcc(PROCEDURE 72)".


    //Unsupported feature: Property Modification (Attributes) on "IsReceivedShippedItemDimChanged(PROCEDURE 89)".


    //Unsupported feature: Property Modification (Attributes) on "ConfirmReceivedShippedItemDimChange(PROCEDURE 90)".


    //Unsupported feature: Property Modification (Attributes) on "InitType(PROCEDURE 22)".


    //Unsupported feature: Property Modification (Attributes) on "CalcSalesTaxLines(PROCEDURE 1020000)".



    //Unsupported feature: Code Modification on "CalcSalesTaxLines(PROCEDURE 1020000)".

    //procedure CalcSalesTaxLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if PurchHeader."Tax Area Code" = '' then
      exit;
    TaxArea.Get(PurchHeader."Tax Area Code");
    SalesTaxCalculate.StartSalesTaxCalculation; // clear temp table

    if TaxArea."Use External Tax Engine" then
      SalesTaxCalculate.CallExternalTaxEngineForPurch(PurchHeader,true)
    else begin
      with PurchLine do begin
        SetRange("Document Type",PurchHeader."Document Type");
        SetRange("Document No.",PurchHeader."No.");
    #12..16
          until Next = 0;
      end;
      SalesTaxCalculate.EndSalesTaxCalculation(PurchHeader."Posting Date");
    end;
    PurchLine2.CopyFilters(PurchLine);
    SalesTaxCalculate.DistTaxOverPurchLines(PurchLine);
    PurchLine.CopyFilters(PurchLine2);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // NA0007.begin
    #1..3
    // NA0007.end
    //NA0002.begin
    SalesTaxCalculate.StartSalesTaxCalculation; // clear temp table

    // NA0007.begin
    #6..8
      // NA0007.end
    #9..19
    end;  // NA0007
    #21..23
    //NA0002.end
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "TestExpenseCapitalize(PROCEDURE 1020001)".



    //Unsupported feature: Code Modification on "TestExpenseCapitalize(PROCEDURE 1020001)".

    //procedure TestExpenseCapitalize();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if not "Use Tax" then
      exit;
    TaxAreaLine.SetCurrentKey("Tax Area","Calculation Order");
    TaxAreaLine.SetRange("Tax Area","Tax Area Code");
    if TaxAreaLine.Find('-') then
    #6..21
            Error(Text1020000,FieldCaption("Use Tax"),TaxDetail.TableCaption,
              TaxAreaLine."Tax Jurisdiction Code","Tax Group Code");
      until TaxAreaLine.Next = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*

    if not "Use Tax" then
      exit;

    #3..24
    //NA0002.end
    */
    //end;


    //Unsupported feature: Code Modification on "CheckForTaxDifferences(PROCEDURE 1020002)".

    //procedure CheckForTaxDifferences();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if "Tax Area Code" = '' then
      exit;

    #4..9
      else
        Error(Text1020000);
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //NA0002.begin
    #1..12
    //NA0002.end
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "CheckLocationOnWMS(PROCEDURE 79)".


    //Unsupported feature: Property Modification (Attributes) on "IsNonInventoriableItem(PROCEDURE 175)".


    //Unsupported feature: Property Modification (Attributes) on "IsInventoriableItem(PROCEDURE 139)".


    //Unsupported feature: Property Modification (Attributes) on "CalcAmountIncludingTax(PROCEDURE 1020003)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateLineDiscountPercent(PROCEDURE 160)".


    //Unsupported feature: Property Modification (Attributes) on "HasTypeToFillMandatoryFields(PROCEDURE 103)".


    //Unsupported feature: Property Modification (Attributes) on "GetDeferralAmount(PROCEDURE 105)".


    //Unsupported feature: Property Modification (Attributes) on "DefaultDeferralCode(PROCEDURE 110)".


    //Unsupported feature: Property Modification (Attributes) on "IsCreditDocType(PROCEDURE 83)".


    //Unsupported feature: Property Modification (Attributes) on "IsInvoiceDocType(PROCEDURE 91)".


    //Unsupported feature: Property Modification (Attributes) on "CanEditUnitOfMeasureCode(PROCEDURE 115)".


    //Unsupported feature: Property Modification (Attributes) on "TestItemFields(PROCEDURE 93)".


    //Unsupported feature: Property Modification (Attributes) on "RecalculateTaxes(PROCEDURE 1020004)".


    //Unsupported feature: Property Modification (Attributes) on "ClearPurchaseHeader(PROCEDURE 120)".


    //Unsupported feature: Property Modification (Attributes) on "FormatType(PROCEDURE 149)".


    //Unsupported feature: Property Modification (Attributes) on "RenameNo(PROCEDURE 133)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignFieldsForNo(PROCEDURE 122)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignHeaderValues(PROCEDURE 134)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignStdTxtValues(PROCEDURE 135)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignGLAccountValues(PROCEDURE 138)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignItemValues(PROCEDURE 136)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignItemChargeValues(PROCEDURE 137)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignFixedAssetValues(PROCEDURE 140)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAssignItemUOM(PROCEDURE 118)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetItem(PROCEDURE 165)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetPurchHeader(PROCEDURE 159)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterFilterLinesWithItemToPlan(PROCEDURE 217)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateDirectUnitCost(PROCEDURE 126)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdateDirectUnitCost(PROCEDURE 127)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeVerifyReservedQty(PROCEDURE 113)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitHeaderDefaults(PROCEDURE 125)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitOutstandingQty(PROCEDURE 142)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitOutstandingAmount(PROCEDURE 109)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitQtyToInvoice(PROCEDURE 128)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitQtyToShip(PROCEDURE 129)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitQtyToReceive(PROCEDURE 130)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSetDefaultQuantity(PROCEDURE 150)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCalcVATAmountLines(PROCEDURE 170)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateDimTableIDs(PROCEDURE 131)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetLineAmountToHandle(PROCEDURE 164)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterTestStatusOpen(PROCEDURE 174)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateAmounts(PROCEDURE 121)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateAmountsDone(PROCEDURE 87)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateUnitCost(PROCEDURE 98)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateJobPrices(PROCEDURE 106)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateWithWarehouseReceive(PROCEDURE 124)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateVATAmounts(PROCEDURE 331)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateVATOnLines(PROCEDURE 162)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateTotalAmounts(PROCEDURE 77)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCopyFromItem(PROCEDURE 167)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeBlanketOrderLookup(PROCEDURE 161)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCalcInvDiscToInvoice(PROCEDURE 31)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCalcVATAmountLines(PROCEDURE 153)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCreateTempJobJnlLine(PROCEDURE 169)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeJobTaskIsSet(PROCEDURE 111)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeOpenItemTrackingLines(PROCEDURE 158)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeTestStatusOpen(PROCEDURE 172)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdateVATAmounts(PROCEDURE 154)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateTempJobJnlLine(PROCEDURE 114)".


    //Unsupported feature: Property Modification (Attributes) on "OnUpdateDirectUnitCostOnBeforeFindPrice(PROCEDURE 146)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateCrossReferenceNoOnBeforeAssignNo(PROCEDURE 151)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateTypeOnCopyFromTempPurchLine(PROCEDURE 147)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateNoOnCopyFromTempPurchLine(PROCEDURE 148)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateNoOnAfterAssignQtyFromXRec(PROCEDURE 144)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateNoOnAfterChecks(PROCEDURE 155)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateNoOnAfterVerifyChange(PROCEDURE 141)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateNoOnBeforeInitRec(PROCEDURE 143)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateQtyToReceiveOnAfterCheck(PROCEDURE 152)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateQuantityOnBeforeDropShptCheck(PROCEDURE 157)".


    //Unsupported feature: Property Modification (Attributes) on "AssignedItemCharge(PROCEDURE 119)".



    //Unsupported feature: Property Modification (TextConstString) on "Text050(Variable 1086)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text050 : ENU=Canceled.;ESM=Cancelado.;FRC=Annulé.;ENC=Cancelled.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text050 : ENU=Cancelled.;ESM=Cancelado.;FRC=Annulé.;ENC=Cancelled.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text1020002(Variable 1020002)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1020002 : ENU=Operation canceled to preserve Tax Differences.;ESM=Operación cancel. para conservar imptos. anticip.;FRC=Opération annulée pour conserver les différences liées aux taxes.;ENC=Operation cancelled to preserve Tax Differences.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1020002 : ENU=Operation cancelled to preserve Tax Differences.;ESM=Operación cancel. para conservar imptos. anticip.;FRC=Opération annulée pour conserver les différences liées aux taxes.;ENC=Operation cancelled to preserve Tax Differences.;
    //Variable type has not been exported.
}

