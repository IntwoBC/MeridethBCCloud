pageextension 50007 pageextension50007 extends "Sales Quote"
{
    // <changelog>
    //   <add id="NA0001" dev="ELYNCH" date="2006-02-03" area="NASALESTAX" feature="617"
    //     releaseversion="NAVNA4.00">Added NA Sales Tax fields and code</add>
    //   <change id="NA0002" dev="ELYNCH" date="2006-02-03" area="NA ADDRESS" feature="2116"
    //     releaseversion="NAVNA4.00">Formatted form with State / ZIP Code</change>
    // </changelog>
    // 
    // MER0001 TLE 02/18/14 Add Commissions Factbox
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on ""Your Reference"(Control 98)".

        addafter(Control1905767507)
        {
            part(Control1240060001; "Commissions Factbox")
            {
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "No." = FIELD("No.");
                ApplicationArea = all;
            }
        }
    }
    actions
    {


        //Unsupported feature: Code Modification on "Statistics(Action 61).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        OnBeforeStatisticsAction(Rec,Handled);
        if not Handled then begin
          CalcInvDiscForHeader;
        #4..7
          else
            PAGE.RunModal(PAGE::"Sales Stats.",Rec);
        end
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*


        #1..10
        */
        //end;
    }

    //Unsupported feature: Property Modification (Attributes) on "OnBeforeStatisticsAction(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCalculateSalesTaxStatistics(PROCEDURE 1020000)".

}

