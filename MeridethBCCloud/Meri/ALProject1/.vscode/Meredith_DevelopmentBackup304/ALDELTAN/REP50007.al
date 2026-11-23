report 50007 "Fix SIH for Scribe"
{
    // MDI0001 TLE 11/03/14 Modify for PSI006402
    // MDI0002 TLE 11/07/14 Modify for PSI000642

    Permissions = TableData "Sales Invoice Header" = rm;
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = WHERE("No." = FILTER('PSI006402'));
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                // TLE 11-01-14 >>
                "EU 3-Party Trade" := false;
                //"EU 3-Party Trade" := TRUE;
                //"Electronic Invoice Type" := "Electronic Invoice Type"::Paper;
                //"Electronic Invoice Type" := "Electronic Invoice Type"::"0";
                // TLE 11-01-14 <<
                Modify;
                //MESSAGE('EU 3-Party Trade: %1 %2 %3',"No.","EU 3-Party Trade","Electronic Invoice Type");
            end;

            trigger OnPreDataItem()
            begin
                // TLE 11-01-14 >>
                //EVALUATE(StartDate,'08/12/14');
                //SETFILTER("Posting Date",'>=%1',StartDate);
                //MESSAGE('%1',GETFILTERS);
                // TLE 11-01-14 <<
            end;
        }
        dataitem(Item; Item)
        {
            DataItemTableView = WHERE("No." = FILTER('TTP PP 23"'));

            trigger OnAfterGetRecord()
            begin
                // TLE 11-05-14 >>
                "Net Weight" := 1;
                //MODIFY;
                //MESSAGE('Item %1 Net Weight %2',"No.","Net Weight");
                // TLE 11-05-14 <<
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

    trigger OnPostReport()
    begin
        Message('Done marking');
    end;

    var
        StartDate: Date;
}

