report 50006 "Item - Clean Desc"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                if CopyStr(Description, 1, 1) = '"' then begin
                    Description := CopyStr(Description, 2);
                    if CopyStr(Description, StrLen(Description), 1) = '"' then
                        Description := CopyStr(Description, 1, StrLen(Description) - 1);
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
}

