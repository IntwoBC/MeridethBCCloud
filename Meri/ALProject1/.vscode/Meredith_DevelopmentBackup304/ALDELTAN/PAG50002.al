page 50002 "Commissions Factbox"
{
    // MER0001 TLE 04/03/14 Disable call to UpdateCommissions.
    // MER0002 TLE 04/18/14 Adjustments for Credit Memos
    // MER0003 TLE 05/11/14 Adjustments for Sales Return Orders

    Editable = false;
    PageType = CardPart;
    SourceTable = "Sales Header";
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            field("Total Outstanding Line Amount"; Rec."Total Outstanding Line Amount")
            {
                ApplicationArea = all;
                Caption = 'Line Amount Price:';
            }
            field(TaxAmt; TaxAmt)
            {
                ApplicationArea = all;
                Caption = 'Tax Amt:';
            }
            field("Total Outstanding Line Cost"; Rec."Total Outstanding Line Cost")
            {
                ApplicationArea = all;
                Caption = 'Line Amount Cost:';
            }
            field("Total Burden Amount"; Rec."Total Burden Amount")
            {
                ApplicationArea = all;
            }
            field("Credit Card Charges"; Rec."Credit Card Charges")
            {
                ApplicationArea = all;
            }
            field("Salesperson Order Fee"; Rec."Salesperson Order Fee")
            {
                ApplicationArea = all;
            }
            field(GrossProfit; GrossProfit)
            {
                ApplicationArea = all;
                Caption = 'Gross Profit:';
            }
            field("Salesperson Commission Amount"; Rec."Salesperson Commission Amount")
            {
                ApplicationArea = all;
            }
            field("Salesperson Misc. Charge"; Rec."Salesperson Misc. Charge")
            {
                ApplicationArea = all;
            }
            field(NetProfit; NetProfit)
            {
                ApplicationArea = all;
                Caption = 'Net Profit:';
            }
            field("Salesperson Commission %"; Rec."Salesperson Commission %")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        SalesLine: Record "Sales Line";
    begin
        // BC25: make sure the FlowFields are calculated before they are used below
        Rec.CalcFields("Total Outstanding Line Amount", "Total Outstanding Line Cost", "Total Burden Amount",
                       "Credit Card Charges", "Salesperson Order Fee", "Salesperson Commission Amount", "Salesperson Misc. Charge");

        // MER0001 >>
        //CLEAR(LineAmountPrice);
        //CLEAR(LineAmountCost);
        //CLEAR(GrossProfit);
        //CLEAR(NetProfit);
        //CLEAR(TaxAmt);
        //UpdateCommissions(tempSalesLine,LineAmountPrice,LineAmountCost,GrossProfit,NetProfit,TaxAmt,FALSE);

        // MER0002 >>
        //GrossProfit := "Total Outstanding Line Amount" - "Total Outstanding Line Cost" - "Total Burden Amount" - "Credit Card Charges" - "Salesperson Order Fee";
        //NetProfit := GrossProfit - "Salesperson Commission Amount" + "Total Burden Amount" + "Salesperson Order Fee" -
        //  "Salesperson Misc. Charge";
        // MER0003 >>
        //IF "Document Type" IN ["Document Type"::"Credit Memo"] THEN BEGIN
        if Rec."Document Type" in [Rec."Document Type"::"Credit Memo", Rec."Document Type"::"Return Order"] then begin
            // MER0003 <<
            GrossProfit := Rec."Total Outstanding Line Amount" - Rec."Total Outstanding Line Cost" - Rec."Total Burden Amount";
            NetProfit := GrossProfit - Rec."Salesperson Commission Amount" + Rec."Total Burden Amount";
        end else begin
            GrossProfit := Rec."Total Outstanding Line Amount" - Rec."Total Outstanding Line Cost" - Rec."Total Burden Amount" - Rec."Credit Card Charges" - Rec."Salesperson Order Fee";
            NetProfit := GrossProfit - Rec."Salesperson Commission Amount" + Rec."Total Burden Amount" + Rec."Salesperson Order Fee" -
              Rec."Salesperson Misc. Charge";
        end;
        // MER0002 <<


        Clear(TaxAmt);
        SalesLine.SetRange("Document Type", Rec."Document Type");
        SalesLine.SetRange("Document No.", Rec."No.");
        if SalesLine.FindSet then
            repeat
                TaxAmt += SalesLine."Amount Including VAT" - SalesLine.Amount;
            until SalesLine.Next = 0;
        // MER0001 <<
    end;

    var
        TotalSalesLine: array[3] of Record "Sales Line";
        TotalSalesLineLCY: array[3] of Record "Sales Line";
        Cust: Record Customer;
        TempVATAmountLine1: Record "VAT Amount Line" temporary;
        TempVATAmountLine2: Record "VAT Amount Line" temporary;
        TempVATAmountLine3: Record "VAT Amount Line" temporary;
        TempVATAmountLine4: Record "VAT Amount Line" temporary;
        SalesSetup: Record "Sales & Receivables Setup";
        SalesPost: Codeunit "Sales-Post";
        TotalAmount1: array[3] of Decimal;
        TotalAmount2: array[3] of Decimal;
        VATAmount: array[3] of Decimal;
        PrepmtTotalAmount: Decimal;
        PrepmtVATAmount: Decimal;
        PrepmtTotalAmount2: Decimal;
        VATAmountText: array[3] of Text[30];
        PrepmtVATAmountText: Text[30];
        ProfitLCY: array[3] of Decimal;
        ProfitPct: array[3] of Decimal;
        AdjProfitLCY: array[3] of Decimal;
        AdjProfitPct: array[3] of Decimal;
        TotalAdjCostLCY: array[3] of Decimal;
        CreditLimitLCYExpendedPct: Decimal;
        PrepmtInvPct: Decimal;
        PrepmtDeductedPct: Decimal;
        i: Integer;
        PrevNo: Code[20];
        ActiveTab: Option General,Invoicing,Shipping,Prepayment;
        PrevTab: Option General,Invoicing,Shipping,Prepayment;
        VATLinesFormIsEditable: Boolean;
        AllowInvDisc: Boolean;
        AllowVATDifference: Boolean;
        VATLinesForm: Page "VAT Amount Lines";
        Text000: Label 'Sales %1 Statistics';
        Text001: Label 'Total';
        Text002: Label 'Amount';
        Text003: Label '%1 must not be 0.';
        Text004: Label '%1 must not be greater than %2.';
        Text005: Label 'You cannot change the invoice discount because a customer invoice discount with the code %1 exists.';
        Text006: Label 'Prepmt. Amount';
        Text007: Label 'Prepmt. Amt. Invoiced';
        Text008: Label 'Prepmt. Amt. Deducted';
        Text009: Label 'Prepmt. Amt. to Deduct';
        GrossProfit: Decimal;
        NetProfit: Decimal;
        Salesperson: Record "Salesperson/Purchaser";
        TaxAmt: Decimal;

    local procedure Pct(Numerator: Decimal; Denominator: Decimal): Decimal
    begin
        if Denominator = 0 then
            exit(0);
        exit(Round(Numerator / Denominator * 10000, 1));
    end;
}

