tableextension 50009 tableextension70000319 extends "Purchase Header"
{
    // <changelog>
    //   <add id="NA0000" dev="ELYNCH" date="2006-03-24" area="1099" feature="601"
    //     releaseversion="NAVUS3.70.00.27">Added field 10020</add>
    //   <change id="NA0001" dev="ELYNCH" date="2006-03-30" area="NASALESTAX" feature="617"
    //     releaseversion="NAVUS3.70.00.27">code for NA Sales Tax</change>
    //   <change id="NA0002" dev="ELYNCH" date="2006-04-11" area="NA ADDRESS" feature="293"
    //     baseversion="NAVUS3.70.00.27" releaseversion="NAVNA5.00">Populate State field (County) from ZIP code table
    //     </change>
    //   <change id="NA0003" dev="JNOZZI" date="2006-08-14" area="NASALESTAX"  request="1087"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA5.00">Only update Tax Area Code from Location Card if Location
    //     allows it.</change>
    //   <change id="NA0004" dev="JNOZZI" date="2007-09-04" area="NASALESTAX"  request="24744"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA5.00.00.01">Canadian Sales Tax changes - Added field 10017
    //     Updated Defaults for Tax Area Code to use the new Vendor Location table, or alternatively, use the Vendor Card (based on
    //     the Purchases and Payables Setup).</change>
    //   <change id="NA0005" dev="JNOZZI" date="2007-12-19" area="NASALESTAX" feature="31197"
    //     baseversion="NAVNA5.00.00.01" releaseversion="NAVNA5.00.01">Add &quot;STE Transaction ID&quot; for Sales Tax
    //     Engine.</change>
    //   <change id="NA0006" dev="JMALIK" date="2008-01-18" area="NASALESTAX" feature="31623"
    //     baseversion="NAVNA5.00.01" releaseversion="NAVNA5.00.01">Fix Prepayments - added a new boolean field 12600
    //     &quot;Prepmt. Include Tax&quot; in the table.</change>
    //   <change id="NA0007" dev="ALL-E" date="2010-08-30" area="NASALESTAX" feature="VSTF219032"
    //     baseversion="NA5.00.01" releaseversion="NA7.00"> Tax Liable on the Purchase line
    //     is no longer updated automatically with 2009 SP1 when the header field is changed </change>
    // </changelog>
    fields
    {
        modify("Pay-to Vendor No.")
        {
            Caption = 'Pay-to Vendor No.';
        }
        modify("Pay-to Name")
        {
            Caption = 'Pay-to Name';
        }
        modify("Pay-to Name 2")
        {
            Caption = 'Pay-to Name 2';
        }
        modify("Pay-to Address")
        {
            Caption = 'Pay-to Address';
        }
        modify("Pay-to Address 2")
        {
            Caption = 'Pay-to Address 2';
        }
        modify("Pay-to City")
        {
            Caption = 'Pay-to City';
        }
        modify("Pay-to Contact")
        {
            Caption = 'Pay-to Contact';
        }
        modify("Amount Including VAT")
        {
            Caption = 'Amount Including VAT';
        }
        modify("VAT Registration No.")
        {
            Caption = 'VAT Registration No.';
        }
        modify("Pay-to Post Code")
        {
            Caption = 'Pay-to Post Code';
        }
        modify("Pay-to County")
        {
            Caption = 'Pay-to County';
        }
        modify("Pay-to Country/Region Code")
        {
            Caption = 'Pay-to Country/Region Code';
        }
        modify("Buy-from Post Code")
        {
            Caption = 'Buy-from Post Code';
        }
        modify("Buy-from County")
        {
            Caption = 'Buy-from County';
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
        modify("Pay-to IC Partner Code")
        {
            Caption = 'Pay-to IC Partner Code';
        }


        //Unsupported feature: Code Modification on ""Buy-from Vendor No."(Field 2).OnValidate".

        //trigger "(Field 2)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "No." = '' then
          InitRecord;
        TestStatusOpen;
        #4..25

        GetVend("Buy-from Vendor No.");
        Vend.CheckBlockedVendOnDocs(Vend,false);
        GLSetup.Get;
        if GLSetup."VAT in Use" then
          Vend.TestField("Gen. Bus. Posting Group");
        OnAfterCheckBuyFromVendor(Rec,xRec,Vend);

        "Buy-from Vendor Name" := Vend.Name;
        "Buy-from Vendor Name 2" := Vend."Name 2";
        #36..93

        if (xRec."Buy-from Vendor No." <> '') and (xRec."Buy-from Vendor No." <> "Buy-from Vendor No.") then
          RecallModifyAddressNotification(GetModifyVendorAddressNotificationId);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..28
        //NA0002.begin
        #29..31


        OnAfterCheckBuyFromVendor(Rec,xRec,Vend);

        #33..96
        */
        //end;


        //Unsupported feature: Code Modification on ""Pay-to Vendor No."(Field 4).OnValidate".

        //trigger "(Field 4)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        if (xRec."Pay-to Vendor No." <> "Pay-to Vendor No.") and
           (xRec."Pay-to Vendor No." <> '')
        #4..53
        "Currency Code" := Vend."Currency Code";
        "Invoice Disc. Code" := Vend."Invoice Disc. Code";
        "Language Code" := Vend."Language Code";
        SetPurchaserCode(Vend."Purchaser Code","Purchaser Code");
        "IRS 1099 Code" := Vend."IRS 1099 Code";
        Validate("Payment Terms Code");
        Validate("Prepmt. Payment Terms Code");
        Validate("Payment Method Code");
        #62..91

        if (xRec."Pay-to Vendor No." <> '') and (xRec."Pay-to Vendor No." <> "Pay-to Vendor No.") then
          RecallModifyAddressNotification(GetModifyPayToVendorAddressNotificationId);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..56

        SetPurchaserCode(Vend."Purchaser Code","Purchaser Code");

        "IRS 1099 Code" := Vend."IRS 1099 Code";
        //NA0001.end
        #59..94
        */
        //end;


        //Unsupported feature: Code Modification on ""Location Code"(Field 28).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        if ("Location Code" <> xRec."Location Code") and
           (xRec."Buy-from Vendor No." = "Buy-from Vendor No.")
        then
          MessageIfPurchLinesExist(FieldCaption("Location Code"));

        UpdateShipToAddress;

        PurchSetup.Get;
        if PurchSetup."Use Vendor's Tax Area Code" then begin
          if "Buy-from Vendor No." <> Vend."No." then
        #12..16
        else
          if not VendorLocation.Get("Buy-from Vendor No.","Location Code") then
            VendorLocation."Business Presence" := true;
        if "Location Code" = '' then begin
          if InvtSetup.Get then
            "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
          CompanyInfo.Get;
          if PurchSetup."Use Vendor's Tax Area Code" and ("Tax Area Code" <> '') then begin
            Validate("Tax Area Code");
            VendorLocation."Business Presence" := true;
        #27..32
            "Provincial Tax Area Code" := CompanyInfo."Provincial Tax Area Code"
          else
            "Provincial Tax Area Code" := '';
          Validate("Tax Exemption No.",CompanyInfo."Tax Exemption No.");
        end else begin
          if Location.Get("Location Code") then begin
            "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";
            if Location."Do Not Use For Tax Calculation" then begin
              CompanyInfo.Get;
              Location."Tax Area Code" := CompanyInfo."Tax Area Code";
              Location."Tax Exemption No." := CompanyInfo."Tax Exemption No.";
              Location."Provincial Tax Area Code" := CompanyInfo."Provincial Tax Area Code";
            end;
            if PurchSetup."Use Vendor's Tax Area Code" and ("Tax Area Code" <> '') then begin
              Validate("Tax Area Code");
              VendorLocation."Business Presence" := true;
        #49..54
              "Provincial Tax Area Code" := Location."Provincial Tax Area Code"
            else
              "Provincial Tax Area Code" := '';
            Validate("Tax Exemption No.",Location."Tax Exemption No.");
          end;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..8
        // NA0004.begin
        #9..19
        // NA0004.end
        #20..22
          //NA0002.begin
          CompanyInfo.Get;
          // NA0004.begin
          // VALIDATE("Tax Area Code", CompanyInfo."Tax Area Code");
          // NA0004.end
          // NA0004.begin
        #24..35
          // NA0004.end
        #36..39
            // NA0003.begin
        #40..43
              Location."Provincial Tax Area Code" := CompanyInfo."Provincial Tax Area Code"; // NA0004
            end;
            // NA0003.end
            // NA0004.begin
            // VALIDATE("Tax Area Code", Location."Tax Area Code");
            // NA0004.end
            // NA0004.begin
        #46..57
            // NA0004.end
            Validate("Tax Exemption No.",Location."Tax Exemption No.");
          end;
          //NA0002.end
        end;
        */
        //end;


        //Unsupported feature: Code Modification on ""Pay-to Country/Region Code"(Field 87).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ModifyPayToVendorAddress;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*

        ModifyPayToVendorAddress;
        */
        //end;


        //Unsupported feature: Code Modification on ""Buy-from Country/Region Code"(Field 90).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        UpdatePayToAddressFromBuyFromAddress(FieldNo("Pay-to Country/Region Code"));
        ModifyVendorAddress;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*

        UpdatePayToAddressFromBuyFromAddress(FieldNo("Pay-to Country/Region Code"));
        ModifyVendorAddress;
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
            "Ship-to City" := '';
         "Ship-to Post Code" := '';
         "Ship-to County" := '';
        end;
        */
        //end;


        //Unsupported feature: Code Modification on ""Tax Area Code"(Field 114).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        UpdatePurchLinesByFieldNo(FieldNo("Tax Area Code"),CurrFieldNo <> 0);
        if "Tax Area Code" = '' then
          Clear(TaxArea)
        else
          TaxArea.Get("Tax Area Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*

        TestStatusOpen;
        UpdatePurchLinesByFieldNo(FieldNo("Tax Area Code"),CurrFieldNo <> 0);

        #3..6
        // NA0004.end
        */
        //end;


        //Unsupported feature: Code Modification on ""Tax Liable"(Field 115).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        UpdatePurchLinesByFieldNo(FieldNo("Tax Liable"),CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*

        TestStatusOpen;
        UpdatePurchLinesByFieldNo(FieldNo("Tax Liable"),CurrFieldNo <> 0);
        */
        //end;


        //Unsupported feature: Code Modification on ""Responsibility Center"(Field 5700).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        if not UserSetupMgt.CheckRespCenter(1,"Responsibility Center") then
          Error(
            Text028,
            RespCenter.TableCaption,UserSetupMgt.GetPurchasesFilter);

        Validate("Location Code",UserSetupMgt.GetLocation(1,'',"Responsibility Center"));

        CreateDim(
          DATABASE::"Responsibility Center","Responsibility Center",
        #11..15
          RecreatePurchLines(FieldCaption("Responsibility Center"));
          "Assigned User ID" := '';
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..6
        // NA0004.begin
        // "Location Code" := UserSetupMgt.GetLocation(1,'',"Responsibility Center");
        // IF "Location Code" = '' THEN BEGIN
        // IF InvtSetup.GET THEN
        // "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
        // END ELSE BEGIN
        // IF Location.GET("Location Code") THEN;
        // "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";
        // END;
        //
        // UpdateShipToAddress;
        // NA0004.end
        // NA0004.begin
        Validate("Location Code",UserSetupMgt.GetLocation(1,'',"Responsibility Center"));
        // NA0004.end
        #8..18
        */
        //end;


        //Unsupported feature: Code Modification on ""Provincial Tax Area Code"(Field 10017).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if (CurrFieldNo = FieldNo("Provincial Tax Area Code")) and
           (xRec."Provincial Tax Area Code" = '') and
           ("Provincial Tax Area Code" <> '')
        #4..17
            if not Confirm(USText001,false,FieldCaption("Provincial Tax Area Code")) then
              Error('');
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // NA0004.begin
        #1..20
        // NA0004.end
        */
        //end;

        //Unsupported feature: Deletion on ""Prepmt. Include Tax"(Field 12600).OnValidate".

    }


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if not UserSetupMgt.CheckRespCenter(1,"Responsibility Center") then
      Error(
        Text023,
        RespCenter.TableCaption,UserSetupMgt.GetPurchasesFilter);

    ArchiveManagement.AutoArchivePurchDocument(Rec);
    PostPurchDelete.DeleteHeader(
      Rec,PurchRcptHeader,PurchInvHeader,PurchCrMemoHeader,
      ReturnShptHeader,PurchInvHeaderPrepmt,PurchCrMemoHeaderPrepmt);
    Validate("Applies-to ID",'');
    Validate("Incoming Document Entry No.",0);

    ApprovalsMgmt.OnDeleteRecordInApprovalRequest(RecordId);
    PurchLine.LockTable;

    WhseRequest.SetRange("Source Type",DATABASE::"Purchase Line");
    WhseRequest.SetRange("Source Subtype","Document Type");
    WhseRequest.SetRange("Source No.","No.");
    WhseRequest.DeleteAll(true);

    PurchLine.SetRange("Document Type","Document Type");
    PurchLine.SetRange("Document No.","No.");
    PurchLine.SetRange(Type,PurchLine.Type::"Charge (Item)");
    DeletePurchaseLines;
    PurchLine.SetRange(Type);
    DeletePurchaseLines;

    PurchCommentLine.SetRange("Document Type","Document Type");
    PurchCommentLine.SetRange("No.","No.");
    PurchCommentLine.DeleteAll;

    if "Tax Area Code" <> '' then begin
      SalesTaxDifference.Reset;
      SalesTaxDifference.SetRange("Document Product Area",SalesTaxDifference."Document Product Area"::Purchase);
      SalesTaxDifference.SetRange("Document Type","Document Type");
      SalesTaxDifference.SetRange("Document No.","No.");
      SalesTaxDifference.DeleteAll;
    end;

    if (PurchRcptHeader."No." <> '') or
       (PurchInvHeader."No." <> '') or
       (PurchCrMemoHeader."No." <> '') or
       (ReturnShptHeader."No." <> '') or
       (PurchInvHeaderPrepmt."No." <> '') or
       (PurchCrMemoHeaderPrepmt."No." <> '')
    then
      Message(PostedDocsToPrintCreatedMsg);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //The code has been merged but contained errors that could prevent import
    //and the code has been put in comments. Use Shift+Ctrl+O to Uncomment
    //IF NOT UserSetupMgt.CheckRespCenter(1,"Responsibility Center") THEN
    //  ERROR(
    //    Text023,
    //    RespCenter.TABLECAPTION,UserSetupMgt.GetPurchasesFilter);
    //
    //ArchiveManagement.AutoArchivePurchDocument(Rec);
    //PostPurchDelete.DeleteHeader(
    //  Rec,PurchRcptHeader,PurchInvHeader,PurchCrMemoHeader,
    //  ReturnShptHeader,PurchInvHeaderPrepmt,PurchCrMemoHeaderPrepmt);
    //VALIDATE("Applies-to ID",'');
    //VALIDATE("Incoming Document Entry No.",0);
    //
    //ApprovalsMgmt.OnDeleteRecordInApprovalRequest(RECORDID);
    //PurchLine.LOCKTABLE;
    //
    //WhseRequest.SETRANGE("Source Type",DATABASE::"Purchase Line");
    //WhseRequest.SETRANGE("Source Subtype","Document Type");
    //WhseRequest.SETRANGE("Source No.","No.");
    //WhseRequest.DELETEALL(TRUE);
    //
    //PurchLine.SETRANGE("Document Type","Document Type");
    //PurchLine.SETRANGE("Document No.","No.");
    //PurchLine.SETRANGE(Type,PurchLine.Type::"Charge (Item)");
    //DeletePurchaseLines;
    //PurchLine.SETRANGE(Type);
    //DeletePurchaseLines;
    //
    //PurchCommentLine.SETRANGE("Document Type","Document Type");
    //PurchCommentLine.SETRANGE("No.","No.");
    //PurchCommentLine.DELETEALL;
    //
    //IF "Tax Area Code" <> '' THEN BEGIN
    //  SalesTaxDifference.RESET;
    //  SalesTaxDifference.SETRANGE("Document Product Area",SalesTaxDifference."Document Product Area"::Purchase);
    //  SalesTaxDifference.SETRANGE("Document Type","Document Type");
    //  SalesTaxDifference.SETRANGE("Document No.","No.");
    //  SalesTaxDifference.DELETEALL;
    //END;
    //
    //IF (PurchRcptHeader."No." <> '') OR
    //   (PurchInvHeader."No." <> '') OR
    //   (PurchCrMemoHeader."No." <> '') OR
    //   (ReturnShptHeader."No." <> '') OR
    //   (PurchInvHeaderPrepmt."No." <> '') OR
    //   (PurchCrMemoHeaderPrepmt."No." <> '')


    //THEN
    //  MESSAGE(PostedDocsToPrintCreatedMsg);
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "InitInsert(PROCEDURE 41)".


    //Unsupported feature: Property Modification (Attributes) on "InitRecord(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "AssistEdit(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "TestNoSeries(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "GetNoSeriesCode(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "ConfirmDeletion(PROCEDURE 11)".



    //Unsupported feature: Code Modification on "ConfirmDeletion(PROCEDURE 11)".

    //procedure ConfirmDeletion();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SourceCodeSetup.Get;
    SourceCodeSetup.TestField("Deleted Document");
    SourceCode.Get(SourceCodeSetup."Deleted Document");
    #4..18
      if not ConfirmManagement.ConfirmProcess(StrSubstNo(Text029,ReturnShptHeader."No."),true) then
        exit;
    if "Prepayment No." <> '' then
      if not ConfirmManagement.ConfirmProcess(StrSubstNo(Text045,PurchInvHeaderPrepmt."No."),true) then
        exit;
    if "Prepmt. Cr. Memo No." <> '' then
      if not ConfirmManagement.ConfirmProcess(StrSubstNo(Text046,PurchCrMemoHeaderPrepmt."No."),true) then
        exit;
    exit(true);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..21


      if not ConfirmManagement.ConfirmProcess(StrSubstNo(Text045,PurchInvHeaderPrepmt."No."),true) then

        exit;
    if "Prepmt. Cr. Memo No." <> '' then



      if not ConfirmManagement.ConfirmProcess(StrSubstNo(Text046,PurchCrMemoHeaderPrepmt."No."),true) then

        exit;
    exit(true);
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "PurchLinesExist(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "TransferSavedFieldsDropShipment(PROCEDURE 79)".

    //procedure TransferSavedFieldsDropShipment();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesLine.Get(SalesLine."Document Type"::Order,
      SourcePurchaseLine."Sales Order No.",
      SourcePurchaseLine."Sales Order Line No.");
    #4..11
    SalesLine."Purchase Order No." := DestinationPurchaseLine."Document No.";
    SalesLine."Purch. Order Line No." := DestinationPurchaseLine."Line No.";
    SalesLine.Modify;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*

    #1..14
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "MessageIfPurchLinesExist(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "PriceMessageIfPurchLinesExist(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateCurrencyFactor(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "GetHideValidationDialog(PROCEDURE 100)".


    //Unsupported feature: Property Modification (Attributes) on "SetHideValidationDialog(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePurchLines(PROCEDURE 15)".



    //Unsupported feature: Code Modification on "UpdatePurchLines(PROCEDURE 15)".

    //procedure UpdatePurchLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Field.SetRange(TableNo,DATABASE::"Purchase Header");
    Field.SetRange("Field Caption",ChangedFieldName);
    Field.SetFilter(ObsoleteState,'<>%1',Field.ObsoleteState::Removed);
    Field.Find('-');
    if Field.Next <> 0 then
      Error(DuplicatedCaptionsNotAllowedErr);
    UpdatePurchLinesByFieldNo(Field."No.",AskQuestion);

    OnAfterUpdatePurchLines(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8

    //{=======} MODIFIED
    {*IF AskQuestion THEN BEGIN
      Question := STRSUBSTNO(
          Text032 +
          Text033,ChangedFieldName);
      IF GUIALLOWED THEN
        IF DIALOG.CONFIRM(Question,TRUE) THEN
          CASE ChangedFieldName OF
            FIELDCAPTION("Expected Receipt Date"),
            FIELDCAPTION("Requested Receipt Date"),
            FIELDCAPTION("Promised Receipt Date"),
            FIELDCAPTION("Lead Time Calculation"),
            FIELDCAPTION("Inbound Whse. Handling Time"):
              ConfirmResvDateConflict;
          END
        ELSE
          EXIT;
    END;

    PurchLine.LOCKTABLE;
    MODIFY;


    PurchLine.RESET;
    PurchLine.SETRANGE("Document Type","Document Type");
    PurchLine.SETRANGE("Document No.","No.");
    IF PurchLine.FINDSET THEN
      REPEAT
        xPurchLine := PurchLine;
        CASE ChangedFieldName OF
          FIELDCAPTION("Expected Receipt Date"):
            IF PurchLine."No." <> '' THEN
              PurchLine.VALIDATE("Expected Receipt Date","Expected Receipt Date");
          FIELDCAPTION("Currency Factor"):
            IF PurchLine.Type <> PurchLine.Type::" " THEN
              PurchLine.VALIDATE("Direct Unit Cost");
          FIELDCAPTION("Transaction Type"):
            PurchLine.VALIDATE("Transaction Type","Transaction Type");
          FIELDCAPTION("Transport Method"):
            PurchLine.VALIDATE("Transport Method","Transport Method");
          FIELDCAPTION("Entry Point"):
            PurchLine.VALIDATE("Entry Point","Entry Point");
          FIELDCAPTION(Area):
            PurchLine.VALIDATE(Area,Area);
          FIELDCAPTION("Transaction Specification"):
            PurchLine.VALIDATE("Transaction Specification","Transaction Specification");
          FIELDCAPTION("Requested Receipt Date"):
            IF PurchLine."No." <> '' THEN
              PurchLine.VALIDATE("Requested Receipt Date","Requested Receipt Date");
          FIELDCAPTION("Prepayment %"):
            IF PurchLine."No." <> '' THEN
              PurchLine.VALIDATE("Prepayment %","Prepayment %");
          FIELDCAPTION("Promised Receipt Date"):
            IF PurchLine."No." <> '' THEN
              PurchLine.VALIDATE("Promised Receipt Date","Promised Receipt Date");
          FIELDCAPTION("Lead Time Calculation"):
            IF PurchLine."No." <> '' THEN
              PurchLine.VALIDATE("Lead Time Calculation","Lead Time Calculation");
          FIELDCAPTION("Inbound Whse. Handling Time"):
            IF PurchLine."No." <> '' THEN
              PurchLine.VALIDATE("Inbound Whse. Handling Time","Inbound Whse. Handling Time");
          PurchLine.FIELDCAPTION("Deferral Code"):
            IF PurchLine."No." <> '' THEN
              PurchLine.VALIDATE("Deferral Code");
          FIELDCAPTION("Tax Liable"):
            IF PurchLine.Type <> PurchLine.Type::" " THEN
              PurchLine.VALIDATE("Use Tax");
          FIELDCAPTION("Tax Area Code"):
            IF PurchLine.Type <> PurchLine.Type::" " THEN
              PurchLine.VALIDATE("Tax Area Code","Tax Area Code");
          ELSE
            OnUpdatePurchLinesByChangedFieldName(Rec,PurchLine,ChangedFieldName);
        END;
        PurchLine.MODIFY(TRUE);
        PurchLineReserve.VerifyChange(PurchLine,xPurchLine);
      UNTIL PurchLine.NEXT = 0;*}

    OnAfterUpdatePurchLines(Rec);
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "UpdatePurchLinesByFieldNo(PROCEDURE 99)".


    //Unsupported feature: Property Modification (Attributes) on "CreateDim(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateShipToAddress(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "CreateInvtPutAwayPick(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDocDim(PROCEDURE 32)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateAllLineDim(PROCEDURE 34)".


    //Unsupported feature: Property Modification (Attributes) on "SetAmountToApply(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "SetShipToForSpecOrder(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "SetSecurityFilterOnRespCenter(PROCEDURE 43)".


    //Unsupported feature: Property Modification (Attributes) on "CalcInvDiscForHeader(PROCEDURE 45)".


    //Unsupported feature: Property Modification (Attributes) on "AddShipToAddress(PROCEDURE 46)".


    //Unsupported feature: Property Modification (Attributes) on "DropShptOrderExists(PROCEDURE 48)".


    //Unsupported feature: Property Modification (Attributes) on "SpecialOrderExists(PROCEDURE 81)".


    //Unsupported feature: Property Modification (Attributes) on "QtyToReceiveIsZero(PROCEDURE 30)".


    //Unsupported feature: Property Modification (Attributes) on "IsApprovedForPostingBatch(PROCEDURE 51)".


    //Unsupported feature: Property Modification (Attributes) on "IsTotalValid(PROCEDURE 36)".


    //Unsupported feature: Property Modification (Attributes) on "SendToPosting(PROCEDURE 57)".


    //Unsupported feature: Property Modification (Attributes) on "CancelBackgroundPosting(PROCEDURE 33)".


    //Unsupported feature: Property Modification (Attributes) on "AddSpecialOrderToAddress(PROCEDURE 80)".


    //Unsupported feature: Property Modification (Attributes) on "InvoicedLineExists(PROCEDURE 56)".


    //Unsupported feature: Property Modification (Attributes) on "CreateDimSetForPrepmtAccDefaultDim(PROCEDURE 44)".


    //Unsupported feature: Property Modification (Attributes) on "OpenPurchaseOrderStatistics(PROCEDURE 60)".


    //Unsupported feature: Property Modification (Attributes) on "GetCardpageID(PROCEDURE 58)".


    //Unsupported feature: Property Modification (Attributes) on "OnCheckPurchasePostRestrictions(PROCEDURE 54)".


    //Unsupported feature: Property Modification (Attributes) on "OnCheckPurchaseReleaseRestrictions(PROCEDURE 55)".


    //Unsupported feature: Property Modification (Attributes) on "CheckPurchaseReleaseRestrictions(PROCEDURE 105)".


    //Unsupported feature: Property Modification (Attributes) on "SetStatus(PROCEDURE 53)".


    //Unsupported feature: Property Modification (Attributes) on "TriggerOnAfterPostPurchaseDoc(PROCEDURE 116)".


    //Unsupported feature: Property Modification (Attributes) on "DeferralHeadersExist(PROCEDURE 38)".


    //Unsupported feature: Property Modification (Attributes) on "IsCreditDocType(PROCEDURE 110)".


    //Unsupported feature: Property Modification (Attributes) on "SetBuyFromVendorFromFilter(PROCEDURE 186)".


    //Unsupported feature: Property Modification (Attributes) on "CopyBuyFromVendorFilter(PROCEDURE 59)".


    //Unsupported feature: Property Modification (Attributes) on "HasBuyFromAddress(PROCEDURE 65)".


    //Unsupported feature: Property Modification (Attributes) on "HasShipToAddress(PROCEDURE 103)".


    //Unsupported feature: Property Modification (Attributes) on "HasPayToAddress(PROCEDURE 66)".


    //Unsupported feature: Property Modification (Attributes) on "SetShipToAddress(PROCEDURE 117)".


    //Unsupported feature: Property Modification (Attributes) on "ConfirmCloseUnposted(PROCEDURE 104)".


    //Unsupported feature: Property Modification (Attributes) on "InitFromPurchHeader(PROCEDURE 109)".


    //Unsupported feature: Property Modification (Attributes) on "SendRecords(PROCEDURE 75)".


    //Unsupported feature: Property Modification (Attributes) on "PrintRecords(PROCEDURE 74)".


    //Unsupported feature: Property Modification (Attributes) on "SendProfile(PROCEDURE 73)".


    //Unsupported feature: Property Modification (Attributes) on "RecalculateTaxesOnLines(PROCEDURE 1020001)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterValidateBuyFromVendorNo(PROCEDURE 77)".


    //Unsupported feature: Property Modification (Attributes) on "BatchConfirmUpdateDeferralDate(PROCEDURE 78)".


    //Unsupported feature: Property Modification (Attributes) on "SetAllowSelectNoSeries(PROCEDURE 86)".


    //Unsupported feature: Property Modification (Attributes) on "RecallModifyAddressNotification(PROCEDURE 148)".


    //Unsupported feature: Property Modification (Attributes) on "GetModifyVendorAddressNotificationId(PROCEDURE 193)".


    //Unsupported feature: Property Modification (Attributes) on "GetModifyPayToVendorAddressNotificationId(PROCEDURE 191)".


    //Unsupported feature: Property Modification (Attributes) on "GetShowExternalDocAlreadyExistNotificationId(PROCEDURE 92)".


    //Unsupported feature: Property Modification (Attributes) on "SetModifyVendorAddressNotificationDefaultState(PROCEDURE 196)".


    //Unsupported feature: Property Modification (Attributes) on "SetModifyPayToVendorAddressNotificationDefaultState(PROCEDURE 197)".


    //Unsupported feature: Property Modification (Attributes) on "SetShowExternalDocAlreadyExistNotificationDefaultState(PROCEDURE 87)".


    //Unsupported feature: Property Modification (Attributes) on "DontNotifyCurrentUserAgain(PROCEDURE 141)".


    //Unsupported feature: Property Modification (Attributes) on "FilterPartialReceived(PROCEDURE 108)".


    //Unsupported feature: Property Modification (Attributes) on "FilterPartialInvoiced(PROCEDURE 307)".


    //Unsupported feature: Property Modification (Attributes) on "ShipToAddressEqualsCompanyShipToAddress(PROCEDURE 111)".


    //Unsupported feature: Property Modification (Attributes) on "BuyFromAddressEqualsShipToAddress(PROCEDURE 94)".


    //Unsupported feature: Property Modification (Attributes) on "ValidatePurchaserOnPurchHeader(PROCEDURE 912)".


    //Unsupported feature: Property Modification (Attributes) on "TestStatusOpen(PROCEDURE 134)".


    //Unsupported feature: Property Modification (Attributes) on "SuspendStatusCheck(PROCEDURE 133)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitRecord(PROCEDURE 138)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitNoSeries(PROCEDURE 140)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterChangePricesIncludingVAT(PROCEDURE 187)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckBuyFromVendor(PROCEDURE 152)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterConfirmPurchPrice(PROCEDURE 166)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyBuyFromVendorFieldsFromVendor(PROCEDURE 114)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyBuyFromVendorAddressFieldsFromVendor(PROCEDURE 130)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyPayToVendorAddressFieldsFromVendor(PROCEDURE 132)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyShipToVendorAddressFieldsFromVendor(PROCEDURE 131)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterRecreatePurchLine(PROCEDURE 93)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterDeleteAllTempPurchLines(PROCEDURE 155)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetNoSeriesCode(PROCEDURE 107)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetPostingNoSeriesCode(PROCEDURE 175)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetPrepaymentPostingNoSeriesCode(PROCEDURE 178)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSetShipToForSpecOrder(PROCEDURE 129)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterTestNoSeries(PROCEDURE 136)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateBuyFromVend(PROCEDURE 128)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateBuyFromCont(PROCEDURE 143)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdatePayToCont(PROCEDURE 144)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateShipToAddress(PROCEDURE 137)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateCurrencyFactor(PROCEDURE 127)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAppliesToDocNoOnLookup(PROCEDURE 106)".


    //Unsupported feature: Property Modification (Attributes) on "OnUpdatePurchLinesByChangedFieldName(PROCEDURE 139)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateDimTableIDs(PROCEDURE 164)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterValidateShortcutDimCode(PROCEDURE 125)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterTransferExtendedTextForPurchaseLineRecreation(PROCEDURE 165)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidatePurchaseHeaderPayToVendorNo(PROCEDURE 1215)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInitRecord(PROCEDURE 151)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeIsCreditDocType(PROCEDURE 146)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeUpdateCurrencyFactor(PROCEDURE 95)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeRecreatePurchLines(PROCEDURE 199)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeSetSecurityFilterOnRespCenter(PROCEDURE 147)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeTestNoSeries(PROCEDURE 149)".


    //Unsupported feature: Property Modification (Attributes) on "OnRecreatePurchLinesOnAfterValidateType(PROCEDURE 344)".


    //Unsupported feature: Property Modification (Attributes) on "OnRecreatePurchLinesOnBeforeInsertPurchLine(PROCEDURE 112)".


    //Unsupported feature: Property Modification (Attributes) on "OnRecreatePurchLinesOnBeforeTempPurchLineInsert(PROCEDURE 118)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateBuyFromVendorNoBeforeRecreateLines(PROCEDURE 115)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeTestStatusOpen(PROCEDURE 135)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterTestStatusOpen(PROCEDURE 142)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdatePurchLines(PROCEDURE 145)".


    //Unsupported feature: Property Modification (Attributes) on "OnRecreatePurchLinesOnBeforeConfirm(PROCEDURE 211)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidatePaytoVendorNoBeforeRecreateLines(PROCEDURE 120)".



    //Unsupported feature: Property Modification (TextConstString) on "Text025(Variable 1024)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text025 : ENU="You have modified the %1 field. Note that the recalculation of Tax may cause penny differences, so you must check the amounts afterwards. ";ESM="Ha modificado el campo %1. El nuevo cálculo de IVA puede tener alguna diferencia, por lo que debería comprobar los importes. ";FRC="Vous avez modifié le champ %1. Notez que recalculer la TVA peut entraîner de petites différences, ";ENC="You have modified the %1 field. Note that the recalculation of Tax may cause penny differences, so you must check the amounts afterwards. ";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text025 : ENU="You have modified the %1 field. Note that the recalculation of VAT may cause penny differences, so you must check the amounts afterwards. ";ESM="Ha modificado el campo %1. El nuevo cálculo de IVA puede tener alguna diferencia, por lo que debería comprobar los importes. ";FRC="Vous avez modifié le champ %1. Notez que recalculer la TVA peut entraîner de petites différences, ";ENC="You have modified the %1 field. Note that the recalculation of Tax may cause penny differences, so you must check the amounts afterwards. ";
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "PurchQuoteDocTxt(Variable 1088)".

    //var
    //>>>> ORIGINAL VALUE:
    //PurchQuoteDocTxt : 1088;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PurchQuoteDocTxt : 10888;
    //Variable type has not been exported.

    var
        Text047: Label 'Deleting this document will cause a gap in the number series for prepayment credit memos. ';
}

