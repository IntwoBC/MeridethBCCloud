page 50014 "Fix CrMemo Commission Amt"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    Permissions = TableData "Cust. Ledger Entry" = rm,
                  TableData "Sales Cr.Memo Header" = rm;
    SourceTable = "Sales Cr.Memo Header";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Salesperson Commission Amount"; Rec."Salesperson Commission Amount")
                {

                    trigger OnValidate()
                    begin
                        CLE.SetRange("Document Type", CLE."Document Type"::"Credit Memo");
                        CLE.SetRange("Document No.", Rec."No.");
                        CLE.Find('-');
                        CLE."Salesperson Commission Amount" := -1 * Rec."Salesperson Commission Amount";
                        CLE.Modify;
                    end;
                }
            }
        }
    }

    actions
    {
    }

    var
        CLE: Record "Cust. Ledger Entry";
}

