# CRM Integration Setup and Test Guide

## 1. What was added

This extension now includes configurable setup for outbound CRM push:

- Table: CRM Integration Setup (ID 50105)
- Page: CRM Integration Setup (ID 50111)
- Control Center action: Integration Setup
- Code flow updated:
  - Item push reads endpoint/auth/timeout from setup
  - Sales Invoice push reads endpoint/auth/timeout from setup

## 2. Where to open setup in BC

1. Publish the extension and open CRM Integration Control Center.
2. Click Integration Setup.
3. The DEFAULT setup record is created automatically on first open.

## 3. Setup fields and meaning

- Item API URL: Endpoint for BC -> CRM Item push
- Invoice API URL: Endpoint for BC -> CRM Sales Invoice push
- Auth Type:
  - None: no Authorization header
  - Bearer: sends Authorization: Bearer <Auth Token>
  - Basic: sends Authorization: Basic <base64(username:password)>
   - OAuth Client Credentials: auto-fetches and refreshes bearer token from Token URL
- Auth Token: required only when Auth Type = Bearer
- Username, Password: required only when Auth Type = Basic
- Token URL: required when Auth Type = OAuth Client Credentials
- Client ID: required when Auth Type = OAuth Client Credentials
- Client Secret: required when Auth Type = OAuth Client Credentials
- OAuth Scope: optional, based on your authorization server requirements
- Token Refresh Buffer (sec): token is refreshed before expiry by this buffer
- Request Timeout (ms): HTTP timeout in milliseconds
- Use HTTPS Only:
  - true: URL must start with https://
  - false: allows non-HTTPS URLs (not recommended)

## 4. Validation behavior in code flow

Before sending request, code now validates:

1. Setup record DEFAULT exists
2. Required endpoint URL exists
3. HTTPS rule (if enabled)
4. Required auth fields based on Auth Type
5. OAuth token cache/expiry for client credentials mode

If validation fails:

- Push does not call CRM
- Staging record is marked Failed
- Error Message shows exact setup issue

## 5. Step-by-step test instructions

### A) Prerequisites

1. Publish extension to sandbox.
2. Ensure master data exists in BC (Tax Area, Currency, Payment Terms, etc.).
3. Ensure CRM API endpoint is reachable from BC environment.

### B) Configure setup

1. Open CRM Integration Control Center.
2. Click Integration Setup.
3. Fill fields:
   - Item API URL = your item endpoint
   - Invoice API URL = your invoice endpoint
   - Auth Type = Bearer, Basic, or OAuth Client Credentials
   - Fill fields based on auth type:
     - Bearer: Auth Token
     - Basic: Username + Password
     - OAuth Client Credentials: Token URL + Client ID + Client Secret (+ Scope if needed)
   - Request Timeout (ms) = e.g. 60000
   - Use HTTPS Only = true
4. Close page (data is saved automatically).

### B1) OAuth client credentials quick test

1. Select Auth Type = OAuth Client Credentials.
2. Enter Token URL, Client ID, Client Secret, and (if required) OAuth Scope.
3. Trigger Item push from CRM Item Dashboard.
4. Verify:
   - Push reaches CRM endpoint successfully.
   - Access Token Expires At is populated in setup.
   - Subsequent pushes reuse cached token until refresh buffer is reached.

### C) Test Item push

1. Open CRM Item Dashboard.
2. Click Stage All BC Items (or select one and use Push Selected Item Again).
3. Verify expected result:
   - Integration Status = Success
   - CRM Record ID populated if CRM returns an ID in response
4. If Failed, read Error Message and fix setup or endpoint.

### D) Test Sales Invoice push

1. Post a Sales Invoice in BC.
2. Open CRM Sales Invoice Dashboard.
3. Stage/push invoice using existing dashboard action.
4. Verify expected result:
   - Header Integration Status = Success
   - Line statuses = Success
5. If Failed, read Error Message and fix setup/auth/payload contract.

### E) Negative tests (recommended)

1. Clear Item API URL and retry Item push.
   - Expected: Failed with message "Item API URL is required."
2. Set Auth Type = Bearer but clear Auth Token and retry.
   - Expected: Failed with auth-token-required message.
3. Set Use HTTPS Only = true and URL as http://...
   - Expected: Failed with HTTPS validation message.

## 6. Quick troubleshooting checklist

1. Endpoint URL correct and reachable?
2. HTTPS enabled and URL starts with https://?
3. Auth Type matches CRM endpoint expectation?
4. Token/credentials valid and not expired?
5. CRM expects exact field names now configured in payload mapping?
6. Timeout sufficient for CRM response time?

