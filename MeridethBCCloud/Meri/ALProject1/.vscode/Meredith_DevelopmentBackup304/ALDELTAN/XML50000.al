xmlport 50000 "Vendor Legacy"
{
    Caption = 'Imp. IRIS to Area/Symptom Code';
    Direction = Import;
    FieldDelimiter = '<NULL>';
    FieldSeparator = '|';
    Format = VariableText;
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement(Vendor; Vendor)
            {
                AutoSave = false;
                AutoUpdate = true;
                XmlName = 'Import';
                UseTemporary = true;
                fieldelement(VendorNo; Vendor."No.")
                {

                    trigger OnAfterAssignField()
                    begin
                        //MESSAGE('%1',);
                    end;
                }
                fieldelement(Legacy1; Vendor."Legacy Vendor No.")
                {
                }
                fieldelement(Legacy2; Vendor."Legacy Vendor No. 2")
                {
                }
                fieldelement(Legacy3; Vendor."Legacy Vendor No. 3")
                {
                }
                fieldelement(Legacy4; Vendor."Legacy Vendor No. 4")
                {
                }

                trigger OnBeforeInsertRecord()
                var
                    FaultArea: Record "Fault Area";
                    SymptCode: Record "Symptom Code";
                begin
                    //MESSAGE('%1 %2',Vendor."No.",Vendor."Legacy Vendor No.");
                    if Vendor2.Get(Vendor."No.") then begin
                        Vendor2."Legacy Vendor No." := Vendor."Legacy Vendor No.";
                        Vendor2."Legacy Vendor No. 2" := Vendor."Legacy Vendor No. 2";
                        Vendor2."Legacy Vendor No. 3" := Vendor."Legacy Vendor No. 3";
                        Vendor2."Legacy Vendor No. 4" := Vendor."Legacy Vendor No. 4";
                        Vendor2.Modify;
                    end;
                    /*
                    CASE "Fault Area/Symptom Code".Type OF
                      "Fault Area/Symptom Code".Type::"Fault Area":
                        BEGIN
                          FaultArea.INIT;
                          FaultArea.Code := "Fault Area/Symptom Code".Code;
                          FaultArea.Description := "Fault Area/Symptom Code".Description;
                          IF NOT FaultArea.INSERT THEN
                            FaultArea.MODIFY;
                          Counter += 1;
                        END;
                      "Fault Area/Symptom Code".Type::"Symptom Code":
                        BEGIN
                          SymptCode.INIT;
                          SymptCode.Code := "Fault Area/Symptom Code".Code;
                          SymptCode.Description := "Fault Area/Symptom Code".Description;
                          IF NOT SymptCode.INSERT THEN
                            SymptCode.MODIFY;
                          Counter += 1;
                        END;
                    END;
                    */

                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPostXmlPort()
    begin
        Message(Text001, Counter);
    end;

    var
        Counter: Integer;
        Text001: Label '%1 records were successfully inserted/modified.';
        Vendor2: Record Vendor;
}

