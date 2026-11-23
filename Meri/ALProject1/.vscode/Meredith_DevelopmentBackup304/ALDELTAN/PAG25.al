pageextension 50004 pageextension25 extends "Customer Ledger Entries"
{
    // MER0001 TLE 12/06/13 Add "Commission Recorded",Commissionable,Commission
    // MER0002 TLE 01/29/14 Restrict Sales People Access
    layout
    {
        addafter("Entry No.")
        {
            field("Commission Recorded"; rec."Commission Recorded")
            {
                ApplicationArea = All;
            }
            field(Commissionable; rec.Commissionable)
            {
                ApplicationArea = All;
            }
            field("Salesperson Commission Amount"; rec."Salesperson Commission Amount")
            {
                ApplicationArea = All;
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
    SetControlVisibility;

    if GetFilters <> '' then
      if FindFirst then;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*

    SetControlVisibility;

    #2..4
    */
    //end;
}

