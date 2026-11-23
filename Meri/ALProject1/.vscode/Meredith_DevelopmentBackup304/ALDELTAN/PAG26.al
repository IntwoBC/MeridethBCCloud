pageextension 50005 pageextension26 extends "Vendor Card"
{
    // <changelog>
    //   <add id="NA0000" dev="ELYNCH" date="2006-01-24" area="1099" feature="601"
    //     releaseversion="NAVUS3.10.01">Added 1099 Liable and Federal ID fields and menu option for 1099 Statistics Form
    //     </add>
    //   <change id="NA0003" dev="ELYNCH" date="2006-02-03" area="NA ADDRESS" feature="2116"
    //     baseversion="NAVUS3.10.01" releaseversion="NAVUS3.10.01">Formatted form with State / ZIP Code</change>
    //   <change id="NA0004" dev="ELYNCH" date="2006-04-12" area="CHECKPRINT"  request="10003"
    //     baseversion="NAVUS3.10.01" releaseversion="NAVNA5.00">Added fields on Foreign Trad tab for Canadian cheque
    //     printing, cdcr 10003</change>
    //   <change id="NA0005" dev="JNOZZI" date="2007-09-04" area="NASALESTAX"  request="24744"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA5.00.00.01">Canadian Sales Tax changes - Add MenuItem to call new
    //     Vendor Locations form. Also, add Tax Area Code back to the Invoicing Tab.</change>
    //   <change id="NA0006" dev="ELYNCH" date="2006-05-21" area="BUG FIX"  request="24458"
    //     baseversion="NAVNA5.00.00.01" releaseversion="NAVNA5.00.01">Changed horizontal location of command and menu
    //     buttons</change>
    //   <change id="NA0007" dev="ELYNCH" date="2009-01-06" area="MX" feature="32033"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA6.00.01">Add new field for MX RFC/CURP identification.</change>
    // </changelog>
    // 
    // MER0001 TLE 12/09/13 Add "Legacy Vendor No."'s.
    layout
    {

        //Unsupported feature: Property Modification (Level) on ""Home Page"(Control 86)".


        //Unsupported feature: Property Modification (Level) on ""Our Account No."(Control 50)".


        //Unsupported feature: Property Modification (Level) on ""Language Code"(Control 56)".

        addafter("Address & Contact")
        {
            group(Legacy)
            {
                Caption = 'Legacy';
                field("Legacy Vendor No."; rec."Legacy Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Legacy Vendor No. 2"; rec."Legacy Vendor No. 2")
                {
                    ApplicationArea = All;
                }
                field("Legacy Vendor No. 3"; rec."Legacy Vendor No. 3")
                {
                    ApplicationArea = All;
                }
                field("Legacy Vendor No. 4"; rec."Legacy Vendor No. 4")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCreateVendorFromTemplate(PROCEDURE 5)".

}

