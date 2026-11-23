report 50092 "Reset Line Amount Price in SIL"
{
    Permissions = TableData "Sales Invoice Line" = rm;
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Invoice Line"; "Sales Invoice Line")
        {

            trigger OnAfterGetRecord()
            begin
                "Line Amount Cost" := 0;
                Modify;
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

