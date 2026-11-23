page 50007 "Comm. Credit Card Backcharges"
{
    CardPageID = "Comm. Credit Card Backcharge";
    Editable = false;
    PageType = List;
    SourceTable = "Comm. Credit Card Backcharge";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                }
                field("Sell-to County"; Rec."Sell-to County")
                {
                }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
            }
        }
    }

    actions
    {
    }
}

