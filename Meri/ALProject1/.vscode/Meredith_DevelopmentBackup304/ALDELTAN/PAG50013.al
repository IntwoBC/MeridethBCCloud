page 50013 "Fix SIH Commission Amt"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    Permissions = TableData "Cust. Ledger Entry" = rm,
                  TableData "Sales Invoice Header" = rm;
    SourceTable = "Sales Invoice Header";
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
                        CLE.SetRange("Document Type", CLE."Document Type"::Invoice);
                        CLE.SetRange("Document No.", Rec."No.");
                        CLE.Find('-');
                        CLE."Salesperson Commission Amount" := Rec."Salesperson Commission Amount";
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

