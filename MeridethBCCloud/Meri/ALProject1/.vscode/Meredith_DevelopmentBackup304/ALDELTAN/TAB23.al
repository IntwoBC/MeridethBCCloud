tableextension 50005 tableextension70000225 extends Vendor
{
    // <changelog>
    //   <add id="NA0000" dev="ELYNCH" date="2006-01-23" area="1099" feature="601"
    //     releaseversion="NAVUS3.10.01">Added fields 10020 and 10016</add>
    //   <change id="NA0001" dev="ELYNCH" date="2006-04-11" area="NA ADDRESS" feature="293"
    //     baseversion="NAVUS3.10.01" releaseversion="NAVNA5.00">Populate State field (County) from ZIP code table
    //     </change>
    //   <change id="NA0002" dev="ELYNCH" date="2006-04-05" area="CHECKPRINT"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA5.00">Added fields for Canadian cheque printing cdcr 10003
    //     </change>
    //   <change id="NA0003" dev="JNOZZI" date="2006-05-15" area="REPORTS PP" feature="620"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA5.00">Add key for Purchaser Code for repeort 10114</change>
    //   <change id="NA0004" dev="JNOZZI" date="2006-05-16" area="REPORTS PP"  request="15738"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA5.00">Make Top Vendor Report Date Aware - Add Fields 10021 and
    //     10022</change>
    //   <change id="NA0005" dev="JNOZZI" date="2006-06-16" area="CHECKPRINT" feature="286"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA5.00">Add new &quot;Spanish&quot; option to Bank Communication
    //     field.</change>
    //   <change id="NA0006" dev="ELYNCH" date="2009-01-06" area="MX" feature="32033"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA6.00.01">Add new field for MX RFC/CURP identification.</change>
    // </changelog>
    // 
    // MER0001 TLE 12/09/13 Add "Legacy Vendor No."'s
    fields
    {
        modify("Pay-to Vendor No.")
        {
            Caption = 'Pay-to Vendor No.';
        }
        modify("Balance (LCY)")
        {
            Caption = 'Balance (LCY)';
        }
        modify("Net Change (LCY)")
        {
            Caption = 'Net Change (LCY)';
        }
        modify("Purchases (LCY)")
        {
            Caption = 'Purchases (LCY)';
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
        modify("Amt. Rcd. Not Invoiced (LCY)")
        {
            Caption = 'Amt. Rcd. Not Invoiced (LCY)';
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
        modify("Pay-to No. of Pstd. Return S.")
        {
            Caption = 'Pay-to No. of Pstd. Return S.';
        }
        modify("Pay-to No. of Pstd. Cr. Memos")
        {
            Caption = 'Pay-to No. of Pstd. Cr. Memos';
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
        field(50000; "Legacy Vendor No."; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Legacy Vendor No. 2"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Legacy Vendor No. 3"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Legacy Vendor No. 4"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "AssistEdit(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "ShowContact(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "SetInsertFromContact(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "CheckBlockedVendOnDocs(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "CheckBlockedVendOnJnls(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "CreateAndShowNewInvoice(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "CreateAndShowNewCreditMemo(PROCEDURE 22)".


    //Unsupported feature: Property Modification (Attributes) on "CreateAndShowNewPurchaseOrder(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "VendBlockedErrorMessage(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "VendPrivacyBlockedErrorMessage(PROCEDURE 62)".


    //Unsupported feature: Property Modification (Attributes) on "GetPrivacyBlockedGenericErrorText(PROCEDURE 73)".


    //Unsupported feature: Property Modification (Attributes) on "DisplayMap(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "CalcOverDueBalance(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateRFCNo(PROCEDURE 1020000)".


    //Unsupported feature: Property Modification (Attributes) on "GetInvoicedPrepmtAmountLCY(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "GetTotalAmountLCY(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "HasAddress(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "GetVendorNo(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "GetVendorNoOpenCard(PROCEDURE 56)".


    //Unsupported feature: Property Modification (Attributes) on "OpenVendorLedgerEntries(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "SetInsertFromTemplate(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "SetAddress(PROCEDURE 40)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateCurrencyId(PROCEDURE 55)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePaymentTermsId(PROCEDURE 57)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePaymentMethodId(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateReferencedIds(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "GetReferencedIds(PROCEDURE 46)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeIsContactUpdateNeeded(PROCEDURE 50)".

}

