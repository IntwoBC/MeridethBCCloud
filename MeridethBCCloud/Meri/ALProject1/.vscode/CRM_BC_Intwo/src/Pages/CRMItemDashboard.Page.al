// ============================================================
// Page: CRM Item Dashboard
// Object ID  : 50104
// Publisher  : Intwo
// Purpose    : Monitor outbound Item Master push records from
//              BC to CRM.
// ============================================================
page 50104 "CRM Item Dashboard"
{
    PageType = List;
    Caption = 'CRM Item Push Dashboard';
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CRM Item Staging";

    layout
    {
        area(Content)
        {
            repeater(Records)
            {
                field("No."; Rec."No.") { ApplicationArea = All; }
                field(Description; Rec.Description) { ApplicationArea = All; }
                field("Item Category Code"; Rec."Item Category Code") { ApplicationArea = All; }
                field("Unit Cost"; Rec."Unit Cost") { ApplicationArea = All; }
                field("Base Unit of Measure"; Rec."Base Unit of Measure") { ApplicationArea = All; }
                field("Integration Status"; Rec."Integration Status")
                {
                    ApplicationArea = All;
                    StyleExpr = StatusStyle;
                }
                field("Latest Method"; Rec."Latest Method") { ApplicationArea = All; }
                field("CRM Record ID"; Rec."CRM Record ID") { ApplicationArea = All; }
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
            action(PushSelectedItem)
            {
                Caption = 'Push Selected Item Again';
                ApplicationArea = All;
                Image = Refresh;
                ToolTip = 'Re-push the selected item record to CRM.';

                trigger OnAction()
                var
                    CRMItemIntMgt: Codeunit "CRM Item Int. Mgt.";
                begin
                    Rec."Integration Status" := Enum::"CRM Integration Status"::Open;
                    Rec.Modify();
                    CRMItemIntMgt.ProcessStagingRecord(Rec);
                    CurrPage.Update(false);
                end;
            }
            action(PushAllOpen)
            {
                Caption = 'Push All Open';
                ApplicationArea = All;
                Image = Start;
                ToolTip = 'Push every Open item record to CRM.';

                trigger OnAction()
                var
                    CRMItemIntMgt: Codeunit "CRM Item Int. Mgt.";
                begin
                    CRMItemIntMgt.ProcessAllOpen();
                    CurrPage.Update(false);
                end;
            }
            action(StageAllBCItems)
            {
                Caption = 'Stage All BC Items';
                ApplicationArea = All;
                Image = ImportExport;
                ToolTip = 'Reads every Item in BC and re-stages it for push to CRM.';

                trigger OnAction()
                var
                    Item: Record Item;
                    CRMItemIntMgt: Codeunit "CRM Item Int. Mgt.";
                    Counter: Integer;
                begin
                    //   Item.SetRange("No.", '006R04367TEST');
                    if Item.FindSet() then
                        repeat
                            CRMItemIntMgt.StageAndPushItem(Item);
                            Counter += 1;
                        until Item.Next() = 0;
                    Message('%1 item(s) staged and pushed.', Counter);
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
