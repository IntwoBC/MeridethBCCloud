// ============================================================
// Codeunit: CRM Ship-To Job Queue Runner
// Object ID  : 50116
// Purpose    : Job Queue entry point to process all Open
//              ship-to staging records asynchronously.
// ============================================================
codeunit 50116 "CRM Ship-To Job Queue Runner"
{
    Permissions = TableData "CRM Customer Staging" = RIMD, TableData "CRM Ship-To Staging" = RIMD, TableData Customer = RIMD, TableData "CRM Integration Log" = RIMD;

    trigger OnRun()
    var
        CRMShipToStaging: Record "CRM Ship-To Staging";
        CRMShipToIntMgt: Codeunit "CRM Ship-To Int. Mgt.";
    begin
        CRMShipToStaging.SetRange("Integration Status", Enum::"CRM Integration Status"::Open);
        if not CRMShipToStaging.FindSet(true) then
            exit;

        repeat
            CRMShipToIntMgt.ProcessStagingRecord(CRMShipToStaging);
        until CRMShipToStaging.Next() = 0;
    end;
}
