// Imports DocCommissionCharges_BC14.csv (made from the BC14 "Edit - Document Commission Charges" printout)
// into table 50004 "Document Commission Charges". Existing rows are updated, missing rows are inserted.
// Run it through report 50095 (it uploads the file and calls this XMLport).
xmlport 50094 "MER Import Doc Comm Charges"
{
    Caption = 'Import Document Commission Charges (BC14)';
    Direction = Import;
    Format = VariableText;
    FieldSeparator = ',';
    FieldDelimiter = '"';
    TextEncoding = UTF8;
    UseRequestPage = false;
    Permissions = tabledata "Document Commission Charges" = rimd;

    schema
    {
        textelement(Root)
        {
            tableelement(Line; Integer)
            {
                AutoSave = false;
                XmlName = 'Line';
                SourceTableView = sorting(Number);

                textelement(DocTypeTxt) { }
                textelement(DocNoTxt) { }
                textelement(CommAmtTxt) { }
                textelement(OrderFeeTxt) { }
                textelement(MiscChargeTxt) { }
                textelement(CCChargesTxt) { }

                trigger OnBeforeInsertRecord()
                begin
                    ImportLine();
                    currXMLport.Skip();
                end;
            }
        }
    }

    var
        InsertedCount: Integer;
        ModifiedCount: Integer;
        SkippedCount: Integer;

    local procedure ImportLine()
    var
        DocCommChgs: Record "Document Commission Charges";
        DocType: Integer;
        DocNo: Code[20];
    begin
        if (DocTypeTxt = '') or (DocTypeTxt = 'Document Type') then // empty line / header line
            exit;

        DocType := ToDocType(DocTypeTxt);
        if DocType < 0 then begin
            SkippedCount += 1;
            exit;
        end;
        DocNo := CopyStr(DelChr(DocNoTxt, '<>', ' '), 1, MaxStrLen(DocNo));

        if DocCommChgs.Get(DocType, DocNo) then begin
            SetAmounts(DocCommChgs);
            DocCommChgs.Modify();
            ModifiedCount += 1;
        end else begin
            DocCommChgs.Init();
            DocCommChgs."Document Type" := DocType;
            DocCommChgs."No." := DocNo;
            SetAmounts(DocCommChgs);
            DocCommChgs.Insert();
            InsertedCount += 1;
        end;
    end;

    local procedure SetAmounts(var DocCommChgs: Record "Document Commission Charges")
    begin
        DocCommChgs."Salesperson Commission Amount" := ToDec(CommAmtTxt);
        DocCommChgs."Salesperson Order Fee" := ToDec(OrderFeeTxt);
        DocCommChgs."Salesperson Misc. Charge" := ToDec(MiscChargeTxt);
        DocCommChgs."Credit Card Charges" := ToDec(CCChargesTxt);
    end;

    local procedure ToDec(Value: Text): Decimal
    var
        Result: Decimal;
    begin
        Value := DelChr(Value, '=', ', '); // remove thousand separators/spaces
        if Value = '' then
            exit(0);
        Evaluate(Result, Value, 9); // 9 = XML format, '.' as decimal separator (independent of user language)
        exit(Result);
    end;

    local procedure ToDocType(Value: Text): Integer
    begin
        // Option order of table 50004: Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order
        case DelChr(Value, '<>', ' ') of
            'Quote':
                exit(0);
            'Order':
                exit(1);
            'Invoice':
                exit(2);
            'Credit Memo':
                exit(3);
            'Blanket Order':
                exit(4);
            'Return Order':
                exit(5);
        end;
        exit(-1);
    end;

    procedure GetCounts(var Inserted: Integer; var Modified: Integer; var Skipped: Integer)
    begin
        Inserted := InsertedCount;
        Modified := ModifiedCount;
        Skipped := SkippedCount;
    end;
}
