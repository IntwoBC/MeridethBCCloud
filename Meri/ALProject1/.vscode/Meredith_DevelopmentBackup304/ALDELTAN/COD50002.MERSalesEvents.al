// BC25 replacement for the Meredith (MER) code that BC14 had inside standard objects.
// An extension cannot change standard objects, so each part is an event subscriber here.
// All publishers and parameter names verified against Base Application 25.5.30849.31109.
//
//   BC14 object / tag                                   BC25 publisher
//   Table 37 UpdateAmounts MER0007 (Line Amount Price)  Table "Sales Line".OnAfterUpdateAmounts
//   Codeunit 414 Release Sales Document MER0001         Codeunit "Release Sales Document".OnAfterReleaseSalesDoc
//   Codeunit 6620 Copy Document Mgt. MER0002            Codeunit "Copy Document Mgt.".OnAfterCopySalesDocument
//   Codeunit 80 Sales-Post MER0004..MER0007 (headers)   Codeunit "Sales-Post".OnBeforeSalesInvHeaderInsert / OnBeforeSalesCrMemoHeaderInsert
//   Codeunit 80 Sales-Post MER0008 (PO on inv. line)    Codeunit "Sales-Post".OnBeforeSalesInvLineInsert
//   Codeunit 80 Sales-Post MER0002 (SIL SCrML Union)    Codeunit "Sales-Post".OnAfterSalesInvLineInsert / OnAfterSalesCrMemoLineInsert
//   Codeunit 80 Sales-Post MER0001/3/5/9 (Gen. Jnl.)    Codeunit "Sales Post Invoice Events".OnPostLedgerEntryOnBeforeGenJnlPostLine
//   Codeunit 12 Gen. Jnl.-Post Line MER0001/MER0002     Table "Cust. Ledger Entry".OnAfterCopyCustLedgerEntryFromGenJnlLine
//   Table 222 Ship-to Address OnInsert MER0002/MER0004  Table "Ship-to Address".OnAfterInsertEvent
codeunit 50002 "MER Sales Events"
{
    Permissions = tabledata "Document Commission Charges" = rimd,
                  tabledata "SIL SCrML Union" = rimd;

    // ---------------------------------------------------------------- open documents

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterUpdateAmounts', '', false, false)]
    local procedure SalesLineOnAfterUpdateAmounts(var SalesLine: Record "Sales Line")
    var
        SalesHeader: Record "Sales Header";
        Currency: Record Currency;
    begin
        // BC14 Table 37 UpdateAmounts MER0007
        if SalesLine.Type = SalesLine.Type::" " then
            exit;
        if SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.") then
            Currency.Initialize(SalesHeader."Currency Code")
        else
            Currency.InitRoundingPrecision();
        SalesLine."Line Amount Price" :=
          Round(SalesLine."Qty. to Invoice" * SalesLine."Unit Price", Currency."Amount Rounding Precision") - SalesLine."Line Discount Amount";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnAfterReleaseSalesDoc', '', false, false)]
    local procedure OnAfterReleaseSalesDoc(var SalesHeader: Record "Sales Header")
    begin
        RecalcCommissions(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopySalesDocument', '', false, false)]
    local procedure OnAfterCopySalesDocument(var ToSalesHeader: Record "Sales Header")
    begin
        RecalcCommissions(ToSalesHeader);
    end;

    local procedure RecalcCommissions(SalesHeader: Record "Sales Header")
    var
        TempSalesLine: Record "Sales Line" temporary;
    begin
        if SalesHeader.IsTemporary() or (SalesHeader."No." = '') then
            exit;
        SalesHeader.UpdateCommissions(TempSalesLine);
    end;

    // ---------------------------------------------------------------- posting: headers

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesInvHeaderInsert', '', false, false)]
    local procedure OnBeforeSalesInvHeaderInsert(var SalesInvHeader: Record "Sales Invoice Header"; var SalesHeader: Record "Sales Header")
    var
        SalesHeader2: Record "Sales Header";
    begin
        // BC14 Codeunit 80 MER0004
        SalesHeader2 := SalesHeader;
        SalesHeader2.CalcFields("Salesperson Commission Amount", "Salesperson Order Fee", "Salesperson Misc. Charge", "Credit Card Charges");
        SalesInvHeader."Salesperson Commission Amount" := SalesHeader2."Salesperson Commission Amount";
        SalesInvHeader."Salesperson Order Fee" := SalesHeader2."Salesperson Order Fee";
        SalesInvHeader."Salesperson Misc. Charge" := SalesHeader2."Salesperson Misc. Charge";
        SalesInvHeader."Credit Card Charges" := SalesHeader2."Credit Card Charges";
        SalesInvHeader."VARStreet Order No." := SalesHeader2."VARStreet Order No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesCrMemoHeaderInsert', '', false, false)]
    local procedure OnBeforeSalesCrMemoHeaderInsert(var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var SalesHeader: Record "Sales Header")
    var
        SalesHeader2: Record "Sales Header";
        Salesperson: Record "Salesperson/Purchaser";
        GrossProfit: Decimal;
    begin
        // BC14 Codeunit 80 MER0005/MER0006/MER0007
        SalesHeader2 := SalesHeader;
        if not Salesperson.Get(SalesHeader2."Salesperson Code") then
            Clear(Salesperson);

        SalesCrMemoHeader."Salesperson Order Fee" := 0;
        SalesHeader2.CalcFields("Salesperson Misc. Charge", "Total Outstanding Line Amount", "Total Outstanding Line Cost", "Total Burden Amount");
        SalesCrMemoHeader."Salesperson Misc. Charge" := SalesHeader2."Salesperson Misc. Charge";
        SalesCrMemoHeader."Credit Card Charges" := 0;

        GrossProfit := SalesHeader2."Total Outstanding Line Amount" - SalesHeader2."Total Outstanding Line Cost" - SalesHeader2."Total Burden Amount";
        SalesCrMemoHeader."Salesperson Commission Amount" :=
          GrossProfit * Salesperson."Commission %" * 0.01 - SalesCrMemoHeader."Salesperson Misc. Charge";
    end;

    // ---------------------------------------------------------------- posting: lines

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesInvLineInsert', '', false, false)]
    local procedure OnBeforeSalesInvLineInsert(var SalesInvLine: Record "Sales Invoice Line"; SalesLine: Record "Sales Line")
    begin
        // BC14 Codeunit 80 MER0008
        SalesInvLine."Purchase Order No." := SalesLine."Purchase Order No.";
        SalesInvLine."Purch. Order Line No." := SalesLine."Purch. Order Line No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesInvLineInsert', '', false, false)]
    local procedure OnAfterSalesInvLineInsert(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header")
    var
        SILSCrMLUnion: Record "SIL SCrML Union";
    begin
        // BC14 Codeunit 80 MER0002 - feeds the "Order History" page (50005)
        Clear(SILSCrMLUnion);
        SILSCrMLUnion."Document No." := SalesInvLine."Document No.";
        SILSCrMLUnion."Line No." := SalesInvLine."Line No.";
        if SalesInvLine.Type.AsInteger() <= 5 then // union table option: " ",G/L Account,Item,Resource,Fixed Asset,Charge (Item)
            SILSCrMLUnion.Type := SalesInvLine.Type.AsInteger();
        SILSCrMLUnion."No." := SalesInvLine."No.";
        SILSCrMLUnion."Shipment Date" := SalesInvLine."Shipment Date";
        SILSCrMLUnion.Description := CopyStr(SalesInvLine.Description, 1, MaxStrLen(SILSCrMLUnion.Description));
        SILSCrMLUnion.Quantity := SalesInvLine.Quantity;
        SILSCrMLUnion."Unit Price" := SalesInvLine."Unit Price";
        SILSCrMLUnion."Unit Cost (LCY)" := SalesInvLine."Unit Cost (LCY)";
        SILSCrMLUnion."Vendor No." := SalesInvLine."Vendor No.";
        SILSCrMLUnion."Sell-to Customer No." := SalesInvLine."Sell-to Customer No.";
        SILSCrMLUnion."Salesperson Code" := SalesInvHeader."Salesperson Code";
        SILSCrMLUnion."Vendor Cross Reference No." := SalesInvLine."Vendor Cross Reference No.";
        if not SILSCrMLUnion.Insert() then;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesCrMemoLineInsert', '', false, false)]
    local procedure OnAfterSalesCrMemoLineInsert(var SalesCrMemoLine: Record "Sales Cr.Memo Line"; SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    var
        SILSCrMLUnion: Record "SIL SCrML Union";
    begin
        // BC14 Codeunit 80 MER0002
        Clear(SILSCrMLUnion);
        SILSCrMLUnion."Document No." := SalesCrMemoLine."Document No.";
        SILSCrMLUnion."Line No." := SalesCrMemoLine."Line No.";
        if SalesCrMemoLine.Type.AsInteger() <= 5 then // union table option: " ",G/L Account,Item,Resource,Fixed Asset,Charge (Item)
            SILSCrMLUnion.Type := SalesCrMemoLine.Type.AsInteger();
        SILSCrMLUnion."No." := SalesCrMemoLine."No.";
        SILSCrMLUnion."Shipment Date" := SalesCrMemoLine."Shipment Date";
        SILSCrMLUnion.Description := CopyStr(SalesCrMemoLine.Description, 1, MaxStrLen(SILSCrMLUnion.Description));
        SILSCrMLUnion.Quantity := SalesCrMemoLine.Quantity;
        SILSCrMLUnion."Unit Price" := SalesCrMemoLine."Unit Price";
        SILSCrMLUnion."Unit Cost (LCY)" := SalesCrMemoLine."Unit Cost (LCY)";
        SILSCrMLUnion."Sell-to Customer No." := SalesCrMemoLine."Sell-to Customer No.";
        SILSCrMLUnion."Salesperson Code" := SalesCrMemoHeader."Salesperson Code";
        if not SILSCrMLUnion.Insert() then;
    end;

    // ---------------------------------------------------------------- posting: customer entry

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Post Invoice Events", 'OnPostLedgerEntryOnBeforeGenJnlPostLine', '', false, false)]
    local procedure OnPostLedgerEntryOnBeforeGenJnlPostLine(var GenJnlLine: Record "Gen. Journal Line"; var SalesHeader: Record "Sales Header"; PreviewMode: Boolean)
    var
        SalesInvHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
    begin
        // BC14 Codeunit 80 MER0001/MER0003/MER0005/MER0009 - value from the posted header (inserted before this point)
        GenJnlLine."Ship-to Code" := SalesHeader."Ship-to Code";
        if SalesHeader."Document Type" in [SalesHeader."Document Type"::"Credit Memo", SalesHeader."Document Type"::"Return Order"] then begin
            if SalesCrMemoHeader.Get(GenJnlLine."Document No.") then
                GenJnlLine."Salesperson Commission Amount" := -1 * SalesCrMemoHeader."Salesperson Commission Amount";
        end else
            if SalesInvHeader.Get(GenJnlLine."Document No.") then
                GenJnlLine."Salesperson Commission Amount" := SalesInvHeader."Salesperson Commission Amount";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', false, false)]
    local procedure CustLedgEntryOnAfterCopyFromGenJnlLine(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        // BC14 Codeunit 12 MER0001 (commission) / MER0002 (Ship-to Code) - also works for manual journals
        CustLedgerEntry."Salesperson Commission Amount" := GenJournalLine."Salesperson Commission Amount";
        CustLedgerEntry."Ship-to Code" := GenJournalLine."Ship-to Code";
    end;

    // ---------------------------------------------------------------- master data

    [EventSubscriber(ObjectType::Table, Database::"Ship-to Address", 'OnAfterInsertEvent', '', false, false)]
    local procedure ShipToAddressOnAfterInsert(var Rec: Record "Ship-to Address"; RunTrigger: Boolean)
    var
        Cust: Record Customer;
    begin
        // BC14 Table 222 OnInsert MER0004 (Name = CRM Customer Name) / MER0002 (School District)
        // Runs after the standard OnInsert, which sets Name := Customer.Name.
        if not RunTrigger or Rec.IsTemporary() then
            exit;
        if not Cust.Get(Rec."Customer No.") then
            exit;
        if Cust."CRM Customer Name" <> '' then
            Rec.Name := Cust."CRM Customer Name";
        Rec."School District" := Cust."School District";
        Rec.Modify();
    end;
}
