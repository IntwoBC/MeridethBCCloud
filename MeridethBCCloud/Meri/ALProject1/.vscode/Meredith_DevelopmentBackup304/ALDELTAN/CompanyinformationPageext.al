pageextension 50001 pageextension50001 extends "Company Information"
{
    // <changelog>
    //   <add id="NA0001" dev="ELYNCH" date="2006-04-17" area="NA ADDRESS" feature="2116"
    //     releaseversion="NAVUS3.60">Formatted forms with State / ZIP Code</add>
    //   <change id="NA0002" dev="ELYNCH" date="2006-04-17" area="NASALESTAX" feature="617"
    //     baseversion="NAVUS3.60" releaseversion="NAVUS3.60">Added Tax fields</change>
    //   <change id="NA0003" dev="JNOZZI" date="2006-06-16" area="CHECKPRINT" feature="286"
    //     baseversion="NAVUS3.60" releaseversion="NAVNA5.00">Add fields to define which Country Codes match which NA
    //     Country.</change>
    //   <change id="NA0004" dev="JNOZZI" date="2007-09-04" area="NASALESTAX"  request="24744"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA5.00.00.01">Canadian Sales Tax changes - Added field 10021.
    //     </change>
    //   <add id="NA0005" dev="all-e" date="20010-05-19" area="GST" feature="VSTF173006"
    //     releaseversion="NAVNA7.00">
    //     Electronic GST HST Filing for Canada  Phase II Electronic Filing for NAV 2009 SP1</add>
    // </changelog>
    // 
    // MER0001 TLE 03/04/14 Add Remit to fast tab
    // MDI0002 TLE 07/09/14 Add "GSA Account No."
    layout
    {
        addafter("Bank Account No.")
        {
            field("GSA Account No."; rec."GSA Account No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("System Indicator")
        {
            group("Remit to")
            {
                Caption = 'Remit to';
                field("Remit to Name"; rec."Remit to Name")
                {
                    ApplicationArea = All;
                }
                field("Remit to Name 2"; rec."Remit to Name 2")
                {
                    ApplicationArea = All;
                }
                field("Remit to Address"; rec."Remit to Address")
                {
                    ApplicationArea = All;
                }
                field("Remit to Address 2"; rec."Remit to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Remit to City"; rec."Remit to City")
                {
                    ApplicationArea = All;
                }
                field("Remit to County"; rec."Remit to County")
                {
                    ApplicationArea = All;
                    Caption = 'State / ZIP Code';
                }
                field("Remit to Post Code"; rec."Remit to Post Code")
                {
                    ApplicationArea = All;
                }
                field("Remit to Country/Region Code"; rec."Remit to Country/Region Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

