// ============================================================
// Page: CRM Customer Integration API
// Object ID  : 50100
// Publisher  : Intwo
// Purpose    : BC API page CRM calls via HTTP POST to push
//              Customer Master records into BC.
// Endpoint   : .../api/intwo/crm/v1.0/customerIntegrations
// ============================================================
page 50100 "CRM Customer Integration API"
{
    PageType = API;
    APIPublisher = 'intwo';
    APIGroup = 'crm';
    APIVersion = 'v1.0';
    EntityName = 'customerIntegration';
    EntitySetName = 'customerIntegrations';
    SourceTable = "CRM Customer Staging";
    DelayedInsert = true;
    ODataKeyFields = "No.";
    InsertAllowed = true;
    ModifyAllowed = true;
    DeleteAllowed = false;
    Permissions = TableData "CRM Customer Staging" = RIMD, tabledata "CRM integration log" = RIMD;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(no; Rec."No.") { Caption = 'no'; }
                field(accountnumber; Rec."No.") { Caption = 'accountnumber'; }
                field(name; Rec.Name) { Caption = 'name'; }
                field(name2; Rec."Name 2") { Caption = 'name2'; }
                field(creditLimit; Rec."Credit Limit (LCY)") { Caption = 'creditLimit'; }
                field(address; Rec.Address) { Caption = 'address'; }
                field(address1_line1; Rec.Address) { Caption = 'address1_line1'; }
                field(address2; Rec."Address 2") { Caption = 'address2'; }
                field(address1_line2; Rec."Address 2") { Caption = 'address1_line2'; }
                field(countryRegionCode; Rec."Country/Region Code") { Caption = 'countryRegionCode'; }
                field(address1_country; Rec."Country/Region Code") { Caption = 'address1_country'; }
                field(city; Rec.City) { Caption = 'city'; }
                field(address1_city; Rec.City) { Caption = 'address1_city'; }
                field(contact; Rec.Contact) { Caption = 'contact'; }
                field(wf_billingcontact; Rec.Contact) { Caption = 'wf_billingcontact'; }
                field(email; Rec.Email) { Caption = 'email'; }
                field(wf_billingemail; Rec.Email) { Caption = 'wf_billingemail'; }
                field(postCode; Rec."Post Code") { Caption = 'postCode'; }
                field(address1_postalcode; Rec."Post Code") { Caption = 'address1_postalcode'; }
                field(vatRegistrationNo; Rec."VAT Registration No.") { Caption = 'vatRegistrationNo'; }
                field(taxLiable; Rec."Tax Liable") { Caption = 'taxLiable'; }
                field(taxAreaCode; Rec."Tax Area Code") { Caption = 'taxAreaCode'; }
                field(wf_taxcodelist; Rec."Tax Area Code") { Caption = 'wf_taxcodelist'; }
                field(taxIdentificationType; Rec."Tax Identification Type") { Caption = 'taxIdentificationType'; }
                field(registrationNo; Rec."Registration No.") { Caption = 'registrationNo'; }
                field(genBusinessPostingGroup; Rec."Gen. Business Posting Group") { Caption = 'genBusinessPostingGroup'; }
                field(customerPostingGroup; Rec."Customer Posting Group") { Caption = 'customerPostingGroup'; }
                //field(currencyCode; Rec."Currency Code") { Caption = 'currencyCode'; }
                field(paymentTermsCode; Rec."Payment Terms Code") { Caption = 'paymentTermsCode'; }
                field(wf_customerpaymentterms; Rec."Payment Terms Code") { Caption = 'wf_customerpaymentterms'; }
                field(phoneNo; Rec."Phone No.") { Caption = 'phoneNo'; }
                field(telephone1; Rec."Phone No.") { Caption = 'telephone1'; }
                field(salespersonCode; Rec."Salesperson Code") { Caption = 'salespersonCode'; }
                field(zzmd_salespersoncode; Rec."Salesperson Code") { Caption = 'zzmd_salespersoncode'; }
                field(paymentMethodCode; Rec."Payment Method Code") { Caption = 'paymentMethodCode'; }
                field(shipToCode; Rec."Ship-to Code") { Caption = 'shipToCode'; }
                field(integrationStatus; Rec."Integration Status") { Caption = 'integrationStatus'; Editable = false; }
                field(errorMessage; Rec."Error Message") { Caption = 'errorMessage'; Editable = false; }
            }
        }
    }

    // --------------------------------------------------------
    // JSON endpoint behavior:
    //   - Accept payload from CRM and store in staging.
    //   - Mark record as Open for asynchronous Job Queue pickup.
    // --------------------------------------------------------
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Created DateTime" := CurrentDateTime();
        Rec."Integration Status" := Enum::"CRM Integration Status"::Open;
        Rec."Processed DateTime" := 0DT;
        Rec."Error Message" := '';
        exit(true); // Let platform insert staged record
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Rec."Integration Status" := Enum::"CRM Integration Status"::Open;
        Rec."Processed DateTime" := 0DT;
        Rec."Error Message" := '';
        exit(true); // Let platform apply changes and re-queue record
    end;
}
