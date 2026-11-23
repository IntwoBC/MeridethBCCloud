//      ItemInFile.TEXTMODE(TRUE);
//         //      ItemInFile.WRITEMODE(FALSE);
//         //      ItemInFile.OPEN(InputPath + '\' + ItemFile.Name);
//                   ItemInFile.Open(InputPath);
//         //      REPEAT
//                 Clear(Element);
//                 Clear(nth);
//                 Clear(mth);
//                 mystrPos := 1;
//                 ItemInFile.Read(InString);
//                 repeat
//                   if InString[mystrPos] in [',','"','|'] then begin
//                   end else
//                     Element[nth + 1] += Format(InString[mystrPos]);
//                   if InString[mystrPos] in [',','|'] then
//                     nth += 1;
//                   mth += 1;
//                   mystrPos += 1;
//                 until mystrPos >= StrLen(InString);
//                 Element[nth + 1] := CopyStr(InString,mystrPos);

//                 if FileHeaderRead then begin
//                   //"3PLStaging".LOCKTABLE;
//                   //IF "3PLStaging".FIND('+') THEN
//                   //  LastEntryNo := "3PLStaging"."Entry No.";

//                   //CLEAR("3PLStaging");
//                   //"3PLStaging".INIT;
//                   //"3PLStaging"."Entry No." := LastEntryNo + 1;
//                   //"3PLStaging"."PLG File Name" := ItemFile.Name;
//                   //"3PLStaging".INSERT;
//                 end;
//                 FileHeaderRead := true;

//               //UNTIL ItemInFile.POS = ItemInFile.LEN;

//               ItemInFile.Close;
//             //END;
//           //UNTIL ItemFile.NEXT = 0;

//         Message('c50018 run');
//     end;

//     var
//         FileHeaderRead: Boolean;
//         ItemFile: Record File;
//         ItemInFile: File;
//         InputPath: Text[250];
//         Element: array [90] of Text[250];
//         nth: Integer;
//         mth: Integer;
//         mystrPos: Integer;
//         InString: Text[1024];
// }
codeunit 60000 "Import Items"
{
    trigger OnRun()
    var
        InStr: InStream;
        FileName: Text;
    begin
        // Upload file instead of using S:\ path
        UploadIntoStream('Select CSV File', '', 'CSV files (*.csv)|*.csv', FileName, InStr);

        FileHeaderRead := true;

        // Read line by line
        while not InStr.EOS do begin
            InStr.ReadText(InString);

            Clear(Element);
            Clear(nth);
            Clear(mth);
            mystrPos := 1;

            repeat
                if InString[mystrPos] in [',', '"', '|'] then begin
                end else
                    Element[nth + 1] += Format(InString[mystrPos]);

                if InString[mystrPos] in [',', '|'] then
                    nth += 1;

                mth += 1;
                mystrPos += 1;

            until mystrPos > StrLen(InString);

            // Assign last value
            Element[nth + 1] := CopyStr(InString, mystrPos);

            // Header logic
            if FileHeaderRead then begin
                // Your staging logic here
                // Example:
                // Message('Header processed');
                FileHeaderRead := false;
            end;

            // 👉 Debug (remove later)
            Message('Column1: %1', Element[1]);
        end;

        Message('Import completed');
    end;

    var
        FileHeaderRead: Boolean;
        Element: array[90] of Text[250];
        nth: Integer;
        mth: Integer;
        mystrPos: Integer;
        InString: Text[1024];
}