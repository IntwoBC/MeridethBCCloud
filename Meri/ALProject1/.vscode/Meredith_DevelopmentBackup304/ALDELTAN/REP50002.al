// report 50002 "Import Item Cross References"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './Import Item Cross References.rdlc';

//     dataset
//     {
//         dataitem("Integer"; "Integer")
//         {
//             DataItemTableView = WHERE(Number = CONST(1));

//             trigger OnAfterGetRecord()
//             var

//             begin
//                 Upload('Item Input', 's:\', '', '', ToFile);
//                 ItemInFile.Open(ToFile);
//                 ItemInFile.CreateInStream(ItemStream);
//                 while not ItemStream.EOS do begin
//                     Clear(Element);
//                     Clear(nth);
//                     Clear(mth);
//                     mystrPos := 1;
//                     ItemStream.ReadText(InString);
//                     repeat
//                         //IF InString[mystrPos] IN [',','"','|'] THEN BEGIN
//                         if InString[mystrPos] in ['|'] then begin
//                         end else
//                             Element[nth + 1] += Format(InString[mystrPos]);
//                         //IF InString[mystrPos] IN [',','|'] THEN
//                         if InString[mystrPos] in ['|'] then
//                             nth += 1;
//                         mth += 1;
//                         mystrPos += 1;
//                     until mystrPos >= StrLen(InString);
//                     Element[nth + 1] := CopyStr(InString, mystrPos);
//                     nthRowRead += 1;

//                     Clear(LegacyVendorNo);
//                     if StrPos(Element[1], ' ') <> 0 then begin
//                         ItemNo := CopyStr(Element[1], 1, StrPos(Element[1], ' ') - 1);
//                         LegacyVendorNo := CopyStr(Element[1], StrPos(Element[1], ' ') + 1);
//                     end else
//                         ItemNo := Element[1];

//                     ItemNo := DelChr(ItemNo, '=', '.|"''');

//                     if ItemNo <> '' then begin
//                         if not Item.Get(ItemNo) then begin
//                             Clear(Item);
//                             Item.Init;
//                             Item."No." := ItemNo;
//                             Item.Insert(true);
//                         end;
//                         Item.Description := Element[2];
//                         Item.Modify;

//                         //UnitofMeasure.GET(Element[8]);
//                         /* // This functionality needs work if it's needed again. Jann tweaked manaully.
//                         CLEAR(ItemUnitofMeasure);
//                         ItemUnitofMeasure.INIT;
//                         CASE Element[8] OF
//                           '100/BOX':
//                           BEGIN
//                             ItemUnitofMeasure."Item No." := ItemNo;
//                             ItemUnitofMeasure.Code := 'BOX';
//                             ItemUnitofMeasure."Qty. per Unit of Measure" := 1;
//                             IF NOT ItemUnitofMeasure.INSERT(TRUE) THEN;
//                             BaseUnitOfMeasure := 'BOX';

//                             ItemUnitofMeasure."Item No." := ItemNo;
//                             ItemUnitofMeasure.Code := Element[8];
//                             ItemUnitofMeasure."Qty. per Unit of Measure" := 100;
//                             IF NOT ItemUnitofMeasure.INSERT(TRUE) THEN;
//                           END;
//                           '12/PADS':
//                           BEGIN
//                             ItemUnitofMeasure."Item No." := ItemNo;
//                             ItemUnitofMeasure.Code := 'EACH';
//                             ItemUnitofMeasure."Qty. per Unit of Measure" := 1;
//                             IF NOT ItemUnitofMeasure.INSERT(TRUE) THEN;
//                             BaseUnitOfMeasure := 'EACH';

//                             ItemUnitofMeasure."Item No." := ItemNo;
//                             ItemUnitofMeasure.Code := Element[8];
//                             ItemUnitofMeasure."Qty. per Unit of Measure" := 12;
//                             IF NOT ItemUnitofMeasure.INSERT(TRUE) THEN;
//                           END;
//                           '25/BOX':
//                           BEGIN
//                             ItemUnitofMeasure."Item No." := ItemNo;
//                             ItemUnitofMeasure.Code := 'BOX';
//                             ItemUnitofMeasure."Qty. per Unit of Measure" := 1;
//                             IF NOT ItemUnitofMeasure.INSERT(TRUE) THEN;
//                             BaseUnitOfMeasure := 'BOX';

//                             ItemUnitofMeasure."Item No." := ItemNo;
//                             ItemUnitofMeasure.Code := Element[8];
//                             ItemUnitofMeasure."Qty. per Unit of Measure" := 25;
//                             IF NOT ItemUnitofMeasure.INSERT(TRUE) THEN;
//                           END;
//                           '250/BOX':
//                           BEGIN
//                             ItemUnitofMeasure."Item No." := ItemNo;
//                             ItemUnitofMeasure.Code := 'BOX';
//                             ItemUnitofMeasure."Qty. per Unit of Measure" := 1;
//                             IF NOT ItemUnitofMeasure.INSERT(TRUE) THEN;
//                             BaseUnitOfMeasure := 'BOX';

