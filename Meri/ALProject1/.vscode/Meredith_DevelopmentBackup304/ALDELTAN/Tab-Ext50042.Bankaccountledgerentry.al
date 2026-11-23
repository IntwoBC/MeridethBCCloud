tableextension 50042 tableextension70000250 extends "Bank Account Ledger Entry"
{
    // <changelog>
    //   <add id="NA0001" dev="ELYNCH" date="2006-02-21" area="BANK REC." feature="604"
    //     releaseversion="NAVNA4.00.01">Added key</add>
    //   <change id="NA0002" dev="JNOZZI" date="2005-03-24" area="BANK DEP." feature="605"  request="2252"
    //     baseversion="NAVNA4.00.01" releaseversion="NAVNA4.00.01">Add new key (with KeyGroups=&quot;NavDep&quot;) for
    //     use when navigating on a Deposit document.</change>
    //   <change id="NA0003" dev="VP" date="2004-04-12" area="PAYROLL HR"
    //     baseversion="NAVNA4.00.01" releaseversion="NAVNA4.00.01">Added Employee option to Bal. Account Type</change>
    //   <change id="NA0004" dev="JNOZZI" date="2006-06-05" area="BANK REC."  request="8690"
    //     baseversion="NAVNA4.00.01" releaseversion="NAVNA4.00.02">Fix table relations of Statement No. and Statement
    //     Line No. fields so that they point to NA objects.</change>
    // </changelog>
    fields
    {
        modify("Amount (LCY)")
        {
            Caption = 'Amount (LCY)';
        }
        modify("Debit Amount (LCY)")
        {
            Caption = 'Debit Amount (LCY)';
        }
        modify("Credit Amount (LCY)")
        {
            Caption = 'Credit Amount (LCY)';
        }
        // MER-BC29 2026-11-22: PTE0002 - field 37028300 "EFT Store No." removed (ID not allowed online); its data is in the field below with the same caption (BC25 1.0.0.12 copies it).
        field(50000; "MER EFT Store No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'EFT Store No.';
        }
        // MER-BC29 2026-11-22: PTE0002 - field 37028301 "EFT Terminal No." removed (ID not allowed online); its data is in the field below with the same caption (BC25 1.0.0.12 copies it).
        field(50001; "MER EFT Terminal No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'EFT Terminal No.';
        }
        // MER-BC29 2026-11-22: PTE0002 - field 37028302 "EFT Transaction Entry No." removed (ID not allowed online); its data is in the field below with the same caption (BC25 1.0.0.12 copies it).
        field(50002; "MER EFT Transaction Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'EFT Transaction Entry No.';
        }
        // MER-BC29 2026-11-22: PTE0002 - field 37028304 "EFT Transaction Archive Status" removed (ID not allowed online); its data is in the field below with the same caption (BC25 1.0.0.12 copies it).
        field(50003; "MER EFT Trans. Archive Status"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'EFT Transaction Archive Status';
            Editable = false;
            OptionCaption = ' ,Archived,Purged';
            OptionMembers = " ",Archived,Purged;
        }
    }
    keys
    {
        key(Key1; "MER EFT Store No.", "MER EFT Terminal No.", "MER EFT Transaction Entry No.")
        {
        }
    }
}