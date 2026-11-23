tableextension 50003 tableextension70000173 extends Customer
{
    // <changelog>
    //   <add id="NA0001" dev="ELYNCH" date="2006-02-08" area="NASALESTAX" feature="617"
    //     releaseversion="NAVUS3.10.01">Added field 10015</add>
    //   <change id="NA0002" dev="ELYNCH" date="2006-02-08" area="REPORTS SR" feature="622"
    //     baseversion="NAVUS3.10.01" releaseversion="NAVUS3.10.01">Add key &quot;by Salesperson&quot;.</change>
    //   <change id="NA0003" dev="ELYNCH" date="2006-02-08" area="ELEC. PAY" feature="608"
    //     baseversion="NAVUS3.10.01" releaseversion="NAVUS3.10.01">Add North American Electronic Payments functionality.
    //     Add field 10017, Bank Communication.</change>
    //   <change id="NA0005" dev="ELYNCH" date="2006-02-08" area="REPORTS SR" feature="622"
    //     baseversion="NAVUS3.10.01" releaseversion="NAVUS3.10.01">Add field 10004 UPS Zone</change>
    //   <change id="NA0006" dev="ELYNCH" date="2006-04-11" area="NA ADDRESS" feature="293"
    //     baseversion="NAVUS3.10.01" releaseversion="NAVNA5.00">Populate State field (County) from ZIP code table
    //     </change>
    //   <change id="NA0008" dev="ELYNCH" date="2006-04-12" area="CHECKPRINT"  request="10003"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA5.00">Added fields for Canadian cheque printing cdcr 10003
    //     </change>
    //   <change id="NA0009" dev="JNOZZI" date="2006-05-16" area="REPORTS SR"  request="15738"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA5.00">Make Top Customer Report Date Aware - Add Fields 10021 and
    //     10022</change>
    //   <change id="NA0010" dev="JNOZZI" date="2006-06-16" area="CHECKPRINT" feature="286"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA5.00">Add new &quot;Spanish&quot; option to Bank Communication
    //     field.</change>
    //   <change id="NA0011" dev="ELYNCH" date="2009-01-06" area="MX" feature="32033"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA6.00.01">Add new field for MX RFC/CURP identification.</change>
    // </changelog>
    // 
    // MER0001 TLE 02/26/14 Add "New Account"
    // MER0002 CH  04/14/14 Add "School District" and code to support updating Ship-to
    // MER0003 CH  04/28/14 Add "Salesperson Filter" and modified calculation for "New Account"
    // MER0004 TLE 05/08/14 Add "CRM Customer Name"
    fields
    {
        modify("Credit Limit (LCY)")
        {
            Caption = 'Credit Limit (LCY)';
        }
        modify("Balance (LCY)")
        {
            Caption = 'Balance (LCY)';
        }
        modify("Net Change (LCY)")
        {
            Caption = 'Net Change (LCY)';
        }
        modify("Sales (LCY)")
        {
            Caption = 'Sales (LCY)';
        }
        modify("Profit (LCY)")
        {
            Caption = 'Profit (LCY)';
        }
        modify("Inv. Discounts (LCY)")
        {
            Caption = 'Inv. Discounts (LCY)';
        }
        modify("Pmt. Discounts (LCY)")
        {
            Caption = 'Pmt. Discounts (LCY)';
        }
        modify("Balance Due (LCY)")
        {
            Caption = 'Balance Due (LCY)';
        }
        modify("Payments (LCY)")
        {
            Caption = 'Payments (LCY)';
        }
        modify("Inv. Amounts (LCY)")
        {
            Caption = 'Inv. Amounts (LCY)';
        }
        modify("Cr. Memo Amounts (LCY)")
        {
            Caption = 'Cr. Memo Amounts (LCY)';
        }
        modify("Fin. Charge Memo Amounts (LCY)")
        {
            Caption = 'Fin. Charge Memo Amounts (LCY)';
        }
        modify("VAT Registration No.")
        {
            Caption = 'VAT Registration No.';
        }
        modify("Post Code")
        {
            Caption = 'Post Code';
        }
        modify(County)
        {
            Caption = 'County';
        }
        modify("Debit Amount (LCY)")
        {
            Caption = 'Debit Amount (LCY)';
        }
        modify("Credit Amount (LCY)")
        {
            Caption = 'Credit Amount (LCY)';
        }
        modify("Reminder Amounts (LCY)")
        {
            Caption = 'Reminder Amounts (LCY)';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'VAT Bus. Posting Group';
        }
        modify("Outstanding Orders (LCY)")
        {
            Caption = 'Outstanding Orders (LCY)';
        }
        modify("Shipped Not Invoiced (LCY)")
        {
            Caption = 'Shipped Not Invoiced (LCY)';
        }
        modify("Pmt. Disc. Tolerance (LCY)")
        {
            Caption = 'Pmt. Disc. Tolerance (LCY)';
        }
        modify("Pmt. Tolerance (LCY)")
        {
            Caption = 'Pmt. Tolerance (LCY)';
        }
        modify("Refunds (LCY)")
        {
            Caption = 'Refunds (LCY)';
        }
        modify("Other Amounts (LCY)")
        {
            Caption = 'Other Amounts (LCY)';
        }
        modify("Outstanding Invoices (LCY)")
        {
            Caption = 'Outstanding Invoices (LCY)';
        }
        modify("Bill-to No. Of Archived Doc.")
        {
            Caption = 'Bill-to No. Of Archived Doc.';
        }
        modify("Outstanding Serv. Orders (LCY)")
        {
            Caption = 'Outstanding Serv. Orders (LCY)';
        }
        modify("Serv Shipped Not Invoiced(LCY)")
        {
            Caption = 'Serv Shipped Not Invoiced(LCY)';
        }
        modify("Balance on Date (LCY)")
        {
            Caption = 'Balance on Date (LCY)';
        }


        //Unsupported feature: Code Modification on ""Country/Region Code"(Field 35).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.CheckClearPostCodeCityCounty(City,"Post Code",County,"Country/Region Code",xRec."Country/Region Code");

        if "Country/Region Code" <> xRec."Country/Region Code" then
          VATRegistrationValidation;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*

        PostCode.CheckClearPostCodeCityCounty(City,"Post Code",County,"Country/Region Code",xRec."Country/Region Code");

        #2..4
        */
        //end;


        //Unsupported feature: Code Modification on ""E-Mail"(Field 102).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        MailManagement.ValidateEmailAddressField("E-Mail");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*

        MailManagement.ValidateEmailAddressField("E-Mail");
        */
        //end;
        field(50000; "New Account"; Boolean)
        {
            CalcFormula = - Exist("Cust. Ledger Entry" WHERE("Customer No." = FIELD("No."),
                                                             "Posting Date" = FIELD("Date Filter"),
                                                             "Salesperson Code" = FIELD("Salesperson Filter"),
                                                             "Document Type" = FILTER(Invoice | "Credit Memo")));
            Caption = 'New Account';
            Description = 'MER0003';
            FieldClass = FlowField;
        }
        field(50001; "School District"; Boolean)
        {
            Caption = 'School District';
            Description = 'MER0002';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                ShipToAddr: Record "Ship-to Address";
            begin
                ShipToAddr.SetRange("Customer No.", "No.");
                if ShipToAddr.FindSet then begin
                    repeat
                        ShipToAddr."School District" := "School District";
                        ShipToAddr.Modify;
                    until ShipToAddr.Next = 0;
                end;
            end;
        }
        field(50002; "Salesperson Filter"; Code[10])
        {
            Description = 'MER0003';
            FieldClass = FlowFilter;

        }
        field(50003; "CRM Customer Name"; Text[50])
        {
            Description = 'MER0004';
            DataClassification = ToBeClassified;
        }
    }


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ApprovalsMgmt.OnCancelCustomerApprovalRequest(Rec);

    ServiceItem.SetRange("Customer No.","No.");
    if ServiceItem.FindFirst then
    #5..8
      else
        Error(Text009);

    Job.SetRange("Bill-to Customer No.","No.");
    if not Job.IsEmpty then
      Error(Text015,TableCaption,"No.",Job.TableCaption);
    #15..120

    DimMgt.DeleteDefaultDim(DATABASE::Customer,"No.");

    CalendarManagement.DeleteCustomizedBaseCalendarData(CustomizedCalendarChange."Source Type"::Customer,"No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //ApprovalsMgmt.OnCancelCustomerApprovalRequest(Rec);

    #2..11

    #12..123

    CalendarManagement.DeleteCustomizedBaseCalendarData(CustomizedCalendarChange."Source Type"::Customer,"No.");
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "AssistEdit(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "ShowContact(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "SetInsertFromContact(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "CheckBlockedCustOnDocs(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "CheckBlockedCustOnJnls(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "CustBlockedErrorMessage(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "CustPrivacyBlockedErrorMessage(PROCEDURE 72)".


    //Unsupported feature: Property Modification (Attributes) on "GetPrivacyBlockedGenericErrorText(PROCEDURE 73)".


    //Unsupported feature: Property Modification (Attributes) on "DisplayMap(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "GetTotalAmountLCY(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "GetTotalAmountLCYUI(PROCEDURE 16)".



    //Unsupported feature: Code Modification on "GetTotalAmountLCYCommon(PROCEDURE 17)".

    //procedure GetTotalAmountLCYCommon();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesOutstandingAmountFromShipment := SalesLine.OutstandingInvoiceAmountFromShipment("No.");
    ServOutstandingAmountFromShipment := ServiceLine.OutstandingInvoiceAmountFromShipment("No.");
    InvoicedPrepmtAmountLCY := GetInvoicedPrepmtAmountLCY;
    RetRcdNotInvAmountLCY := GetReturnRcdNotInvAmountLCY;

    exit("Balance (LCY)" + "Outstanding Orders (LCY)" + "Shipped Not Invoiced (LCY)" + "Outstanding Invoices (LCY)" +
      "Outstanding Serv. Orders (LCY)" + "Serv Shipped Not Invoiced(LCY)" + "Outstanding Serv.Invoices(LCY)" -
      SalesOutstandingAmountFromShipment - ServOutstandingAmountFromShipment - InvoicedPrepmtAmountLCY - RetRcdNotInvAmountLCY);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*

    #1..5


    #6..8
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "GetSalesLCY(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "CalcAvailableCredit(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "CalcAvailableCreditUI(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "CalcOverdueBalance(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateRFCNo(PROCEDURE 1020000)".


    //Unsupported feature: Property Modification (Attributes) on "GetLegalEntityType(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "GetLegalEntityTypeLbl(PROCEDURE 26)".


    //Unsupported feature: Property Modification (Attributes) on "SetStyle(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "HasValidDDMandate(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "GetReturnRcdNotInvAmountLCY(PROCEDURE 53)".


    //Unsupported feature: Property Modification (Attributes) on "GetInvoicedPrepmtAmountLCY(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "CalcCreditLimitLCYExpendedPct(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "CreateAndShowNewInvoice(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "CreateAndShowNewOrder(PROCEDURE 30)".


    //Unsupported feature: Property Modification (Attributes) on "CreateAndShowNewCreditMemo(PROCEDURE 22)".


    //Unsupported feature: Property Modification (Attributes) on "CreateAndShowNewQuote(PROCEDURE 24)".


    //Unsupported feature: Property Modification (Attributes) on "GetBillToCustomerNo(PROCEDURE 27)".


    //Unsupported feature: Property Modification (Attributes) on "HasAddressIgnoreCountryCode(PROCEDURE 37)".


    //Unsupported feature: Property Modification (Attributes) on "HasAddress(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "HasDifferentAddress(PROCEDURE 49)".


    //Unsupported feature: Property Modification (Attributes) on "GetCustNo(PROCEDURE 44)".


    //Unsupported feature: Property Modification (Attributes) on "GetCustNoOpenCard(PROCEDURE 36)".


    //Unsupported feature: Property Modification (Attributes) on "CreateNewCustomer(PROCEDURE 28)".


    //Unsupported feature: Property Modification (Attributes) on "OpenCustomerLedgerEntries(PROCEDURE 31)".


    //Unsupported feature: Property Modification (Attributes) on "SetInsertFromTemplate(PROCEDURE 32)".


    //Unsupported feature: Property Modification (Attributes) on "IsLookupRequested(PROCEDURE 34)".


    //Unsupported feature: Property Modification (Attributes) on "IsBlocked(PROCEDURE 52)".


    //Unsupported feature: Property Modification (Attributes) on "HasAnyOpenOrPostedDocuments(PROCEDURE 60)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromCustomerTemplate(PROCEDURE 63)".


    //Unsupported feature: Property Modification (Attributes) on "SetAddress(PROCEDURE 40)".


    //Unsupported feature: Property Modification (Attributes) on "FindByEmail(PROCEDURE 41)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateReferencedIds(PROCEDURE 61)".


    //Unsupported feature: Property Modification (Attributes) on "GetReferencedIds(PROCEDURE 46)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateCurrencyId(PROCEDURE 55)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePaymentTermsId(PROCEDURE 57)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateShipmentMethodId(PROCEDURE 59)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePaymentMethodId(PROCEDURE 45)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateTaxAreaId(PROCEDURE 1166)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeIsContactUpdateNeeded(PROCEDURE 50)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromCustomerTemplate(PROCEDURE 64)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterHasAnyOpenOrPostedDocuments(PROCEDURE 62)".



    //Unsupported feature: Property Modification (TextConstString) on "Text007(Variable 1028)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : ENU=You cannot delete %1 %2 because there is at least one not canceled Service Contract for this customer.;ESM=No puede borrar %1 %2 porque hay al menos un Contrato de Servicio no cancelado para este cliente.;FRC=Vous ne pouvez pas supprimer %1 %2 puisqu'au moins un contrat de services n'est pas annulé pour ce client.;ENC=You cannot delete %1 %2 because there is at least one not cancelled Service Contract for this customer.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : ENU=You cannot delete %1 %2 because there is at least one not cancelled Service Contract for this customer.;ESM=No puede borrar %1 %2 porque hay al menos un Contrato de Servicio no cancelado para este cliente.;FRC=Vous ne pouvez pas supprimer %1 %2 puisqu'au moins un contrat de services n'est pas annulé pour ce client.;ENC=You cannot delete %1 %2 because there is at least one not cancelled Service Contract for this customer.;
    //Variable type has not been exported.
}

