report 50000 "Extended AP Check Stub"
{
    // MER0001 TLE 04/28/14 Fix VendorName
    DefaultLayout = RDLC;
    RDLCLayout = './Extended AP Check Stub.rdlc';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;


    dataset
    {
        dataitem("Extended Check Stub"; "Extended Check Stub")
        {
            DataItemTableView = SORTING("Check No.", "Vendor No.");
            RequestFilterFields = "Check No.", "Check Date", "Vendor No.";

            trigger OnAfterGetRecord()
            begin
                // MER0001 >>
                //IF Vendor.GET("Vendor No.") THEN
                //  VendorName := Vendor.Name;
                // MER0001 <<

                tempExtendedCheckStub := "Extended Check Stub";
                tempExtendedCheckStub.Insert;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("Check No.");

                tempExtendedCheckStub.DeleteAll;
                OnLineNumber := 0;
            end;
        }
        dataitem(CopyLoop; "Integer")
        {
            dataitem(ExtendedSubLines; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(Extended_AP_Check_Stub__Check_No_; tempExtendedCheckStub."Check No.")
                {
                }
                column(CompanyInformation_Name; CompanyInformation.Name)
                {
                }
                column(Page_______FORMAT_CurrReport_PAGENO_; 'Page - ' + Format(CurrReport.PageNo))
                {
                }
                column(Vendor_No____________VendorName; tempExtendedCheckStub."Vendor No." + ' - ' + VendorName)
                {
                }
                column(Extended_AP_Check_Stub__Check_Date_; tempExtendedCheckStub."Check Date")
                {
                }
                column(Extended_AP_Check_Stub__External_Document_No_; tempExtendedCheckStub."External Document No.")
                {
                }
                column(Extended_AP_Check_Stub__Invoice_Date_; tempExtendedCheckStub."Invoice Date")
                {
                }
                column(Extended_AP_Check_Stub__Document_No_; tempExtendedCheckStub."Document No.")
                {
                }
                column(Extended_AP_Check_Stub__Discount_Amount_; tempExtendedCheckStub."Discount Amount")
                {
                }
                column(Extended_AP_Check_Stub__Net_Amount_; tempExtendedCheckStub."Net Amount")
                {
                }
                column(Extended_AP_Check_Stub__Gross_Amount_; tempExtendedCheckStub."Gross Amount")
                {
                }
                column(Total_for_Check_No________Check_No_______; 'Total for Check No - ' + tempExtendedCheckStub."Check No." + ':')
                {
                }
                column(Extended_AP_Check_Stub__Gross_Amount; tempExtendedCheckStub."Gross Amount")
                {
                }
                column(Extended_AP_Check_Stub__Discount_Amount; tempExtendedCheckStub."Discount Amount")
                {
                }
                column(Extended_AP_Check_Stub__Net_Amount; tempExtendedCheckStub."Net Amount")
                {
                }
                column(Extend_AP_Check_StubCaption; Extend_AP_Check_StubCaptionLbl)
                {
                }
                column(ReferenceCaption; ReferenceCaptionLbl)
                {
                }
                column(Internal_NoCaption; Internal_NoCaptionLbl)
                {
                }
                column(Discount_AmtCaption; Discount_AmtCaptionLbl)
                {
                }
                column(Gross_AmtCaption; Gross_AmtCaptionLbl)
                {
                }
                column(Check_Date_Caption; Check_Date_CaptionLbl)
                {
                }
                column(Check_No_Caption; Check_No_CaptionLbl)
                {
                }
                column(Vendor_No_Caption; Vendor_No_CaptionLbl)
                {
                }
                column(Extended_AP_Check_Stub_Entry_No; tempExtendedCheckStub."Entry No.")
                {
                }
                column(PostingDesc; tempExtendedCheckStub."Posting Description")
                {
                }
                column(CopyNo; CopyNo)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    OnLineNumber += 1;

                    if OnLineNumber = 1 then
                        tempExtendedCheckStub.Find('-')
                    else
                        tempExtendedCheckStub.Next;

                    // MER0001 >>
                    if Vendor.Get(tempExtendedCheckStub."Vendor No.") then
                        VendorName := Vendor.Name;
                    // MER0001 <<
                end;

                trigger OnPreDataItem()
                begin
                    NumberofLines := tempExtendedCheckStub.Count;
                    SetRange(Number, 1, NumberofLines);
                    OnLineNumber := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.PageNo := 1;
                if CopyNo = NoLoops then begin
                    CurrReport.Break;
                end;
                CopyNo := CopyNo + 1;
            end;

            trigger OnPreDataItem()
            begin
                NoLoops := 2;
                CopyNo := 0;
            end;
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

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInformation.Get('');
    end;

    var
        CompanyInformation: Record "Company Information";
        Vendor: Record Vendor;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        VendorName: Text[50];
        Extend_AP_Check_StubCaptionLbl: Label 'Extend AP Check Stub';
        ReferenceCaptionLbl: Label 'Reference';
        Internal_NoCaptionLbl: Label 'Internal No';
        Discount_AmtCaptionLbl: Label 'Discount Amt';
        Gross_AmtCaptionLbl: Label 'Gross Amt';
        Project_CodeCaptionLbl: Label 'Project Code';
        Check_Date_CaptionLbl: Label 'Check Date:';
        Check_No_CaptionLbl: Label 'Check No:';
        Vendor_No_CaptionLbl: Label 'Vendor No:';
        NoLoops: Integer;
        CopyNo: Integer;
        tempExtendedCheckStub: Record "Extended Check Stub" temporary;
        OnLineNumber: Integer;
        NumberofLines: Integer;
}

