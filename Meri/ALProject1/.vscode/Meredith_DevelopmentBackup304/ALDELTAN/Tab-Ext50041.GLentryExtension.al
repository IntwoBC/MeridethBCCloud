
tableextension 50041 tableextension50041 extends "G/L Entry"
{
    //     // <changelog>
    //     //   <add id="NA0001" dev="JNOZZI" date="2005-03-24" area="BANK DEP." feature="605"  request="2252"
    //     //     releaseversion="NAVNA4.00.01">Add new key (with KeyGroups=&quot;NavDep&quot;) for use when navigating on a
    //     //     Deposit document.</add>
    //     //   <change id="NA0002" dev="JNOZZI" date="2006-04-18" area="PAYROLL HR"
    //     //     baseversion="NAVNA4.00.01" releaseversion="NAVNA4.00.01">Added Employee option to Bal. Account Type and Source
    //     //     Type fields</change>
    //     //   <change id="NA0003" dev="JNOZZI" date="2007-12-19" area="NASALESTAX" feature="31197"
    //     //     baseversion="NAVNA4.00.01" releaseversion="NAVNA5.00.01">Add &quot;STE Transaction ID&quot; for Sales Tax
    //  //     Engine.</change>
    //     //   <add id="NA0004" dev="all-e" date="20010-05-19" area="GST" feature="VSTF173006"
    //     //     releaseversion="NAVNA7.00">
    //     //     Electronic GST HST Filing for Canada  Phase II Electronic Filing for NAV 2009 SP1</add>
    //     //   <change id="NA0005" dev="all-e" date="2010-09-29" area="GST" feature="VSTF231828"
    //     //     baseversion="NA7.00" releaseversion="NA7.00">
    //     //     British Columbias and Ontarios sales tax reform</change>
    //     //   <add id="NA0006" dev="all-e" date="2011-04-22" area="Elec. Pay" feature="VSTF257818"
    //     //      releaseversion="NA7.00">Canada 2011 Changes to GST HST Internet File Transfer
    //     //   </add>
    //     // </changelog>
    //     fields
    //     {
    //         modify("VAT Amount")
    //         {
    //             Caption = 'VAT Amount';
    //         }
    //         modify("VAT Bus. Posting Group")
    //         {
    //             Caption = 'VAT Bus. Posting Group';
    //         }
    //         modify("VAT Prod. Posting Group")
    //         {
    //             Caption = 'VAT Prod. Posting Group';
    //         }
    fields
    {
        field(50000; "EFT Store No."; Code[10])
        {
            Caption = 'EFT Store No.';
            // TableRelation = Table37028302;
        }
        field(50001; "EFT Terminal No."; Code[10])
        {
            Caption = 'EFT Terminal No.';
            // TableRelation = Table37028303.Field2 WHERE (Field1=FIELD("EFT Store No."));
        }
        field(50002; "EFT Transaction Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'EFT Transaction Entry No.';
            //TableRelation = IF ("EFT Transaction Archive Status"=CONST(" ")) Table37028310.Field3 WHERE (Field1=FIELD("EFT Store No."),
            //Field2=FIELD("EFT Terminal No."))
            // ELSE IF ("EFT Transaction Archive Status"=CONST(Archived)) Table37028357.Field3 WHERE (Field1=FIELD("EFT Store No."),
            // Field2=FIELD("EFT Terminal No."));
        }
        field(50003; "EFT Transaction Archive Status"; Option)
        {
            Caption = 'EFT Transaction Archive Status';
            Editable = false;
            OptionCaption = ' ,Archived,Purged';
            OptionMembers = " ",Archived,Purged;
        }
    }
    keys
    {
        key(Key1; "EFT Store No.", "EFT Terminal No.", "EFT Transaction Entry No.")
        {
        }
    }
}



