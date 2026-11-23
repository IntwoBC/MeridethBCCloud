codeunit 50000 "VARStreet Add Comment"
{

    trigger OnRun()
    begin
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

