tableextension 50001 tableextension70000325 extends Currency
{
    // <changelog>
    //   <add id="NA0001" dev="JNOZZI" date="2006-06-27" area="CHECKPRINT" feature="286"
    //     releaseversion="NAVNA5.00">Added field 10000, Symbol</add>
    // </changelog>
    fields
    {
        modify("Customer Balance (LCY)")
        {
            Caption = 'Customer Balance (LCY)';
        }
        modify("Vendor Balance (LCY)")
        {
            Caption = 'Vendor Balance (LCY)';
        }
        modify("Conv. LCY Rndg. Debit Acc.")
        {
            Caption = 'Conv. LCY Rndg. Debit Acc.';
        }
        modify("Conv. LCY Rndg. Credit Acc.")
        {
            Caption = 'Conv. LCY Rndg. Credit Acc.';
        }
        modify("Max. VAT Difference Allowed")
        {
            Caption = 'Max. VAT Difference Allowed';
        }

        //Unsupported feature: Deletion (FieldCollection) on "Symbol(Field 56)".

        field(50000; "MER Symbol"; Code[5]) // MER-BC29 2026-11-22: renamed - must match the BC25 transition field (data migration)
        {
            Caption = 'Symbol';
            DataClassification = ToBeClassified;
        }
        // field(37028300; "ISO Code old"; Code[3])
        // {
        //     DataClassification = ToBeClassified;
        // }

    }


    //Unsupported feature: Code Modification on "InitRoundingPrecision(PROCEDURE 2)".

    //procedure InitRoundingPrecision();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GLSetup.Get;
    if GLSetup."Amount Rounding Precision" <> 0 then
      "Amount Rounding Precision" := GLSetup."Amount Rounding Precision"
    #4..10
    "VAT Rounding Type" := GLSetup."VAT Rounding Type";
    "Invoice Rounding Precision" := GLSetup."Inv. Rounding Precision (LCY)";
    "Invoice Rounding Type" := GLSetup."Inv. Rounding Type (LCY)";
    Symbol := '$';
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..13
    Symbol := '$';  // NA0001
    */
    //end;
}

