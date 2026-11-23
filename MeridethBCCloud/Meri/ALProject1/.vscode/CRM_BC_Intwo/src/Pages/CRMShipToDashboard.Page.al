// ============================================================
// Page: CRM Ship-To Dashboard
// Object ID  : 50103
// Publisher  : Intwo
// Purpose    : Monitor Ship-To Address staging records.
// ============================================================
page 50103 "CRM Ship-To Dashboard"
{
    PageType = List;
    Caption = 'CRM Ship-To Integration Dashboard';
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CRM Ship-To Staging";
    CardPageId = "CRM Ship-To Staging Card";

    layout
    {
        area(Content)
        {
            repeater(Records)
            {
                field("Customer No."; Rec."Customer No.") { ApplicationArea = All; }
                field(Code; Rec.Code) { ApplicationArea = All; }
                field(Name; Rec.Name) { ApplicationArea = All; }
                field(City; Rec.City) { ApplicationArea = All; }
                field("Tax Area Code"; Rec."Tax Area Code") { ApplicationArea = All; }
                field("Integration Status"; Rec."Integration Status")
                {
                    ApplicationArea = All;
                    StyleExpr = StatusStyle;
                }
                field("Error Message"; Rec."Error Message") { ApplicationArea = All; }
                field("Created DateTime"; Rec."Created DateTime") { ApplicationArea = All; }
                field("Processed DateTime"; Rec."Processed DateTime") { ApplicationArea = All; }
                field("Retry Count"; Rec."Retry Count") { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(RetrySelected)
            {
                Caption = 'Retry Selected';
                ApplicationArea = All;
                Image = Refresh;
                ToolTip = 'Re-process the selected staging record.';

                trigger OnAction()
                var
                    CRMShipToIntMgt: Codeunit "CRM Ship-To Int. Mgt.";
                begin
                    Rec."Integration Status" := Enum::"CRM Integration Status"::Open;
                    Rec.Modify();
                    CRMShipToIntMgt.ProcessStagingRecord(Rec);
                    CurrPage.Update(false);
                end;
            }
            action(RetryAllFailed)
            {
                Caption = 'Retry All Failed';
                ApplicationArea = All;
                Image = RefreshLines;
                ToolTip = 'Re-process every record currently Failed.';

                trigger OnAction()
                var
                    CRMShipToStaging: Record "CRM Ship-To Staging";
                    CRMShipToIntMgt: Codeunit "CRM Ship-To Int. Mgt.";
                begin
                    CRMShipToStaging.SetRange("Integration Status", Enum::"CRM Integration Status"::Failed);
                    if CRMShipToStaging.FindSet(true) then
                        repeat
                            CRMShipToStaging."Integration Status" := Enum::"CRM Integration Status"::Open;
                            CRMShipToStaging.Modify();
                            CRMShipToIntMgt.ProcessStagingRecord(CRMShipToStaging);
                        until CRMShipToStaging.Next() = 0;
                    CurrPage.Update(false);
                end;
            }
            action(ProcessAllOpen)
            {
                Caption = 'Process All Open';
                ApplicationArea = All;
                Image = Start;
                ToolTip = 'Process every record currently Open.';

                trigger OnAction()
                var
                    CRMShipToIntMgt: Codeunit "CRM Ship-To Int. Mgt.";
                begin
                    CRMShipToIntMgt.ProcessAllOpen();
                    CurrPage.Update(false);
                end;
            }
        }
        area(Navigation)
        {
            action(ShipToDashboard)
            {
                Caption = 'Ship-To Dashboard';
                ApplicationArea = All;
                Image = ShipAddress;
                RunObject = page "CRM Ship-To Dashboard";
            }
            action(CustomerDashboard)
            {
                Caption = 'Customer Dashboard';
                ApplicationArea = All;
                Image = Customer;
                RunObject = page "CRM Customer Dashboard";
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
