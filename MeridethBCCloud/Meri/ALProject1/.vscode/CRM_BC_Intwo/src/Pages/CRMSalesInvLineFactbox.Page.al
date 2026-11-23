// ============================================================
// Page: CRM Sales Inv. Line Factbox
// Object ID  : 50108
// Publisher  : Intwo
// Purpose    : ListPart FactBox showing invoice lines for the
//              currently selected header on the Sales Invoice
//              Push Dashboard (50107).
// ============================================================
page 50108 "CRM Sales Inv. Line Factbox"
{
    PageType = ListPart;
    Caption = 'Invoice Lines';
    SourceTable = "CRM Sales Inv. Line Staging";
    ApplicationArea = All;
    UsageCategory = lists;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Line No."; Rec."Line No.") { ApplicationArea = All; }
                field("No."; Rec."No.") { ApplicationArea = All; }
                field(Description; Rec.Description) { ApplicationArea = All; }
                field(Quantity; Rec.Quantity) { ApplicationArea = All; }
                field("Unit Price Excl. Tax"; Rec."Unit Price Excl. Tax") { ApplicationArea = All; }
                field("Line Amount Excl. Tax"; Rec."Line Amount Excl. Tax") { ApplicationArea = All; }
                field("Integration Status"; Rec."Integration Status")
                {
                    ApplicationArea = All;
                    StyleExpr = StatusStyle;
                }
            }
        }
    }

    var
        StatusStyle: Text;

    trigger OnAfterGetRecord()
    begin
        case Rec."Integration Status" of
            Rec."Integration Status"::Success:
                StatusStyle := 'Favorable';
            Rec."Integration Status"::Failed:
                StatusStyle := 'Unfavorable';
            else
                StatusStyle := 'Ambiguous';
        end;
    end;
}
