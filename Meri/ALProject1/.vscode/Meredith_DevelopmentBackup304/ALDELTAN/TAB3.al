tableextension 50000 tableextension70000271 extends "Payment Terms"
{
    // MER0001 TLE 12/30/13 Add "Credit Card" - unused as of 01-08-14
    fields
    {
        field(50000; "Credit Card"; Boolean)
        {
            DataClassification = CustomerContent;
            ObsoleteState = Pending;
            Description = 'MER0001';

        }
        // field(37028300; "EFT Approval %-Post Invoice"; Decimal)
        // {
        //     Caption = 'EFT Approval %-Invoice';
        //     MaxValue = 100;
        //     MinValue = 0;
        //     DataClassification = CustomerContent;
        // }
        // field(37028301; "EFT Approval %-Post Shipment"; Decimal)
        // {
        //     Caption = 'EFT Approval %-Ship';
        //     MaxValue = 100;
        //     MinValue = 0;
        //     DataClassification = CustomerContent;
        // }
        // field(37028302; "EFT Approval %-Release Order"; Decimal)
        // {
        //     Caption = 'EFT Approval %-Release Order';
        //     MaxValue = 100;
        //     MinValue = 0;
        //     DataClassification = CustomerContent;
        // }
        // field(37028303; "EFT Approval %-Post Prepayment"; Boolean)
        // {
        //     Caption = 'EFT Approval %-Post Prepayment';
        //     DataClassification = CustomerContent;
        // }
        // field(37028304; "EFT Approval %-Release Credit"; Decimal)
        // {
        //     Caption = 'EFT Approval %-Release Credit';
        //     MaxValue = 100;
        //     MinValue = 0;
        //     DataClassification = CustomerContent;
        // }
        // field(37028305; "EFT Approval %-Post Credit"; Decimal)
        // {
        //     Caption = 'EFT Approval %-Post Credit';
        //     MaxValue = 100;
        //     MinValue = 0;
        //     DataClassification = CustomerContent;
        // }
        // field(37028306; "EFT Approval %-Post Receipt"; Decimal)
        // {
        //     Caption = 'EFT Approval %-Post Receipt';
        //     MaxValue = 100;
        //     MinValue = 0;
        //     DataClassification = CustomerContent;
        // }
    }
}

