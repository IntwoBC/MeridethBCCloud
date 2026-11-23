# CRM <-> Business Central Integration — Full AL Extension
**Publisher:** Intwo | **Version:** 1.0.0.0 | **BC Runtime:** 12.0 | **ID Range:** 50100-50199

Covers all four integration flows from the field-mapping workbooks:

| # | Flow | Direction | BC Object | Status |
|---|------|-----------|-----------|--------|
| 1 | Customer Master | PULL (CRM -> BC) | Table 18 Customer | ✅ Built |
| 2 | Ship-To Address | PULL (CRM -> BC) | Table 222 Ship-to Address | ✅ Built |
| 3 | Item Master | PUSH (BC -> CRM) | Table 27 Item | ✅ Built |
| 4 | Sales Invoice (Header+Lines) | PUSH (BC -> CRM) | Tables 112/113 | ✅ Built |

---

## Project Structure

```
CRM_BC_Intwo/
├── app.json
├── .vscode/launch.json
└── src/
    ├── Enums/
    │   └── CRMIntegrationStatus.Enum.al        (50100)
    ├── Tables/
    │   ├── CRMCustomerStaging.Table.al          (50100) — Pull
    │   ├── CRMShipToStaging.Table.al             (50101) — Pull
    │   ├── CRMItemStaging.Table.al                (50102) — Push
    │   ├── CRMSalesInvHeaderStaging.Table.al      (50103) — Push
    │   └── CRMSalesInvLineStaging.Table.al        (50104) — Push
    ├── Codeunits/
    │   ├── CRMCustomerIntMgt.Codeunit.al          (50100) — Pull logic
    │   ├── CRMShipToIntMgt.Codeunit.al            (50101) — Pull logic
    │   ├── CRMItemIntMgt.Codeunit.al              (50102) — Push logic
    │   ├── CRMSalesInvIntMgt.Codeunit.al          (50103) — Push logic
    │   └── CRMInboundAPIHandler.Codeunit.al       (50104) — JSON parser
    └── Pages/
        ├── CRMCustomerIntegrationAPI.Page.al      (50100) — API endpoint
        ├── CRMShipToIntegrationAPI.Page.al        (50101) — API endpoint
        ├── CRMCustomerDashboard.Page.al            (50102) — Monitor UI
        ├── CRMShipToDashboard.Page.al               (50103) — Monitor UI
        ├── CRMItemDashboard.Page.al                  (50104) — Monitor UI
        ├── CRMShipToStagingFactbox.Page.al            (50105) — FactBox
        ├── CRMCustomerStagingCard.Page.al              (50106) — Drill-down
        ├── CRMSalesInvDashboard.Page.al                 (50107) — Monitor UI
        ├── CRMSalesInvLineFactbox.Page.al                (50108) — FactBox
        └── CRMIntegrationControlCenter.Page.al            (50110) — Landing page
```

---

## Field Mapping Reference (from your 4 Excel files)

### 1. Customer Master — PULL (18-CUSTOMER)

| CRM Field | Type/Len | BC Field | Mandatory | Default/Remark |
|---|---|---|---|---|
| — | — | No. | Code[20] | ✅ PK |
| — | — | Name | Text[100] | ✅ |
| — | — | Name 2 | Text[50] | |
| — | — | Credit Limit (LCY) | Decimal | |
| — | — | Address / Address 2 | Text[100]/[50] | |
| — | — | Country/Region Code | Code[10] | |
| — | — | City | Text[30] | |
| — | — | VAT Registration No. | Text[20] | |
| — | — | Tax Liable | Boolean | ✅ **Default = True** |
| — | — | Tax Area Code | Code[20] | ✅ |
| — | — | Tax Identification Type | Option | ✅ Legal Entity / Natural Person |
| — | — | Gen. Business Posting Group | Code[20] | ✅ **Hardcoded = GEN** |
| — | — | Customer Posting Group | Code[20] | ✅ **Hardcoded = TRADE** |
| — | — | Currency Code | Code[10] | ✅ |
| — | — | Payment Method Code | Code[10] | Sample: CREDITCARD |
| — | — | Integration Status | Boolean | ✅ Open/Success/Failed |

