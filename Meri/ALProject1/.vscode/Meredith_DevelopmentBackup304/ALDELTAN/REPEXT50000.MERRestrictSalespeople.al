// BC14 MER0002 "Restrict Sales People Access" on standard reports.
// BC14 set this filter in OnPreDataItem of the standard reports; BC25 cannot change standard reports,
// so a report extension sets the same filter after the standard OnPreDataItem.
// A salesperson with "Restrict view to self" only sees his own customers / entries.
//   BC14 Report 121   -> BC25 121   "Customer - Balance to Date"   (Customer)
//   BC14 Report 10042 -> BC25 10042 "Customer Account Detail"      (Customer)
//   BC14 Report 10046 -> BC25 10046 "Customer Register"            (Cust. Ledger Entry)
//   BC14 Report 10053 -> BC25 10053 "Open Customer Entries"        (Customer)
//   BC14 Report 116 "Statement" does not exist in BC25 -> same filter on 1316 "Standard Statement"
// (BC14 Report 10040 "Aged Accounts Receivable": the filter was commented out in BC14 - not added.)

reportextension 50000 "MER Cust. Balance to Date" extends "Customer - Balance to Date"
{
    dataset
    {
        modify(Customer)
        {
            trigger OnAfterPreDataItem()
            var
                SalespersonCode: Code[20];
            begin
                if MERRestrictedSalesperson(SalespersonCode) then
                    Customer.SetRange("Salesperson Code", SalespersonCode);
            end;
        }
    }

    local procedure MERRestrictedSalesperson(var SalespersonCode: Code[20]): Boolean
    var
        UserSetup: Record "User Setup";
        Salesperson: Record "Salesperson/Purchaser";
    begin
        if UserSetup.Get(UserId) and Salesperson.Get(UserSetup."Salespers./Purch. Code") and Salesperson."Restrict view to self" then begin
            SalespersonCode := UserSetup."Salespers./Purch. Code";
            exit(true);
        end;
        exit(false);
    end;
}

reportextension 50001 "MER Customer Account Detail" extends "Customer Account Detail"
{
    dataset
    {
        modify(Customer)
        {
            trigger OnAfterPreDataItem()
            var
                SalespersonCode: Code[20];
            begin
                if MERRestrictedSalesperson(SalespersonCode) then
                    Customer.SetRange("Salesperson Code", SalespersonCode);
            end;
        }
    }

    local procedure MERRestrictedSalesperson(var SalespersonCode: Code[20]): Boolean
    var
        UserSetup: Record "User Setup";
        Salesperson: Record "Salesperson/Purchaser";
    begin
        if UserSetup.Get(UserId) and Salesperson.Get(UserSetup."Salespers./Purch. Code") and Salesperson."Restrict view to self" then begin
            SalespersonCode := UserSetup."Salespers./Purch. Code";
            exit(true);
        end;
        exit(false);
    end;
}

reportextension 50002 "MER Customer Register" extends "Customer Register"
{
    dataset
    {
        modify("Cust. Ledger Entry")
        {
            trigger OnAfterPreDataItem()
            var
                SalespersonCode: Code[20];
            begin
                if MERRestrictedSalesperson(SalespersonCode) then
                    "Cust. Ledger Entry".SetRange("Salesperson Code", SalespersonCode);
            end;
        }
    }

    local procedure MERRestrictedSalesperson(var SalespersonCode: Code[20]): Boolean
    var
        UserSetup: Record "User Setup";
        Salesperson: Record "Salesperson/Purchaser";
    begin
        if UserSetup.Get(UserId) and Salesperson.Get(UserSetup."Salespers./Purch. Code") and Salesperson."Restrict view to self" then begin
            SalespersonCode := UserSetup."Salespers./Purch. Code";
            exit(true);
        end;
        exit(false);
    end;
}

reportextension 50003 "MER Open Customer Entries" extends "Open Customer Entries"
{
    dataset
    {
        modify(Customer)
        {
            trigger OnAfterPreDataItem()
            var
                SalespersonCode: Code[20];
            begin
                if MERRestrictedSalesperson(SalespersonCode) then
                    Customer.SetRange("Salesperson Code", SalespersonCode);
            end;
        }
    }

    local procedure MERRestrictedSalesperson(var SalespersonCode: Code[20]): Boolean
    var
        UserSetup: Record "User Setup";
        Salesperson: Record "Salesperson/Purchaser";
    begin
        if UserSetup.Get(UserId) and Salesperson.Get(UserSetup."Salespers./Purch. Code") and Salesperson."Restrict view to self" then begin
            SalespersonCode := UserSetup."Salespers./Purch. Code";
            exit(true);
        end;
        exit(false);
    end;
}

reportextension 50004 "MER Standard Statement" extends "Standard Statement"
{
    dataset
    {
        modify(Customer)
        {
            trigger OnAfterPreDataItem()
            var
                SalespersonCode: Code[20];
            begin
                if MERRestrictedSalesperson(SalespersonCode) then
                    Customer.SetRange("Salesperson Code", SalespersonCode);
            end;
        }
    }

    local procedure MERRestrictedSalesperson(var SalespersonCode: Code[20]): Boolean
    var
        UserSetup: Record "User Setup";
        Salesperson: Record "Salesperson/Purchaser";
    begin
        if UserSetup.Get(UserId) and Salesperson.Get(UserSetup."Salespers./Purch. Code") and Salesperson."Restrict view to self" then begin
            SalespersonCode := UserSetup."Salespers./Purch. Code";
            exit(true);
        end;
        exit(false);
    end;
}
