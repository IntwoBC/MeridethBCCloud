// ============================================================
// Codeunit: CRM Customer Job Queue Runner
// Object ID  : 50114
// Purpose    : Job Queue entry point to process all Open
//              customer staging records asynchronously.
// ============================================================
codeunit 50114 "CRM Customer Job Queue Runner"
{
    Permissions = TableData "CRM Customer Staging" = RIMD, TableData "CRM Ship-To Staging" = RIMD, TableData Customer = RIMD, TableData "CRM Integration Log" = RIMD;

    trigger OnRun()
    var
        CRMCustomerStaging: Record "CRM Customer Staging";
        CRMCustomerIntMgt: Codeunit "CRM Customer Int. Mgt.";
    begin
        CRMCustomerStaging.SetRange("Integration Status", Enum::"CRM Integration Status"::Open);
        if not CRMCustomerStaging.FindSet(true) then
            exit;

        repeat
            CRMCustomerIntMgt.ProcessStagingRecord(CRMCustomerStaging);
        until CRMCustomerStaging.Next() = 0;
    end;
}
