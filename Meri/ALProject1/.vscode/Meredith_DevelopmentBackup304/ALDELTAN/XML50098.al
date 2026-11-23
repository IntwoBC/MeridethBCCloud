xmlport 50098 "DMS Universal XMLport"
{
    // ************************
    // Copyright Notice
    // 
    // This objects content is copyright (2010) of Dynamic Manufacturing Solutions Inc.  All rights reserved.
    // Reproduction. modification, or distribution of part or all of the contents in any form is prohibited
    // unless this copyright notice is included.
    // 
    // Code is free for personal and commercial use, modification, or redistribution.
    // 
    // www.dynms.com
    // ************************
    // 
    // <DMS>
    //  <REVISION author="M.Hamblin" date="9/5/2012" version="DMS" issue="UDP">
    //   Universal XMLport - will import data for any table
    //   Requires tab-separated file with first row containing field names.
    //   Field names prefixed with an asterix ("*") can be validated based on request form options
    //   Sample Item file format ("<tab>" means a tab character):
    //     "No." <tab> "*Description" <tab> "Last Modified Date"
    //     "123" <tab> "My description" <tab> "3/11/2010"
    //     "456" <tab> "My description 2" <tab> "6/8/08"
    // 
    // 
    //   You may add item tracking lines to item journals by importing the serial no., lot no., and expiry date fields
    // 
    //   See http://blog.dynms.com/2012/09/the-nav-2013-universal-xmlport.html for full instructions
    //  </REVISION>
    // </DMS>

    Caption = 'DMS Universal XMLport - www.dynms.com';
    DefaultFieldsValidation = false;
    Direction = Import;
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(FileRoot)
        {
            tableelement(Integer; Integer)
            {
                AutoReplace = false;
                AutoSave = false;
                AutoUpdate = false;
                XmlName = 'DummyTable';
                SourceTableView = SORTING(Number);
                textelement(Field1)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[1] := Field1;
                    end;
                }
                textelement(Field2)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[2] := Field2;
                    end;
                }
                textelement(Field3)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[3] := Field3;
                    end;
                }
                textelement(Field4)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[4] := Field4;
                    end;
                }
                textelement(Field5)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[5] := Field5;
                    end;
                }
                textelement(Field6)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[6] := Field6;
                    end;
                }
                textelement(Field7)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[7] := Field7;
                    end;
                }
                textelement(Field8)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[8] := Field8;
                    end;
                }
                textelement(Field9)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[9] := Field9;
                    end;
                }
                textelement(Field10)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[10] := Field10;
                    end;
                }
                textelement(Field11)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[11] := Field11;
                    end;
                }
                textelement(Field12)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[12] := Field12;
                    end;
                }
                textelement(Field13)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[13] := Field13;
                    end;
                }
                textelement(Field14)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[14] := Field14;
                    end;
                }
                textelement(Field15)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[15] := Field15;
                    end;
                }
                textelement(Field16)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[16] := Field16;
                    end;
                }
                textelement(Field17)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[17] := Field17;
                    end;
                }
                textelement(Field18)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[18] := Field18;
                    end;
                }
                textelement(Field19)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[19] := Field19;
                    end;
                }
                textelement(Field20)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[20] := Field20;
                    end;
                }
                textelement(Field21)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[21] := Field21;
                    end;
                }
                textelement(Field22)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[22] := Field22;
                    end;
                }
                textelement(Field23)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[23] := Field23;
                    end;
                }
                textelement(Field24)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[24] := Field24;
                    end;
                }
                textelement(Field25)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[25] := Field25;
                    end;
                }
                textelement(Field26)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[26] := Field26;
                    end;
                }
                textelement(Field27)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[27] := Field27;
                    end;
                }
                textelement(Field28)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[28] := Field28;
                    end;
                }
                textelement(Field29)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[29] := Field29;
                    end;
                }
                textelement(Field30)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[30] := Field30;
                    end;
                }
                textelement(Field31)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[31] := Field31;
                    end;
                }
                textelement(Field32)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[32] := Field32;
                    end;
                }
                textelement(Field33)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[33] := Field33;
                    end;
                }
                textelement(Field34)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[34] := Field34;
                    end;
                }
                textelement(Field35)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[35] := Field35;
                    end;
                }
                textelement(Field36)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[36] := Field36;
                    end;
                }
                textelement(Field37)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[37] := Field37;
                    end;
                }
                textelement(Field38)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[38] := Field38;
                    end;
                }
                textelement(Field39)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[39] := Field39;
                    end;
                }
                textelement(Field40)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[40] := Field40;
                    end;
                }
                textelement(Field41)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[41] := Field41;
                    end;
                }
                textelement(Field42)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[42] := Field42;
                    end;
                }
                textelement(Field43)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[43] := Field43;
                    end;
                }
                textelement(Field44)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[44] := Field44;
                    end;
                }
                textelement(Field45)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[45] := Field45;
                    end;
                }
                textelement(Field46)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[46] := Field46;
                    end;
                }
                textelement(Field47)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[47] := Field47;
                    end;
                }
                textelement(Field48)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[48] := Field48;
                    end;
                }
                textelement(Field49)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[49] := Field49;
                    end;
                }
                textelement(Field50)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[50] := Field50;
                    end;
                }
                textelement(Field51)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[51] := Field51;
                    end;
                }
                textelement(Field52)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[52] := Field52;
                    end;
                }
                textelement(Field53)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[53] := Field53;
                    end;
                }
                textelement(Field54)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[54] := Field54;
                    end;
                }
                textelement(Field55)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[55] := Field55;
                    end;
                }
                textelement(Field56)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[56] := Field56;
                    end;
                }
                textelement(Field57)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[57] := Field57;
                    end;
                }
                textelement(Field58)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[58] := Field58;
                    end;
                }
                textelement(Field59)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[59] := Field59;
                    end;
                }
                textelement(Field60)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[60] := Field60;
                    end;
                }
                textelement(Field61)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[61] := Field61;
                    end;
                }
                textelement(Field62)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[62] := Field62;
                    end;
                }
                textelement(Field63)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[63] := Field63;
                    end;
                }
                textelement(Field64)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[64] := Field64;
                    end;
                }
                textelement(Field65)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[65] := Field65;
                    end;
                }
                textelement(Field66)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[66] := Field66;
                    end;
                }
                textelement(Field67)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[67] := Field67;
                    end;
                }
                textelement(Field68)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[68] := Field68;
                    end;
                }
                textelement(Field69)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[69] := Field69;
                    end;
                }
                textelement(Field70)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[70] := Field70;
                    end;
                }
                textelement(Field71)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[71] := Field71;
                    end;
                }
                textelement(Field72)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[72] := Field72;
                    end;
                }
                textelement(Field73)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[73] := Field73;
                    end;
                }
                textelement(Field74)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[74] := Field74;
                    end;
                }
                textelement(Field75)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[75] := Field75;
                    end;
                }
                textelement(Field76)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[76] := Field76;
                    end;
                }
                textelement(Field77)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[77] := Field77;
                    end;
                }
                textelement(Field78)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[78] := Field78;
                    end;
                }
                textelement(Field79)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[79] := Field79;
                    end;
                }
                textelement(Field80)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[80] := Field80;
                    end;
                }
                textelement(Field81)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[81] := Field81;
                    end;
                }
                textelement(Field82)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[82] := Field82;
                    end;
                }
                textelement(Field83)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[83] := Field83;
                    end;
                }
                textelement(Field84)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[84] := Field84;
                    end;
                }
                textelement(Field85)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[85] := Field85;
                    end;
                }
                textelement(Field86)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[86] := Field86;
                    end;
                }
                textelement(Field87)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[87] := Field87;
                    end;
                }
                textelement(Field88)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[88] := Field88;
                    end;
                }
                textelement(Field89)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[89] := Field89;
                    end;
                }
                textelement(Field90)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[90] := Field90;
                    end;
                }
                textelement(Field91)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[91] := Field91;
                    end;
                }
                textelement(Field92)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[92] := Field92;
                    end;
                }
                textelement(Field93)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[93] := Field93;
                    end;
                }
                textelement(Field94)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[94] := Field94;
                    end;
                }
                textelement(Field95)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[95] := Field95;
                    end;
                }
                textelement(Field96)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[96] := Field96;
                    end;
                }
                textelement(Field97)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[97] := Field97;
                    end;
                }
                textelement(Field98)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[98] := Field98;
                    end;
                }
                textelement(Field99)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[99] := Field99;
                    end;
                }
                textelement(Field100)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        atxtFieldData[100] := Field100;
                    end;
                }

                trigger OnBeforeInsertRecord()
                begin
                    nRecNum += 1;
                    dlgProgress.Update(3, nRecNum);
                    doAfterImportRecord;
                end;
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Filename)
                {
                    Caption = 'Filename - Optional (NAV also forces file selection when you click OK)';
                    field(txtFileName; txtFileName)
                    {
                        ApplicationArea = All; // MER-BC29 2026-11-22: PTE0008
                        AssistEdit = true;
                        Caption = 'Filename';
                        ExtendedDatatype = None;
                    }
                }
                group(Options)
                {
                    field(edtTableID; nTableID)
                    {
                        ApplicationArea = All; // MER-BC29 2026-11-22: PTE0008
                        AssistEdit = true;
                        Caption = 'Table ID';
                    }
                    field(txtTableName; txtTableName)
                    {
                        ApplicationArea = All; // MER-BC29 2026-11-22: PTE0008
                        Caption = 'Table Name';
                        Editable = false;
                        Enabled = false;
                    }
                    field(bAllowInserts; bAllowInserts)
                    {
                        ApplicationArea = All; // MER-BC29 2026-11-22: PTE0008
                        Caption = 'Allow record inserts';
                    }
                    field(bAllowUpdates; bAllowUpdates)
                    {
                        ApplicationArea = All; // MER-BC29 2026-11-22: PTE0008
                        Caption = 'Allow record updates';
                    }
                    field(optValidate; optValidate)
                    {
                        ApplicationArea = All; // MER-BC29 2026-11-22: PTE0008
                        Caption = 'Validate fields';
                    }
                    field(bRunOnInsert; bRunOnInsert)
                    {
                        ApplicationArea = All; // MER-BC29 2026-11-22: PTE0008
                        Caption = 'Run OnInsert Trigger';
                    }
                    field(bRunOnModify; bRunOnModify)
                    {
                        ApplicationArea = All; // MER-BC29 2026-11-22: PTE0008
                        Caption = 'Run OnModify Trigger';
                    }
                    field(bDisableChangeLog; bDisableChangeLog)
                    {
                        ApplicationArea = All; // MER-BC29 2026-11-22: PTE0008
                        Caption = 'Disable change log';
                    }
                }
            }
        }

        actions
        {
            area(navigation)
            {
                group(Data)
                {
                    Caption = 'Data';
                    action("View Table Data")
                    {
                        ApplicationArea = All; // MER-BC29 2026-11-22: PTE0008
                        Caption = 'View Table Data';
                        Image = "Table";
                        //Promoted = true;
                        //PromotedCategory = Process;
                        // PromotedIsBig = true;
                    }
                }
            }
        }
    }

    trigger OnPostXmlPort()
    begin
        if bOldChangeLogActive then begin
            recChangeLogSetup."Change Log Activated" := true;
            recChangeLogSetup.Modify;
        end;//if
        Commit;
        dlgProgress.Close;
        Message(tcComplete, nRecNum - 1, Round((Time - tStart) / 1000, 1));

        txtFileName := currXMLport.Filename;
    end;

    trigger OnPreXmlPort()
    begin
        bValidateAll := optValidate = optValidate::"Validate all fields";
        rrRecRef.Open(nTableID);
        if bDisableChangeLog then begin
            recChangeLogSetup.Get;
            bOldChangeLogActive := recChangeLogSetup."Change Log Activated";
            if bOldChangeLogActive then begin
                recChangeLogSetup."Change Log Activated" := false;
                recChangeLogSetup.Modify;
            end;//if
        end;//if

        cuChangeLog.InitChangeLog;  // un-caches change log setup

        dlgProgress.Open(tcProgress);
        dlgProgress.Update(1, txtFileName);
        dlgProgress.Update(2, txtTableName);
        tStart := Time;
    end;

    var
        atxtFieldData: array[100] of Text[100];
        bGotHeadings: Boolean;
        abFieldValidate: array[150] of Boolean;
        rrRecRef: RecordRef;
        nTableID: Integer;
        anFieldRefIDs: array[150] of Integer;
        nFileFldCount: Integer;
        optValidate: Option "Only validate fields prefixed with '*'","Validate all fields";
        bValidateAll: Boolean;
        txtFileName: Text;
        txtTableName: Text;
        bAllowUpdates: Boolean;
        bAllowInserts: Boolean;
        bDisableChangeLog: Boolean;
        bOldChangeLogActive: Boolean;
        cuChangeLog: Codeunit "Change Log Management";
        dlgProgress: Dialog;
        nRecNum: Integer;
        tcProgress: Label 'Filename #1\Table #2\Importing Record #3';
        tcComplete: Label 'Import complete.  %1 records imported in %2 seconds';
        tStart: Time;
        tcFileDlgTitle: Label 'Verify Import File';
        tcFileFilter: Label 'Text Files|*.txt';
        //recServerInst: Record "Server Instance";
        tcTableID: Label 'dynamicsnav://%1:%2/%3/%4/runtable?table=%5';
        recChangeLogSetup: Record "Change Log Setup";
        bRunOnInsert: Boolean;
        bRunOnModify: Boolean;

    procedure getTableName(pnTableID: Integer)
    var
    //lrecObject: Record Object;
    begin
        //lrecObject.SetRange(Type, lrecObject.Type::Table);
        //lrecObject.SetRange(ID, pnTableID);
        // lrecObject.Find('-');
        //txtTableName := lrecObject.Name;
    end;

    procedure doAfterImportRecord()
    var
        lbDidInsert: Boolean;
        lrrOldRec: RecordRef;
    begin
        //<DMS author="M.Hamblin" date="11/12/2010" issue="UDP" >
        // Main loop - maps fields from first row then inserts or updates data
        //</DMS>

        if not bGotHeadings then
            getFieldNames
        else begin
            populateFields;

            if bAllowInserts then begin
                if not bAllowUpdates then begin
                    rrRecRef.Insert(bRunOnInsert); // generate error if insert fails and updates not allowed
                    lbDidInsert := true;
                end else
                    lbDidInsert := rrRecRef.Insert(bRunOnInsert);

                if lbDidInsert and (nTableID = 83) then
                    addItemTracking();

            end;//allow inserts

            if bAllowUpdates and not lbDidInsert then begin
                if rrRecRef.Find('=') then begin

                    populateFields;
                    rrRecRef.Modify(bRunOnModify);
                end;//if
            end;//allow updates
        end;//if

        clearFields;
    end;

    local procedure getFieldNames()
    var
        lfrField: FieldRef;
        lnFileFldIndex: Integer;
        lnNavFldCount: Integer;
        lnNavFldIndex: Integer;
        ltxtSQLFieldName: Text[100];
        ltcMisingField: Label 'The file field %1 does not exist in table %2\Continue?';
    begin
        //<DMS author="M.Hamblin" date="11/10/2010" issue="UDP" >
        // maps fields to underlying file
        //</DMS>

        formatFileFields;

        // create field map from file field to record field (anFieldRefIDs)
        lnNavFldCount := rrRecRef.FieldCount;
        for lnFileFldIndex := 1 to nFileFldCount do begin

            lnNavFldIndex := 1;
            repeat
                lfrField := rrRecRef.FieldIndex(lnNavFldIndex);
                ltxtSQLFieldName := UpperCase(ConvertStr(lfrField.Name, '."\/''', '_____'));
                if (atxtFieldData[lnFileFldIndex] = UpperCase(lfrField.Name)) or
                   (atxtFieldData[lnFileFldIndex] = ltxtSQLFieldName)
                then
                    anFieldRefIDs[lnFileFldIndex] := lnNavFldIndex;

                lnNavFldIndex += 1;
            until (anFieldRefIDs[lnFileFldIndex] <> 0) or (lnNavFldIndex > lnNavFldCount);

            if anFieldRefIDs[lnFileFldIndex] = 0 then
                if not Confirm(ltcMisingField, true, atxtFieldData[lnFileFldIndex], txtTableName) then
                    Error('');
        end;//for fld index

        bGotHeadings := true;
    end;

    local procedure formatFileFields()
    begin
        //<DMS author="M.Hamblin" date="11/12/2010" issue="UDP" >
        // Cleans up file fields and calculates field count
        //</DMS>

        // get count of fields in file (compressarray not safe)
        nFileFldCount := 1;
        while (atxtFieldData[nFileFldCount] <> '') and (nFileFldCount <= 100) do begin
            atxtFieldData[nFileFldCount] := UpperCase(atxtFieldData[nFileFldCount]);
            if CopyStr(atxtFieldData[nFileFldCount], 1, 1) = '*' then begin
                abFieldValidate[nFileFldCount] := true;
                atxtFieldData[nFileFldCount] := CopyStr(atxtFieldData[nFileFldCount], 2, 50);
            end;//if

            abFieldValidate[nFileFldCount] := abFieldValidate[nFileFldCount] or bValidateAll;
            nFileFldCount += 1;
        end;//while

        nFileFldCount -= 1;
    end;

    local procedure populateFields()
    var
        lnFileFldIndex: Integer;
        lfrField: FieldRef;
        ltxtValue: Text;
        ldtDateValue: Date;
        ldDecValue: Decimal;
        ldtDateTimeValue: DateTime;
        ltmTimeValue: Time;
        ldfDateFormula: DateFormula;
    begin
        //<DMS author="M.Hamblin" date="11/11/2010" issue="UDP" >
        // Populates the fields in the recordref based on file data
        // Update for XMLport - needs to either use VALUE or VALIDATE - cannot use value then validate
        //</DMS>

        for lnFileFldIndex := 1 to nFileFldCount do begin
            if anFieldRefIDs[lnFileFldIndex] <> 0 then begin

                lfrField := rrRecRef.FieldIndex(anFieldRefIDs[lnFileFldIndex]);
                ltxtValue := Format(atxtFieldData[lnFileFldIndex]);

                doInternalPreProcessing(lfrField, ltxtValue);

                case Format(lfrField.Type) of
                    'Option':
                        if abFieldValidate[lnFileFldIndex] then
                            lfrField.Validate(getOptionFromText(ltxtValue, lfrField))
                        else
                            lfrField.Value(getOptionFromText(ltxtValue, lfrField));
                    'Code', 'Text':
                        if abFieldValidate[lnFileFldIndex] then
                            lfrField.Validate(ltxtValue)
                        else
                            lfrField.Value(ltxtValue);
                    'Date':
                        begin
                            Evaluate(ldtDateValue, ltxtValue);
                            if abFieldValidate[lnFileFldIndex] then
                                lfrField.Validate(ldtDateValue)
                            else
                                lfrField.Value(ldtDateValue);
                        end;
                    'DateTime':
                        begin
                            Evaluate(ldtDateTimeValue, ltxtValue);
                            if abFieldValidate[lnFileFldIndex] then
                                lfrField.Validate(ldtDateTimeValue)
                            else
                                lfrField.Value(ldtDateTimeValue);
                        end;
                    'Time':
                        begin
                            Evaluate(ltmTimeValue, ltxtValue);
                            if abFieldValidate[lnFileFldIndex] then
                                lfrField.Validate(ltmTimeValue)
                            else
                                lfrField.Value(ltmTimeValue);
                        end;
                    'DateFormula':
                        begin
                            Evaluate(ldfDateFormula, ltxtValue);
                            if abFieldValidate[lnFileFldIndex] then
                                lfrField.Validate(ldfDateFormula)
                            else
                                lfrField.Value(ldfDateFormula);
                        end;
                    'Boolean':
                        if abFieldValidate[lnFileFldIndex] then
                            lfrField.Validate(getBoolFromText(ltxtValue))
                        else
                            lfrField.Value(getBoolFromText(ltxtValue));
                    else begin
                        if ltxtValue <> '' then
                            Evaluate(ldDecValue, ltxtValue);
                        if abFieldValidate[lnFileFldIndex] then
                            lfrField.Validate(ldDecValue)
                        else
                            lfrField.Value(ldDecValue);
                    end;//else
                end;//case
            end;//if mapped field index not 0
        end;//for
    end;

    local procedure getBoolFromText(ptxtValue: Text): Boolean
    begin
        //<DMS author="M.Hamblin" date="11/12/2010" issue="UDP" >
        // Converts a text string to boolean - string can be 1,0,Y[es],N[o],T[rue],F[alse]
        //</DMS>

        if UpperCase(CopyStr(ptxtValue, 1, 1)) in ['1', 'Y', 'T'] then
            exit(true);

        exit(false);
    end;

    local procedure getOptionFromText(ptxtValue: Text; pfrFieldRef: FieldRef) rnOptionVal: Integer
    var
        ltxtOptionStr: Text[500];
        lnStrPos: Integer;
        ltcBadOption: Label '%1 on line %2 is not a valid option for field %3.\Continue?';
        lnCharPos: Integer;
    begin
        //<DMS author="M.Hamblin" date="11/12/2010" issue="UDP" >
        // Gets an option value (i.e., ordninal value) based on import text
        // todo: possibly cache option strings per field
        //</DMS>

        if not Evaluate(rnOptionVal, ptxtValue) then begin
            ltxtOptionStr := UpperCase(pfrFieldRef.OptionCaption) + ',';
            lnStrPos := StrPos(ltxtOptionStr, UpperCase(ptxtValue) + ',');
            if lnStrPos = 0 then
                if not Confirm(ltcBadOption, true, ptxtValue, nRecNum, pfrFieldRef.Name) then
                    Error('')
                else
                    exit(0);

            while lnCharPos < lnStrPos do begin
                lnCharPos += 1;
                if ltxtOptionStr[lnCharPos] = ',' then
                    rnOptionVal += 1;
            end;//if
        end;//if
    end;

    local procedure doInternalPreProcessing(pfrField: FieldRef; var ptxtValue: Text)
    var
        lrecItemUOM: Record "Item Unit of Measure";
        lrecResourceUOM: Record "Resource Unit of Measure";
    begin
        //<DMS author="M.Hamblin" date="11/12/2010" issue="UDP" >
        // Does pre-processing of data for specific fields
        // Base functionality is to add item units of measure, resource UOM and contact no. series
        //</DMS>

        if (nTableID = DATABASE::Item) and (pfrField.Number = 8) then begin
            lrecItemUOM."Item No." := rrRecRef.Field(1).Value;
            lrecItemUOM.Code := ptxtValue;
            lrecItemUOM."Qty. per Unit of Measure" := 1;
            if lrecItemUOM.Insert then;
        end//if need to set item UOM
        else if (nTableID = DATABASE::Resource) and (pfrField.Number = 18) then begin
            lrecResourceUOM."Resource No." := rrRecRef.Field(1).Value;
            lrecResourceUOM.Code := ptxtValue;
            lrecResourceUOM."Qty. per Unit of Measure" := 1;
            if lrecResourceUOM.Insert then;
        end//if
        else if (nTableID = DATABASE::Contact) and (pfrField.Number = 1) and (ptxtValue = '') then begin
            ptxtValue := getContactNo; // use no. series to assign contact #
        end;//if
    end;

    procedure getContactNo() rtxtContactNo: Text
    var
        lrecMktngSetup: Record "Marketing Setup";
        lcNoSeriesMgmt: Codeunit "No. Series"; // MER-BC29 2026-11-22: NoSeriesManagement removed
    begin
        //<DMS author="M.Hamblin" date="12/12/2011" issue="--" >
        // Returns a contact # from the assigned number series
        //</DMS>
        lrecMktngSetup.Get;
        exit(lcNoSeriesMgmt.GetNextNo(lrecMktngSetup."Contact Nos.", Today));
    end;

    procedure clearFields()
    begin
        //<DMS>
        // Clears import fields to prevent issues with cached data
        // (squished together to make it easier to scroll through dataport code)
        //</DMS>
        Field1 := '';
        Field2 := '';
        Field3 := '';
        Field4 := '';
        Field5 := '';
        Field6 := '';
        Field7 := '';
        Field8 := '';
        Field9 := '';
        Field10 := '';
        Field11 := '';
        Field12 := '';
        Field13 := '';
        Field14 := '';
        Field15 := '';
        Field16 := '';
        Field17 := '';
        Field18 := '';
        Field19 := '';
        Field20 := '';
        Field21 := '';
        Field22 := '';
        Field23 := '';
        Field24 := '';
        Field25 := '';
        Field26 := '';
        Field27 := '';
        Field28 := '';
        Field29 := '';
        Field30 := '';
        Field31 := '';
        Field32 := '';
        Field33 := '';
        Field34 := '';
        Field35 := '';
        Field36 := '';
        Field37 := '';
        Field38 := '';
        Field39 := '';
        Field40 := '';
        Field41 := '';
        Field42 := '';
        Field43 := '';
        Field44 := '';
        Field45 := '';
        Field46 := '';
        Field47 := '';
        Field48 := '';
        Field49 := '';
        Field50 := '';
        Field51 := '';
        Field52 := '';
        Field53 := '';
        Field54 := '';
        Field55 := '';
        Field56 := '';
        Field57 := '';
        Field58 := '';
        Field59 := '';
        Field60 := '';
        Field61 := '';
        Field62 := '';
        Field63 := '';
        Field64 := '';
        Field65 := '';
        Field66 := '';
        Field67 := '';
        Field68 := '';
        Field69 := '';
        Field70 := '';
        Field71 := '';
        Field72 := '';
        Field73 := '';
        Field74 := '';
        Field75 := '';
        Field76 := '';
        Field77 := '';
        Field78 := '';
        Field79 := '';
        Field80 := '';
        Field81 := '';
        Field82 := '';
        Field83 := '';
        Field84 := '';
        Field85 := '';
        Field86 := '';
        Field87 := '';
        Field88 := '';
        Field89 := '';
        Field90 := '';
        Field91 := '';
        Field92 := '';
        Field93 := '';
        Field94 := '';
        Field95 := '';
        Field96 := '';
        Field97 := '';
        Field98 := '';
        Field99 := '';
        Field100 := '';

        Clear(rrRecRef);
        rrRecRef.Open(nTableID);
    end;

    procedure addItemTracking()
    var
        lrecItemJnl: Record "Item Journal Line";
        lcuCreateResEntry: Codeunit "Create Reserv. Entry";
        ReservEntry: Record "Reservation Entry";
    begin
        if nTableID <> 83 then
            exit;

        rrRecRef.SetTable(lrecItemJnl);

        if (lrecItemJnl."Serial No." <> '') or (lrecItemJnl."Lot No." <> '') then begin
            Clear(ReservEntry);

            lcuCreateResEntry.CreateReservEntryFor(
                DATABASE::"Item Journal Line",
                lrecItemJnl."Entry Type",
                lrecItemJnl."Journal Template Name",
                lrecItemJnl."Journal Batch Name",
                0,
                lrecItemJnl."Line No.",
                lrecItemJnl."Qty. per Unit of Measure",
                lrecItemJnl.Quantity,
                lrecItemJnl."Quantity (Base)",
                ReservEntry
            );

            // Assign tracking
            ReservEntry."Serial No." := lrecItemJnl."Serial No.";
            ReservEntry."Lot No." := lrecItemJnl."Lot No.";

            // Finalize
            lcuCreateResEntry.SetDates(lrecItemJnl."Warranty Date", lrecItemJnl."Expiration Date");

            lcuCreateResEntry.CreateEntry(
              lrecItemJnl."Item No.", //ItemNo
              lrecItemJnl."Variant Code", //VariantCode
              lrecItemJnl."Location Code", //LocationCode
              lrecItemJnl.Description, //Description
              lrecItemJnl."Posting Date", //ExpectedReceiptDate
              0D, //ShipmentDate
              0, //TransferredFromEntryNo
              3 //Status (3==Prospect)
            );

            lrecItemJnl."Warranty Date" := 0D;
            lrecItemJnl."Expiration Date" := 0D;
            lrecItemJnl."Serial No." := '';
            lrecItemJnl."Lot No." := '';
            lrecItemJnl.Modify;

        end;//if
        //with
    end;
}