### 2. Ship-To Address — PULL (222-SHIP TO ADDRESS)

| Field | Type/Len | Mandatory | Remark |
|---|---|---|---|
| Customer No. | Code[20] | ✅ | FK to Customer |
| Code | Code[10] | ✅ | "To check with Liza on Formula" — auto-generated from Address if blank |
| Name | Text[100] | ✅ | |
| Tax Liable | Boolean | ✅ | Default = true |
| Tax Area Code | Code[20] | ✅ | |
| Location Code | Code[10] | | Sample: SAN PEDRO |

### 3. Item Master — PUSH (27-ITEM)

| BC Field | Type/Len |
|---|---|
| No. | Code[20] ✅ |
| Description | Text[100] |
| Item Category Code | Code[20] |
| Unit Cost | Decimal |
| Base Unit of Measure | Code[10] |
| Integration Status | Boolean ✅ |

### 4. Sales Invoice — PUSH (112-HEADER / 113-LINES)

**Header mandatory fields:** Sell-to Customer No., Posting Date, Tax Liable, Tax Area Code
**Line mandatory fields:** Document No. (Header link), Line No., Type, Location Code, Quantity, Unit of Measure Code, Unit Price Excl. Tax, Tax Area Code, Tax Group Code, Line Amount Excl. Tax, Amount Including VAT

---

## Setup in VS Code

1. **Install AL Language extension** (`ms-dynamics-smb.al`)
2. **Download Symbols**: `Ctrl+Shift+P` → `AL: Download Symbols`
3. **Edit `.vscode/launch.json`**: set your `environmentName`
4. **Publish**: Press `F5` — opens the Control Center page (50110)

---

## Pre-Publish Checklist (avoids runtime errors)

Before testing, create these reference records in BC — every one is referenced by the codeunits and **will cause a "does not exist" error if missing**:

| Setup Area | BC Page | Required Codes |
|---|---|---|
| Tax Areas | Tax Areas | `LA`, `OS` (from sample data) |
| Countries/Regions | Countries/Regions | `US` |
| Currencies | Currencies | `USD` |
| Payment Terms | Payment Terms | `N30` |
| Payment Methods | Payment Methods | `CREDITCARD` |
| Gen. Bus. Posting Groups | Gen. Business Posting Groups | `GEN` |
| Customer Posting Groups | Customer Posting Groups | `TRADE` |
| Locations | Locations | `SAN PEDRO` (if testing Ship-To with location) |

> If any of these codes don't exist in your sandbox, the codeunit raises a controlled `Error()` and the staging record is marked **Failed** with a clear message — it will **not** crash silently.

---

## Test Scenarios (run in this order)

### Scenario 1 — Customer Master (Pull) — Happy Path
1. Open **CRM Customer Integration API** (page 50100) or POST via Postman to `/api/intwo/crm/v1.0/customerIntegrations`
2. Payload:
   ```json
   {
     "no": "C05056",
     "name": "Arnold Mireles Elementary Academy",
     "creditLimit": 25000,
     "address": "9000 S EXCHANGE AVE",
     "city": "North Miami Bch",
     "countryRegionCode": "US",
     "taxAreaCode": "LA",
     "currencyCode": "USD",
     "paymentTermsCode": "N30"
   }
   ```
3. **Expected:** Customer Dashboard shows `C05056` with status **Success**; BC Customer card shows Gen. Bus. Posting Group = GEN, Customer Posting Group = TRADE, Tax Liable = true (all auto-applied).

### Scenario 2 — Customer Master — Missing Mandatory Field
1. Send the same payload without `"taxAreaCode"`.
2. **Expected:** Status = **Failed**, Error Message = "Tax Area Code is mandatory."

