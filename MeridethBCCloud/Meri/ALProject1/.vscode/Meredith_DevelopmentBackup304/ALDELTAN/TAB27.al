tableextension 50006 tableextension70000247 extends Item
{
    // <changelog>
    //   <add id="NA0001" dev="JNOZZI" date="2006-03-01" area="REPORTS IC" feature="615"
    //     releaseversion="NAVNA4.00.01">Add Flowfields to be used in Inventory Reports, related to Manufacturing. Add
    //     Duty Class field.</add>
    // </changelog>
    // 
    // MER0001 TLE 12/06/13 Add "Marked Up Cost","Burden Rate"
    fields
    {
        modify(Inventory)
        {
            Caption = 'Inventory';
        }
        modify("Purchases (LCY)")
        {
            Caption = 'Purchases (LCY)';
        }
        modify("Sales (LCY)")
        {
            Caption = 'Sales (LCY)';
        }
        modify("Positive Adjmt. (LCY)")
        {
            Caption = 'Positive Adjmt. (LCY)';
        }
        modify("Negative Adjmt. (LCY)")
        {
            Caption = 'Negative Adjmt. (LCY)';
        }
        modify("COGS (LCY)")
        {
            Caption = 'COGS (LCY)';
        }
        modify("VAT Bus. Posting Gr. (Price)")
        {
            Caption = 'VAT Bus. Posting Gr. (Price)';
        }
        modify("Transferred (LCY)")
        {
            Caption = 'Transferred (LCY)';
        }
        modify("Automatic Ext. Texts")
        {
            Caption = 'Automatic Ext. Texts';
        }
        modify("VAT Prod. Posting Group")
        {
            Caption = 'VAT Prod. Posting Group';
        }
        field(50001; "Marked Up Cost"; Decimal)
        {
            Description = 'MER0001';
            DataClassification = ToBeClassified;
        }
        field(50002; "Burden Rate"; Decimal)
        {
            Description = 'MER0001';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                PurchPrice2: Record "Purchase Price";
            begin
                // MER0001 >>
                PurchPrice2.SetRange("Item No.", "No.");
                PurchPrice2.SetFilter("Ending Date", '=%1|>=%2', 0D, WorkDate);
                if PurchPrice2.FindSet then
                    repeat
                        PurchPrice2."Marked up Cost" := PurchPrice2."Direct Unit Cost" * "Burden Rate" * 0.01;
                        PurchPrice2.Modify;
                    until PurchPrice2.Next = 0;
                // MER0001 <<
            end;
        }
        field(50000; "MER Gift Card"; Option) // MER-BC29 2026-11-22: renamed - must match the BC25 transition field (data migration)
        {
            Caption = 'Gift Card';
            OptionCaption = ' ,Activate,Deactivate,Balance Increase';
            OptionMembers = " ",Activate,Deactivate,"Balance Increase";
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "MER Gift Card")
        {
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "AssistEdit(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "FindItemVend(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "TestNoEntriesExist(PROCEDURE 1006)".


    //Unsupported feature: Property Modification (Attributes) on "TestNoOpenEntriesExist(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "ItemSKUGet(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "IsMfgItem(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "IsAssemblyItem(PROCEDURE 24)".


    //Unsupported feature: Property Modification (Attributes) on "HasBOM(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "CheckSerialNoQty(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "CheckBlockedByApplWorksheet(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "ShowTimelineFromItem(PROCEDURE 20)".


    //Unsupported feature: Property Modification (Attributes) on "ShowTimelineFromSKU(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "CheckJournalsAndWorksheets(PROCEDURE 22)".


    //Unsupported feature: Property Modification (Attributes) on "CheckDocuments(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "PreventNegativeInventory(PROCEDURE 33)".


    //Unsupported feature: Property Modification (Attributes) on "CalcUnitPriceExclVAT(PROCEDURE 41)".


    //Unsupported feature: Property Modification (Attributes) on "GetItemNo(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "TryGetItemNo(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "TryGetItemNoOpenCard(PROCEDURE 43)".


    //Unsupported feature: Property Modification (Attributes) on "PickItem(PROCEDURE 51)".


    //Unsupported feature: Property Modification (Attributes) on "SetLastDateTimeFilter(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateReplenishmentSystem(PROCEDURE 54)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateUnitOfMeasureId(PROCEDURE 55)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateItemCategoryId(PROCEDURE 63)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateTaxGroupId(PROCEDURE 47)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateReferencedIds(PROCEDURE 61)".


    //Unsupported feature: Property Modification (Attributes) on "GetReferencedIds(PROCEDURE 49)".


    //Unsupported feature: Property Modification (Attributes) on "IsServiceType(PROCEDURE 53)".


    //Unsupported feature: Property Modification (Attributes) on "IsNonInventoriableType(PROCEDURE 50)".


    //Unsupported feature: Property Modification (Attributes) on "IsInventoriableType(PROCEDURE 52)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckDocuments(PROCEDURE 74)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterDeleteRelatedData(PROCEDURE 57)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeValidateStandardCost(PROCEDURE 56)".


    //Unsupported feature: Property Modification (Attributes) on "ExistsItemLedgerEntry(PROCEDURE 58)".



    //Unsupported feature: Property Modification (TextConstString) on "Text7381(Variable 1056)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text7381 : ENU=Canceled.;ESM=Cancelado.;FRC=Annulé.;ENC=Cancelled.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text7381 : ENU=Cancelled.;ESM=Cancelado.;FRC=Annulé.;ENC=Cancelled.;
    //Variable type has not been exported.
}

