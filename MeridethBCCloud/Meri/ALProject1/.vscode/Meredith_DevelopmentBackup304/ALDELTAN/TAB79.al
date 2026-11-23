tableextension 50011 tableextension70000703 extends "Company Information"
{
    // <changelog>
    //   <add id="NA0000" dev="ELYNCH" date="2006-01-23" area="NASALESTAX" feature="617"
    //     releaseversion="NAVNA4.00">Added new fields</add>
    //   <change id="NA0001" dev="ELYNCH" date="2006-04-11" area="NA ADDRESS" feature="293"
    //     baseversion="NAVNA4.00" releaseversion="NAVNA5.00">Populate State field (County) from ZIP code table</change>
    //   <change id="NA0002" dev="JNOZZI" date="2006-06-16" area="CHECKPRINT" feature="286"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA5.00">Add new fields to define which Country Code indicates which
    //     NA Country.</change>
    //   <change id="NA0003" dev="JNOZZI" date="2007-09-04" area="NASALESTAX"  request="24744"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA5.00.00.01">Canadian Sales Tax changes - Added field 10021.
    //     </change>
    //   <add id="NA0004" dev="all-e" date="20010-05-19" area="GST" feature="VSTF173006"
    //     releaseversion="NAVNA7.00">
    //     Electronic GST HST Filing for Canada  Phase II Electronic Filing for NAV 2009 SP1</add>
    // </changelog>
    // 
    // MER0001 TLE 03/04/14 Add field 50000..50007
    // MDI0002 TLE 07/09/14 Add "GSA Account No."
    fields
    {
        modify("VAT Registration No.")
        {
            Caption = 'VAT Registration No.';
        }
        modify("Post Code")
        {
            Caption = 'Post Code';
        }
        modify(County)
        {
            Caption = 'County';
        }
        modify("Ship-to Post Code")
        {
            Caption = 'Ship-to Post Code';
        }
        modify("Ship-to County")
        {
            Caption = 'Ship-to County';
        }


        //Unsupported feature: Code Modification on ""Country/Region Code"(Field 36).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.CheckClearPostCodeCityCounty(City,"Post Code",County,"Country/Region Code",xRec."Country/Region Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*

        PostCode.CheckClearPostCodeCityCounty(City,"Post Code",County,"Country/Region Code",xRec."Country/Region Code");
        */
        //end;


        //Unsupported feature: Code Insertion on ""Ship-to Country/Region Code"(Field 37)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        if ("Ship-to Country/Region Code" <> xRec."Ship-to Country/Region Code") and (xRec."Ship-to Country/Region Code" <> '') then
         // PostCode.ClearFields("Ship-to City","Ship-to Post Code","Ship-to County");
          begin
        "Ship-to City":='';
            "Ship-to Post Code":='';
            "Ship-to County":='';
            end;
        */
        //end;
        // field(10018; "US Country/Region Code"; Code[10])
        // {
        //     TableRelation = "Country/Region";
        // }
        // field(10019; "Canada Country/Region Code"; Code[10])
        // {
        //     TableRelation = "Country/Region";
        // }
        // field(10020; "Mexico Country/Region Code"; Code[10])
        // {
        //     TableRelation = "Country/Region";
        // }
        field(50000; "Remit to Name"; Text[50])
        {
            Description = 'MER0001';
            DataClassification = ToBeClassified;
        }
        field(50001; "Remit to Name 2"; Text[50])
        {
            Description = 'MER0001';
            DataClassification = ToBeClassified;
        }
        field(50002; "Remit to Address"; Text[50])
        {
            Description = 'MER0001';
            DataClassification = ToBeClassified;
        }
        field(50003; "Remit to Address 2"; Text[50])
        {
            Description = 'MER0001';
            DataClassification = ToBeClassified;
        }
        field(50004; "Remit to City"; Text[30])
        {
            Description = 'MER0001';
            TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code".City
            ELSE IF ("Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = ToBeClassified;
        }
        field(50005; "Remit to County"; Text[30])
        {
            Description = 'MER0001';
            DataClassification = ToBeClassified;
        }
        field(50006; "Remit to Post Code"; Code[20])
        {
            Description = 'MER0001';
            TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code".Code
            ELSE IF ("Country/Region Code" = FILTER(<> '')) "Post Code".Code WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = ToBeClassified;
        }
        field(50007; "Remit to Country/Region Code"; Code[10])
        {
            Description = 'MER0001';
            TableRelation = "Country/Region";
            DataClassification = ToBeClassified;
        }
        field(50008; "GSA Account No."; Code[20])
        {
            Description = 'MDI0002';
            DataClassification = ToBeClassified;
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "CheckIBAN(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "DisplayMap(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "GetRegistrationNumber(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "GetRegistrationNumberLbl(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "GetVATRegistrationNumber(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "GetVATRegistrationNumberLbl(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "GetLegalOffice(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "GetLegalOfficeLbl(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "GetCustomGiro(PROCEDURE 20)".


    //Unsupported feature: Property Modification (Attributes) on "GetCustomGiroLbl(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "VerifyAndSetPaymentInfo(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "GetSystemIndicator(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "GetCountryRegionCode(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "GetCompanyCountryRegionCode(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "GetDevBetaModeTxt(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "GetContactUsText(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "IsSyncEnabledForOtherCompany(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetSystemIndicator(PROCEDURE 24)".

}

