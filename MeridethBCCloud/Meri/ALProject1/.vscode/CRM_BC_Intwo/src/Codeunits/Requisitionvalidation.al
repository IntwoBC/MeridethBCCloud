codeunit 50002 "Req Worksheet Subscriber"
{
    [EventSubscriber(ObjectType::Report,
                     Report::"Get Sales Orders",
                     'OnBeforeInsertReqWkshLine',
                     '',
                     false,
                     false)]
    local procedure OnBeforeInsertReqWkshLine(
        var ReqLine: Record "Requisition Line";
        SalesLine: Record "Sales Line";
        SpecOrder: Integer)
    begin
        // Example: validate Vendor No.
        if SalesLine."Vendor No." = '' then
            Error(
              'Vendor No. must be specified on Sales Order %1 Line %2.',
              SalesLine."Document No.",
              SalesLine."Line No.");

        ReqLine.Validate("Vendor No.", SalesLine."Vendor No.");
    end;
}