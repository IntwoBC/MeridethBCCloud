pageextension 50024 pageextension70000288 extends "Ship-to Address List"
{
    // MER0001 TLE 01/29/14 Restrict SAles People Access
    // MER0001 TLE 01/30/14 Add "Salesperson Code"
    layout
    {
        addafter("Location Code")

        {
            // BC14 field 50000 "Salesperson Code" = BC25 extension field "SalespersonCode" (BC25 has its own standard "Salesperson Code")
            field(SalespersonCode; Rec.SalespersonCode)
            {
                ApplicationArea = All;
                Caption = 'MER Salesperson Code';
                ToolTip = 'Salesperson from BC14 (field 50000). Used to restrict salespeople to their own ship-to addresses.';
            }
            field("School District"; rec."School District")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("New Account"; rec."New Account")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
        Salesperson: Record "Salesperson/Purchaser";
    begin
        // MER0001 >> BC14 Page 301 OnOpenPage - Restrict Sales People Access
        if UserSetup.Get(UserId) and Salesperson.Get(UserSetup."Salespers./Purch. Code") and Salesperson."Restrict view to self" then begin
            Rec.FilterGroup(2);
            Rec.SetRange(SalespersonCode, UserSetup."Salespers./Purch. Code");
            Rec.FilterGroup(0);
        end;
        // MER0001 <<
    end;
}
