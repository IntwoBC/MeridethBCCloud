tableextension 50026 tableextension70000242 extends "VAT Statement Line"
{
    fields
    {
        modify(Type)
        {
            OptionCaption = 'Account Totaling,VAT Entry Totaling,Row Totaling,Description';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'VAT Bus. Posting Group';
        }
        modify("VAT Prod. Posting Group")
        {
            Caption = 'VAT Prod. Posting Group';
        }
    }
}

