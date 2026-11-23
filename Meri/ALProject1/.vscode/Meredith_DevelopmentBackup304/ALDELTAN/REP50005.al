report 50005 "SIH CC Charges"
{
    DefaultLayout = RDLC;
    RDLCLayout = './SIH CC Charges.rdlc';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = WHERE("No." = CONST('PSI000041'));

            trigger OnAfterGetRecord()
            begin
                "Credit Card Charges" := 0;
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

