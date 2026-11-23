tableextension 50016 tableextension70000035 extends "Sales Shipment Header"
{
    // <changelog>
    //   <add id="NA0001" dev="ELYNCH" date="2006-02-09" area="ORDERENTRY" feature="607"
    //     releaseversion="NAVUS3.70.00.27">Added field and code for Package Tracking</add>
    //   <change id="NA0002" dev="ELYNCH" date="2006-04-11" area="NA ADDRESS" feature="293"
    //     baseversion="NAVUS3.70.00.27" releaseversion="NAVNA5.00">Populate State field (County) from ZIP code table
    //     </change>
    // </changelog>
    // 
    // MER0001 CH (TLE) 04/08/14 Add "Total Line Amount" & "Total Line Cost"
    fields
    {
        modify("Bill-to Name")
        {
            Caption = 'Bill-to Name';
        }
        modify("Bill-to Name 2")
        {
            Caption = 'Bill-to Name 2';
        }
        modify("Bill-to Address")
        {
            Caption = 'Bill-to Address';
        }
        modify("Bill-to Address 2")
        {
            Caption = 'Bill-to Address 2';
        }
        modify("Bill-to City")
        {
            Caption = 'Bill-to City';
        }
        modify("Bill-to Contact")
        {
            Caption = 'Bill-to Contact';
        }
        modify("Your Reference")
        {
            Caption = 'Your Reference';
        }
        modify("VAT Registration No.")
        {
            Caption = 'VAT Registration No.';
        }
        modify("Bill-to Post Code")
        {
            Caption = 'Bill-to Post Code';
        }
        modify("Bill-to County")
        {
            Caption = 'Bill-to County';
        }
        modify("Bill-to Country/Region Code")
        {
            Caption = 'Bill-to Country/Region Code';
        }
        modify("Sell-to Post Code")
        {
            Caption = 'Sell-to Post Code';
        }
        modify("Sell-to County")
        {
            Caption = 'Sell-to County';
        }
        modify("Ship-to Post Code")
        {
            Caption = 'Ship-to Post Code';
        }
        modify("Ship-to County")
        {
            Caption = 'Ship-to County';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'VAT Bus. Posting Group';
        }
        field(50011; "Total Line Amount"; Decimal)
        {
            CalcFormula = Sum("Sales Shipment Line"."Line Amount Price" WHERE("Document No." = FIELD("No.")));
            Description = 'MER0001';
            FieldClass = FlowField;
        }
        field(50012; "Total Line Cost"; Decimal)
        {
            CalcFormula = Sum("Sales Shipment Line"."Line Amount Cost" WHERE("Document No." = FIELD("No.")));
            Description = 'MER0001';
            FieldClass = FlowField;
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "SendProfile(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "PrintRecords(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "EmailRecords(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "Navigate(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "StartTrackingSite(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "StartTrackingSite(PROCEDURE 1)".

    //procedure StartTrackingSite();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if PackageTrackingNo = '' then
      PackageTrackingNo := "Package Tracking No.";

    HyperLink(GetTrackingInternetAddr);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //NA0001.begin
    if PackageTrackingNo = '' then
      PackageTrackingNo := "Package Tracking No.";
    //NA0001.end

    HyperLink(GetTrackingInternetAddr);
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "IsCompletlyInvoiced(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "SetSecurityFilterOnRespCenter(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "GetTrackingInternetAddr(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "GetWorkDescription(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeEmailRecords(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforePrintRecords(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeSendProfile(PROCEDURE 11)".

}

