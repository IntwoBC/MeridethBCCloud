pageextension 50030 pageextension70000652 extends "Sales Return Order"
{
    // <changelog>
    //   <add id="NA0001" dev="ELYNCH" date="2006-06-08" area="NASALESTAX"
    //     releaseversion="NAVNA4.00">Added NA Sales Tax fields and code</add>
    //   <change id="NA0002" dev="ELYNCH" date="2006-06-08" area="NA ADDRESS"
    //     releaseversion="NAVNA4.00">Formatted address with State / ZIP Code</change>
    // </changelog>
    // 
    // MER0001 TLE 05/08/14 Add Commissions Factbox, Cost Calculation Fasttab
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on ""Your Reference"(Control 77)".

        addafter("Foreign Trade")
        {
            group(EFT)
            {
                Caption = 'EFT';

            }
            group("Cost Calculation")
            {
                Caption = 'Cost Calculation';
                field("Credit Card Charges"; rec."Credit Card Charges")
                {
                    ApplicationArea = all;
                }

                field(SalespersonMiscCharge; SalespersonMiscCharge)
                {
                    ApplicationArea = all;
                    Caption = 'Salesperson Misc. Charges';

                    trigger OnValidate()
                    var
                        DocCommChgs: Record "Document Commission Charges";
                        tempSalesLine: Record "Sales Line" temporary;
                    begin
                        // MER0001 >>
                        // BC25 fix: create the record if the document has none yet (Get without IF raised an error)
                        if not DocCommChgs.Get(Rec."Document Type", Rec."No.") then begin
                            DocCommChgs.Init();
                            DocCommChgs."Document Type" := Rec."Document Type".AsInteger();
                            DocCommChgs."No." := Rec."No.";
                            DocCommChgs.Insert(true);
                        end;
                        DocCommChgs."Salesperson Misc. Charge" := SalespersonMiscCharge;
                        DocCommChgs.Modify;

                        Rec.UpdateCommissions(tempSalesLine);

                        SendF5;
                        // MER0001 <<
                    end;
                }
                field("Salesperson Order Fee"; rec."Salesperson Order Fee")
                {
                    ApplicationArea = all;
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
        addafter(Control1905767507)
        {
            part(Control1240060000; "Commissions Factbox")
            {
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "No." = FIELD("No.");
                ApplicationArea = all;
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Modification (Name) on "ActionGroup7(Action 7)".


        //Unsupported feature: Property Modification (Name) on "Release(Action 112)".



        //Unsupported feature: Code Modification on "Statistics(Action 51).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        OnBeforeStatisticsAction(Rec,Handled);
        if not Handled then begin
          OnBeforeCalculateSalesTaxStatistics(Rec,true);
          OpenSalesOrderStatistics;
          SalesCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
        end
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*

        #1..6
        */
        //end;
        addafter(Approvals)
        {
            action("EFT &Transactions")
            {
                Caption = 'EFT &Transactions';
                ApplicationArea = All;
                Image = CreditCardLog;
                //RunObject = Page Page37028311;
                // RunPageLink = Field1100=FIELD("Document Type"),
                //             Field1110=FIELD("No.");
                // RunPageView = SORTING(Field1100,Field1110);

                trigger OnAction()
                begin
                    CurrPage.Update(false);
                end;
            }
        }
        addafter("F&unctions")
        {
            group(Payment)
            {
                Caption = 'Payment';
                Image = Sales;
                action("&Submit EFT Credit")
                {
                    Caption = '&Submit EFT Credit';
                    ApplicationArea = All;
                    Image = ReceivablesPayables;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+S';

                    trigger OnAction()
                    begin
                        // MakeEFTPayment;
                    end;
                }
                group("&Credit Card")
                {
                    Caption = '&Credit Card';
                    Image = CreditCard;
                    action(Refund)
                    {
                        Caption = 'Refund';
                        ApplicationArea = All;
                        Image = AuthorizeCreditCard;
                        Promoted = false;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = Process;
                        RunPageMode = Create;
                    }
                }
            }
        }
    }

    var
        DocCommChgs: Record "Document Commission Charges";

    var
        SalespersonMiscCharge: Decimal;


    //Unsupported feature: Code Insertion (VariableCollection) on "OnOpenPage".

    //trigger (Variable: DocCommChgs)()
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;
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
        SalesSetup: Record "Sales & Receivables Setup";
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
                // if PaymentMethod."EFT Tender Type" = PaymentMethod."EFT Tender Type"::"Credit Card" then begin
                //    DocCommChgs."Credit Card Charges" := (lLineAmountPrice + TaxAmt) * SalesSetup."Credit Card Charges Rate" * 0.01;
                //end else
                //  DocCommChgs."Credit Card Charges" := 0;
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

    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if UserMgt.GetSalesFilter <> '' then begin
      FilterGroup(2);
      SetRange("Responsibility Center",UserMgt.GetSalesFilter);
      FilterGroup(0);
    end;

    ActivateFields;

    SetDocNoVisible;
    if ("No." <> '') and ("Sell-to Customer No." = '') then
      DocumentIsPosted := (not Get("Document Type","No."));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6

    ActivateFields;

    #8..11
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "ShowPreview(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeStatisticsAction(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCalculateSalesTaxStatistics(PROCEDURE 1020000)".


    procedure SendF5()
    begin
        // BC25: replaces the BC14 WshShell.SendKeys('{F5}') automation (not supported) - refreshes page and factboxes
        if not GuiAllowed then
            exit;
        CurrPage.Update(false);
    end;
}

