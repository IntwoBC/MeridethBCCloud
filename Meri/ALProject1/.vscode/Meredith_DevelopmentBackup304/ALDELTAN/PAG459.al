pageextension 50025 pageextension70000371 extends "Sales & Receivables Setup"
{
    // <changelog>
    //   <add id="NA0001" dev="ELYNCH" date="2006-02-21" area="ORDERENTRY" feature="607"
    //     releaseversion="NAVNA4.00">Added G/L Freight field</add>
    //   <change id="NA0002" dev="ELYNCH" date="2008-07-02" area="BUG FIX" feature="26254"
    //     baseversion="KITNA6.00" releaseversion="KITNA6.00">Adjust heights and textbox/label locations due to W1/NA
    //     overlapping fields.</change>
    // </changelog>
    // 
    // MER0001 TLE 01/15/14 Add "Salesperson Order Fee Base","Slsperson Order Fee Additional","Credit Card Charges Rate","Def. Comm. Gen. Jnl. Btch Name",
    //   "G/L Freight Expense Account","G/L Freight Revenue Account"
    // 
    // MER0002 TLE 02/04/14 Add "Comm. Cred. Card Backcharges"
    layout
    {
        addafter("Background Posting")
        {
            group(Commissions)
            {
                Caption = 'Commissions';
                field("Salesperson Order Fee Base"; rec."Salesperson Order Fee Base")
                {
                    ApplicationArea = all;
                }
                field("Slsperson Order Fee Additional"; rec."Slsperson Order Fee Additional")
                {
                    ApplicationArea = all;
                }
                field("Credit Card Charges Rate"; rec."Credit Card Charges Rate")
                {
                    ApplicationArea = all;
                }
                field("Def. Comm. Gen. Jnl. Btch Name"; Rec."Def. Comm. Gen. Jnl. Btch Name")
                {
                    ApplicationArea = all;
                }
                field("G/L Freight Expense Account"; rec."G/L Freight Expense Account")
                {
                    ApplicationArea = all;
                }
                field("G/L Freight Revenue Account"; rec."G/L Freight Revenue Account")
                {
                    ApplicationArea = all;
                }
                field("Comm. Cred. Card Backcharges"; rec."Comm. Cred. Card Backcharges")
                {
                    ApplicationArea = all;
                }
                field("New Accounts (Time Period)"; rec."New Accounts (Time Period)")
                {
                    ApplicationArea = all;
                }
            }
            group(VARStreet)
            {
                Caption = 'VARStreet';
                field("VARStreet Permission Set"; rec."VARStreet Permission Set")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}