### Scenario 3 — Ship-To Address (Pull) — Happy Path
1. **Run Scenario 1 first** (Ship-To depends on the Customer existing).
2. POST to `/api/intwo/crm/v1.0/shipToIntegrations`:
   ```json
   {
     "customerNo": "C00003",
     "code": "16756 CWAR",
     "name": "California Institution For Women & Men",
     "address": "16756 Chino-Corona Road",
     "city": "North Miami Beach",
     "countryRegionCode": "US",
     "taxAreaCode": "OS",
     "locationCode": "SAN PEDRO"
   }
   ```
3. **Expected:** Ship-To Dashboard shows Success; visible as a FactBox on the Customer Dashboard when `C00003` is selected.

### Scenario 4 — Ship-To — Customer Doesn't Exist
1. POST a Ship-To payload with `"customerNo": "C99999"` (never created).
2. **Expected:** Status = Failed, Error = "Customer No. C99999 does not exist in BC. Process Customer staging first."

### Scenario 5 — Item Master (Push) — Happy Path
1. In BC, create/open any Item (e.g., `1000`).
2. Open **CRM Item Dashboard** (50104) → action **Stage All BC Items**.
3. **Expected:** Item appears in dashboard. Since the CRM endpoint URL is a placeholder (`your-crm-domain.example.com`), status will show **Failed** with a network error — **this is expected** until you wire in your real CRM URL (see "Connecting Your Real CRM" below). This confirms the staging/build logic works end-to-end.

### Scenario 6 — Sales Invoice (Push) — Happy Path
1. Post any Sales Invoice in BC sandbox (Sales → Invoices → New → Post).
2. Open **CRM Sales Invoice Push Dashboard** (50107) → action **Stage Posted Invoice by No.** → pick the invoice you just posted.
3. **Expected:** Header + all lines appear staged; FactBox shows line details; push attempt shows Failed (placeholder URL) — confirms mapping and JSON-building logic.

### Scenario 7 — Retry Flow
1. From any dashboard, select a **Failed** record → action **Retry Selected** (or **Retry All Failed**).
2. **Expected:** Status resets to Open, re-processes, error message clears (or updates) based on the new outcome.

---

## Connecting Your Real CRM (required before go-live)

Two codeunits contain a `TrySendToCrm` procedure with a placeholder URL:
- `CRMItemIntMgt.Codeunit.al` → `CRMEndpointUrl := 'https://your-crm-domain.example.com/api/v1/items'`
- `CRMSalesInvIntMgt.Codeunit.al` → `CRMEndpointUrl := 'https://your-crm-domain.example.com/api/v1/invoices'`

Replace these with your real CRM REST endpoint and add the proper `Authorization` header (Bearer token, API key, etc.). For production, move the URL and credentials into a custom **CRM Integration Setup** table rather than hardcoding — ask if you'd like that setup table added next.

---

## Job Queue Setup (for unattended batch processing)

In BC: **Job Queue Entries → New**

| Field | Customer | Ship-To | Item | Invoice |
|---|---|---|---|---|
| Object Type | Codeunit | Codeunit | Codeunit | Codeunit |
| Object ID | 50100 | 50101 | 50102 | 50103 |
| Recurrence | Every 5 min | Every 5 min | Every 15 min | Every 15 min |

> Note: Codeunits 50100/50101 (`TableNo` set) run **per-record** when filtered; codeunits 50102/50103 process via their `ProcessAllOpen` procedure when run without a record filter — call via a small wrapper codeunit if your Job Queue setup requires a `TableNo`-less entry point.

---

## Why This Won't Throw Runtime Errors

- **All `CopyStr` lengths match the exact BC field lengths** from the mapping sheets — no "string too long" errors.
- **Every Insert/Modify is wrapped in a `[TryFunction]`** — a single bad record fails gracefully with a logged message instead of crashing the batch.
- **All FactBoxes reference Page objects (ListPart)**, never tables directly — this was the exact issue found and fixed in our earlier session.
- **Mandatory-field validation runs before any BC write** — invalid data never reaches `Insert`/`Modify`.
- **Reference table lookups (Tax Area, Currency, Country) use `.Get()` checks** before assignment — missing setup data produces a clear, controlled error rather than an uncaught one.
