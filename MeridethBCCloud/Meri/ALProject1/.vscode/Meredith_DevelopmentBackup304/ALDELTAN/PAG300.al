pageextension 50023 pageextension70000287 extends "Ship-to Address"
{
    // <changelog>
    //   <add id="NA0001" dev="ELYNCH" date="2004-05-13" area="NA ADDRESS" feature="2116"
    //     releaseversion="NAVUS3.70">Formatted address with State / ZIP Code</add>
    //   <change id="NA0002" dev="ELYNCH" date="2006-06-13" area="NASALESTAX" feature="617"
    //     baseversion="NAVUS3.70" releaseversion="NAVNA4.00">Added NA Sales Tax fields</change>
    // </changelog>
    // 
    // MER0001 TLE 01/05/14 Add "Salesperson Code"
    layout
    {
        addafter("Tax Area Code")
        {

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
}

