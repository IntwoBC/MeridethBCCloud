page 50015 "CRM Ship-To Staging Card"
{
    PageType = Card;
    SourceTable = "CRM Ship-To Staging";
    Caption = 'CRM Ship-To Staging Card';
    ApplicationArea = All;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }

                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }

                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                }

                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }

                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }

                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                }
            }

            group(Contacts)
            {
                Caption = 'Contact';

                field(Contact; Rec.Contact)
                {
                    ApplicationArea = All;
                }

                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }

                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
            }

            group(Financial)
            {
                Caption = 'Financial';

                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }

                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }

                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ApplicationArea = All;
                }

                field("Tax Liable"; Rec."Tax Liable")
                {
                    ApplicationArea = All;
                }
            }

            group(Integration)
            {
                Caption = 'Integration';

                field("Integration Status"; Rec."Integration Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Error Message"; Rec."Error Message")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    Editable = false;
                }

                field("Retry Count"; Rec."Retry Count")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Created DateTime"; Rec."Created DateTime")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Processed DateTime"; Rec."Processed DateTime")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Retry)
            {
                Caption = 'Retry';
                Image = Refresh;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ShipToMgt: Codeunit "CRM Ship-To Int. Mgt.";
                begin
                    Rec."Integration Status" := Rec."Integration Status"::Open;
                    Rec."Error Message" := '';
                    Rec.Modify(true);

                    Commit();

                    ShipToMgt.ProcessStagingRecord(Rec);

                    CurrPage.Update(false);

                    Message('Ship-To record processed.');
                end;
            }

            action(ProcessAllOpen)
            {
                Caption = 'Process All Open';
                Image = Start;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ShipToMgt: Codeunit "CRM Ship-To Int. Mgt.";
                begin
                    ShipToMgt.ProcessAllOpen();
                    CurrPage.Update(false);
                end;
            }
        }

        area(Navigation)
        {
            action(OpenDashboard)
            {
                Caption = 'Ship-To Dashboard';
                ApplicationArea = All;
                Image = ShipAddress;
                RunObject = Page "CRM Ship-To Dashboard";
            }
        }
    }
}