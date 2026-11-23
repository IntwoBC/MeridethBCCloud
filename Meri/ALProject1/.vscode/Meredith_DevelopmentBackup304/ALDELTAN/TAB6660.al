tableextension 50038 tableextension70000618 extends "Return Receipt Header"
{
    // MER0001 TLE 05/08/14 Add CalculateCommissions,"Total Burden Amount","Salesperson Commission Amount","Salesperson Order Fee"
    //   "Salesperson Misc. Charge","Salesperson Commission Rate","Credit Card Charges","Total Line Amount","Total Line Cost"
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


        //Unsupported feature: Code Insertion on ""Bill-to Country/Region Code"(Field 87)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        if ("Bill-to Country/Region Code" <> xRec."Bill-to Country/Region Code") and (xRec."Bill-to Country/Region Code" <> '') then
        //  PostCode.ClearFields("Bill-to City","Bill-to Post Code","Bill-to County");
          begin
            "Bill-to City":='';
            "Bill-to Post Code":='';
            "Bill-to County":='';
            end;
        */
        //end;


        //Unsupported feature: Code Insertion on ""Sell-to Country/Region Code"(Field 90)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        if ("Sell-to Country/Region Code" <> xRec."Sell-to Country/Region Code") and (xRec."Sell-to Country/Region Code" <> '') then
         // PostCode.ClearFields("Sell-to City","Sell-to Post Code","Sell-to County");
          begin
             "Sell-to City":='';
            "Sell-to Post Code":='';
            "Sell-to County":='';
            end;
        */
        //end;


        //Unsupported feature: Code Insertion on ""Ship-to Country/Region Code"(Field 93)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        if ("Ship-to Country/Region Code" <> xRec."Ship-to Country/Region Code") and (xRec."Ship-to Country/Region Code" <> '') then
          //PostCode.ClearFields("Ship-to City","Ship-to Post Code","Ship-to County");
          begin
            "Ship-to City":='';
            "Ship-to Post Code":='';
            "Ship-to County":='';
            end;
        */
        //end;
        field(50001; "Total Burden Amount"; Decimal)
        {
            CalcFormula = Sum("Return Receipt Line"."Burden Amount" WHERE("Document No." = FIELD("No.")));
            Description = 'MER0001';
            FieldClass = FlowField;
        }
        field(50004; "Salesperson Commission Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'MER0001';
        }
        field(50006; "Salesperson Order Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'MER0001';
        }
        field(50007; "Salesperson Misc. Charge"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'MER0001';
        }
        field(50008; "Salesperson Commission Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'MER0001';
        }
        field(50010; "Credit Card Charges"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'MER0001';
        }
        field(50011; "Total Line Amount"; Decimal)
        {
            CalcFormula = Sum("Return Receipt Line"."Line Amount Price" WHERE("Document No." = FIELD("No.")));
            Description = 'MER0001';
            FieldClass = FlowField;
        }
        field(50012; "Total Line Cost"; Decimal)
        {
            CalcFormula = Sum("Return Receipt Line"."Line Amount Cost" WHERE("Document No." = FIELD("No.")));
            Description = 'MER0001';
            FieldClass = FlowField;
        }
        /* field(37028320; "Sell-to Phone No."; Text[30])
         {
             DataClassification = ToBeClassified;
         }
         field(37028321; "Bill-to Phone No."; Text[30])
         {
             DataClassification = ToBeClassified;
         }
         /*field(37028322; "Ship-to Phone No."; Text[30])
         {
             DataClassification = ToBeClassified;
         }*/
        /*field(37028323; "Bill-to Federal ID No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(37028324; "Bill-to Identification No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(37028325; "Bill-to Identification County"; Code[2])
        {
            DataClassification = ToBeClassified;
        }*/
    }

    //Unsupported feature: Property Modification (Attributes) on "PrintRecords(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "EmailRecords(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "Navigate(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "SetSecurityFilterOnRespCenter(PROCEDURE 4)".


    procedure CalculateCommissions(var LineAmountPrice: Decimal; var LineAmountCost: Decimal; var GrossProfit: Decimal; var NetProfit: Decimal; var TaxAmt: Decimal; var TotalBurdenAmount: Decimal)
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        Salesperson: Record "Salesperson/Purchaser";
    begin
        // MER0001 >>
        SalesCrMemoLine.SetRange("Document No.", "No.");
        if SalesCrMemoLine.FindSet then
            repeat
                LineAmountPrice += SalesCrMemoLine."Line Amount";
                LineAmountCost += SalesCrMemoLine.Quantity * SalesCrMemoLine."Unit Cost";
                TotalBurdenAmount += SalesCrMemoLine."Burden Amount";
                TaxAmt += SalesCrMemoLine."Amount Including VAT" - SalesCrMemoLine.Amount;
            until SalesCrMemoLine.Next = 0;

        GrossProfit := LineAmountPrice - LineAmountCost - TotalBurdenAmount;

        NetProfit := GrossProfit - "Salesperson Commission Amount" + TotalBurdenAmount;
        // MER0001 <<
    end;
}

