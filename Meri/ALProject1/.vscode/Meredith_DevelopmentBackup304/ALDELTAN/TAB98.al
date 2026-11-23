tableextension 50015 tableextension70000795 extends "General Ledger Setup"
{
    // <changelog>
    //   <add id="NA0000" dev="ELYNCH" date="2006-01-23" area="BANK REC." feature="604"
    //     releaseversion="NAVUS3.60">Add local field for Bank Reconciliation 10002</add>
    //   <change id="NA0001" dev="ELYNCH" date="2006-01-23" area="NASALESTAX" feature="617"
    //     releaseversion="NAVUS3.60">local fields for US Sales Tax 10001</change>
    //   <change id="NA0002" dev="JNOZZI" date="2006-01-23" area="BANK DEP." feature="605"
    //     releaseversion="NAVUS3.60">Add local field for Bank Deposits 10003</change>
    //   <change id="NA0003" dev="ELYNCH" date="2006-04-10" area="NA ADDRESS" feature="2116"
    //     baseversion="NAVUS3.60" releaseversion="NAVNA5.00">Address format for MX added to F57: Post Code + City +
    //     County</change>
    // </changelog>
    // 
    // MER0001 TLE 03/05/14 Add new option to Local Address Format
    fields
    {
        modify("Pmt. Disc. Excl. VAT")
        {
            Caption = 'Pmt. Disc. Excl. VAT';
        }
        modify("Unrealized VAT")
        {
            Caption = 'Unrealized VAT';
        }
        modify("Inv. Rounding Precision (LCY)")
        {
            Caption = 'Inv. Rounding Precision (LCY)';
        }
        modify("Inv. Rounding Type (LCY)")
        {
            Caption = 'Inv. Rounding Type (LCY)';
        }
        modify("VAT Exchange Rate Adjustment")
        {
            Caption = 'VAT Exchange Rate Adjustment';
        }
        modify("Max. VAT Difference Allowed")
        {
            Caption = 'Max. VAT Difference Allowed';
        }
        modify("Print VAT specification in LCY")
        {
            Caption = 'Print VAT specification in LCY';
        }
        modify("Prepayment Unrealized VAT")
        {
            Caption = 'Prepayment Unrealized VAT';
        }
        // field(37028300; "LCY ISO Code"; Code[3])
        // {
        //     DataClassification = ToBeClassified;
        //     Caption = '$ ISO Code';

        // }
        // field(37028302; "Local ISO Code"; Code[3])
        // {
        //     DataClassification = ToBeClassified;
        //     Caption = 'Local ISO Code';
        // }
        // field(37028304; "LCY Symbol"; Code[5])
        // {
        //     DataClassification = ToBeClassified;
        //     Caption = 'LCY Symbol';
        // }
    }

    //Unsupported feature: Property Modification (Attributes) on "CheckDecimalPlacesFormat(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "GetCurrencyCode(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "GetCurrencySymbol(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "GetRecordOnce(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "IsPostingAllowed(PROCEDURE 22)".


    //Unsupported feature: Property Modification (Attributes) on "OptimGLEntLockForMultiuserEnv(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "FirstAllowedPostingDate(PROCEDURE 78)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateDimValueGlobalDimNo(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "UseVat(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "CheckAllowedPostingDates(PROCEDURE 10)".

}

