tableextension 50027 tableextension70000262 extends "Payment Method"
{
    fields
    {

        //Unsupported feature: Code Modification on ""Bal. Account No."(Field 4).OnValidate".

        //trigger  Account No()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Bal. Account No." <> '' then
          TestField("Direct Debit",false);
        if "Bal. Account Type" = "Bal. Account Type"::"G/L Account" then
          CheckGLAcc("Bal. Account No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4

        //EFT3.00.13 -
        if "Bal. Account No." <> '' then
          TestField("EFT Tender Type", 0);
        //EFT3.00.13 +
        */
        // //end;
        // field(37028300;"EFT Tender Type";Option)
        // {
        //     Caption = 'EFT Tender Type';
        //     OptionCaption = ' ,,Check,Credit Card,,,Gift Card';
        //     OptionMembers = " ",,Check,"Credit Card",,,"Gift Card";

        //     trigger OnValidate()
        //     begin
        //         if "EFT Tender Type" <> "EFT Tender Type"::" " then
        //           TestField("Bal. Account No.", '');
        //     end;
        // }
    }

    //Unsupported feature: Property Modification (Attributes) on "TranslateDescription(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "GetDescriptionInCurrentLanguage(PROCEDURE 1)".

}

