pageextension 50003 pageextension22 extends "Customer List"
{
    // MER0001 TLE 01/18/14 Add report Customer/Item Statistics
    // MER0002 TLE 01/29/14 Restrict Sales People Access
    // MER0003 TLE 02/26/14 New Account
    // MER0004 CH  04/14/14 School District
    // MER0005 TLE 05/16/14 Remove "Customer - Detail Trial Bal.","Customer - Trial Balance","Customer - Payment Receipt"
    layout
    {
        addafter("Base Calendar Code")
        {
            field("School District"; rec."School District")
            {
                ApplicationArea = All;
            }
            field("New Account"; rec."New Account")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Deletion (RunPageView) on ""Return Orders"(Action 70)".


        //Unsupported feature: Property Deletion (RunPageLink) on ""Return Orders"(Action 70)".

        addafter("Sales Statistics")
        {
            action("Report Customer/Item Statistic")
            {
                Caption = 'Customer/Item Statistics';
                ApplicationArea = All;
                Image = "Report";

                trigger OnAction()
                var
                    CustomerItemStats: Report "Customer/Item Statistics";
                    myCustomer: Record Customer;
                begin
                    // MER0001 >>
                    CurrPage.GetRecord(myCustomer);
                    myCustomer.SetRange("No.", myCustomer."No.");
                    CustomerItemStats.SetTableView(myCustomer);
                    CustomerItemStats.Run;
                    // MER0001 <<
                end;
            }
        }
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
    CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
    with SocialListeningSetup do
      SocialListeningSetupVisible := Get and "Show on Customers" and "Accept License Agreement" and ("Solution ID" <> '');
    SetWorkflowManagementEnabledState;
    SetFilter("Date Filter",'..%1',WorkDate);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*

    // IF UserSetup.GET(USERID) AND Salesperson.GET(UserSetup."Salespers./Purch. Code") AND Salesperson."Restrict view to self" THEN
    //  SETFILTER("Salesperson Code",'%1|%2','',UserSetup."Salespers./Purch. Code");

    #1..5
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "GetSelectionFilter(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "SetSelection(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "SetCaption(PROCEDURE 17)".

}

