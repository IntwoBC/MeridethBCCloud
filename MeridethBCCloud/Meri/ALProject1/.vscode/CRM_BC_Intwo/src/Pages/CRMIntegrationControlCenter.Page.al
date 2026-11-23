// ============================================================
// Page: CRM Integration Control Center
// Object ID  : 50110
// Publisher  : Intwo
// Purpose    : Single entry-point landing page linking to all
//              four dashboards (Customer, Ship-To, Item, Invoice).
//              Set as startupObjectId in launch.json for quick
//              access when pressing F5 in VS Code.
// ============================================================
page 50110 "CRM Integration Control Ctr"
{
    PageType = Card;
    Caption = 'CRM <-> BC Integration Control Center';
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CRM Customer Staging";

    layout
    {
        area(Content)
        {
            group(Summary)
            {
                Caption = 'Integration Overview';
                label(Info)
                {
                    ApplicationArea = All;
                    Caption = 'Use the actions below to open each integration dashboard. Pull flows (CRM to BC) cover Customer Master and Ship-To Address. Push flows (BC to CRM) cover Item Master and Sales Invoices.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(OpenIntegrationSetup)
            {
                Caption = 'Integration Setup';
                ApplicationArea = All;
                Image = Setup;
                RunObject = page "CRM Integration Setup";
            }
            action(OpenIntegrationLogs)
            {
                Caption = 'Integration Logs';
                ApplicationArea = All;
                Image = Log;
                RunObject = page "CRM Integration Log Entries";
            }
            action(OpenCustomerDashboard)
            {
                Caption = 'Customer Master (Pull)';
                ApplicationArea = All;
                Image = Customer;
                RunObject = page "CRM Customer Dashboard";
            }
            action(OpenShipToDashboard)
            {
                Caption = 'Ship-To Address (Pull)';
                ApplicationArea = All;
                Image = ShipAddress;
                RunObject = page "CRM Ship-To Dashboard";
            }
            action(OpenItemDashboard)
            {
                Caption = 'Item Master (Push)';
                ApplicationArea = All;
                Image = ItemAvailability;
                RunObject = page "CRM Item Dashboard";
            }
            action(OpenInvoiceDashboard)
            {
                Caption = 'Sales Invoice (Push)';
                ApplicationArea = All;
                Image = SalesInvoice;
                RunObject = page "CRM Sales Inv. Dashboard";
            }
        }
    }
}