//                             ItemUnitofMeasure."Item No." := ItemNo;
//                             ItemUnitofMeasure.Code := Element[8];
//                             ItemUnitofMeasure."Qty. per Unit of Measure" := 250;
//                             IF NOT ItemUnitofMeasure.INSERT(TRUE) THEN;
//                           END;
//                           '500/BOX':
//                           BEGIN
//                             ItemUnitofMeasure."Item No." := ItemNo;
//                             ItemUnitofMeasure.Code := 'BOX';
//                             ItemUnitofMeasure."Qty. per Unit of Measure" := 1;
//                             IF NOT ItemUnitofMeasure.INSERT(TRUE) THEN;
//                             BaseUnitOfMeasure := 'BOX';

//                             ItemUnitofMeasure."Item No." := ItemNo;
//                             ItemUnitofMeasure.Code := Element[8];
//                             ItemUnitofMeasure."Qty. per Unit of Measure" := 500;
//                             IF NOT ItemUnitofMeasure.INSERT(TRUE) THEN;
//                           END;
//                           'BOX','EACH','PACK','RM','DOZEN':
//                           BEGIN
//                             ItemUnitofMeasure."Item No." := ItemNo;
//                             ItemUnitofMeasure.Code := Element[8];
//                             ItemUnitofMeasure."Qty. per Unit of Measure" := 1;
//                             IF NOT ItemUnitofMeasure.INSERT(TRUE) THEN;
//                             BaseUnitOfMeasure := Element[8];
//                           END;
//                         ELSE
//                           BEGIN
//                             ItemUnitofMeasure."Item No." := ItemNo;
//                             ItemUnitofMeasure.Code := 'EACH';
//                             ItemUnitofMeasure."Qty. per Unit of Measure" := 1;
//                             IF NOT ItemUnitofMeasure.INSERT(TRUE) THEN;
//                             BaseUnitOfMeasure := 'EACH';
//                           END;
//                         END;
//                         */
//                         /* May need to handle ILE entries here.
//                         Item.VALIDATE("Base Unit of Measure",BaseUnitOfMeasure);
//                         Item.VALIDATE("Costing Method",Item."Costing Method"::Average);
//                         IF Element[7] <> '' THEN
//                           EVALUATE(Item."Unit Cost",Element[7]);
//                         Item.VALIDATE("Gen. Prod. Posting Group",'SALES');
//                         Item.VALIDATE("Inventory Posting Group",'INVENTORY');
//                         Item.MODIFY;
//                         */

//                         // 12-09-13 >>
//                         Clear(Vendor);
//                         Vendor.Reset;
//                         Vendor.SetRange("Legacy Vendor No.", LegacyVendorNo);
//                         if not Vendor.Find('-') then begin
//                             Vendor.Reset;
//                             Vendor.SetRange("Legacy Vendor No. 2", LegacyVendorNo);
//                             if not Vendor.Find('-') then begin
//                                 Vendor.Reset;
//                                 Vendor.SetRange("Legacy Vendor No. 3", LegacyVendorNo);
//                                 if not Vendor.Find('-') then begin
//                                     Vendor.Reset;
//                                     Vendor.SetRange("Legacy Vendor No. 4", LegacyVendorNo);
//                                     if not Vendor.Find('-') then
//                                         Clear(Vendor);
//                                 end;
//                             end;
//                         end;
//                         //changes for version MS update
//                         if Vendor."No." <> '' then begin
//                             Clear(ItemCrossRef);
//                             ItemCrossRef.Init;
//                             ItemCrossRef."Item No." := Item."No.";
//                             ItemCrossRef."Unit of Measure" := Item."Base Unit of Measure";
//                             ItemCrossRef."Reference Type" := ItemCrossRef."Reference Type"::Vendor;
//                             ItemCrossRef."Reference Type No." := Vendor."No.";
//                             //ItemCrossRef."Cross-Reference No." := Item."No." + LegacyVendorNo;
//                             ItemCrossRef."Reference No." := Item."No.";
//                             if not ItemCrossRef.Insert then;

//                             // 12-10-13 >>
//                             Clear(PurchPrice);
//                             PurchPrice.Init;
//                             PurchPrice."Asset No.":= Item."No.";
//                             PurchPrice. "Source No.":= Vendor."No.";
//                             PurchPrice."Unit of Measure Code" := Item."Base Unit of Measure";
//                             PurchPrice."Minimum Quantity" := 1;
//                             Evaluate(PurchPrice."Direct Unit Cost", Element[7]);
//                             if not PurchPrice.Insert then;
//                             // 12-10-13 <<
//                         end;
//                         // 12-09-13 <<
//                     end;
//                 end;
//                 ItemInFile.Close;
//                 Message('%1 rows read', nthRowRead);

