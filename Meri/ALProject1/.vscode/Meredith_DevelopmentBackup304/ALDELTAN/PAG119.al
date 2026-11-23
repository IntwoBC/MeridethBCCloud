pageextension 50016 pageextension50016 extends "User Setup"
{
    // MER0001 TLE 01/29/14 Add "Salespers./Purch. Code"
    layout
    {
        addafter("Time Sheet Admin.")
        {
            field("E-Mail"; rec."E-Mail")
            {
                ApplicationArea = all;
            }
            // field("Cashier Number"; rec."Cashier Number")
            // {
            // }
        }
    }
}

