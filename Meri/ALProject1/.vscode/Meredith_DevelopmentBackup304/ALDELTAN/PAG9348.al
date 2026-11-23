pageextension 50037 "MER Sales Quote Archives" extends "Sales Quote Archives"
{
    // MER0001 TLE 03/27/14 Restrict Sales People Access (BC14 Page 9348 OnOpenPage)
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
        Salesperson: Record "Salesperson/Purchaser";
    begin
        if UserSetup.Get(UserId) and Salesperson.Get(UserSetup."Salespers./Purch. Code") and Salesperson."Restrict view to self" then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Salesperson Code", UserSetup."Salespers./Purch. Code");
            Rec.FilterGroup(0);
        end;
    end;
}
