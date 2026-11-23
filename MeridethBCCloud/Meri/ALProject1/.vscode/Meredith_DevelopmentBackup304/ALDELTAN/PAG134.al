pageextension 50019 pageextension70000121 extends "Posted Sales Credit Memo"
{
    // <changelog>
    //   <add id="NA0001" dev="ELYNCH" date="2006-02-03" area="NASALESTAX" feature="617"
    //     releaseversion="NAVNA4.00">Added NA Sales Tax fields and code</add>
    //   <change id="NA0002" dev="ELYNCH" date="2006-02-03" area="NA ADDRESS" feature="2116"
    //     releaseversion="NAVNA4.00">Formatted address with State / ZIP Code</change>
    // </changelog>
    // 
    // MER0001 TLE 04/10/14 Add Commissions fast tab & Commissions Factbox
    layout
    {
        addafter("Electronic Invoice")
        {
            group(EFT)
            {
                Caption = 'EFT';
            }
            group(Commissions)
            {
                Caption = 'Commissions';
                field("Credit Card Charges"; rec."Credit Card Charges")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Salesperson Misc. Charge"; rec."Salesperson Misc. Charge")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Salesperson Order Fee"; rec."Salesperson Order Fee")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
            }
        }
        addfirst(FactBoxes)
        {
            // {
            //     part(Control1905906707)
            //     {
            //         SubPageLink = Field3=FIELD("No.");
            //         Visible = true;
            //     }
            part(Control1240060000; "Posted CrMemo Comm. Factbox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
            }
        }
    }
    actions
    {


        //Unsupported feature: Code Modification on "SendCustom(Action 8).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SalesCrMemoHeader := Rec;
        CurrPage.SetSelectionFilter(SalesCrMemoHeader);
        SalesCrMemoHeader.SendRecords;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*

        // {=======} MODIFIED
        // NA0001.begin
        //  IF "Tax Area Code" = '' THEN
        //  PAGE.RUNMODAL(PAGE::"Sales Credit Memo Statistics",Rec,"No.")
        //  ELSE
         // PAGE.RUNMODAL(PAGE::"Sales Credit Memo Stats.",Rec,"No.");
        // NA0001.end

        #1..3
        */
        //end;
    }


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetSecurityFilterOnRespCenter;
    IsOfficeAddin := OfficeMgt.IsAvailable;
    IsFoundationEnabled := ApplicationAreaMgmtFacade.IsFoundationEnabled;

    ActivateFields;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //EFT3.00 -
    //SETFILTER("Expiration Filter", '>%1', TODAY);
    //EFT3.00 +
    #1..5
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCalculateSalesTaxStatistics(PROCEDURE 1020000)".

}

