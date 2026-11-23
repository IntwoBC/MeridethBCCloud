tableextension 50040 tableextension70000630 extends "Purchase Price"
{
    // MER0001 TLE 02/04/14 Add "Marked up Cost"
    fields
    {
        field(50000; "Marked up Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'MER0001';
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "CopyPurchPriceToVendorsPurchPrice(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeNewPurchasePriceInsert(PROCEDURE 1)".

}

