pageextension 50000 pageextension21 extends "Customer Card"
{
    // <changelog>
    //   <add id="NA0000" dev="ELYNCH" date="2006-04-10" area="NA ADDRESS" feature="2116"
    //     releaseversion="NAVUS3.10.01">Formatted form with State / ZIP Code</add>
    //   <change id="NA0001" dev="ELYNCH" date="2006-04-12" area="NASALESTAX" feature="617"
    //     baseversion="NAVUS3.10.01" releaseversion="NAVUS3.10.01">Added Tax fields to Invoicing tab</change>
    //   <change id="NA0002" dev="ELYNCH" date="2006-04-12" area="CHECKPRINT"  request="10003"
    //     baseversion="NAVUS3.10.01" releaseversion="NAVNA5.00">Added fields on Foreign Trad tab for Canadian cheque
    //     printing, cdcr 10003</change>
    //   <change id="NA0003" dev="ELYNCH" date="2009-01-06" area="MX" feature="32033"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA6.00.01">Add new field for MX RFC/CURP identification.</change>
    // </changelog>
    // 
    // MER0001 TLE 01/18/14 Add report Customer/Item Statistics
    // MER0002 TLE 03/10/14 Replace "Customer Statement" report with "Statement" report.
    // MER0003 TLE 05/22/14 Add "Order & Product History"
    layout
    {
        addafter("State Inscription")
        {
            field(Control37028331; '')
            {
                ApplicationArea = All;
                ShowCaption = false;
            }
            field(Control37028333; '')
            {
                ApplicationArea = All;
                ShowCaption = false;
            }
            field(Control37028335; '')
            {
                ApplicationArea = All;
                ShowCaption = false;
            }
        }
        addafter("Prepayment %")
        {
            field(Control37028349; '')
            {
                ApplicationArea = All;
                ShowCaption = false;
            }
            field(Control37028357; '')
            {
                ApplicationArea = All;
                ShowCaption = false;
            }
            field("School District"; rec."School District")
            {
                ApplicationArea = All;
            }
        }
        addafter("Cash Flow Payment Terms Code")
        {
            field(Control37028351; '')
            {
                ApplicationArea = All;
                ShowCaption = false;
            }
            field(Control37028353; '')
            {
                ApplicationArea = All;
                ShowCaption = false;
            }
        }
    }
    actions
    {
        addafter(Service)
        {
            group("Order & Product History")
            {
                Caption = 'Order & Product History';
                action(Action1240060003)
                {
                    Caption = 'Order & Product History';
                    Image = History;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        OrderHistory: Page "Order History";
                        SILSCrMLUnion: Record "SIL SCrML Union";
                        UserSetup: Record "User Setup";
                        Salesperson: Record "Salesperson/Purchaser";
                    begin
                        // MER0003 >>
                        SILSCrMLUnion.SetRange("Sell-to Customer No.", rec."No.");
                        if UserSetup.Get(UserId) and Salesperson.Get(UserSetup."Salespers./Purch. Code") and Salesperson."Restrict view to self" then
                            SILSCrMLUnion.SetRange("Salesperson Code", UserSetup."Salespers./Purch. Code");

                        OrderHistory.SetTableView(SILSCrMLUnion);
                        OrderHistory.Run;
                        // MER0003 <<
                    end;
                }
            }
        }
        addafter("Customer Jobs (Price)")
        {
            action("Report Customer/Item Statistics")
            {
                Caption = 'Report Customer/Item Statistics';
                Image = "Report";
                ApplicationArea = All;

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

    //Unsupported feature: Property Modification (Attributes) on "RunReport(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "SetCaption(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCreateCustomerFromTemplate(PROCEDURE 4)".

}

