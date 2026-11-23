report 50077 "MER Sales Shipment"
{
    // <changelog>
    //   <add id="NA0000" dev="JNOZZI" date="2004-04-08" area="REPORTS SR" feature="622"
    //     releaseversion="NAVUS3.70">North American Sales Shipment Document</add>
    //   <change id="NA0001" dev="JNOZZI" date="2004-04-08" area="REPORTS SR" feature="622"
    //     baseversion="NAVUS3.70" releaseversion="NAVNA4.00">Minor cleanup.</change>
    //   <change id="NA0002" dev="JNOZZI" date="2006-05-10" area="BUG FIX"  request="16629"
    //     baseversion="NAVNA4.00" releaseversion="NAVNA4.00.03">Allow the printing of a blank &quot;voided&quot;
    //     invoice.</change>
    //   <change id="NA0004" dev="JNOZZI" date="2006-06-05" area="REPORTS SR" feature="337"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA5.00">Implement the W1 Logo Position functionality.</change>
    //   <change id="NA0005" dev="MBAHADUR" date="2007-12-10" area="REPORTS SR" feature="0003"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA5.00.01">modified sales comment line tableview property to
    //     support comment line feature.</change>
    //   <change id="NA0006" dev="V-WQIAN" date="2008-05-21" area="REPORTS SR" feature="NC14261"
    //     baseversion="NAVNA5.00.01" releaseversion="NAVNA6.00">Report Transformation - local Report Layout.</change>
    //   <change id="NA0007" dev="V-JOOSTL" date="2009-04-23" area="REPORTS SR"  request="PS37379"
    //     baseversion="NAVNA6.00" releaseversion="NAVNA6.00.01">If header comments exist, an extra blank page is printed
    //     before the document.</change>
    //   <add id="NA0008" dev="hhjort" date="2011-03-30" area="XX" feature="VSTFS260459"
    //     releaseversion="NAVNA7.00">Kitting Report transformation of Sales Invoice
    //     (order confirmation), sales shipment and posted sales invoice for NA (include
    //     Assembly info)</add>
    //   <change id="NA0009" dev="hhjort" date="2011-04-07" area="XX" feature="VSTFS256949"
    //     baseversion="NAVNA7.00" releaseversion="NAVNA7.00">Correction: Blanks should be Text, not C
    //    ode</change>
    // </changelog>
    DefaultLayout = RDLC;
    RDLCLayout = './MER Sales Shipment.rdlc';

    Caption = 'Sales Shipment';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.", "Bill-to Customer No.", "Ship-to Code", "No. Printed";
            RequestFilterHeading = 'Sales Shipment';
            column(No_SalesShptHeader; "No.")
            {
            }
            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");
                dataitem(SalesLineComments; "Sales Comment Line")
                {
                    DataItemLink = "No." = FIELD("Document No."), "Document Line No." = FIELD("Line No.");
                    DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST(Shipment), "Print On Shipment" = CONST(true));

                    trigger OnAfterGetRecord()
                    begin
                        //NA0005.begin
                        TempSalesShipmentLine.Init;
                        TempSalesShipmentLine."Document No." := "Sales Shipment Header"."No.";
                        TempSalesShipmentLine."Line No." := HighestLineNo + 10;
                        HighestLineNo := TempSalesShipmentLine."Line No.";
                        if StrLen(Comment) <= MaxStrLen(TempSalesShipmentLine.Description) then begin
                            TempSalesShipmentLine.Description := Comment;
                            TempSalesShipmentLine."Description 2" := '';
                        end else begin
                            SpacePointer := MaxStrLen(TempSalesShipmentLine.Description) + 1;
                            while (SpacePointer > 1) and (Comment[SpacePointer] <> ' ') do
                                SpacePointer := SpacePointer - 1;
                            if SpacePointer = 1 then
                                SpacePointer := MaxStrLen(TempSalesShipmentLine.Description) + 1;
                            TempSalesShipmentLine.Description := CopyStr(Comment, 1, SpacePointer - 1);
                            TempSalesShipmentLine."Description 2" :=
                              CopyStr(CopyStr(Comment, SpacePointer + 1), 1, MaxStrLen(TempSalesShipmentLine."Description 2"));
                        end;
                        TempSalesShipmentLine.Insert;
                        //NA0005.end
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    TempSalesShipmentLine := "Sales Shipment Line";
                    TempSalesShipmentLine.Insert;
                    // NA0008.begin
                    TempSalesShipmentLineAsm := "Sales Shipment Line";
                    TempSalesShipmentLineAsm.Insert;
                    // NA0008.end
                    HighestLineNo := "Line No.";
                end;

                trigger OnPreDataItem()
                begin
                    TempSalesShipmentLine.Reset;
                    TempSalesShipmentLine.DeleteAll;
                    // NA0008.begin
                    TempSalesShipmentLineAsm.Reset;
                    TempSalesShipmentLineAsm.DeleteAll;
                    // NA0008.end
                end;
            }
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST(Shipment), "Print On Shipment" = CONST(true), "Document Line No." = CONST(0));

                trigger OnAfterGetRecord()
                begin
                    TempSalesShipmentLine.Init;
                    TempSalesShipmentLine."Document No." := "Sales Shipment Header"."No.";
                    TempSalesShipmentLine."Line No." := HighestLineNo + 1000;
                    HighestLineNo := TempSalesShipmentLine."Line No.";
                    if StrLen(Comment) <= MaxStrLen(TempSalesShipmentLine.Description) then begin
                        TempSalesShipmentLine.Description := Comment;
                        TempSalesShipmentLine."Description 2" := '';
                    end else begin
                        SpacePointer := MaxStrLen(TempSalesShipmentLine.Description) + 1;
                        while (SpacePointer > 1) and (Comment[SpacePointer] <> ' ') do
                            SpacePointer := SpacePointer - 1;
                        if SpacePointer = 1 then
                            SpacePointer := MaxStrLen(TempSalesShipmentLine.Description) + 1;
                        TempSalesShipmentLine.Description := CopyStr(Comment, 1, SpacePointer - 1);
                        TempSalesShipmentLine."Description 2" :=
                          CopyStr(CopyStr(Comment, SpacePointer + 1), 1, MaxStrLen(TempSalesShipmentLine."Description 2"));
                    end;
                    TempSalesShipmentLine.Insert;
                end;

                trigger OnPreDataItem()
                begin
                    //NA0005.begin
                    TempSalesShipmentLine.Init;
                    TempSalesShipmentLine."Document No." := "Sales Shipment Header"."No.";
                    TempSalesShipmentLine."Line No." := HighestLineNo + 1000;
                    HighestLineNo := TempSalesShipmentLine."Line No.";
                    TempSalesShipmentLine.Insert;
                    //NA0005.end
                end;
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfoPicture; CompanyInfo3.Picture)
                    {
                    }
                    column(CompanyAddress1; CompanyAddress[1])
                    {
                    }
                    column(CompanyAddress2; CompanyAddress[2])
                    {
                    }
                    column(CompanyAddress3; CompanyAddress[3])
                    {
                    }
                    column(CompanyAddress4; CompanyAddress[4])
                    {
                    }
                    column(CompanyAddress5; CompanyAddress[5])
                    {
                    }
                    column(CompanyAddress6; CompanyAddress[6])
                    {
                    }
                    column(CopyTxt; CopyTxt)
                    {
                    }
                    column(BillToAddress1; BillToAddress[1])
                    {
                    }
                    column(BillToAddress2; BillToAddress[2])
                    {
                    }
                    column(BillToAddress3; BillToAddress[3])
                    {
                    }
                    column(BillToAddress4; BillToAddress[4])
                    {
                    }
                    column(BillToAddress5; BillToAddress[5])
                    {
                    }
                    column(BillToAddress6; BillToAddress[6])
                    {
                    }
                    column(BillToAddress7; BillToAddress[7])
                    {
                    }
                    column(ShipToAddress1; ShipToAddress[1])
                    {
                    }
                    column(ShipToAddress2; ShipToAddress[2])
                    {
                    }
                    column(ShipToAddress3; ShipToAddress[3])
                    {
                    }
                    column(ShipToAddress4; ShipToAddress[4])
                    {
                    }
                    column(ShipToAddress5; ShipToAddress[5])
                    {
                    }
                    column(ShipToAddress6; ShipToAddress[6])
                    {
                    }
                    column(ShipToAddress7; ShipToAddress[7])
                    {
                    }
                    column(BilltoCustNo_SalesShptHeader; "Sales Shipment Header"."Bill-to Customer No.")
                    {
                    }
                    column(YourRef_SalesShptHeader; "Sales Shipment Header"."Your Reference")
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(ShptDate_SalesShptHeader; "Sales Shipment Header"."Shipment Date")
                    {
                    }
                    column(CompanyAddress7; CompanyAddress[7])
                    {
                    }
                    column(CompanyAddress8; CompanyAddress[8])
                    {
                    }
                    column(BillToAddress8; BillToAddress[8])
                    {
                    }
                    column(ShipToAddress8; ShipToAddress[8])
                    {
                    }
                    column(ShipmentMethodDesc; ShipmentMethod.Description)
                    {
                    }
                    column(OrderDate_SalesShptHeader; "Sales Shipment Header"."Order Date")
                    {
                    }
                    column(OrderNo_SalesShptHeader; "Sales Shipment Header"."Order No.")
                    {
                    }
                    column(PackageTrackingNoText; PackageTrackingNoText)
                    {
                    }
                    column(ShippingAgentCodeText; ShippingAgentCodeText)
                    {
                    }
                    column(ShippingAgentCodeLabel; ShippingAgentCodeLabel)
                    {
                    }
                    column(PackageTrackingNoLabel; PackageTrackingNoLabel)
                    {
                    }
                    column(TaxRegNo; TaxRegNo)
                    {
                    }
                    column(TaxRegLabel; TaxRegLabel)
                    {
                    }
                    column(CopyNo; CopyNo)
                    {
                    }
                    column(PageLoopNumber; Number)
                    {
                    }
                    column(BillCaption; BillCaptionLbl)
                    {
                    }
                    column(ToCaption; ToCaptionLbl)
                    {
                    }
                    column(CustomerIDCaption; CustomerIDCaptionLbl)
                    {
                    }
                    column(PONumberCaption; PONumberCaptionLbl)
                    {
                    }
                    column(SalesPersonCaption; SalesPersonCaptionLbl)
                    {
                    }
                    column(ShipCaption; ShipCaptionLbl)
                    {
                    }
                    column(ShipmentCaption; ShipmentCaptionLbl)
                    {
                    }
                    column(ShipmentNumberCaption; ShipmentNumberCaptionLbl)
                    {
                    }
                    column(ShipmentDateCaption; ShipmentDateCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(ShipViaCaption; ShipViaCaptionLbl)
                    {
                    }
                    column(PODateCaption; PODateCaptionLbl)
                    {
                    }
                    column(OurOrderNoCaption; OurOrderNoCaptionLbl)
                    {
                    }
                    dataitem(SalesShptLine; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(SalesShptLineNumber; Number)
                        {
                        }
                        column(TempSalesShptLineNo; TempSalesShipmentLine."No.")
                        {
                        }
                        column(TempSalesShptLineUOM; TempSalesShipmentLine."Unit of Measure")
                        {
                        }
                        column(TempSalesShptLineQy; TempSalesShipmentLine.Quantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(OrderedQuantity; OrderedQuantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(BackOrderedQuantity; BackOrderedQuantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(TempSalesShptLineDesc; TempSalesShipmentLine.Description + ' ' + TempSalesShipmentLine."Description 2")
                        {
                        }
                        column(PackageTrackingText; PackageTrackingText)
                        {
                            // DecimalPlaces = 0:5;
                        }
                        column(AsmHeaderExists; AsmHeaderExists)
                        {
                        }
                        column(PrintFooter; PrintFooter)
                        {
                        }
                        column(ItemNoCaption; ItemNoCaptionLbl)
                        {
                        }
                        column(UnitCaption; UnitCaptionLbl)
                        {
                        }
                        column(DescriptionCaption; DescriptionCaptionLbl)
                        {
                        }
                        column(ShippedCaption; ShippedCaptionLbl)
                        {
                        }
                        column(OrderedCaption; OrderedCaptionLbl)
                        {
                        }
                        column(BackOrderedCaption; BackOrderedCaptionLbl)
                        {
                        }
                        dataitem(AsmLoop; "Integer")
                        {
                            DataItemTableView = SORTING(Number);
                            column(PostedAsmLineItemNo; BlanksForIndent + PostedAsmLine."No.")
                            {
                            }
                            column(PostedAsmLineDescription; BlanksForIndent + PostedAsmLine.Description)
                            {
                            }
                            column(PostedAsmLineQuantity; PostedAsmLine.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(PostedAsmLineUOMCode; GetUnitOfMeasureDescr(PostedAsmLine."Unit of Measure Code"))
                            {
                                /// DecimalPlaces = 0:5;
                            }

                            trigger OnAfterGetRecord()
                            begin
                                // NA0008.begin
                                if Number = 1 then
                                    PostedAsmLine.FindSet
                                else
                                    PostedAsmLine.Next;
                                // NA0008.end
                            end;

                            trigger OnPreDataItem()
                            begin
                                // NA0008.begin
                                if not DisplayAssemblyInformation then
                                    CurrReport.Break;
                                if not AsmHeaderExists then
                                    CurrReport.Break;
                                PostedAsmLine.SetRange("Document No.", PostedAsmHeader."No.");
                                SetRange(Number, 1, PostedAsmLine.Count);
                                // NA0008.end
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                            SalesShipmentLine: Record "Sales Shipment Line";
                        begin
                            OnLineNumber := OnLineNumber + 1;

                            if OnLineNumber = 1 then
                                TempSalesShipmentLine.Find('-')
                            else
                                TempSalesShipmentLine.Next;

                            OrderedQuantity := 0;
                            BackOrderedQuantity := 0;
                            if TempSalesShipmentLine."Order No." = '' then
                                OrderedQuantity := TempSalesShipmentLine.Quantity
                            else begin
                                if OrderLine.Get(1, TempSalesShipmentLine."Order No.", TempSalesShipmentLine."Order Line No.") then begin
                                    OrderedQuantity := OrderLine.Quantity;
                                    BackOrderedQuantity := OrderLine."Outstanding Quantity";
                                end else begin
                                    ReceiptLine.SetCurrentKey("Order No.", "Order Line No.");
                                    ReceiptLine.SetRange("Order No.", TempSalesShipmentLine."Order No.");
                                    ReceiptLine.SetRange("Order Line No.", TempSalesShipmentLine."Order Line No.");
                                    ReceiptLine.Find('-');
                                    repeat
                                        OrderedQuantity := OrderedQuantity + ReceiptLine.Quantity;
                                    until 0 = ReceiptLine.Next;
                                end;
                            end;

                            if TempSalesShipmentLine.Type = 0 then begin
                                OrderedQuantity := 0;
                                BackOrderedQuantity := 0;
                                TempSalesShipmentLine."No." := '';
                                TempSalesShipmentLine."Unit of Measure" := '';
                                TempSalesShipmentLine.Quantity := 0;
                            end else
                                if TempSalesShipmentLine.Type = TempSalesShipmentLine.Type::"G/L Account" then
                                    TempSalesShipmentLine."No." := '';

                            PackageTrackingText := '';
                            if (TempSalesShipmentLine."Package Tracking No." <> "Sales Shipment Header"."Package Tracking No.") and
                               (TempSalesShipmentLine."Package Tracking No." <> '') and PrintPackageTrackingNos
                            then
                                PackageTrackingText := Text002 + ' ' + TempSalesShipmentLine."Package Tracking No.";

                            // NA0008.begin
                            if DisplayAssemblyInformation then
                                if TempSalesShipmentLineAsm.Get(TempSalesShipmentLine."Document No.", TempSalesShipmentLine."Line No.") then begin
                                    SalesShipmentLine.Get(TempSalesShipmentLine."Document No.", TempSalesShipmentLine."Line No.");
                                    AsmHeaderExists := SalesShipmentLine.AsmToShipmentExists(PostedAsmHeader);
                                end;
                                // NA0008.end

                            //NA0006.begin
                            if OnLineNumber = NumberOfLines then
                                PrintFooter := true;
                            //NA0006.end
                        end;

                        trigger OnPreDataItem()
                        begin
                            NumberOfLines := TempSalesShipmentLine.Count;
                            SetRange(Number, 1, NumberOfLines);
                            OnLineNumber := 0;
                            PrintFooter := false;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    CurrReport.PageNo := 1;
                    if CopyNo = NoLoops then begin
                        if not CurrReport.Preview then
                            SalesShipmentPrinted.Run("Sales Shipment Header");
                        CurrReport.Break;
                    end;
                    CopyNo := CopyNo + 1;
                    if CopyNo = 1 then // Original
                        Clear(CopyTxt)
                    else
                        CopyTxt := Text000;
                end;

                trigger OnPreDataItem()
                begin
                    NoLoops := 1 + Abs(NoCopies);
                    if NoLoops <= 0 then
                        NoLoops := 1;
                    CopyNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if PrintCompany then
                    if RespCenter.Get("Responsibility Center") then begin
                        FormatAddress.RespCenter(CompanyAddress, RespCenter);
                        CompanyInformation."Phone No." := RespCenter."Phone No.";
                        CompanyInformation."Fax No." := RespCenter."Fax No.";
                    end;
                //CurrReport.Language := Language.GetLanguageID("Language Code");
                CurrReport.Language := LanguageG."Windows Language ID";
                if "Salesperson Code" = '' then
                    Clear(SalesPurchPerson)
                else
                    SalesPurchPerson.Get("Salesperson Code");

                if "Shipment Method Code" = '' then
                    Clear(ShipmentMethod)
                else
                    ShipmentMethod.Get("Shipment Method Code");

                // NA0002.begin
                if "Sell-to Customer No." = '' then begin
                    "Bill-to Name" := Text009;
                    "Ship-to Name" := Text009;
                end;
                // NA0002.end
                // NA0003.begin
                if not Cust.Get("Sell-to Customer No.") then
                    Clear(Cust);
                // NA0003.end

                FormatAddress.SalesShptBillTo(BillToAddress, Custaddresstxt, "Sales Shipment Header");
                FormatAddress.SalesShptShipTo(Custaddresstxt, "Sales Shipment Header");

                ShippingAgentCodeLabel := '';
                ShippingAgentCodeText := '';
                PackageTrackingNoLabel := '';
                PackageTrackingNoText := '';
                if PrintPackageTrackingNos then begin
                    ShippingAgentCodeLabel := Text003;
                    ShippingAgentCodeText := "Sales Shipment Header"."Shipping Agent Code";
                    PackageTrackingNoLabel := Text001;
                    PackageTrackingNoText := "Sales Shipment Header"."Package Tracking No.";
                end;
                if LogInteraction then
                    if not CurrReport.Preview then
                        SegManagement.LogDocument(
                          5, "No.", 0, 0, DATABASE::Customer, "Sell-to Customer No.",
                          "Salesperson Code", "Campaign No.", "Posting Description", '');   // NA0001
                TaxRegNo := '';
                TaxRegLabel := '';
                /**IF "Tax Area Code" <> '' THEN BEGIN
                  TaxArea.GET("Tax Area Code");
                  CASE TaxArea.Country OF
                    TaxArea.Country::US:
                      ;
                    TaxArea.Country::CA:
                      BEGIN
                        TaxRegNo := CompanyInformation."VAT Registration No.";
                        TaxRegLabel := CompanyInformation.FIELDCAPTION("VAT Registration No.");
                      END;**/

            end;

            trigger OnPreDataItem()
            begin
                // NA0004.begin
                // CompanyInformation.GET;  // NA0001
                // IF PrintCompany THEN
                // FormatAddress.Company(CompanyAddress,CompanyInformation)
                // ELSE
                // CLEAR(CompanyAddress);
                // NA0004.end
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoCopies; NoCopies)
                    {
                        ApplicationArea = All;
                        Caption = 'Number of Copies';
                    }
                    field(PrintCompanyAddress; PrintCompany)
                    {
                        ApplicationArea = All;
                        Caption = 'Print Company Address';
                    }
                    field(PrintPackageTrackingNos; PrintPackageTrackingNos)
                    {
                        ApplicationArea = All;
                        Caption = 'Print Package Tracking Nos.';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = All;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                    }
                    field(DisplayAsmInfo; DisplayAssemblyInformation)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Assembly Components';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            LogInteractionEnable := true;
        end;

        trigger OnOpenPage()
        begin
            InitLogInteraction;
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyInfo.Get;
        SalesSetup.Get;

        case SalesSetup."Logo Position on Documents" of
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                begin
                    CompanyInfo3.Get;
                    CompanyInfo3.CalcFields(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Center:
                begin
                    CompanyInfo1.Get;
                    CompanyInfo1.CalcFields(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Right:
                begin
                    CompanyInfo2.Get;
                    CompanyInfo2.CalcFields(Picture);
                end;
        end;
    end;

    trigger OnPreReport()
    begin
        if not CurrReport.UseRequestPage then
            InitLogInteraction;

        // NA0004.begin
        CompanyInformation.Get;
        SalesSetup.Get;

        case SalesSetup."Logo Position on Documents" of
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                CompanyInformation.CalcFields(Picture);
            SalesSetup."Logo Position on Documents"::Center:
                begin
                    CompanyInfo1.Get;
                    CompanyInfo1.CalcFields(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Right:
                begin
                    CompanyInfo2.Get;
                    CompanyInfo2.CalcFields(Picture);
                end;
        end;

        if PrintCompany then
            FormatAddress.Company(CompanyAddress, CompanyInformation)
        else
            Clear(CompanyAddress);
        // NA0004.end
    end;

    var
        OrderedQuantity: Decimal;
        BackOrderedQuantity: Decimal;
        ShipmentMethod: Record "Shipment Method";
        ReceiptLine: Record "Sales Shipment Line";
        OrderLine: Record "Sales Line";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInformation: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        CompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        TempSalesShipmentLine: Record "Sales Shipment Line" temporary;
        TempSalesShipmentLineAsm: Record "Sales Shipment Line" temporary;
        RespCenter: Record "Responsibility Center";
        LanguageG: Record Language;
        TaxArea: Record "Tax Area";
        Cust: Record Customer;
        PostedAsmHeader: Record "Posted Assembly Header";
        PostedAsmLine: Record "Posted Assembly Line";
        CompanyAddress: array[8] of Text[50];
        BillToAddress: array[8] of Text[50];
        ShipToAddress: array[8] of Text[50];
        CopyTxt: Text[50];
        PrintCompany: Boolean;
        PrintFooter: Boolean;
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        HighestLineNo: Integer;
        SpacePointer: Integer;
        SalesShipmentPrinted: Codeunit "Sales Shpt.-Printed";
        FormatAddress: Codeunit "Format Address";
        PackageTrackingText: Text[50];
        PrintPackageTrackingNos: Boolean;
        PackageTrackingNoText: Text[50];
        PackageTrackingNoLabel: Text[50];
        ShippingAgentCodeText: Text[50];
        ShippingAgentCodeLabel: Text[50];
        SegManagement: Codeunit SegManagement;
        LogInteraction: Boolean;
        Text000: Label 'COPY';
        Text001: Label 'Tracking No.';
        Text002: Label 'Specific Tracking No.';
        Text003: Label 'Shipping Agent';
        TaxRegNo: Text[30];
        TaxRegLabel: Text[30];
        Text009: Label 'VOID SHIPMENT';
        [InDataSet]
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        AsmHeaderExists: Boolean;
        BillCaptionLbl: Label 'Bill';
        ToCaptionLbl: Label 'To:';
        CustomerIDCaptionLbl: Label 'Customer ID';
        PONumberCaptionLbl: Label 'P.O. Number';
        SalesPersonCaptionLbl: Label 'SalesPerson';
        ShipCaptionLbl: Label 'Ship';
        ShipmentCaptionLbl: Label 'SHIPMENT';
        ShipmentNumberCaptionLbl: Label 'Shipment Number:';
        ShipmentDateCaptionLbl: Label 'Shipment Date:';
        PageCaptionLbl: Label 'Page:';
        ShipViaCaptionLbl: Label 'Ship Via';
        PODateCaptionLbl: Label 'P.O. Date';
        OurOrderNoCaptionLbl: Label 'Our Order No.';
        ItemNoCaptionLbl: Label 'Item No.';
        UnitCaptionLbl: Label 'Unit';
        DescriptionCaptionLbl: Label 'Description';
        ShippedCaptionLbl: Label 'Shipped';
        OrderedCaptionLbl: Label 'Ordered';
        BackOrderedCaptionLbl: Label 'Back Ordered';
        Custaddresstxt: array[8] of Text[50];

    procedure InitLogInteraction()
    begin
        LogInteraction :=
        SegManagement.FindInteractionTemplateCode(
            "Interaction Log Entry Document Type"::"Sales Shpt. Note")
         <> '';
    end;

    procedure GetUnitOfMeasureDescr(UOMCode: Code[10]): Text[10]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        // NA0008.begin
        if not UnitOfMeasure.Get(UOMCode) then
            exit(UOMCode);
        exit(UnitOfMeasure.Description);
        // NA0008.end
    end;

    procedure BlanksForIndent(): Text[10]
    begin
        // NA0008.begin
        exit(PadStr('', 2, ' '));
        // NA0008.end
    end;
}

