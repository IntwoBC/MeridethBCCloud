report 50091 "Update Doc Comm Chgs"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {

            trigger OnAfterGetRecord()
            begin
                Clear(DocCommChgs);
                DocCommChgs.Init;
                DocCommChgs."Document Type" := "Document Type";
                DocCommChgs."No." := "No.";
                DocCommChgs."Salesperson Commission Amount" := "Salesperson Commission Amount";
                DocCommChgs."Salesperson Order Fee" := "Salesperson Order Fee";
                DocCommChgs."Salesperson Misc. Charge" := "Salesperson Misc. Charge";
                DocCommChgs."Credit Card Charges" := "Credit Card Charges";
                DocCommChgs.Insert;

                "Salesperson Commission Amount" := 0;
                "Salesperson Order Fee" := 0;
                "Salesperson Misc. Charge" := 0;
                "Credit Card Charges" := 0;
                Modify;
            end;

            trigger OnPostDataItem()
            begin
                Message('Done');
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
        DocCommChgs: Record "Document Commission Charges";
}

