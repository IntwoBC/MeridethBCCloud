pageextension 50018 pageextension50018 extends "Posted Sales Invoice Subform"
{
    // <changelog>
    //   <add id="NA0001" dev="ELYNCH" date="2006-02-03" area="NASALESTAX" feature="617"
    //     releaseversion="NAVNA4.00">Added fields for NA Sales Tax</add>
    //   <change id="NA0002" dev="ELYNCH" date="2006-02-21" area="ORDERENTRY" feature="607"
    //     releaseversion="NAVNA4.00">Added field for Package Tracking</change>
    // </changelog>
    // 
    // MER0001 TLE 01/21/14 Add "Vendor No.","Vendor Cross Reference No."
    // MER0002 TLE 05/12/14 Add "Purchase Order No." & "Purch. Order Line No."
    layout
    {
        addafter("Shortcut Dimension 2 Code")
        {
            field("Vendor No."; rec."Vendor No.")
            {
                ApplicationArea = all;
            }
            field("Vendor Cross Reference No."; rec."Vendor Cross Reference No.")
            {
                ApplicationArea = all;
            }
            field("Purchase Order No."; rec."Purchase Order No.")
            {
                ApplicationArea = all;
            }
            field("Purch. Order Line No."; rec."Purch. Order Line No.")
            {
                ApplicationArea = all;
            }
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "ShowDocumentLineTracking(PROCEDURE 14)".

}

