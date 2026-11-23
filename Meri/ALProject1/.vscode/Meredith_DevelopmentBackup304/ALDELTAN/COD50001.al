codeunit 50001 "VARStreet Permission"
{
    Permissions = TableData "Sales Invoice Header" = rm;

    trigger OnRun()
    begin
    end;

    procedure HasVARStreetRole(AllowSuper: Boolean): Boolean
    var
        AccessControl: Record "Access Control";
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        SalesSetup.Get;
        if SalesSetup."VARStreet Permission Set" = '' then
            exit(false);

        AccessControl.SetRange("User Security ID", UserSecurityId);
        if AllowSuper then
            AccessControl.SetFilter("Role ID", '%1|%2', 'SUPER', SalesSetup."VARStreet Permission Set")
        else
            AccessControl.SetRange("Role ID", SalesSetup."VARStreet Permission Set");
        AccessControl.SetFilter("Company Name", '%1|%2', CompanyName, '');
        if AccessControl.FindFirst then
            exit(true);

        exit(false);
    end;

    procedure EditInvoice(var SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
        SalesInvoiceHeader.Modify;
    end;
}