//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     var
//         FileHeaderRead: Boolean;
//         ItemFile: Record File;
//         ItemInFile: File;
//         ItemStream: InStream;
//         InputPath: Text[250];
//         Element: array[90] of Text[250];
//         nth: Integer;
//         mth: Integer;
//         mystrPos: Integer;
//         InString: Text[1024];
//         ToFile: Text[250];
//         nthRowRead: Integer;
//         Item: Record Item;
//         ItemNo: Code[20];
//         LegacyVendorNo: Code[20];
//         ItemUnitofMeasure: Record "Item Unit of Measure";
//         UnitofMeasure: Record "Unit of Measure";
//         BaseUnitOfMeasure: Code[20];
//         ItemCrossRef: Record "Item Reference";
//         Vendor: Record Vendor;
//         PurchPrice: Record "Price List Line";
// }

report 50100 "Import Item Cross References"
{
    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = where(Number = const(1));

            trigger OnAfterGetRecord()
            var
                FileName: Text;
                InStr: InStream;
                Line: Text;
            begin
                // ✅ Modern file upload
                if not UploadIntoStream('Select File', '', '', FileName, InStr) then
                    Error('File not selected');

                while not InStr.EOS do begin
                    Clear(Element);
                    nth := 0;
                    InStr.ReadText(Line);

                    ParseLine(Line);

                    ProcessLine();
                    nthRowRead += 1;
                end;

                Message('%1 rows read', nthRowRead);
            end;
        }
    }

    var
        Element: array[90] of Text[250];
        nth: Integer;
        nthRowRead: Integer;

        Item: Record Item;
        Vendor: Record Vendor;
        ItemCrossRef: Record "Item Reference";
        PurchPrice: Record "Price List Line";

        ItemNo: Code[20];
        LegacyVendorNo: Code[20];

    // ✅ Split line by |
    local procedure ParseLine(Line: Text)
    var
        Parts: List of [Text];
        Part: Text;
    begin
        Parts := Line.Split('|');

        foreach Part in Parts do begin
            nth += 1;
            Element[nth] := Part;
        end;
    end;

    // ✅ Process each row
    local procedure ProcessLine()
    begin
        if Element[1] = '' then
            exit;

        // Split Item + Vendor
        if StrPos(Element[1], ' ') <> 0 then begin
            ItemNo := CopyStr(Element[1], 1, StrPos(Element[1], ' ') - 1);
            LegacyVendorNo := CopyStr(Element[1], StrPos(Element[1], ' ') + 1);
        end else
            ItemNo := Element[1];

        ItemNo := DelChr(ItemNo, '=', '.|"''');

        // ✅ Item
        if not Item.Get(ItemNo) then begin
            Item.Init();
            Item."No." := ItemNo;
            Item.Insert();
        end;

        Item.Description := Element[2];
        Item.Modify();

        // ✅ Vendor lookup
        if not FindVendor(LegacyVendorNo) then
            exit;

        // ✅ Item Reference
        ItemCrossRef.Reset();
        ItemCrossRef.Init();
        ItemCrossRef."Item No." := Item."No.";
        ItemCrossRef."Reference Type" := ItemCrossRef."Reference Type"::Vendor;
        ItemCrossRef."Reference Type No." := Vendor."No.";
        ItemCrossRef."Reference No." := Item."No.";
        ItemCrossRef.Insert(true);

        // ✅ Price List (BC24 standard)
        PurchPrice.Init();
        PurchPrice."Asset Type" := PurchPrice."Asset Type"::Item;
        PurchPrice."Asset No." := Item."No.";
        PurchPrice."Source Type" := PurchPrice."Source Type"::Vendor;
        PurchPrice."Source No." := Vendor."No.";
        PurchPrice."Minimum Quantity" := 1;

        if Element[7] <> '' then
            Evaluate(PurchPrice."Direct Unit Cost", Element[7]);

        PurchPrice.Insert(true);
    end;

    // ✅ Vendor search
    local procedure FindVendor(LegacyVendorNo: Code[20]): Boolean
    begin
        Vendor.Reset();
        Vendor.SetRange("Legacy Vendor No.", LegacyVendorNo);
        if Vendor.FindFirst() then
            exit(true);

        Vendor.SetRange("Legacy Vendor No. 2", LegacyVendorNo);
        if Vendor.FindFirst() then
            exit(true);

        Vendor.SetRange("Legacy Vendor No. 3", LegacyVendorNo);
        if Vendor.FindFirst() then
            exit(true);

        Vendor.SetRange("Legacy Vendor No. 4", LegacyVendorNo);
        if Vendor.FindFirst() then
            exit(true);

        exit(false);
    end;
}