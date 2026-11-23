pageextension 50034 pageextension70000861 extends "Sales Order List"
{
    // <changelog>
    //   <add id="NA0001" dev="ALL-E" date="2010-08-27" area="NASALESTAX" feature="VSTF202579"
    //     releaseversion="NA7.00">Page Form 160 Sales Statistics is opened from the Sales Invoice or
    //     Credit Memo Lists instead of Page Form 10038 in North America</add>
    // </changelog>
    // 
    // MER0001 TLE 01/29/14 Restrict Sales People Access
    layout
    {
        addafter("Job Queue Status")
        {
            field("VARStreet Order No."; rec."VARStreet Order No.")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {


        //Unsupported feature: Code Modification on "Statistics(Action 1102601006).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        OnBeforeCalculateSalesTaxStatistics(Rec,true);
        OpenSalesOrderStatistics;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*

        OnBeforeCalculateSalesTaxStatistics(Rec,true);
        OpenSalesOrderStatistics;
        */
        //end;
    }

    var
        UserSetup: Record "User Setup";
        Salesperson: Record "Salesperson/Purchaser";


    //Unsupported feature: Code Insertion (VariableCollection) on "OnOpenPage".

    //trigger (Variable: UserSetup)()
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if UserMgt.GetSalesFilter <> '' then begin
      FilterGroup(2);
      SetRange("Responsibility Center",UserMgt.GetSalesFilter);
    #4..6
    SetRange("Date Filter",0D,WorkDate - 1);

    JobQueueActive := SalesSetup.JobQueueActive;
    CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
    IsOfficeAddin := OfficeMgt.IsAvailable;

    CopySellToCustomerFilter;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..9

    #10..13
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "ShowPreview(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "SkipShowingLinesWithoutVAT(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCalculateSalesTaxStatistics(PROCEDURE 1020000)".

}

