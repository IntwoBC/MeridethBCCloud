page 50000 "Posted Sls. Ord. Comm. Factbox"
{
    Editable = false;
    PageType = CardPart;
    SourceTable = "Return Receipt Header";
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            field(LineAmountPrice; LineAmountPrice)
            {
                ApplicationArea = all;
                Caption = 'Line Amount Price:';
            }
            field(TaxAmt; TaxAmt)
            {
                ApplicationArea = all;
                Caption = 'Tax Amt:';
            }
            field(LineAmountCost; LineAmountCost)
            {
                ApplicationArea = all;
                Caption = 'Line Amount Cost:';
            }
            field(TotalBurdenAmount; TotalBurdenAmount)
            {
                ApplicationArea = all;
                Caption = 'Total Burden Amount:';
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
        SalesInvLine: Record "Sales Invoice Line";
        Salesperson: Record "Salesperson/Purchaser";
    begin
        // MER0002 >>
        SalesInvLine.SetRange("Document No.", rec."No.");
        if SalesInvLine.FindSet then
            repeat
                LineAmountPrice += SalesInvLine."Line Amount";
                LineAmountCost += SalesInvLine.Quantity * SalesInvLine."Unit Cost";
                TotalBurdenAmount += SalesInvLine."Burden Amount";
                TaxAmt += SalesInvLine."Amount Including VAT" - SalesInvLine.Amount;
            until SalesInvLine.Next = 0;

        GrossProfit := LineAmountPrice - LineAmountCost - TotalBurdenAmount - rec."Credit Card Charges" - rec."Salesperson Order Fee";

        NetProfit := GrossProfit - rec."Salesperson Commission Amount" + TotalBurdenAmount + rec."Salesperson Order Fee";
        // MER0002 <<
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

