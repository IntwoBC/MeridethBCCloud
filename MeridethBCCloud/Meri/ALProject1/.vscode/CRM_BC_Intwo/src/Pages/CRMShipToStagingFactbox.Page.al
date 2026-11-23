// ============================================================
// Page: CRM Ship-To Staging Factbox
// Object ID  : 50105
// Publisher  : Intwo
// Purpose    : ListPart FactBox embedded on the Customer
//              Dashboard, showing related Ship-To records for
//              the currently selected customer.
// NOTE       : A part() inside area(FactBoxes) MUST reference a
//              Page object (ListPart/CardPart), never a Table
//              directly — that is what causes the AL0118 /
//              "cannot convert" compile error.
// ============================================================
page 50105 "CRM Ship-To Staging Factbox"
{
    PageType = ListPart;
    Caption = 'Related Ship-To Records';
    SourceTable = "CRM Ship-To Staging";
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Customer No."; Rec."Customer No.") { ApplicationArea = All; }
                field(Code; Rec.Code) { ApplicationArea = All; }
                field(City; Rec.City) { ApplicationArea = All; }
                field("Integration Status"; Rec."Integration Status")
                {
                    ApplicationArea = All;
                    StyleExpr = StatusStyle;
                }
                field("Error Message"; Rec."Error Message") { ApplicationArea = All; }
            }
        }
    }

    var
        StatusStyle: Text;

    trigger OnAfterGetRecord()
    begin
        StatusStyle := GetStatusStyle(Rec."Integration Status");
    end;

    // --------------------------------------------------------
    // PRIVATE: Shared style-mapping helper. Duplicated logic
    //          is intentional here since AL pages cannot share
    //          local procedures across object boundaries without
    //          a common codeunit; kept inline for simplicity.
    // --------------------------------------------------------
    local procedure GetStatusStyle(Status: Enum "CRM Integration Status"): Text
    begin
        case Status of
            Status::Success:
                exit('Favorable');
            Status::Failed:
                exit('Unfavorable');
            else
                exit('Ambiguous');
        end;
    end;
}
