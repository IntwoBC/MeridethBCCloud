page 50008 "MER Vendor List"
{
    DeleteAllowed = false;
    Editable = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = Vendor;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(VendorCrossRefNo; VendorCrossRefNo)
                {
                    Caption = 'Vendor Cross Ref. No.';
                }
                field(DirectUnitCost; DirectUnitCost)
                {
                    Caption = 'Direct Unit Cost';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        //MSupdate
        PurchPrice: Record "Price List Line";
        ItemCrossReference: Record "Item Reference";
    begin
        Clear(DirectUnitCost);
        PurchPrice.Reset;
        //PurchPrice.SetRange("Item No.", ItemNo);
        PurchPrice.SetRange("Price List Code", rec."No.");
        PurchPrice.SetFilter("Ending Date", '%1|>=%2', 0D, WorkDate);
        PurchPrice.SetRange("Starting Date", 0D, WorkDate);
        if PurchPrice.Find('-') then
            DirectUnitCost := PurchPrice."Direct Unit Cost";

        Clear(VendorCrossRefNo);
        ItemCrossReference.SetRange("Item No.", ItemNo);
        ItemCrossReference.SetRange("Reference Type", ItemCrossReference."Reference Type"::Vendor);
        ItemCrossReference.SetRange("Reference Type No.", rec."No.");
        if ItemCrossReference.Find('-') then
            VendorCrossRefNo := ItemCrossReference."Reference No.";
    end;

    var
        DirectUnitCost: Decimal;
        ItemNo: Code[20];
        VendorCrossRefNo: Code[20];

    procedure SetItemNo(pItemNo: Code[20])
    begin
        ItemNo := pItemNo;
    end;
}

