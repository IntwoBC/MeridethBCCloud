pageextension 50033 pageextension70000762 extends "Sales Manager Role Center"
{
    // <changelog>
    //   <add id="NA0000" dev="ELYNCH" date="2006-09-15" area="REPORTS SR" feature="622"
    //     releaseversion="NAVNA6.00">Add local reports to homepage</add>
    //   <change id="NA0001" dev="ALL-E" date="2011-03-03" area="REPORTS SR" feature="VSTF253725"
    //     baseversion="NA6.00" releaseversion="NA7.00">
    //     Caption of Customer Top 10 List Report is Translated To Top  Customer List in the NA Local Version</change>
    // </changelog>
    // 
    // MER0001 TLE 04/23/14 Add "MER Salesperson Commissions"
    layout
    {
        addafter("My User Tasks")
        {
            // part(Control1903810208)
            // {
            //     Visible = false;
            // }
        }
    }
    actions
    {
        addafter("Customer - &Top 10 List")
        {
            action("MER Salesperson Commissions")
            {
                ApplicationArea = All;
                Image = "Report";
                RunObject = Report "MER Salesperson Commissions";
            }
        }
    }
}

