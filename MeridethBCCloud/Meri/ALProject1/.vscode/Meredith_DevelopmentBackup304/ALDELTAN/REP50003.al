report 50003 "Item Burden Rate by Item Cat."
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.", "Item Category Code";

            trigger OnAfterGetRecord()
            begin
                if "Item Category Code" <> '' then begin
                    ItemCategory.Get("Item Category Code");
                    Validate("Burden Rate", ItemCategory."Burden Rate");
                    Modify;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ItemCategory: Record "Item Category";
}

