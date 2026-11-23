page 50010 "Salesperson Goal List"
{
    PageType = List;
    SourceTable = "Salesperson Goal";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                }
                field(Year; Rec.Year)
                {
                }
                field(Month; Rec.Month)
                {
                }
                field(Goal; Rec.Goal)
                {
                }
            }
        }
    }

    actions
    {
    }
}

