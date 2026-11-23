// ============================================================
// Page: CRM Customer Staging Card
// Object ID  : 50106
// Publisher  : Intwo
// Purpose    : Detail card for a single Customer Staging record,
//              used as CardPageId drill-down from the Dashboard
//              list (50102). Allows manual field correction
//              before retrying a Failed record.
// ============================================================
page 50106 "CRM Customer Staging Card"
{
    PageType = Card;
    Caption = 'CRM Customer Staging Detail';
    ApplicationArea = All;
    SourceTable = "CRM Customer Staging";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.") { ApplicationArea = All; }
                field(Name; Rec.Name) { ApplicationArea = All; }
                field("Name 2"; Rec."Name 2") { ApplicationArea = All; }
                field("Credit Limit (LCY)"; Rec."Credit Limit (LCY)") { ApplicationArea = All; }
            }
            group(AddressDetails)
            {
                Caption = 'Address';
                field(Address; Rec.Address) { ApplicationArea = All; }
                field("Address 2"; Rec."Address 2") { ApplicationArea = All; }
                field(City; Rec.City) { ApplicationArea = All; }
                field("Country/Region Code"; Rec."Country/Region Code") { ApplicationArea = All; }
                 field(State; Rec.State)
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code") { ApplicationArea = All; }
                field(Contact; Rec.Contact) { ApplicationArea = All; }
                field(Email; Rec.Email) { ApplicationArea = All; }
                field("Phone No."; Rec."Phone No.") { ApplicationArea = All; }
            }
            group(TaxAndPosting)
            {
                Caption = 'Tax / Posting';
                field("Tax Liable"; Rec."Tax Liable") { ApplicationArea = All; }
                field("Tax Area Code"; Rec."Tax Area Code") { ApplicationArea = All; }
                field("Tax Identification Type"; Rec."Tax Identification Type") { ApplicationArea = All; }
                field("VAT Registration No."; Rec."VAT Registration No.") { ApplicationArea = All; }
                field("Registration No."; Rec."Registration No.") { ApplicationArea = All; }
                field("Gen. Business Posting Group"; Rec."Gen. Business Posting Group") { ApplicationArea = All; }
                field("Customer Posting Group"; Rec."Customer Posting Group") { ApplicationArea = All; }
            }
            group(PaymentDetails)
            {
                Caption = 'Payment';
                // field("Currency Code"; Rec."Currency Code") { ApplicationArea = All; }
                field("Payment Terms Code"; Rec."Payment Terms Code") { ApplicationArea = All; }
                field("Payment Method Code"; Rec."Payment Method Code") { ApplicationArea = All; }
                field("Salesperson Code"; Rec."Salesperson Code") { ApplicationArea = All; }
                field("Ship-to Code"; Rec."Ship-to Code") { ApplicationArea = All; }
            }
            group(IntegrationDetails)
            {
                Caption = 'Integration Status';
                field("Integration Status"; Rec."Integration Status") { ApplicationArea = All; }
                field("Error Message"; Rec."Error Message") { ApplicationArea = All; }
                field("Created DateTime"; Rec."Created DateTime") { ApplicationArea = All; }
                field("Processed DateTime"; Rec."Processed DateTime") { ApplicationArea = All; }
                field("Retry Count"; Rec."Retry Count") { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Retry)
            {
                Caption = 'Retry';
                ApplicationArea = All;
                Image = Refresh;
                ToolTip = 'Re-process this record after correcting values.';

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
        }
    }
}
