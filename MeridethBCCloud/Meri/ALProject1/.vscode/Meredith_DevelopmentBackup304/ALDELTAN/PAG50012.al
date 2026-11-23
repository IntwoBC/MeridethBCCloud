page 50012 "Posted CrMemo Comm. Factbox"
{
    Editable = false;
    PageType = CardPart;
    SourceTable = "Sales Cr.Memo Header";
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            field(LineAmountPrice; LineAmountPrice)
            {
                Caption = 'Line Amount Price:';
            }
            field(TaxAmt; TaxAmt)
            {
                Caption = 'Tax Amt:';
            }
            field(LineAmountCost; LineAmountCost)
            {
                Caption = 'Line Amount Cost:';
            }
            field(TotalBurdenAmount; TotalBurdenAmount)
            {
                Caption = 'Total Burden Amount:';
            }
            field("Credit Card Charges"; Rec."Credit Card Charges")
            {
            }
            field("Salesperson Order Fee"; Rec."Salesperson Order Fee")
            {
            }
            field(GrossProfit; GrossProfit)
            {
                Caption = 'Gross Profit:';
            }
            field("Salesperson Commission Amount"; Rec."Salesperson Commission Amount")
            {
            }
            field("Salesperson Misc. Charge"; Rec."Salesperson Misc. Charge")
            {
            }
            field(NetProfit; NetProfit)
            {
                Caption = 'Net Profit:';
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        SalesLine: Record "Sales Line";
        tempSalesLine: Record "Sales Line" temporary;
        SalesPostPrepmt: Codeunit "Sales-Post Prepayments";
    begin
        Clear(LineAmountPrice);
        Clear(LineAmountCost);
        Clear(GrossProfit);
        Clear(NetProfit);
        Clear(TaxAmt);
        Clear(TotalBurdenAmount);
        Rec.CalculateCommissions(LineAmountPrice, LineAmountCost, GrossProfit, NetProfit, TaxAmt, TotalBurdenAmount);
    end;

    procedure CalculateCommissions(var LineAmountPrice: Decimal; var LineAmountCost: Decimal; var GrossProfit: Decimal; var NetProfit: Decimal; var TaxAmt: Decimal; var TotalBurdenAmount: Decimal)
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
    begin
        // = BC14 Table 114 "Sales Cr.Memo Header".CalculateCommissions (MER0002..MER0005)
        // BC25 fix: the converted code read "Sales Invoice Line" and used the invoice formula.
        SalesCrMemoLine.SetRange("Document No.", Rec."No.");
        if SalesCrMemoLine.FindSet() then
            repeat
                LineAmountPrice += SalesCrMemoLine."Line Amount";
                LineAmountCost += SalesCrMemoLine.Quantity * SalesCrMemoLine."Unit Cost";
                TotalBurdenAmount += SalesCrMemoLine."Burden Amount";
                TaxAmt += SalesCrMemoLine."Amount Including VAT" - SalesCrMemoLine.Amount;
            until SalesCrMemoLine.Next() = 0;

        // Credit memo: no Credit Card Charges / Order Fee in the formula (BC14 MER0003..MER0005)
        GrossProfit := LineAmountPrice - LineAmountCost - TotalBurdenAmount;

        NetProfit := GrossProfit - Rec."Salesperson Commission Amount" + TotalBurdenAmount;
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
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
        LineAmountPrice: Decimal;
        LineAmountCost: Decimal;
        Salesperson: Record "Salesperson/Purchaser";
        TaxAmt: Decimal;
        TotalBurdenAmount: Decimal;

    local procedure Pct(Numerator: Decimal; Denominator: Decimal): Decimal
    begin
        if Denominator = 0 then
            exit(0);
        exit(Round(Numerator / Denominator * 10000, 1));
    end;
}

