page 50011 "Document Commission Charges"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Document Commission Charges";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Salesperson Commission Amount"; rec."Salesperson Commission Amount")
                {
                }
                field("Salesperson Order Fee"; Rec."Salesperson Order Fee")
                {
                }
                field("Salesperson Misc. Charge"; Rec."Salesperson Misc. Charge")
                {
                }
                field("Credit Card Charges"; Rec."Credit Card Charges")
                {
                }
            }
        }
    }

    actions
    {
    }
}

