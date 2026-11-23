tableextension 50025 tableextension70000222 extends "Ship-to Address"
{
    // <changelog>
    //   <add id="NA0000" dev="JNOZZI" date="2006-02-21" area="REPORTS SR" feature="622"
    //     releaseversion="NAVNA4.00.01">Add UPS Zone field.</add>
    //   <change id="NA0001" dev="ELYNCH" date="2006-04-11" area="NA ADDRESS" feature="293"
    //     baseversion="NAVNA4.00.01" releaseversion="NAVNA5.00">Populate State field (County) from ZIP code table
    //     </change>
    // </changelog>
    // 
    // MER0001 TLE 01/05/14 Add "Salesperson Code"
    // MER0002 CH  04/14/14 Add "School District" and "New Account"
    // MER0003 CH  04/28/14 Add "Salesperson Filter" and modified calculation for "New Account"
    // MER0004 TLE 05/11/14 Assign Name to Cust."CRM Customer Name"
    fields
    {
        modify("Post Code")
        {
            Caption = 'Post Code';
        }
        modify(County)
        {
            Caption = 'County';
        }


        //Unsupported feature: Code Modification on ""Country/Region Code"(Field 35).OnValidate".

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
        field(50000; "SalespersonCode"; Code[10])
        {
            Caption = 'Salesperson Code';
            Description = 'MER0001';
            TableRelation = "Salesperson/Purchaser";
            DataClassification = ToBeClassified;
        }
        field(50001; "School District"; Boolean)
        {
            Caption = 'School District';
            DataClassification = ToBeClassified;
            Description = 'MER0002';

        }
        field(50002; "New Account"; Boolean)
        {
            CalcFormula = - Exist("Cust. Ledger Entry" WHERE("Customer No." = FIELD("Customer No."),
                                                             "Ship-to Code" = FIELD(Code),
                                                             "Document Type" = FILTER(Invoice | "Credit Memo"),
                                                             "Posting Date" = FIELD("Date Filter"),
                                                             "Salesperson Code" = FIELD("Salesperson Filter")));
            Caption = 'New Account';
            Description = 'MER0003';
            FieldClass = FlowField;
        }
        field(50003; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            Description = 'MER0002';
            FieldClass = FlowFilter;
        }
        field(50004; "Salesperson Filter"; Code[10])
        {
            Description = 'MER0003';
            FieldClass = FlowFilter;
        }
    }


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Cust.Get("Customer No.");
    Name := Cust.Name;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    Cust.Get("Customer No.");
    // MER0004 >>
    //Name := Cust.Name;
    Name := Cust."CRM Customer Name";
    // MER0004 <<
    // MER0002 >> - TLE
    "School District" := Cust."School District";
    // MER0002 << - TLE
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "Caption(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "DisplayMap(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "GetFilterCustNo(PROCEDURE 2)".

}

