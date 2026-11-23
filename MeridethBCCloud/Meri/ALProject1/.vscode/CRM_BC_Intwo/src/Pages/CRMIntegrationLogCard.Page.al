page 50113 "CRM Integration Log Card"
{
    Caption = 'CRM Integration Log Card';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "CRM Integration Log";
    DataCaptionFields = "Integration Area", Direction;


    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Integration Area"; Rec."Integration Area")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(Direction; Rec.Direction)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Record No."; Rec."Record No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Error Text"; Rec."Error Text")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(URL; Rec.URL)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
            }

            group(Request)
            {
                field("Request Data"; RequestData)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    Editable = false;
                }
                field("Request Time"; Rec."Request Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group(Response)
            {
                field("Response Data"; ResponseData)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    Editable = false;
                }
                field("Response Time"; Rec."Response Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(DownloadRequestData)
            {
                Caption = 'Download Request Data';
                ApplicationArea = All;
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    InStr: InStream;
                    FileName: Text;
                begin
                    Rec.CalcFields("Request Data");
                    if not Rec."Request Data".HasValue() then
                        Error('The field Request Data must have a value.');

                    Rec."Request Data".CreateInStream(InStr, TextEncoding::UTF8);
                    FileName := StrSubstNo('%1_%2.txt', Rec."Integration Area", Rec."Entry No.");
                    DownloadFromStream(InStr, 'Export', '', 'All Files (*.*)|*.*', FileName);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Clear(RequestData);
        Clear(ResponseData);
        RequestData := Rec.GetRequestData();
        ResponseData := Rec.GetResponseData();
    end;

    var
        RequestData: Text;
        ResponseData: Text;
}
