pageextension 50008 pageextension50008 extends "Sales Order"
{
    // <changelog>
    //   <add id="NA0000" dev="ELYNCH" date="2006-02-01" area="NASALESTAX" feature="617"
    //     releaseversion="NAVNA4.00">Added NA Sales Tax fields</add>
    //   <change id="NA0002" dev="ELYNCH" date="2006-02-03" area="NA ADDRESS" feature="2116"
    //     releaseversion="NAVNA4.00">Address formatting</change>
    //   <change id="NA0003" dev="JNOZZI" date="2007-02-19" area="NA ADDRESS"  request="6733"
    //     baseversion="NAVNA4.00" releaseversion="NAVNA5.00">Incorrect UID on Ship-to UPS Zone; corrected.</change>
    //   <change id="NA0006" dev="MBAHADUR" date="2007-12-03" area="NASALESTAX" feature="31623"
    //     baseversion="NAVNA5.00.01" releaseversion="NAVNA5.00.01">Fix Prepayments - showed Prepayment Include Tax on
    //     the prepayment tab</change>
    // </changelog>
    // 
    // MER0001 TLE 12/06/13 Add Comment Line Factbox
    // MER0002 TLE 12/06/13 Add Commissions Fast tab, Commissions Factbox
    // MER0003 TLE 01/20/14 Add function ExtractFreightExpenses. Check for G/L Freight Revenue lines.
    // MER0004 TLE 02/09/14 Call UpdateCommissions
    // MER0005 TLE 03/03/14 Order & Product History
    // MER0006 TLE 04/03/14 Disable call to UpdateCommissions on post.
    // MER0007 TLE 04/03/14 Add page for "Document Commission Charges"
    // MER0008 TLE 04/07/14 Redirect "Salesperson Misc. Charge"
    // MER0009 TLE 04/08/14 F5 for ExtractFreightExpenses
    // MER0010 TLE 04/09/14 Call UpdateCommissions on changing Salesperson Misc. Charge
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on ""Your Reference"(Control 138)".



        //Unsupported feature: Code Insertion on ""Payment Terms Code"(Control 28)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        // MER0001 >>
        SendF5;
        // MER0001 <<
        */
        //end;


        //Unsupported feature: Code Modification on ""Ship-to Code"(Control 36).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if (xRec."Ship-to Code" <> '') and ("Ship-to Code" = '') then
          Error(EmptyShipToCodeErr);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*

        if (xRec."Ship-to Code" <> '') and ("Ship-to Code" = '') then
          Error(EmptyShipToCodeErr);
        */
        //end;
        addafter("External Document No.")
        {
            field("VARStreet Order No."; rec."VARStreet Order No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Control85)
        {
            field(Control37028450; '')
            {
                ApplicationArea = All;
                ShowCaption = false;
            }
        }
        addafter(Control1900201301)
        {
            group(EFT)
            {
                Caption = 'EFT';
                field("EFT Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                }
                field(Control37028370; '')
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ShowCaption = false;
                }
                field(Control37028372; '')
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ShowCaption = false;
                }
                field(Control37028374; '')
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                }
                field(Control37028376; '')
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                }
            }
            group("Cost Calculation")
            {
                Caption = 'Cost Calculation';
                field("Credit Card Charges"; Rec."Credit Card Charges")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // MER0001 >>
                        SendF5;
                        // MER0001 <<
                    end;
                }
                field(SalespersonMiscCharge; SalespersonMiscCharge)
                {
                    ApplicationArea = All;
                    Caption = 'Salesperson Misc. Charges';

                    trigger OnValidate()
                    var
                        DocCommChgs: Record "Document Commission Charges";
                        tempSalesLine: Record "Sales Line" temporary;
                    begin
                        // MER0008 >>
                        // BC25 fix: create the record if the document has none yet (Get without IF raised an error)
                        if not DocCommChgs.Get(Rec."Document Type", Rec."No.") then begin
                            DocCommChgs.Init();
                            DocCommChgs."Document Type" := Rec."Document Type".AsInteger();
                            DocCommChgs."No." := Rec."No.";
                            DocCommChgs.Insert(true);
                        end;
                        DocCommChgs."Salesperson Misc. Charge" := SalespersonMiscCharge;
                        DocCommChgs.Modify;
                        // MER0008 <<

                        // MER000X >>
                        Rec.UpdateCommissions(tempSalesLine);
                        // MER000X <<

                        // MER0001 >>
                        SendF5;
                        // MER0001 <<
                    end;
                }
                field("Salesperson Order Fee"; Rec."Salesperson Order Fee")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // MER0001 >>
                        SendF5;
                        // MER0001 <<
                    end;
                }
            }
        }
        addafter(Control1900316107)
        {
            // part(Control1900204307)
            // {
            //     SubPageLink = Field1 = FIELD("Document Type"),
            //                   Field3 = FIELD("No.");
            //     Visible = true;
            // }
        }
        addafter(Control1907234507)
        {
            part("Comment Line Factbox"; "Comment Line Factbox")
            {
                ApplicationArea = all;
                SubPageLink = "Table Name" = CONST(Customer),
                              "No." = FIELD("Sell-to Customer No.");
            }
            part("Commissions Factbox"; "Commissions Factbox")
            {
                ApplicationArea = all;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "No." = FIELD("No.");
            }
        }
    }
    actions
    {


        //Unsupported feature: Code Insertion (VariableCollection) on "Post(Action 75).OnAction".

        //trigger (Variable: SalesSetup)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on "Post(Action 75).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Post(CODEUNIT::"Sales-Post (Yes/No)",NavigateAfterPost::"Posted Document");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*

        // SalesSetup.GET;

        //  SalesLine2.RESET;
        //  SalesLine2.SETRANGE("Document Type","Document Type");
        // SalesLine2.SETRANGE("Document No.","No.");
        //  SalesLine2.SETRANGE(Type,SalesLine2.Type::Item);
        //  SalesLine2.SETFILTER("Purchase Order No.",'<>%1','');
        //  IF SalesLine2.FINDSET THEN
        //  REPEAT
         //   tempSalesLine.RESET;
         //   tempSalesLine.SETRANGE("Purchase Order No.",SalesLine2."Purchase Order No.");
          //  IF NOT tempSalesLine.FIND('-') THEN BEGIN
              //CLEAR(tempSalesLine);
           //   tempSalesLine := SalesLine2;
            //  tempSalesLine.INSERT;
           // END;
         // UNTIL SalesLine2.NEXT = 0;

        // tempSalesLine.RESET;

        // IF tempSalesLine.FINDSET THEN BEGIN
        //  REPEAT
         //   SalesLine2.RESET;
         //   SalesLine2.SETRANGE("Document Type","Document Type");
         //   SalesLine2.SETRANGE("Document No.","No.");
          //  SalesLine2.SETRANGE(Type,SalesLine2.Type::"G/L Account");
          //  SalesLine2.SETRANGE("No.",SalesSetup."G/L Freight Revenue Account");
          //  SalesLine2.SETRANGE("Vendor No.",tempSalesLine."Vendor No.");
          //  IF NOT SalesLine2.FIND('-') THEN BEGIN
           //   Question := MERText0000;
            //  IF NOT CONFIRM(Question,FALSE,tempSalesLine."Vendor No.") THEN
            //    ERROR(MERText0001);
           // END;
         // UNTIL tempSalesLine.NEXT = 0;
        // END;
        // MER0003 <<

        // Post(CODEUNIT::"Sales-Post (Yes/No)");

        // MER0006 >>
        //// MER0003 >>
        //CLEAR(LineAmountPrice);
        //CLEAR(LineAmountCost);
        //CLEAR(GrossProfit);
        //CLEAR(NetProfit);
        //CLEAR(TaxAmt);
        //UpdateCommissions(tempSalesLine,LineAmountPrice,LineAmountCost,GrossProfit,NetProfit,TaxAmt,TRUE);
        //SendF5;
        //// MER0003 <<
        // MER0006 <<

        Post(CODEUNIT::"Sales-Post (Yes/No)",NavigateAfterPost::"Posted Document");
        */
        //end;

        addafter(Prepayment)
        {
            group("Order & Product History")
            {
                Caption = 'Order & Product History';
            }
            action(Action1240060005)
            {
                ApplicationArea = All;
                Caption = 'Order & Product History';
                Image = History;

                trigger OnAction()
                var
                    OrderHistory: Page "Order History";
                    SILSCrMLUnion: Record "SIL SCrML Union";
                    UserSetup: Record "User Setup";
                    Salesperson: Record "Salesperson/Purchaser";
                begin
                    // MER0005 >>
                    //SalesInvoiceLine.SETRANGE("Sell-to Customer No.","Sell-to Customer No.");
                    //IF SalesInvoiceLine.FINDSET THEN
                    //  REPEAT
                    //    SalesInvoiceHeader.GET(SalesInvoiceLine."Document No.");
                    //    CLEAR(SILSCrMLUnion);
                    //    SILSCrMLUnion."Document No." := SalesInvoiceLine."Document No.";
                    //    SILSCrMLUnion."Line No." := SalesInvoiceLine."Line No.";
                    //    SILSCrMLUnion.Type := SalesInvoiceLine.Type;
                    //    SILSCrMLUnion."No." := SalesInvoiceLine."No.";
                    //    SILSCrMLUnion."Shipment Date" := SalesInvoiceLine."Shipment Date";
                    //    SILSCrMLUnion.Description := SalesInvoiceLine.Description;
                    //    SILSCrMLUnion.Quantity := SalesInvoiceLine.Quantity;
                    //    SILSCrMLUnion."Unit Price" := SalesInvoiceLine."Unit Price";
                    //    SILSCrMLUnion."Unit Cost (LCY)" := SalesInvoiceLine."Unit Cost (LCY)";
                    //    SILSCrMLUnion."Vendor No." := SalesInvoiceLine."Vendor No.";
                    //    SILSCrMLUnion."Sell-to Customer No." := SalesInvoiceLine."Sell-to Customer No.";
                    //    SILSCrMLUnion."Salesperson Code" := SalesInvoiceHeader."Salesperson Code";
                    //    IF NOT SILSCrMLUnion.INSERT THEN;
                    //  UNTIL SalesInvoiceLine.NEXT = 0;
                    //
                    //SalesCrMemoLine.SETRANGE("Sell-to Customer No.","Sell-to Customer No.");
                    //IF SalesCrMemoLine.FINDSET THEN
                    //  REPEAT
                    //    SalesCrMemoHeader.GET(SalesCrMemoLine."Document No.");
                    //    CLEAR(SILSCrMLUnion);
                    //    SILSCrMLUnion."Document No." := SalesCrMemoLine."Document No.";
                    //    SILSCrMLUnion."Line No." := SalesCrMemoLine."Line No.";
                    //    SILSCrMLUnion.Type := SalesCrMemoLine.Type;
                    //    SILSCrMLUnion."No." := SalesCrMemoLine."No.";
                    //    SILSCrMLUnion."Shipment Date" := SalesCrMemoLine."Shipment Date";
                    //    SILSCrMLUnion.Description := SalesCrMemoLine.Description;
                    //    SILSCrMLUnion.Quantity := SalesCrMemoLine.Quantity;
                    //    SILSCrMLUnion."Unit Price" := SalesCrMemoLine."Unit Price";
                    //    SILSCrMLUnion."Unit Cost (LCY)" := SalesCrMemoLine."Unit Cost (LCY)";
                    //    //SILSCrMLUnion."Vendor No." := SalesCrmemoLine."Vendor No.";
                    //    SILSCrMLUnion."Sell-to Customer No." := SalesCrMemoLine."Sell-to Customer No.";
                    //    SILSCrMLUnion."Salesperson Code" := SalesCrMemoHeader."Salesperson Code";
                    //    IF NOT SILSCrMLUnion.INSERT THEN;
                    //  UNTIL SalesCrMemoLine.NEXT = 0;

                    SILSCrMLUnion.SetRange("Sell-to Customer No.", rec."Sell-to Customer No.");
                    if UserSetup.Get(UserId) and Salesperson.Get(UserSetup."Salespers./Purch. Code") and Salesperson."Restrict view to self" then
                        SILSCrMLUnion.SetRange("Salesperson Code", UserSetup."Salespers./Purch. Code");

                    OrderHistory.SetTableView(SILSCrMLUnion);
                    OrderHistory.Run;
                end;
            }
            action("Document Commission Charges")
            {
                ApplicationArea = All;
                Caption = 'Document Commission Charges';

                trigger OnAction()
                var
                    DocumentCommissionCharges: Page "Document Commission Charges";
                    DocCommChgs: Record "Document Commission Charges";
                begin
                    // MER0007 >>
                    DocCommChgs.SetRange("Document Type", rec."Document Type");
                    DocCommChgs.SetRange("No.", rec."No.");
                    DocumentCommissionCharges.SetTableView(DocCommChgs);
                    DocumentCommissionCharges.RunModal;
                    // MER0007 <<
                end;
            }
        }
        addafter(GetRecurringSalesLines)
        {
            action("Extract Freight Expenses")
            {
                ApplicationArea = All;
                Caption = 'Extract Freight Expenses';
                Image = UpdateUnitCost;

                trigger OnAction()
                begin
                    // MER0003 >>
                    // rec.ExtractFreightExpenses;
                    // MER0003 <<

                    // MER0009 >>
                    SendF5;
                    // MER0009 <<
                end;
            }
        }
    }
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
        PaymentMethod: Record "Payment Method";
    begin
        // MER0014 >>
        if not Salesperson.Get(rec."Salesperson Code") then
            Clear(Salesperson);

        SalesLine2.SetRange("Document Type", rec."Document Type");
        SalesLine2.SetRange("Document No.", rec."No.");
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

        if not DocCommChgs.Get(rec."Document Type", rec."No.") then begin
            Clear(DocCommChgs);
            DocCommChgs.Init;
            DocCommChgs."Document Type" := rec."Document Type";
            DocCommChgs."No." := rec."No.";
            DocCommChgs.Insert(true);
        end;

        // MER0015 >>
        // MER0017 >>
        //IF "Document Type" IN ["Document Type"::"Credit Memo"] THEN
        if Rec."Document Type" in [Rec."Document Type"::"Credit Memo", rec."Document Type"::"Return Order"] then
            // MER0017 <<
            DocCommChgs."Credit Card Charges" := 0
        else begin
            // MER0015 >>
            if not PaymentMethod.Get(rec."Payment Method Code") then
                DocCommChgs."Credit Card Charges" := 0
            else begin
                //if PaymentMethod."EFT Tender Type" = PaymentMethod."EFT Tender Type"::"Credit Card" then begin
                //   DocCommChgs."Credit Card Charges" := (lLineAmountPrice + TaxAmt) * SalesSetup."Credit Card Charges Rate" * 0.01;
                // end else
                //    DocCommChgs."Credit Card Charges" := 0;
            end;
            // MER0015 >>
        end;
        // MER0015 <<

        DocCommChgs."Salesperson Order Fee" := rec.CalcSalespersonOrderFee;

        // MER0017 >>
        //IF "Document Type" IN ["Document Type"::"Credit Memo"] THEN
        if rec."Document Type" in [rec."Document Type"::"Credit Memo", rec."Document Type"::"Return Order"] then
            // MER0017 <<
            GrossProfit := lLineAmountPrice - lLineAmountCost - lTotalBurdenAmount
        else
            GrossProfit := lLineAmountPrice - lLineAmountCost - lTotalBurdenAmount - DocCommChgs."Credit Card Charges" - DocCommChgs."Salesperson Order Fee";

        // MER0017 >>
        if rec."Document Type" in [rec."Document Type"::"Credit Memo"] then //original kept
                                                                            //IF "Document Type" IN ["Document Type"::"Credit Memo","Document Type"::"Return Order"] THEN
                                                                            // MER0017 <<
            DocCommChgs."Salesperson Commission Amount" := GrossProfit * Salesperson."Commission %" * 0.01
        else
            DocCommChgs."Salesperson Commission Amount" := GrossProfit * Salesperson."Commission %" * 0.01 - DocCommChgs."Salesperson Misc. Charge";

        DocCommChgs.Modify;
        // MER0014 >>
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        SalesLine2: Record "Sales Line";
        //tempSalesLine: Record "Sales Line" temporary;
        MERText0000: Label 'G/L Freight Revenue Line not found for Vendor No. %1.\Do you want to continue?';
        Question: Text[120];
        MERText0001: Label 'Posting process interrupted.';

    var
        DocCommChgs: Record "Document Commission Charges";

    var
        tempSalesLine: Record "Sales Line" temporary;
        LineAmountPrice: Decimal;
        LineAmountCost: Decimal;
        GrossProfit: Decimal;
        NetProfit: Decimal;
        TaxAmt: Decimal;
        SalespersonMiscCharge: Decimal;


    //Unsupported feature: Code Insertion on "OnClosePage".

    //trigger OnClosePage()
    //begin
    /*
    // MER0008 >>
    //// MER0004 >>
    //CLEAR(LineAmountPrice);
    //CLEAR(LineAmountCost);
    //CLEAR(GrossProfit);
    //CLEAR(NetProfit);
    //CLEAR(TaxAmt);
    //UpdateCommissions(tempSalesLine,LineAmountPrice,LineAmountCost,GrossProfit,NetProfit,TaxAmt,TRUE);
    //// MER0004 <<
    // MER0008 <<
    */
    //end;


    //Unsupported feature: Code Insertion (VariableCollection) on "OnOpenPage".

    //trigger (Variable: DocCommChgs)()
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "UpdateShipToBillToGroupVisibility(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeStatisticsAction(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCalculateSalesTaxStatistics(PROCEDURE 1020000)".


    //Unsupported feature: Property Modification (Attributes) on "CheckNotificationsOnce(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "OnPostOnAfterSetDocumentIsPosted(PROCEDURE 13)".


    procedure SendF5()
    begin
        // BC25: replaces the BC14 WshShell.SendKeys('{F5}') automation (not supported) - refreshes page and factboxes
        if not GuiAllowed then
            exit;
        CurrPage.Update(false);
    end;
}

