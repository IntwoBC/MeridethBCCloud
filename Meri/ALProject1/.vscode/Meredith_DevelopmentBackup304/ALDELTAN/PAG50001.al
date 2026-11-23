page 50001 "Comment Line Factbox"
{
    Editable = false;
    PageType = CardPart;
    SourceTable = "Comment Line";
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1240060001)
            {
                ShowCaption = false;
                field(Date; rec.Date)
                {
                    ApplicationArea = all;
                }
                field("Code"; rec.Code)
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Comment; rec.Comment)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

