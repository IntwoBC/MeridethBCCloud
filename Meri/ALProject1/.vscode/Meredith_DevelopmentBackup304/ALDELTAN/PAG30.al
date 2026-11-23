pageextension 50006 pageextension50006 extends "Item Card"
{
    // <changelog>
    //   <add id="NA0001" dev="ELYNCH" date="2006-02-03" area="NASALESTAX" feature="617"
    //     releaseversion="NAVNA4.00">Added Tax Group Code field</add>
    // </changelog>
    // 
    // MER0001 TLE 12/06/13 Add Commissions fast tab, "Burden Rate"
    layout
    {
        addafter("Service Item Group")
        {
            field("Manufacturer_Code"; rec."Manufacturer Code")
            {
                ApplicationArea = All;
            }
            field("Gift Card"; rec."Gift Card")
            {
                ApplicationArea = All;
            }
        }
        addafter(Control1900383207)
        {
            group(Commissions)
            {

                Caption = 'Commissions';
                field("Burden Rate"; rec."Burden Rate")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCreateItemFromTemplate(PROCEDURE 9)".

}

