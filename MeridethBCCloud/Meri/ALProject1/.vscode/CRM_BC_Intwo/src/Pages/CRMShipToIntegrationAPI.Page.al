// ============================================================
// Page: CRM Ship-To Integration API
// Object ID  : 50101
// Publisher  : Intwo
// Purpose    : BC API page CRM calls via HTTP POST to push
//              Ship-To Address records into BC.
// Endpoint   : .../api/intwo/crm/v1.0/shipToIntegrations
// ============================================================
page 50101 "CRM Ship-To Integration API"
{
    PageType = API;
    APIPublisher = 'intwo';
    APIGroup = 'crm';
    APIVersion = 'v1.0';
    EntityName = 'shipToIntegration';
    EntitySetName = 'shipToIntegrations';
    SourceTable = "CRM Ship-To Staging";
    DelayedInsert = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(customerNo; Rec."Customer No.") { Caption = 'customerNo'; }
                field(accountnumber; Rec."Customer No.") { Caption = 'accountnumber'; }
                field(code; Rec.Code) { Caption = 'code'; }
                field(name; Rec.Name) { Caption = 'name'; }
                field(address1_name; Rec.Name) { Caption = 'address1_name'; }
                field(address; Rec.Address) { Caption = 'address'; }
                field(address1_line1; Rec.Address) { Caption = 'address1_line1'; }
                field(address2; Rec."Address 2") { Caption = 'address2'; }
                field(address1_line2; Rec."Address 2") { Caption = 'address1_line2'; }
                field(city; Rec.City) { Caption = 'city'; }
                field(address1_city; Rec.City) { Caption = 'address1_city'; }
                field(countryRegionCode; Rec."Country/Region Code") { Caption = 'countryRegionCode'; }
                field(address1_country; Rec."Country/Region Code") { Caption = 'address1_country'; }
                field(phoneNo; Rec."Phone No.") { Caption = 'phoneNo'; }
                field(telephone1; Rec."Phone No.") { Caption = 'telephone1'; }
                field(contact; Rec.Contact) { Caption = 'contact'; }
                field(fullname; Rec.Contact) { Caption = 'fullname'; }
                field(email; Rec.Email) { Caption = 'email'; }
                field(emailaddress1; Rec.Email) { Caption = 'emailaddress1'; }
                field(locationCode; Rec."Location Code") { Caption = 'locationCode'; }
                field(postCode; Rec."Post Code") { Caption = 'postCode'; }
                field(address1_postalcode; Rec."Post Code") { Caption = 'address1_postalcode'; }
                field(salespersonCode; Rec."Salesperson Code") { Caption = 'salespersonCode'; }
                field(zzmd_salespersoncode; Rec."Salesperson Code") { Caption = 'zzmd_salespersoncode'; }
                field(taxLiable; Rec."Tax Liable") { Caption = 'taxLiable'; }
                field(taxAreaCode; Rec."Tax Area Code") { Caption = 'taxAreaCode'; }
                field(wf_taxcodelist; Rec."Tax Area Code") { Caption = 'wf_taxcodelist'; }
                field(integrationStatus; Rec."Integration Status") { Caption = 'integrationStatus'; Editable = false; }
                field(errorMessage; Rec."Error Message") { Caption = 'errorMessage'; Editable = false; }
            }
        }
    }

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
