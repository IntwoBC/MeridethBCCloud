table 50120 "CRM Integration Log"
{
    Caption = 'CRM Integration Log';
    DataClassification = CustomerContent;


    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }

        field(2; "Logged DateTime"; DateTime)
        {
            Caption = 'Logged DateTime';
            DataClassification = SystemMetadata;
        }

        field(3; "Integration Area"; Text[30])
        {
            Caption = 'Integration Area';
            DataClassification = CustomerContent;
        }

        field(4; Direction; Text[10])
        {
            Caption = 'Direction';
            DataClassification = CustomerContent;
        }

        field(5; "Record No."; Code[20])
        {
            Caption = 'Record No.';
            DataClassification = CustomerContent;
        }

        field(6; "Reference No."; Text[50])
        {
            Caption = 'Reference No.';
            DataClassification = CustomerContent;
        }

        field(7; Status; Enum "CRM Integration Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }

        field(8; Message; Text[250])
        {
            Caption = 'Message';
            DataClassification = CustomerContent;
        }

        field(9; "Source Table ID"; Integer)
        {
            Caption = 'Source Table ID';
            DataClassification = SystemMetadata;
        }

        field(10; "Attempt No."; Integer)
        {
            Caption = 'Attempt No.';
            DataClassification = CustomerContent;
            MinValue = 0;
        }

        field(11; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = SystemMetadata;
        }

        field(12; "Request Data"; Blob)
        {
            Caption = 'Request Data';
            DataClassification = CustomerContent;
        }

        field(13; "Request Time"; DateTime)
        {
            Caption = 'Request Time';
            DataClassification = SystemMetadata;
        }

        field(14; "Response Data"; Blob)
        {
            Caption = 'Response Data';
            DataClassification = CustomerContent;
        }

        field(15; "Response Time"; DateTime)
        {
            Caption = 'Response Time';
            DataClassification = SystemMetadata;
        }

        field(16; URL; Text[250])
        {
            Caption = 'URL';
            DataClassification = CustomerContent;
        }

        field(17; "Error Text"; Text[250])
        {
            Caption = 'Error Text';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }

        key(Idx1; "Integration Area", "Record No.", "Logged DateTime") { }
        key(Idx2; Status, "Logged DateTime") { }
    }

    procedure SetRequestData(NewRequestData: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Request Data");
        "Request Data".CreateOutStream(OutStream, TextEncoding::UTF8);
        OutStream.WriteText(NewRequestData);
    end;

    procedure GetRequestData(): Text
    var
        InStream: InStream;
        TypeHelper: Codeunit "Type Helper";
    begin
        CalcFields("Request Data");
        "Request Data".CreateInStream(InStream, TextEncoding::UTF8);
        exit(TypeHelper.ReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator));
    end;

    procedure SetResponseData(NewResponseData: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Response Data");
        "Response Data".CreateOutStream(OutStream, TextEncoding::UTF8);
        OutStream.WriteText(NewResponseData);
    end;

    procedure GetResponseData(): Text
    var
        InStream: InStream;
        TypeHelper: Codeunit "Type Helper";
    begin
        CalcFields("Response Data");
        "Response Data".CreateInStream(InStream, TextEncoding::UTF8);
        exit(TypeHelper.ReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator));
    end;
}
