page 50112 "CRM Integration Log Entries"
{
    PageType = List;
    Caption = 'CRM Integration Log Entries';
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CRM Integration Log";
    SourceTableView = sorting("Entry No.") order(descending);
    CardPageId = "CRM Integration Log Card";

    layout
    {
        area(Content)
        {
            repeater(Records)
            {
                field("Entry No."; Rec."Entry No.") { ApplicationArea = All; }
                field("Integration Area"; Rec."Integration Area") { ApplicationArea = All; }
                field(Direction; Rec.Direction) { ApplicationArea = All; }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    StyleExpr = StatusStyle;
                }
                field("Error Text"; Rec."Error Text")
                {
                    ApplicationArea = All;
                    Style = Attention;
                }
                field(URL; Rec.URL) { ApplicationArea = All; }
                field("Request Time"; Rec."Request Time") { ApplicationArea = All; }
                field("Response Time"; Rec."Response Time") { ApplicationArea = All; }
                field("Logged DateTime"; Rec."Logged DateTime") { ApplicationArea = All; }
                field("Record No."; Rec."Record No.") { ApplicationArea = All; }
                field("Reference No."; Rec."Reference No.") { ApplicationArea = All; }
                field("Attempt No."; Rec."Attempt No.") { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(Processing)
        {
        }
    }

    var
        StatusStyle: Text;

    trigger OnAfterGetRecord()
    begin
        case Rec.Status of
            Rec.Status::Success:
                StatusStyle := 'Favorable';
            Rec.Status::Failed:
                StatusStyle := 'Unfavorable';
            else
                StatusStyle := 'Ambiguous';
        end;
    end;
}
