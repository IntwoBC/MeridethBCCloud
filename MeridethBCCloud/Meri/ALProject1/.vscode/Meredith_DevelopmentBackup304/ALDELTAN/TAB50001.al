table 50001 "Comm. Credit Card Backcharge"
{
    DataCaptionFields = "No.";
    DrillDownPageID = "Comm. Credit Card Backcharges";
    LookupPageID = "Comm. Credit Card Backcharges";

    fields
    {
        field(1; "No."; Code[10])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(GetNoSeriesCode);
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Sell-to Customer No."; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(3; "Sell-to Address"; Text[50])
        {
            Caption = 'Sell-to Address';
        }
        field(4; "Sell-to Address 2"; Text[50])
        {
            Caption = 'Sell-to Address 2';
        }
        field(5; "Sell-to City"; Text[30])
        {
            Caption = 'Sell-to City';
            TableRelation = "Post Code".City;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(6; "Sell-to Post Code"; Code[20])
        {
            Caption = 'Sell-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(7; "Sell-to County"; Text[30])
        {
            Caption = 'Sell-to County';
        }
        field(8; "Sell-to Country/Region Code"; Code[10])
        {
            Caption = 'Sell-to Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(9; "Posting Date"; Date)
        {
        }
        field(10; Amount; Decimal)
        {
        }
        field(11; Posted; Boolean)
        {
        }
        field(12; "No. Series"; Code[10])
        {
        }
        field(13; "Reference No."; Code[20])
        {
            TableRelation = "Sales Invoice Header"."No.";

            trigger OnValidate()
            begin
                SalesInvHeader.Get("Reference No.");
                "Sell-to Customer No." := SalesInvHeader."Sell-to Customer No.";
                "Sell-to Address" := SalesInvHeader."Sell-to Address";
                "Sell-to Address 2" := SalesInvHeader."Sell-to Address 2";
                "Sell-to City" := SalesInvHeader."Sell-to City";
                "Sell-to Post Code" := SalesInvHeader."Sell-to Post Code";
                "Sell-to County" := SalesInvHeader."Sell-to County";
                "Sell-to Country/Region Code" := SalesInvHeader."Sell-to Country/Region Code";
                "Salesperson Code" := SalesInvHeader."Salesperson Code";
            end;
        }
        field(14; "Salesperson Code"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            TestNoSeries;
            "No. Series" := GetNoSeriesCode;
            "No." := NoSeriesMgt.GetNextNo("No. Series", "Posting Date", true);
        end;

        InitRecord;
    end;

    trigger OnModify()
    begin
        TestField(Posted, false);
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit "No. Series";
        CommCreditCardBackcharge: Record "Comm. Credit Card Backcharge";
        Text051: Label 'The Comm. Credit Card Backcharges %1 already exists.';
        SalesInvHeader: Record "Sales Invoice Header";

    procedure InitRecord()
    begin
        SalesSetup.Get;

        "Posting Date" := WorkDate;
    end;

    procedure AssistEdit(OldCommCreditCardBackcharge: Record "Comm. Credit Card Backcharge"): Boolean
    var
        CommCreditCardBackcharge2: Record "Comm. Credit Card Backcharge";
    begin
        CommCreditCardBackcharge.Copy(Rec);
        SalesSetup.Get;
        TestNoSeries;
        if NoSeriesMgt.LookupRelatedNoSeries(GetNoSeriesCode, CommCreditCardBackcharge."No. Series") then begin
            CommCreditCardBackcharge."No." :=
              NoSeriesMgt.GetNextNo(CommCreditCardBackcharge."No. Series", "Posting Date", true);
            if CommCreditCardBackcharge2.Get(CommCreditCardBackcharge."No.") then
                Error(Text051, CommCreditCardBackcharge."No.");
            Rec := CommCreditCardBackcharge;
            exit(true);
        end;
        exit(false);
    end;

    local procedure GetNoSeriesCode(): Code[10]
    begin
        exit(SalesSetup."Comm. Cred. Card Backcharges");
    end;

    local procedure TestNoSeries(): Boolean
    begin
        SalesSetup.Get;

        SalesSetup.TestField("Comm. Cred. Card Backcharges")
    end;

    procedure PostRecord()
    begin
        Posted := true;
        Modify;
    end;
}

