tableextension 50020 tableextension70000046 extends "Sales Cr.Memo Header"
{
    // <changelog>
    //   <add id="NA0000" dev="ELYNCH" date="2006-02-01" area="NASALESTAX" feature="617"
    //     releaseversion="NAVUS3.70.00.27">Added fields for NA Sales Tax</add>
    //   <change id="NA0001" dev="ELYNCH" date="2006-04-11" area="NA ADDRESS" feature="293"
    //     baseversion="NAVUS3.70.00.27" releaseversion="NAVNA5.00">Populate State field (County) from ZIP code table
    //     </change>
    //   <change id="NA0002" dev="JNOZZI" date="2007-12-19" area="NASALESTAX" feature="31197"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA5.00.01">Add &quot;STE Transaction ID&quot; for Sales Tax Engine.
    //     </change>
    // </changelog>
    // 
    // MER0001 CH (TLE) 04/08/14 Add "Total Line Amount" & "Total Line Cost"
    // MER0002 TLE 04/09/14 Add "Salesperson Commission Amount","Salesperson Order Fee","Salesperson Misc. Charge","Total Burden Amount"
    //   "Salesperson Commission Rate","Credit Card Charges", CalculateCommissions
    // MER0003 TLE 04/18/14 Adjustments to GrossProfit
    // MER0004 TLE 04/29/14 Adjustments to GrossProfit
    // MER0005 TLE 04/30/14 Adjustments to GrossProfit
    fields
    {
        modify("Bill-to Name")
        {
            Caption = 'Bill-to Name';
        }
        modify("Bill-to Name 2")
        {
            Caption = 'Bill-to Name 2';
        }
        modify("Bill-to Address")
        {
            Caption = 'Bill-to Address';
        }
        modify("Bill-to Address 2")
        {
            Caption = 'Bill-to Address 2';
        }
        modify("Bill-to City")
        {
            Caption = 'Bill-to City';
        }
        modify("Bill-to Contact")
        {
            Caption = 'Bill-to Contact';
        }
        modify("Your Reference")
        {
            Caption = 'Your Reference';
        }
        modify("Amount Including VAT")
        {
            Caption = 'Amount Including VAT';
        }
        modify("VAT Registration No.")
        {
            Caption = 'VAT Registration No.';
        }
        modify("Bill-to Post Code")
        {
            Caption = 'Bill-to Post Code';
        }
        modify("Bill-to County")
        {
            Caption = 'Bill-to County';
        }
        modify("Bill-to Country/Region Code")
        {
            Caption = 'Bill-to Country/Region Code';
        }
        modify("Sell-to Post Code")
        {
            Caption = 'Sell-to Post Code';
        }
        modify("Sell-to County")
        {
            Caption = 'Sell-to County';
        }
        modify("Ship-to Post Code")
        {
            Caption = 'Ship-to Post Code';
        }
        modify("Ship-to County")
        {
            Caption = 'Ship-to County';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'VAT Bus. Posting Group';
        }
        field(50001; "Total Burden Amount"; Decimal)
        {
            CalcFormula = Sum("Sales Cr.Memo Line"."Burden Amount" WHERE("Document No." = FIELD("No.")));
            Description = 'MER0002';
            FieldClass = FlowField;
        }
        field(50004; "Salesperson Commission Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'MER0002';
        }
        field(50006; "Salesperson Order Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'MER0002';
        }
        field(50007; "Salesperson Misc. Charge"; Decimal)
        {
            Description = 'MER0002';
        }
        field(50008; "Salesperson Commission Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'MER0002';
        }
        field(50010; "Credit Card Charges"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'MER0002';
        }
        field(50011; "Total Line Amount"; Decimal)
        {

            CalcFormula = Sum("Sales Cr.Memo Line"."Line Amount Price" WHERE("Document No." = FIELD("No.")));
            Description = 'MER0001';
            FieldClass = FlowField;
        }
        field(50012; "Total Line Cost"; Decimal)
        {
            CalcFormula = Sum("Sales Cr.Memo Line"."Line Amount Cost" WHERE("Document No." = FIELD("No.")));
            Description = 'MER0001';
            FieldClass = FlowField;
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "SendRecords(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "SendProfile(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "PrintRecords(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "EmailRecords(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "Navigate(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "LookupAdjmtValueEntries(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "GetCustomerVATRegistrationNumber(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "GetCustomerVATRegistrationNumberLbl(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "GetCustomerGlobalLocationNumber(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "GetCustomerGlobalLocationNumberLbl(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "GetLegalStatement(PROCEDURE 60)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "SetSecurityFilterOnRespCenter(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "ExportEDocument(PROCEDURE 1020000)".


    //Unsupported feature: Property Modification (Attributes) on "RequestStampEDocument(PROCEDURE 1020001)".


    //Unsupported feature: Property Modification (Attributes) on "CancelEDocument(PROCEDURE 1020002)".


    //Unsupported feature: Property Modification (Attributes) on "GetDocExchStatusStyle(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "ShowActivityLog(PROCEDURE 116)".


    //Unsupported feature: Property Modification (Attributes) on "DocExchangeStatusIsSent(PROCEDURE 112)".


    //Unsupported feature: Property Modification (Attributes) on "ShowCanceledOrCorrInvoice(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "ShowCorrectiveInvoice(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "ShowCancelledInvoice(PROCEDURE 37)".


    //Unsupported feature: Property Modification (Attributes) on "GetWorkDescription(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeEmailRecords(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforePrintRecords(PROCEDURE 24)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeSendProfile(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeSendRecords(PROCEDURE 7)".


    procedure GetAccountNumber() AccountNumber: Code[19]
    begin
        //EFT4.00.02 -EFTSetup.GET;
        /**IF ("Account Number Protection Type" = "Account Number Protection Type"::Encryption) OR
           (NOT ("EFT Tender Type" IN ["EFT Tender Type"::"Credit Card", "EFT Tender Type"::Check])) THEN
          AccountNumber := CryptoMgt.Decrypt("Protected Account Number", EFTSetup.GetEncryptionKey, "Encryption Salt")
        ELSE IF ("Account Number Protection Type" = "Account Number Protection Type"::"Remote Storage") AND
                ("EFT Tender Type" = "EFT Tender Type"::"Credit Card") THEN
          AccountNumber := RemoteStorageMgt.GetCreditCardAccountNumber("Protected Account Number")
        ELSE IF ("Account Number Protection Type" = "Account Number Protection Type"::"Remote Storage") AND
                ("EFT Tender Type" = "EFT Tender Type"::Check) THEN
          AccountNumber := RemoteStorageMgt.GetDemandDepositAccountNumber("Protected Account Number");**/
        //EFT4.00.02 +

    end;

    procedure CalculateCommissions(var LineAmountPrice: Decimal; var LineAmountCost: Decimal; var GrossProfit: Decimal; var NetProfit: Decimal; var TaxAmt: Decimal; var TotalBurdenAmount: Decimal)
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        Salesperson: Record "Salesperson/Purchaser";
    begin
        // MER0002 >>
        SalesCrMemoLine.SetRange("Document No.", "No.");
        if SalesCrMemoLine.FindSet then
            repeat
                LineAmountPrice += SalesCrMemoLine."Line Amount";
                LineAmountCost += SalesCrMemoLine.Quantity * SalesCrMemoLine."Unit Cost";
                TotalBurdenAmount += SalesCrMemoLine."Burden Amount";
                TaxAmt += SalesCrMemoLine."Amount Including VAT" - SalesCrMemoLine.Amount;
            until SalesCrMemoLine.Next = 0;

        // MER0003 >>
        //GrossProfit := LineAmountPrice - LineAmountCost - TotalBurdenAmount - "Credit Card Charges"- "Salesperson Order Fee";
        //
        //NetProfit := GrossProfit - "Salesperson Commission Amount" + TotalBurdenAmount + "Salesperson Order Fee";
        // MER0004 >>
        //GrossProfit := LineAmountPrice - LineAmountCost - TotalBurdenAmount;
        // MER0005 >>
        //GrossProfit := LineAmountPrice - LineAmountCost - TotalBurdenAmount - "Salesperson Order Fee";
        GrossProfit := LineAmountPrice - LineAmountCost - TotalBurdenAmount;
        // MER0005 <<
        // MER0004 <<

        NetProfit := GrossProfit - "Salesperson Commission Amount" + TotalBurdenAmount;
        // MER0003 <<
        // MER0002 <<
    end;
}

