# Invoice and Invoice Line API Testing Document

## 1. Purpose

This document captures the validation steps for the Invoice and Invoice Line API flow used by the CRM Business Central integration. It covers the create, retrieve, update, and delete behavior described in the supplied integration contract, including the default bindings for invoice price list and invoice line unit of measure.

## 2. Instance-specific defaults

The integration layer must apply the following MRD DEV defaults when the source system does not provide them:

- Invoice price list binding: /pricelevels(6472e80a-bfff-e211-acb5-00155d602128)
- Invoice line unit binding: /uoms(b2f82e2d-98ab-46b5-9577-600f4567fcb7)

These values should be configurable in the target environment and should not be hardcoded in downstream systems.

## 3. Test prerequisites

1. Valid Dataverse / CRM access token.
2. A reachable CRM environment endpoint for invoices and invoicedetails.
3. An existing invoice number to use as the alternate key for create and update operations.
4. An existing product number for catalog-product invoice lines, or a write-in product scenario if product binding is not used.

## 4. Header API tests

### 4.1 Create invoice

Method: POST
URL: https://mrd-dev.crm.dynamics.com/api/data/v9.2/invoices?$select=invoiceid,invoicenumber

Sample payload:

```json
{
  "name": "Sample Invoice",
  "pricelevelid@odata.bind": "/pricelevels(6472e80a-bfff-e211-acb5-00155d602128)",
  "invoicenumber": "INV-2026-000155",
  "datedelivered": "2026-06-23",
  "duedate": "2026-07-31",
  "lastbackofficesubmit": "2026-06-23T10:30:00Z",
  "billto_name": "ABC Corp Billing",
  "billto_line1": "123 Billing Street",
  "billto_line2": "Suite 400",
  "billto_city": "Seattle",
  "billto_stateorprovince": "WA",
  "billto_postalcode": "98101",
  "billto_country": "USA",
  "shipto_name": "ABC Corp Warehouse",
  "shipto_line1": "500 Shipping Ave",
  "shipto_line2": "Dock 2",
  "shipto_city": "Tacoma",
  "shipto_stateorprovince": "WA",
  "shipto_postalcode": "98402",
  "shipto_country": "USA",
  "wf_billtonavcustomerno": "NAV-BILL-1001",
  "wf_selltonavcustomerno": "NAV-SELL-1001",
  "wf_shiptocode": "SHIP-01",
  "wf_customerpo": "PO-778899",
  "wf_extdocno": "EXT-556677",
  "description": "Created via Web API"
}
```

Expected result:
- HTTP 2xx response.
- Response contains invoiceid and invoicenumber.
- Save invoiceid and invoicenumber for later retrieve/update/delete steps.

### 4.2 Retrieve invoice by invoice number

Method: GET
URL: https://mrd-dev.crm.dynamics.com/api/data/v9.2/invoices(invoicenumber='INV-2026-000155')?$select=invoiceid,invoicenumber,name,description,datedelivered,duedate,_customerid_value,_pricelevelid_value,statecode,statuscode

Expected result:
- Response returns the invoice GUID and the alternate key field.
- The price level binding is available via the returned _pricelevelid_value.
- The invoice can be identified consistently using invoicenumber.

### 4.3 Update invoice by invoice number

Method: PATCH
URL: https://mrd-dev.crm.dynamics.com/api/data/v9.2/invoices(invoicenumber='INV-2026-000155')

Sample payload:

```json
{
  "description": "Updated via Web API",
  "prioritycode": 1,
  "name": "Sample Invoice",
  "datedelivered": "2026-06-23",
  "duedate": "2026-07-31",
  "wf_customerpo": "PO-778899",
  "wf_extdocno": "EXT-556677"
}
```

Expected result:
- HTTP 2xx response.
- Invoice remains identified by invoicenumber.
- The default price level does not need to be resent unless the price list must change.

### 4.4 Delete invoice by invoice number

Method: DELETE
URL: https://mrd-dev.crm.dynamics.com/api/data/v9.2/invoices(invoicenumber='INV-2026-000155')

Expected result:
- Only delete after invoice line dependencies have been reviewed and any required business status transition has been completed.
- If deletion is blocked, validate the invoice state instead of deleting immediately.

