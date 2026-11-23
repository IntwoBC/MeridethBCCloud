tableextension 50035 tableextension70000537 extends "Shipping Agent Services"
{
    fields
    {
        /* field(37028300; "Sales Line Type"; Option)
         {
             DataClassification = ToBeClassified;
             Caption = 'Sales Line Type';
             OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
             OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";

             trigger OnValidate()
             begin
                 "Sales Line No." := '';
             end;
         }
         field(37028301; "Sales Line No."; Code[20])
         {
             DataClassification = ToBeClassified;
             Caption = 'Sales Line No.';
             TableRelation = IF ("Sales Line Type" = CONST(" ")) "Standard Text"
             ELSE IF ("Sales Line Type" = CONST("G/L Account")) "G/L Account"
             ELSE IF ("Sales Line Type" = CONST(Item)) Item
             ELSE IF ("Sales Line Type" = CONST(Resource)) Resource
             ELSE IF ("Sales Line Type" = CONST("Fixed Asset")) "Fixed Asset"
             ELSE IF ("Sales Line Type" = CONST("Charge (Item)")) "Item Charge";
         }*/
    }
}

