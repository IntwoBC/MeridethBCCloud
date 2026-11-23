codeunit 50121 "CRM Integration Log Mgt."
{

    Permissions = tabledata "CRM Customer Staging" = RIMD, tabledata "CRM Ship-To Staging" = RIMD, tabledata Customer = RIMD, tabledata "CRM Integration Log" = RIMD;


    procedure WriteLog(IntegrationArea: Text[30]; Direction: Text[100]; RecordNo: Code[20]; ReferenceNo: Text[50]; Status: Enum "CRM Integration Status"; LogMessage: Text; SourceTableId: Integer; AttemptNo: Integer)
    var
        LogRec: Record "CRM Integration Log";
    begin
        LogRec.Init();
        LogRec."Logged DateTime" := CurrentDateTime();
        LogRec."Integration Area" := IntegrationArea;
        LogRec.Direction := Direction;
        LogRec."Record No." := RecordNo;
        LogRec."Reference No." := CopyStr(ReferenceNo, 1, 50);
        LogRec.Status := Status;
        LogRec.Message := CopyStr(LogMessage, 1, 250);
        LogRec."Source Table ID" := SourceTableId;
        LogRec."Attempt No." := AttemptNo;
        LogRec."User ID" := CopyStr(UserId(), 1, 50);

        if Status = Status::Open then
            LogRec."Request Time" := CurrentDateTime()
        else begin
            LogRec."Response Time" := CurrentDateTime();
            LogRec.SetResponseData(LogMessage);
            if Status = Status::Failed then
                LogRec."Error Text" := CopyStr(LogMessage, 1, MaxStrLen(LogRec."Error Text"));
        end;

        LogRec.Insert(true);
    end;

    procedure InsertLog(IntegrationArea: Text[30]; Direction: Text[10]; RecordNo: Code[20]; ReferenceNo: Text[50]; SourceTableId: Integer; AttemptNo: Integer; RequestData: Text; RequestUrl: Text): Integer
    var
        LogRec: Record "CRM Integration Log";
    begin
        LogRec.Init();
        LogRec."Logged DateTime" := CurrentDateTime();
        LogRec."Integration Area" := IntegrationArea;
        LogRec.Direction := Direction;
        LogRec."Record No." := RecordNo;
        LogRec."Reference No." := CopyStr(ReferenceNo, 1, MaxStrLen(LogRec."Reference No."));
        LogRec.Status := LogRec.Status::Open;
        LogRec."Source Table ID" := SourceTableId;
        LogRec."Attempt No." := AttemptNo;
        LogRec."User ID" := CopyStr(UserId(), 1, MaxStrLen(LogRec."User ID"));
        LogRec.URL := CopyStr(RequestUrl, 1, MaxStrLen(LogRec.URL));
        LogRec."Request Time" := CurrentDateTime();
        LogRec.SetRequestData(RequestData);
        LogRec.Insert(true);

        exit(LogRec."Entry No.");
    end;

    procedure ModifyLog(EntryNo: Integer; Status: Enum "CRM Integration Status"; ErrorText: Text; ResponseData: Text)
    var
        LogRec: Record "CRM Integration Log";
    begin
        if not LogRec.Get(EntryNo) then
            exit;

        LogRec.Status := Status;
        LogRec."Error Text" := CopyStr(ErrorText, 1, MaxStrLen(LogRec."Error Text"));
        LogRec.SetResponseData(ResponseData);
        LogRec."Response Time" := CurrentDateTime();

        if Status = Status::Failed then
            LogRec.Message := CopyStr(ErrorText, 1, MaxStrLen(LogRec.Message));

        LogRec.Modify(true);
    end;
}
