tableextension 50028 tableextension70000279 extends "Sales & Receivables Setup"
{
    // <changelog>
    //   <add id="NA0001" dev="ELYNCH" date="2006-02-09" area="ORDERENTRY" feature="607"
    //     releaseversion="NAVUS3.01">Added field</add>
    // </changelog>
    // 
    // MER0001 TLE 01/15/14 Add "Salesperson Order Fee Base","Slsperson Order Fee Additional","Credit Card Charges Rate",
    //   "Def. Comm. Gen. Jnl. Btch Name","G/L Freight Expense Account","G/L Freight Revenue Account"
    // 
    // MER0002 TLE 02/04/14 Add "Comm. Cred. Card Backcharges"
    // MER0003 CH  04/01/14 Add "New Accounts (Time Period)"
    fields
    {
        modify("Allow VAT Difference")
        {
            Caption = 'Allow VAT Difference';
        }
        // MER-BC29 2026-11-22: PTE0002 - field 10000 "G/L Freight Account No." removed (ID not allowed online); its data is in the field below with the same caption (BC25 1.0.0.12 copies it).
        field(50009; "MER G/L Freight Account No."; Code[20])
        {
            Caption = 'G/L Freight Account No.';
            DataClassification = ToBeClassified;
        }
        field(50000; "Salesperson Order Fee Base"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'MER0001';
        }
        field(50001; "Slsperson Order Fee Additional"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'MER0001';
        }
        field(50002; "Credit Card Charges Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'MER0001';
        }
        field(50003; "Def. Comm. Gen. Jnl. Btch Name"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'MER0001';
        }
        field(50004; "G/L Freight Expense Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'MER0001';
            TableRelation = "G/L Account"."No.";
        }
        field(50005; "G/L Freight Revenue Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'MER0001';
            TableRelation = "G/L Account"."No.";
        }
        field(50006; "Comm. Cred. Card Backcharges"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'MER0002';
            TableRelation = "No. Series".Code;
        }
        field(50007; "New Accounts (Time Period)"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'New Accounts (Time Period)';
            Description = 'MER0003';
        }
        field(50008; "VARStreet Permission Set"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Permission Set";
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "GetRecordOnce(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "GetLegalStatement(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "JobQueueActive(PROCEDURE 1)".

}

