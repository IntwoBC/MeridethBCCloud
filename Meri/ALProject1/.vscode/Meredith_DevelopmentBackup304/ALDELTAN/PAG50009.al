page 50009 "MER Purchase Price List"
{
    // = BC14 Page 50009 (SourceTable 7012 "Purchase Price").
    // BC25: the converted page pointed to "Price List Line" and showed "Price List Code" as Vendor No.,
    //       while the Sales Line lookup, Item "Burden Rate" and the BC14 data all use "Purchase Price".
    DeleteAllowed = false;
    Editable = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Purchase Price";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Vendor No."; Rec."Vendor No.")
                {
                    Caption = 'Vendor No.';
                    ApplicationArea = All;
                }
                field(VendorName; VendorName)
                {
                    Caption = 'Vendor Name';
                    ApplicationArea = All;
                }
                field(VendorCrossRefNo; VendorCrossRefNo)
                {
                    Caption = 'Vendor Cross Ref. No.';
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    Caption = 'Direct Unit Cost';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        Vendor: Record Vendor;
        ItemCrossReference: Record "Item Reference";
    begin
        Clear(VendorName);
        if Vendor.Get(Rec."Vendor No.") then
            VendorName := Vendor.Name;

        Clear(VendorCrossRefNo);
        ItemCrossReference.SetRange("Item No.", Rec."Item No.");
        ItemCrossReference.SetRange("Reference Type", ItemCrossReference."Reference Type"::Vendor);
        ItemCrossReference.SetRange("Reference Type No.", Rec."Vendor No.");
        ItemCrossReference.SetRange("Variant Code", Rec."Variant Code");
        if ItemCrossReference.FindFirst() then
            VendorCrossRefNo := CopyStr(ItemCrossReference."Reference No.", 1, MaxStrLen(VendorCrossRefNo));
    end;

    var
        VendorCrossRefNo: Code[20];
        VendorName: Text[100];
}