## 5. Invoice line API tests

### 5.1 Create invoice line - existing product

Method: POST
URL: https://mrd-dev.crm.dynamics.com/api/data/v9.2/invoicedetails?$select=invoicedetailid

Sample payload:

```json
{
  "invoiceid@odata.bind": "/invoices(invoicenumber='INV-2026-000155')",
  "productid@odata.bind": "/products(productnumber='1595C001')",
  "uomid@odata.bind": "/uoms(b2f82e2d-98ab-46b5-9577-600f4567fcb7)",
  "description": "Invoice line for ordered product",
  "ispriceoverridden": true,
  "isproductoverridden": false,
  "lineitemnumber": 1,
  "priceperunit": 100.00,
  "quantity": 2,
  "wf_dateordered": "2026-06-23",
  "wf_unitcost": 80.00,
  "wf_vendorcrossreference": "VCR-12345",
  "wf_vendornumber": "VEND-1001"
}
```

Expected result:
- HTTP 2xx response.
- Response contains invoicedetailid.
- Save the returned invoicedetailid for retrieve/update/delete testing.

### 5.2 Create invoice line - write-in product

Method: POST
URL: https://mrd-dev.crm.dynamics.com/api/data/v9.2/invoicedetails?$select=invoicedetailid

Sample payload:

```json
{
  "invoiceid@odata.bind": "/invoices(invoicenumber='INV-2026-000155')",
  "productdescription": "Product-1",
  "description": "Invoice line for write-in product",
  "ispriceoverridden": true,
  "isproductoverridden": true,
  "lineitemnumber": 1,
  "priceperunit": 100.00,
  "quantity": 2,
  "wf_dateordered": "2026-06-23",
  "wf_unitcost": 80.00,
  "wf_vendorcrossreference": "VCR-12345",
  "wf_vendornumber": "VEND-1001"
}
```

Expected result:
- HTTP 2xx response.
- Product binding is omitted because the line is write-in.
- isproductoverridden is true and productdescription is used.

### 5.3 Retrieve invoice line by ID

Method: GET
URL: https://mrd-dev.crm.dynamics.com/api/data/v9.2/invoicedetails(<invoicedetailid>)?$select=invoicedetailid,_invoiceid_value,_productid_value,_uomid_value,description,lineitemnumber,priceperunit,quantity,ispriceoverridden,isproductoverridden,statecode,statuscode

Expected result:
- Response includes the line GUID and related invoice/product/UoM references.
- Commercial values such as quantity and priceperunit are available.

### 5.4 Update invoice line by ID

Method: PATCH
URL: https://mrd-dev.crm.dynamics.com/api/data/v9.2/invoicedetails(<invoicedetailid>)

Sample payload:

```json
{
  "quantity": 3,
  "priceperunit": 900.00,
  "description": "Invoice line for ordered product",
  "ispriceoverridden": true,
  "lineitemnumber": 1,
  "wf_dateordered": "2026-06-23",
  "wf_unitcost": 80.00,
  "wf_vendorcrossreference": "VCR-12345",
  "wf_vendornumber": "VEND-1001"
}
```

Expected result:
- HTTP 2xx response.
- The line remains bound to the invoice and retains its identity by invoicedetailid.

### 5.5 Delete invoice line by ID

Method: DELETE
URL: https://mrd-dev.crm.dynamics.com/api/data/v9.2/invoicedetails(<invoicedetailid>)

Expected result:
- Delete only after validating invoice state and downstream business rules.
- If deletion is blocked, follow the required status transition path instead of deleting.

## 6. Negative tests

1. Missing invoice number in the header request should fail validation.
2. Invalid productnumber or missing product record should return 404 or a validation error.
3. Missing or expired authentication token should return 401.
4. Invalid headers or malformed JSON should return 400.
5. Deleting an invoice with dependent lines without validation should be blocked by the business rules.

## 7. Validation checklist

- Invoice create returns invoiceid and invoicenumber.
- Invoice line create returns invoicedetailid.
- Invoice lines bind to invoice through invoicenumber.
- Catalog-product lines set isproductoverridden = false and use productid binding.
- Write-in lines set isproductoverridden = true and use productdescription.
- The integration layer applies the default price list and unit values when the source system omits them.
