report 50090 "Update New Sales Line Fields"
{
    Permissions = TableData "Sales Shipment Line" = rm,
                  TableData "Sales Invoice Line" = rm,
                  TableData "Sales Cr.Memo Line" = rm;
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {

            trigger OnAfterGetRecord()
            begin
                "Sales Line"."Line Amount Price" := "Sales Line"."Qty. to Invoice" * "Sales Line"."Unit Price" - "Line Discount Amount";
                "Sales Line"."Line Amount Cost" := "Sales Line"."Qty. to Invoice" * "Sales Line"."Unit Cost";
                "Sales Line".Modify;
            end;
        }
        dataitem("Sales Shipment Line"; "Sales Shipment Line")
        {

            trigger OnAfterGetRecord()
            begin
                "Sales Shipment Line"."Line Amount Price" := "VAT Base Amount";
                "Sales Shipment Line"."Line Amount Cost" := "Sales Shipment Line".Quantity * "Sales Shipment Line"."Unit Cost";
                "Sales Shipment Line".Modify;
            end;
        }
        dataitem("Sales Invoice Line"; "Sales Invoice Line")
        {

            trigger OnAfterGetRecord()
            begin
                "Sales Invoice Line"."Line Amount Price" := "Sales Invoice Line"."VAT Base Amount";
                "Sales Invoice Line"."Line Amount Cost" := "Sales Invoice Line".Quantity * "Sales Invoice Line"."Unit Cost";
                "Sales Invoice Line".Modify;
            end;
        }
        dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
        {

            trigger OnAfterGetRecord()
            begin
                "Sales Cr.Memo Line"."Line Amount Price" := "Sales Cr.Memo Line"."VAT Base Amount";
                "Sales Cr.Memo Line"."Line Amount Cost" := "Sales Cr.Memo Line".Quantity * "Sales Cr.Memo Line"."Unit Cost";
                "Sales Cr.Memo Line".Modify;
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

