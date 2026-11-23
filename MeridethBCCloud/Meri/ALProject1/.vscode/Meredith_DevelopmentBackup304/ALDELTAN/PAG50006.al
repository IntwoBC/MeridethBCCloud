page 50006 "Comm. Credit Card Backcharge"
{
    PageType = Card;
    SourceTable = "Comm. Credit Card Backcharge";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {

                    trigger OnAssistEdit()
                    begin
                        //if AssistEdit(xRec) then
                        CurrPage.Update;
                    end;
                }
                field("Reference No."; Rec."Reference No.")
                {
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    Editable = false;
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    Editable = false;
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    Editable = false;
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    Editable = false;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    Editable = false;
                }
                field("Sell-to County"; Rec."Sell-to County")
                {
                    Editable = false;
                }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                {
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    Enabled = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Posting)
            {
                action(Post)
                {
                    Image = PostOrder;

                    trigger OnAction()
                    begin
                        Rec.PostRecord;
                    end;
                }
            }
        }
    }
}

