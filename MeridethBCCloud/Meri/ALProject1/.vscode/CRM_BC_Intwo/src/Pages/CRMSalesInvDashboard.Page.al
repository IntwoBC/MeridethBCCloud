// ============================================================
// Page: CRM Sales Inv. Dashboard
// Object ID  : 50107
// Publisher  : Intwo
// Purpose    : Monitor outbound Posted Sales Invoice push
//              records (header level) from BC to CRM.
// ============================================================
page 50107 "CRM Sales Inv. Dashboard"
{
    PageType = List;
    Caption = 'CRM Sales Invoice Push Dashboard';
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CRM Sales Inv. Header Staging";

    layout
    {
        area(Content)
        {
            repeater(Records)
            {
                field("No."; Rec."No.") { ApplicationArea = All; }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.") { ApplicationArea = All; }
                field("Posting Date"; Rec."Posting Date") { ApplicationArea = All; }
                field("Currency Code"; Rec."Currency Code") { ApplicationArea = All; }
                field("Tax Area Code"; Rec."Tax Area Code") { ApplicationArea = All; }
                field("Integration Status"; Rec."Integration Status")
                {
                    ApplicationArea = All;
                    StyleExpr = StatusStyle;
                }
                field("CRM Invoice ID"; Rec."CRM Invoice ID") { ApplicationArea = All; }
                field("Error Message"; Rec."Error Message") { ApplicationArea = All; }
                field("Created DateTime"; Rec."Created DateTime") { ApplicationArea = All; }
                field("Processed DateTime"; Rec."Processed DateTime") { ApplicationArea = All; }
                field("Retry Count"; Rec."Retry Count") { ApplicationArea = All; }
            }
        }
        area(FactBoxes)
        {
            part(LinesFactBox; "CRM Sales Inv. Line Factbox")
            {
                ApplicationArea = All;
                Caption = 'Invoice Lines';
                SubPageLink = "Document No." = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(PushSelected)
            {
                Caption = 'Push Selected Invoice Again';
                ApplicationArea = All;
                Image = Refresh;
                ToolTip = 'Re-push the selected invoice (header + lines) to CRM.';

                trigger OnAction()
                var
                    CRMSalesInvIntMgt: Codeunit "CRM Sales Inv. Int. Mgt.";
                begin
                    Rec."Integration Status" := Enum::"CRM Integration Status"::Open;
                    Rec.Modify();
                    CRMSalesInvIntMgt.ProcessStagingRecord(Rec);
                    CurrPage.Update(false);
                end;
            }
            action(PushAllOpen)
            {
                Caption = 'Push All Open';
                ApplicationArea = All;
                Image = Start;
                ToolTip = 'Push every Open invoice to CRM.';

                trigger OnAction()
                var
                    CRMSalesInvIntMgt: Codeunit "CRM Sales Inv. Int. Mgt.";
                begin
                    CRMSalesInvIntMgt.ProcessAllOpen();
                    CurrPage.Update(false);
                end;
            }
            action(StagePostedInvoice)
            {
                Caption = 'Stage Posted Invoice by No.';
                ApplicationArea = All;
                Image = ImportExport;
                ToolTip = 'Look up a Posted Sales Invoice and stage it for push.';

                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                    CRMSalesInvIntMgt: Codeunit "CRM Sales Inv. Int. Mgt.";
                begin
                    if Page.RunModal(Page::"Posted Sales Invoices", SalesInvHeader) = Action::LookupOK then
                        CRMSalesInvIntMgt.StageAndPushInvoice(SalesInvHeader);
                    CurrPage.Update(false);
                end;
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
