pageextension 50012 pageextension50012 extends "Purchase Quote"
{
    // <changelog>
    //   <add id="NA0001" dev="ELYNCH" date="2006-02-03" area="NA ADDRESS" feature="2116"
    //     releaseversion="NAVUS3.60.00.10">Formatted forms with State / ZIP Code</add>
    //   <change id="NA0002" dev="ELYNCH" date="2006-02-03" area="NASALESTAX" feature="617"
    //     baseversion="NAVUS3.60.00.10" releaseversion="NAVNA4.00">Added NA Sales Tax fields</change>
    // </changelog>
    actions
    {


        //Unsupported feature: Code Modification on "Statistics(Action 61).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CalcInvDiscForHeader;
        Commit;
        if "Tax Area Code" = '' then
          PAGE.RunModal(PAGE::"Purchase Statistics",Rec)
        else
          PAGE.RunModal(PAGE::"Purchase Stats.",Rec);
        PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CalcInvDiscForHeader;
        Commit;
        // NA0002.begin
        // PAGE.RUNMODAL(PAGE::"Purchase Statistics",Rec);
        #3..5

          PAGE.RunModal(PAGE::"Purchase Stats.",Rec);
        PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
        */
        //end;
    }


    //Unsupported feature: Code Modification on "ShortcutDimension1CodeOnAfterV(PROCEDURE 19029405)".

    //procedure ShortcutDimension1CodeOnAfterV();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.Update;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CurrPage.PurchLines.PAGE.UpdateForm(true);
    */
    //end;


    //Unsupported feature: Code Modification on "ShortcutDimension2CodeOnAfterV(PROCEDURE 19008725)".

    //procedure ShortcutDimension2CodeOnAfterV();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.Update;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CurrPage.PurchLines.PAGE.UpdateForm(true);
    */
    //end;
}

