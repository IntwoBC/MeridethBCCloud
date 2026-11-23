report 50001 "MER Salesperson Commissions"
{
    // MER0001 TLE 04/09/14 Adjust Gross Profit to decrease by Salesperson Order Fee, Total Burden Amount, Credit Card Charges & Salesperson Order Fee.
    // MER0002 TLE 04/10/14 Accomodate DELETED SalesCrMemo
    // MER0003 TLE 04/10/14 Use Sales (LCY) rather than Amount to not include tax.
    // MER0004 TLE 04/10/14 Total Burden Amount CALCFIELDS for Gross Profit. Move Profit calcs for Invoices.
    // MER0005 TLE 04/10/14 Credit Memos
    // MER0006 TLE 04/22/14 Chargebacks get same Posting Date as CLE's.
    // MER0007 CH  04/22/14 Credit Memo calculation of GP was modified.
    // MER0008 TLE 04/23/14 Restrict Sales People Access
    // MER0009 TLE 06/03/14
    DefaultLayout = RDLC;
    RDLCLayout = './MER Salesperson Commissions.rdlc';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;



    dataset
    {
        dataitem("Salesperson/Purchaser"; "Salesperson/Purchaser")
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Code";
            column(Code_Salesperson; "Salesperson/Purchaser".Code)
            {
            }
            column(Name_Salesperson; "Salesperson/Purchaser".Name)
            {
            }
            column(CompanyAddress1; CompanyAddress[1])
            {
            }
            column(CompanyAddress2; CompanyAddress[2])
            {
            }
            column(CompanyAddress3; CompanyAddress[3])
            {
            }
            column(CompanyAddress4; CompanyAddress[4])
            {
            }
            column(CompanyAddress5; CompanyAddress[5])
            {
            }
            column(CompanyAddress6; CompanyAddress[6])
            {
            }
            column(CompanyAddress7; CompanyAddress[7])
            {
            }
            column(CompanyAddress8; CompanyAddress[8])
            {
            }
            column(SalesRepFilter; DisplayFilter)
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Salesperson Code" = FIELD(Code);
                DataItemTableView = WHERE("Document Type" = FILTER(Invoice | "Credit Memo"));
                RequestFilterFields = "Posting Date";

                trigger OnAfterGetRecord()
                begin
                    TempCustLedgEntry := "Cust. Ledger Entry";
                    TempCustLedgEntry.Insert;
                end;

                trigger OnPreDataItem()
                begin
                    TempCustLedgEntry.Reset;
                    TempCustLedgEntry.DeleteAll;
                end;
            }
            dataitem("Comm. Credit Card Backcharge"; "Comm. Credit Card Backcharge")
            {
                DataItemLink = "Salesperson Code" = FIELD(Code);
                DataItemTableView = SORTING("No.");
                RequestFilterFields = "Posting Date";

                trigger OnAfterGetRecord()
                var
                    LastEntryNo: Integer;
                begin
                    // MER0009 >>
                    //TempCustLedgEntry.FIND('+');
                    //LastEntryNo := TempCustLedgEntry."Entry No.";
                    if TempCustLedgEntry.Find('+') then
                        LastEntryNo := TempCustLedgEntry."Entry No.";
                    // MER0009 <<
                    Clear(TempCustLedgEntry);
                    TempCustLedgEntry."Entry No." := LastEntryNo + 1;
                    TempCustLedgEntry."Document No." := "No.";
                    TempCustLedgEntry."Posting Date" := "Posting Date";
                    TempCustLedgEntry."Customer No." := "Sell-to Customer No.";
                    TempCustLedgEntry."Salesperson Commission Amount" := -1 * Amount;
                    TempCustLedgEntry.Insert;
                end;

                trigger OnPreDataItem()
                var
                    myFilter: Text[30];
                begin
                    // MER0006 >>
                    //SETRANGE("Posting Date","Cust. Ledger Entry".GETFILTER("Posting Date"));
                    //SETFILTER("Posting Date",'=%1',TODAY);
                    //COPYFILTER("Posting Date","Cust. Ledger Entry"."Posting Date");
                    //SETFILTER("Posting Date",'%1',myFilter);
                    // MER0006 <<
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) ORDER(Descending);
                column(DocumentType_TempCustLedgEntry; TempCustLedgEntry."Document Type")
                {
                }
                column(DocumentNo_TempCustLedgEntry; TempCustLedgEntry."Document No.")
                {
                }
                column(SourceNo; SourceNo)
                {
                }
                column(OrderDate; OrderDate)
                {
                }
                column(PostingDate_TempCustLedgEntry; TempCustLedgEntry."Posting Date")
                {
                }
                column(CustomerNo_TempCustLedgEntry; TempCustLedgEntry."Customer No.")
                {
                }
                column(Sales_TempCustLedgEntry; TempCustLedgEntry."Sales (LCY)")
                {
                }
                column(ProfitLCY_TempCustLedgEntry; TempCustLedgEntry."Profit (LCY)")
                {
                }
                column(SalespersonCommissionAmount_TempCustLedgEntry; TempCustLedgEntry."Salesperson Commission Amount")
                {
                }
                column(Name_Customer; Customer.Name)
                {
                }
                column(TotalSubtotalAmount; TotalSubtotalAmount)
                {
                }
                column(TotalGrossProfitAmount; TotalGrossProfitAmount)
                {
                }
                column(TotalSalespersonCommissionAmount; TotalSalespersonCommissionAmount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    OnLineNumber += 1;

                    if OnLineNumber = 1 then
                        TempCustLedgEntry.Find('-')
                    else
                        TempCustLedgEntry.Next;

                    // MER0003 >>
                    //CALCFIELDS(Amount);
                    // MER0003 <<

                    Customer.Get(TempCustLedgEntry."Customer No.");

                    Clear(OrderDate);
                    Clear(SourceNo);
                    case TempCustLedgEntry."Document Type" of
                        TempCustLedgEntry."Document Type"::Invoice:
                            begin
                                SalesInvoiceHeader.Get(TempCustLedgEntry."Document No.");
                                OrderDate := SalesInvoiceHeader."Order Date";
                                SourceNo := SalesInvoiceHeader."Order No.";

                                // MER0004 >>
                                SalesInvoiceHeader.CalcFields("Total Burden Amount");
                                TempCustLedgEntry."Profit (LCY)" := TempCustLedgEntry."Profit (LCY)" - SalesInvoiceHeader."Salesperson Order Fee"
                                  - SalesInvoiceHeader."Credit Card Charges" - SalesInvoiceHeader."Total Burden Amount";
                                // MER0004 <<
                            end;
                        TempCustLedgEntry."Document Type"::"Credit Memo":
                            begin
                                // MER0002 >>
                                //SalesCrMemoHeader.GET("Document No.");
                                //OrderDate := SalesCrMemoHeader."Posting Date";
                                Clear(OrderDate);
                                if SalesCrMemoHeader.Get(TempCustLedgEntry."Document No.") then
                                    OrderDate := SalesCrMemoHeader."Posting Date";
                                // MER0002 <<

                                // MER0005 >>
                                SalesCrMemoHeader.CalcFields("Total Burden Amount");
                                // MER0007 >>
                                TempCustLedgEntry."Profit (LCY)" := TempCustLedgEntry."Profit (LCY)" + SalesCrMemoHeader."Total Burden Amount";
                                //      "Profit (LCY)" := "Profit (LCY)" + SalesCrMemoHeader."Salesperson Order Fee"
                                //        + SalesCrMemoHeader."Credit Card Charges" + SalesCrMemoHeader."Total Burden Amount";
                                // MER0007 <<
                                // MER0005 <<
                            end;
                        TempCustLedgEntry."Document Type"::" ":
                            begin
                                CommCreditCardBackcharge.Get(TempCustLedgEntry."Document No.");
                                SourceNo := CommCreditCardBackcharge."Reference No.";
                            end;
                    end;

                    // MER0004 >>
                    //// MER0001 >>
                    //"Profit (LCY)" := "Profit (LCY)" - SalesInvoiceHeader."Salesperson Order Fee" - SalesInvoiceHeader."Salesperson Misc. Charge"
                    //  - SalesInvoiceHeader."Credit Card Charges" - SalesInvoiceHeader."Total Burden Amount";
                    //// MER0001 <<
                    // MER0004 <<

                    // MER0003 >>
                    //TotalSubtotalAmount += Amount;
                    TotalSubtotalAmount += TempCustLedgEntry."Sales (LCY)";
                    // MER0003 <<
                    TotalGrossProfitAmount += TempCustLedgEntry."Profit (LCY)";
                    TotalSalespersonCommissionAmount += TempCustLedgEntry."Salesperson Commission Amount";
                end;

                trigger OnPreDataItem()
                begin
                    Clear(TotalSubtotalAmount);
                    Clear(TotalGrossProfitAmount);
                    Clear(TotalSalespersonCommissionAmount);

                    NumberOfLines := TempCustLedgEntry.Count;
                    SetRange(Number, 1, NumberOfLines);
                    OnLineNumber := 0;
                end;
            }

            trigger OnPreDataItem()
            begin
                // MER0008 >>
                if UserSetup.Get(UserId) and Salesperson.Get(UserSetup."Salespers./Purch. Code") and Salesperson."Restrict view to self" then
                    "Salesperson/Purchaser".SetRange(Code, UserSetup."Salespers./Purch. Code");
                // MER0008 <<
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
        lblType = 'Type';
        lblNumber = 'Number';
        lblOrderDate = 'Order Date';
        lblInvoicedDate = 'Invoiced Date';
        lblCustCode = 'Cust. Code';
        lblCustName = 'Cust Name';
        lblSubtotal = 'Subtotal';
        lblGrossProfit = 'Gross Profit';
        lblCommissionable = 'Commissionable';
        lblCommission = 'Commission';
        lblSourceNo = 'Source No.';
    }

    trigger OnPreReport()
    begin
        CompanyInformation.Get;

        FormatAddress.Company(CompanyAddress, CompanyInformation);
        DisplayFilter := DelChr("Salesperson/Purchaser".GetFilters + ' ' + "Cust. Ledger Entry".GetFilters, '<>', '');
    end;

    var
        CompanyInformation: Record "Company Information";
        Customer: Record Customer;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        CompanyAddress: array[8] of Text[50];
        FormatAddress: Codeunit "Format Address";
        TotalSalespersonCommissionAmount: Decimal;
        TotalSubtotalAmount: Decimal;
        TotalGrossProfitAmount: Decimal;
        OrderDate: Date;
        DisplayFilter: Text[250];
        TempCustLedgEntry: Record "Cust. Ledger Entry" temporary;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        SourceNo: Code[20];
        CommCreditCardBackcharge: Record "Comm. Credit Card Backcharge";
        UserSetup: Record "User Setup";
        Salesperson: Record "Salesperson/Purchaser";
}

