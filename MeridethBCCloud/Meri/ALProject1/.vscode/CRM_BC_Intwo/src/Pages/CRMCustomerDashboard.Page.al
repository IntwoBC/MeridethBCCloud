// ============================================================
// Page: CRM Customer Dashboard
// Object ID  : 50102
// Publisher  : Intwo
// Purpose    : Monitor Customer Master staging records; retry
//              failed records individually or in bulk.
// ============================================================
page 50102 "CRM Customer Dashboard"
{
    PageType = List;
    Caption = 'CRM Customer Integration Dashboard';
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CRM Customer Staging";
    CardPageId = "CRM Customer Staging Card";

    layout
    {
        area(Content)
        {
            repeater(Records)
            {
                field("No."; Rec."No.") { ApplicationArea = All; }
                field(Name; Rec.Name) { ApplicationArea = All; }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field.', Comment = '%';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ToolTip = 'Specifies the value of the Address 2 field.', Comment = '%';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the value of the City field.', Comment = '%';
                }
                field(Contact; Rec.Contact)
                {
                    ToolTip = 'Specifies the value of the Contact field.', Comment = '%';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ToolTip = 'Specifies the value of the Country/Region Code field.', Comment = '%';
                }
                field("Credit Limit (LCY)"; Rec."Credit Limit (LCY)")
                {
                    ToolTip = 'Specifies the value of the Credit Limit (LCY) field.', Comment = '%';
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ToolTip = 'Specifies the value of the Customer Posting Group field.', Comment = '%';
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field.', Comment = '%';
                }
                field("Gen. Business Posting Group"; Rec."Gen. Business Posting Group")
                {
                    ToolTip = 'Specifies the value of the Gen. Business Posting Group field.', Comment = '%';
                }
                field("Name 2"; Rec."Name 2")
                {
                    ToolTip = 'Specifies the value of the Name 2 field.', Comment = '%';
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ToolTip = 'Specifies the value of the Payment Method Code field.', Comment = '%';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ToolTip = 'Specifies the value of the Payment Terms Code field.', Comment = '%';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the value of the Phone No. field.', Comment = '%';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Specifies the value of the Post Code field.', Comment = '%';
                }
                field("Registration No."; Rec."Registration No.")
                {
                    ToolTip = 'Specifies the value of the Registration No. field.', Comment = '%';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ToolTip = 'Specifies the value of the Salesperson Code field.', Comment = '%';
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTip = 'Specifies the value of the Ship-to Code field.', Comment = '%';
                }
                field("Location Code";Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.', Comment = '%';
                }
                field("Tax Identification Type"; Rec."Tax Identification Type")
                {
                    ToolTip = 'Specifies the value of the Tax Identification Type field.', Comment = '%';
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ToolTip = 'Specifies the value of the Tax Liable field.', Comment = '%';
                }
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    ToolTip = 'Specifies the value of the VAT Registration No. field.', Comment = '%';
                }
                field("Tax Area Code"; Rec."Tax Area Code") { ApplicationArea = All; }
                //field("Currency Code"; Rec."Currency Code") { ApplicationArea = All; }
                field("Integration Status"; Rec."Integration Status")
                {
                    ApplicationArea = All;
                    StyleExpr = StatusStyle;
                }
                field("Error Message"; Rec."Error Message") { ApplicationArea = All; }
                field("Created DateTime"; Rec."Created DateTime") { ApplicationArea = All; }
                field("Processed DateTime"; Rec."Processed DateTime") { ApplicationArea = All; }
                field("Retry Count"; Rec."Retry Count") { ApplicationArea = All; }
            }
        }
        area(FactBoxes)
        {
            // FactBox correctly references the ListPart Page (50105),
            // not the table directly — see header comment in that page.
            part(ShipToFactBox; "CRM Ship-To Staging Factbox")
            {
                ApplicationArea = All;
                Caption = 'Related Ship-To Records';
                SubPageLink = "Customer No." = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(RetrySelected)
            {
                Caption = 'Retry Selected';
                ApplicationArea = All;
                Image = Refresh;
                ToolTip = 'Re-process the selected staging record through BC.';

                trigger OnAction()
                var
                    CRMCustomerIntMgt: Codeunit "CRM Customer Int. Mgt.";
                begin
                    Rec."Integration Status" := Enum::"CRM Integration Status"::Open;
                    //Rec.Modify();
                    CRMCustomerIntMgt.ProcessStagingRecord(Rec);
                    CurrPage.Update(false);
                end;
            }
            action(RetryAllFailed)
            {
                Caption = 'Retry All Failed';
                ApplicationArea = All;
                Image = RefreshLines;
                ToolTip = 'Re-process every record currently in Failed status.';

                trigger OnAction()
                var
                    CRMCustomerStaging: Record "CRM Customer Staging";
                    CRMCustomerIntMgt: Codeunit "CRM Customer Int. Mgt.";
                begin
                    CRMCustomerStaging.SetRange("Integration Status", Enum::"CRM Integration Status"::Failed);
                    if CRMCustomerStaging.FindSet(true) then
                        repeat
                            CRMCustomerStaging."Integration Status" := Enum::"CRM Integration Status"::Open;
                            CRMCustomerStaging.Modify();
                            CRMCustomerIntMgt.ProcessStagingRecord(CRMCustomerStaging);
                        until CRMCustomerStaging.Next() = 0;
                    CurrPage.Update(false);
                end;
            }
            action(ProcessAllOpen)
            {
                Caption = 'Process All Open';
                ApplicationArea = All;
                Image = Start;
                ToolTip = 'Process every record currently in Open status.';

                trigger OnAction()
                var
                    CRMCustomerIntMgt: Codeunit "CRM Customer Int. Mgt.";
                begin
                    CRMCustomerIntMgt.ProcessAllOpen();
                    CurrPage.Update(false);
                end;
            }
        }
        area(Navigation)
        {
            action(ShipToDashboard)
            {
                Caption = 'Ship-To Dashboard';
                ApplicationArea = All;
                Image = ShipAddress;
                RunObject = page "CRM Ship-To Dashboard";
            }
            action(ItemDashboard)
            {
                Caption = 'Item Push Dashboard';
                ApplicationArea = All;
                Image = ItemAvailability;
                RunObject = page "CRM Item Dashboard";
            }
            action(InvoiceDashboard)
            {
                Caption = 'Sales Invoice Push Dashboard';
                ApplicationArea = All;
                Image = SalesInvoice;
                RunObject = page "CRM Sales Inv. Dashboard";
            }
        }
    }

    var
        StatusStyle: Text;

    trigger OnAfterGetRecord()
    begin
        StatusStyle := GetStatusStyle(Rec."Integration Status");
    end;

    local procedure GetStatusStyle(Status: Enum "CRM Integration Status"): Text
    begin
        case Status of
            Status::Success:
                exit('Favorable');
            Status::Failed:
                exit('Unfavorable');
            else
                exit('Ambiguous');
        end;
    end;
}
