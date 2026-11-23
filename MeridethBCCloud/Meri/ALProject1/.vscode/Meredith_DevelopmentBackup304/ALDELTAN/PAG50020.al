page 50020 "Sales Comment Sheet VARStreet"
{
    // <changelog>
    //   <add id="NA0001" dev="ELYNCH" date="2006-02-21" area="ORDERENTRY" feature="607"
    //     releaseversion="NAVNA4.00">Added fields for Comments on Sales docs</add>
    // </changelog>

    Caption = 'Comment Sheet';
    DataCaptionFields = "Document Type", "No.";
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = "Sales Comment Line";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            field("Document Type"; Rec."Document Type")
            {
            }
            field("No."; Rec."No.")
            {
            }
            field("Document Line No."; Rec."Document Line No.")
            {
            }
            field("Line No."; Rec."Line No.")
            {
            }
            field(Date; Rec.Date)
            {
            }
            field("Code"; Rec.Code)
            {
            }
            field(Comment; Rec.Comment)
            {
            }
            field("Print On Quote"; Rec."Print On Quote")
            {
            }
            field("Print On Pick Ticket"; Rec."Print On Pick Ticket")
            {
            }
            field("Print On Order Confirmation"; Rec."Print On Order Confirmation")
            {
            }
            field("Print On Shipment"; Rec."Print On Shipment")
            {
            }
            field("Print On Invoice"; Rec."Print On Invoice")
            {
            }
            field("Print On Credit Memo"; Rec."Print On Credit Memo")
            {
            }
            field("Print On Return Authorization"; Rec."Print On Return Authorization")
            {
            }
            field("Print On Return Receipt"; Rec."Print On Return Receipt")
            {
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        LineNo: Integer;
        SalesCommentLine: Record "Sales Comment Line";
    begin
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //SetUpNewLine;
    end;

    procedure AddComment(DocumentNo: Code[20]; Comment: Text[80])
    var
        SalesCommentLine: Record "Sales Comment Line";
        LineNo: Integer;
    begin
        SalesCommentLine.SetRange(SalesCommentLine."Document Type", SalesCommentLine."Document Type"::Order);
        SalesCommentLine.SetRange(SalesCommentLine."No.", DocumentNo);
        SalesCommentLine.SetRange(SalesCommentLine."Document Line No.", 0);
        if SalesCommentLine.FindLast then
            LineNo := SalesCommentLine."Line No.";
        LineNo += 10000;

        Clear(SalesCommentLine);
        SalesCommentLine."Document Type" := SalesCommentLine."Document Type"::Order;
        SalesCommentLine."No." := DocumentNo;
        SalesCommentLine."Document Line No." := 0;
        SalesCommentLine."Line No." := LineNo;
        SalesCommentLine.Date := Today;
        SalesCommentLine.Comment := Comment;
        SalesCommentLine.Insert;
    end;
}