## 7. Postman testing instructions

Use Postman for two kinds of tests:

- Inbound test: simulate CRM posting Customer and Ship-To data into BC API pages.
- Outbound validation test: point BC setup URL to a Postman mock endpoint and inspect payload sent by BC.

### A) Postman setup for BC inbound API tests (CRM -> BC)

1. Create a new Postman Environment with variables:
   - bcBaseUrl = https://api.businesscentral.dynamics.com/v2.0/<tenant-id>/<environment>/api/intwo/crm/v1.0
   - customerEndpoint = {{bcBaseUrl}}/customerIntegrations
   - shipToEndpoint = {{bcBaseUrl}}/shipToIntegrations
2. Authentication options:
   - Recommended: OAuth 2.0 (Microsoft Entra app with BC API permissions).
   - Alternative (sandbox only): Basic auth with BC web service access key if enabled in your tenant.
3. Add headers:
   - Content-Type: application/json
   - Accept: application/json

### B) Customer inbound request in Postman

1. Method: POST
2. URL: {{customerEndpoint}}
3. Body (raw JSON):

```json
{
  "accountnumber": "C05056",
  "name": "Arnold Mireles Elementary Academy",
  "address1_line1": "9000 S EXCHANGE AVE",
  "address1_line2": "107 PACIFIC HALL",
  "address1_city": "North Miami Bch",
  "address1_country": "US",
  "address1_postalcode": "33162",
  "wf_billingcontact": "John Doe",
  "wf_billingemail": "john@example.com",
  "telephone1": "312-555-0100",
  "wf_taxcodelist": "LA",
  "wf_customerpaymentterms": "N30",
  "zzmd_salespersoncode": "JS",
  "currencyCode": "USD",
  "creditLimit": 25000
}
```

4. Send request.
5. Expected result:
   - HTTP success response from BC API.
   - Record appears in Customer staging/dashboard.
   - Integration Status becomes Success or Failed with clear Error Message.

### C) Ship-To inbound request in Postman

1. Method: POST
2. URL: {{shipToEndpoint}}
3. Body (raw JSON):

```json
{
  "accountnumber": "C05056",
  "code": "16756CWAR",
  "address1_name": "California Institution For Women & Men",
  "address1_line1": "16756 Chino-Corona Road",
  "address1_line2": "Suite 1",
  "address1_city": "North Miami Beach",
  "address1_country": "US",
  "address1_postalcode": "91710",
  "telephone1": "(909) 597-1771 x 55",
  "fullname": "Annex Warehouse",
  "emailaddress1": "charity.anti@cdcr.ca.gov",
  "zzmd_salespersoncode": "JS",
  "wf_taxcodelist": "OS",
  "locationCode": "SANPEDRO"
}
```

4. Send request.
5. Expected result:
   - HTTP success response from BC API.
   - Ship-To staging record processed.
   - Integration Status becomes Success or Failed with clear Error Message.

### D) Outbound payload validation using Postman Mock Server (BC -> CRM)

1. In Postman, create a Mock Server with two paths:
   - POST /api/v1/items
   - POST /api/v1/invoices
2. Copy mock base URL, for example:
   - https://<mock-id>.mock.pstmn.io
3. In BC Integration Setup:
   - Item API URL = https://<mock-id>.mock.pstmn.io/api/v1/items
   - Invoice API URL = https://<mock-id>.mock.pstmn.io/api/v1/invoices
   - Auth Type = None (for first validation)
   - Use HTTPS Only = true
4. Trigger push from BC dashboards.
5. In Postman mock history, verify request bodies contain expected CRM schema keys:
   - Item: productnumber, wf_itemcategory, standardcost, defaultuomid
   - Invoice header: invoicenumber, wf_selltonavcustomerno, wf_billtonavcustomerno, wf_shiptocode
   - Invoice lines: lineitemnumber, productid, priceperunit, wf_unitcost

### E) Suggested Postman negative tests

1. Send Customer payload without accountnumber.
   - Expected: staging record fails with mandatory field message.
2. Send Ship-To payload with non-existing customer number.
   - Expected: failure message indicating customer not found in BC.
3. In setup, keep Auth Type = Bearer but leave token blank and trigger push.
   - Expected: push fails with setup validation error.

## 8. Optional production hardening

1. Move secrets from plain fields to secure secret storage pattern.
2. Add a Test Connection action on setup page.
3. Add separate setup for Customer/Ship-To inbound auth if needed.
4. Add environment-specific setup (Sandbox/Production separation).
