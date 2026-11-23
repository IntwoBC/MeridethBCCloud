// Step 1: import the BC14 CSV into "Document Commission Charges" (table 50004)
//         -> Document Commission Charges page and the Commissions Factbox on open documents show BC14 values.
// Step 2: copy those values to the Posted Sales Invoices (exactly what BC14 posting did, Codeunit 80 MER0004)
//         -> Posted Commissions Factbox shows BC14 values.
//         Optional: also the Customer Ledger Entry "Salesperson Commission Amount" (used by report 50001).
report 50095 "MER Import BC14 Comm. Charges"
{
    Caption = 'Import BC14 Commission Charges';
    ProcessingOnly = true;
    UsageCategory = Tasks;
    ApplicationArea = All;
    Permissions = tabledata "Document Commission Charges" = rimd,
                  tabledata "Sales & Receivables Setup" = rim,
                  tabledata "Sales Invoice Header" = rm,
                  tabledata "Cust. Ledger Entry" = rm;

    dataset
    {
        dataitem(SalesInvHeader; "Sales Invoice Header")
        {
            RequestFilterFields = "No.", "Posting Date", "Order No.";

            trigger OnPreDataItem()
            begin
                if not UpdatePostedInvoices then
                    CurrReport.Break();
            end;

            trigger OnAfterGetRecord()
            var
                DocCommChgs: Record "Document Commission Charges";
                SalesInvHeader2: Record "Sales Invoice Header";
                CustLedgEntry: Record "Cust. Ledger Entry";
                DocType: Integer;
                SourceNo: Code[20];
            begin
                // Which open document did this invoice come from?
                if SalesInvHeader."Order No." <> '' then begin
                    DocType := 1; // Order
                    SourceNo := SalesInvHeader."Order No.";
                end else begin
                    DocType := 2; // Invoice
                    SourceNo := SalesInvHeader."Pre-Assigned No.";
                end;
                if (SourceNo = '') or not DocCommChgs.Get(DocType, SourceNo) then begin
                    NotFoundCount += 1;
                    CurrReport.Skip();
                end;

                // Partially invoiced orders: the BC14 value belongs to the whole order, not to each invoice
                if SalesInvHeader."Order No." <> '' then begin
                    SalesInvHeader2.SetRange("Order No.", SalesInvHeader."Order No.");
                    if SalesInvHeader2.Count() > 1 then
                        if SkipMultiInvoiceOrders then begin
                            MultiInvCount += 1;
                            AddToList(MultiInvList, SalesInvHeader."No.");
                            CurrReport.Skip();
                        end;
                end;

                if not OverwriteExisting and HasValues(SalesInvHeader) then begin
                    KeptCount += 1;
                    CurrReport.Skip();
                end;

                SalesInvHeader."Salesperson Commission Amount" := DocCommChgs."Salesperson Commission Amount";
                SalesInvHeader."Salesperson Order Fee" := DocCommChgs."Salesperson Order Fee";
                SalesInvHeader."Salesperson Misc. Charge" := DocCommChgs."Salesperson Misc. Charge";
                SalesInvHeader."Credit Card Charges" := DocCommChgs."Credit Card Charges";
                SalesInvHeader.Modify();
                UpdatedInvCount += 1;

                if UpdateCustLedgEntries then begin
                    CustLedgEntry.SetRange("Document Type", CustLedgEntry."Document Type"::Invoice);
                    CustLedgEntry.SetRange("Document No.", SalesInvHeader."No.");
                    CustLedgEntry.SetRange("Customer No.", SalesInvHeader."Bill-to Customer No.");
                    if CustLedgEntry.FindFirst() then begin
                        CustLedgEntry."Salesperson Commission Amount" := SalesInvHeader."Salesperson Commission Amount";
                        CustLedgEntry.Modify();
                        UpdatedCLECount += 1;
                    end;
                end;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(Step1)
                {
                    Caption = '1. Import';
                    field(ImportFileField; ImportFile)
                    {
                        ApplicationArea = All;
                        Caption = 'Import CSV into Document Commission Charges';
                        ToolTip = 'Asks for DocCommissionCharges_BC14.csv and inserts/updates table 50004.';
                    }
                }
                group(Step0)
                {
                    Caption = '0. Setup';
                    field(ApplySalesSetupField; ApplySalesSetup)
                    {
                        ApplicationArea = All;
                        Caption = 'Apply BC14 Sales & Receivables commission setup';
                        ToolTip = 'Fills the Commissions fields of Sales & Receivables Setup with the BC14 values (Order Fee Base 11.75, Additional 7.00, CC Rate 2.75, G/L 5051501 / 4504501, COMM-CC, New Accounts 13). Only empty fields are filled unless Overwrite is selected.';
                    }
                    field(OverwriteSetupField; OverwriteSetup)
                    {
                        ApplicationArea = All;
                        Caption = 'Overwrite setup values that are already filled';
                    }
                }
                group(Step2)
                {
                    Caption = '2. Posted Sales Invoices';
                    field(UpdatePostedInvoicesField; UpdatePostedInvoices)
                    {
                        ApplicationArea = All;
                        Caption = 'Update Posted Sales Invoices';
                    }
                    field(OverwriteExistingField; OverwriteExisting)
                    {
                        ApplicationArea = All;
                        Caption = 'Overwrite invoices that already have values';
                    }
                    field(SkipMultiInvoiceOrdersField; SkipMultiInvoiceOrders)
                    {
                        ApplicationArea = All;
                        Caption = 'Skip orders posted with more than one invoice';
                    }
                    field(UpdateCustLedgEntriesField; UpdateCustLedgEntries)
                    {
                        ApplicationArea = All;
                        Caption = 'Also update Cust. Ledger Entries';
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            ApplySalesSetup := true;
            ImportFile := true;
            UpdatePostedInvoices := true;
            SkipMultiInvoiceOrders := true;
        end;
    }

    trigger OnPreReport()
    var
        ImportXmlPort: XmlPort "MER Import Doc Comm Charges";
        InStr: InStream;
        FileName: Text;
    begin
        if ApplySalesSetup then
            ApplyBC14SalesSetup();
        if not ImportFile then
            exit;
        if not UploadIntoStream('Select DocCommissionCharges_BC14.csv', '', 'CSV files (*.csv)|*.csv', FileName, InStr) then
            Error('No file selected.');
        ImportXmlPort.SetSource(InStr);
        ImportXmlPort.Import();
        ImportXmlPort.GetCounts(InsertedCount, ModifiedCount, SkippedCount);
    end;

    trigger OnPostReport()
    var
        Msg: Text;
    begin
        if ApplySalesSetup then
            Msg := SetupMsg + '\';
        if ImportFile then
            Msg += StrSubstNo('Document Commission Charges: %1 inserted, %2 updated, %3 skipped.\', InsertedCount, ModifiedCount, SkippedCount);
        if UpdatePostedInvoices then begin
            Msg += StrSubstNo('Posted Sales Invoices updated: %1\No BC14 record found: %2\Kept (already had values): %3\Skipped (order with several invoices): %4',
                              UpdatedInvCount, NotFoundCount, KeptCount, MultiInvCount);
            if UpdateCustLedgEntries then
                Msg += StrSubstNo('\Cust. Ledger Entries updated: %1', UpdatedCLECount);
            if MultiInvList <> '' then
                Msg += '\\Check manually: ' + CopyStr(MultiInvList, 1, 500);
        end;
        Message(Msg);
    end;

    var
        ApplySalesSetup: Boolean;
        OverwriteSetup: Boolean;
        SetupMsg: Text;
        ImportFile: Boolean;
        UpdatePostedInvoices: Boolean;
        OverwriteExisting: Boolean;
        SkipMultiInvoiceOrders: Boolean;
        UpdateCustLedgEntries: Boolean;
        InsertedCount: Integer;
        ModifiedCount: Integer;
        SkippedCount: Integer;
        UpdatedInvCount: Integer;
        UpdatedCLECount: Integer;
        NotFoundCount: Integer;
        KeptCount: Integer;
        MultiInvCount: Integer;
        MultiInvList: Text;

    local procedure ApplyBC14SalesSetup()
    var
        SalesSetup: Record "Sales & Receivables Setup";
        GLAccount: Record "G/L Account";
        NoSeries: Record "No. Series";
        Missing: Text;
    begin
        // Values = BC14 Sales & Receivables Setup, Commissions tab (screenshot from BC14 RTC)
        if not SalesSetup.Get() then
            SalesSetup.Insert();

        if OverwriteSetup or (SalesSetup."Salesperson Order Fee Base" = 0) then
            SalesSetup."Salesperson Order Fee Base" := 11.75;
        if OverwriteSetup or (SalesSetup."Slsperson Order Fee Additional" = 0) then
            SalesSetup."Slsperson Order Fee Additional" := 7.00;
        if OverwriteSetup or (SalesSetup."Credit Card Charges Rate" = 0) then
            SalesSetup."Credit Card Charges Rate" := 2.75;
        if OverwriteSetup or (SalesSetup."New Accounts (Time Period)" = 0) then
            SalesSetup."New Accounts (Time Period)" := 13;
        // "Def. Comm. Gen. Jnl. Btch Name" was empty in BC14 - left as it is.

        if OverwriteSetup or (SalesSetup."G/L Freight Expense Account" = '') then
            if GLAccount.Get('5051501') then
                SalesSetup."G/L Freight Expense Account" := '5051501'
            else
                Missing += ' G/L Account 5051501;';
        if OverwriteSetup or (SalesSetup."G/L Freight Revenue Account" = '') then
            if GLAccount.Get('4504501') then
                SalesSetup."G/L Freight Revenue Account" := '4504501'
            else
                Missing += ' G/L Account 4504501;';
        if OverwriteSetup or (SalesSetup."Comm. Cred. Card Backcharges" = '') then
            if NoSeries.Get('COMM-CC') then
                SalesSetup."Comm. Cred. Card Backcharges" := 'COMM-CC'
            else
                Missing += ' No. Series COMM-CC;';

        SalesSetup.Modify();

        SetupMsg := 'Sales & Receivables Setup: BC14 commission values applied.';
        if Missing <> '' then
            SetupMsg += ' Not found in BC25 (create them, then run again):' + Missing;
    end;

    local procedure HasValues(SIH: Record "Sales Invoice Header"): Boolean
    begin
        exit((SIH."Salesperson Commission Amount" <> 0) or (SIH."Salesperson Order Fee" <> 0) or
             (SIH."Salesperson Misc. Charge" <> 0) or (SIH."Credit Card Charges" <> 0));
    end;

    local procedure AddToList(var List: Text; Value: Code[20])
    begin
        if StrLen(List) > 500 then
            exit;
        if List <> '' then
            List += ', ';
        List += Value;
    end;
}
