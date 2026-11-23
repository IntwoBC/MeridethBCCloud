// ============================================================
// Codeunit: CRM Inbound Integration Web Service
// Object ID  : 50115
// Purpose    : Service-enabled JSON receiver for CRM payloads.
//              Stages Customer/Ship-To records and returns JSON
//              acknowledgment. Processing is done by Job Queue.
// ============================================================
codeunit 50115 "CRM Inbound WS"
{
    Permissions =
        TableData "CRM Customer Staging" = RIMD,
        TableData "CRM Ship-To Staging" = RIMD,
        TableData "Ship-to Address" = RIMD,
        TableData Customer = RIMD,
        TableData "CRM Integration Log" = RIMD;

    [ServiceEnabled]
    procedure HandleMultipleCustomerPayload(Payload: Text) Responsetxt: Text
    var
        RootObj: JsonObject;
        CustomerArray: JsonArray;
        CustomerToken: JsonToken;
        CustomerObj: JsonObject;
        CustomerPayload: Text;
        codeunitcu: codeunit 50104;
        Jobject: JsonObject;
        CustomersArray: JsonArray;
        JToken: JsonToken;
        //   CustomerObj: JsonObject;
        CustomerNos: JsonArray;
        CustomerNo: Code[20];
        i: Integer;
        ResponseObj: jsonObject;
    //   Responsetxt: text;
    begin
        Responsetxt := '';
        if not RootObj.ReadFrom(Payload) then
            Error('Invalid JSON.');

        if not RootObj.Get('customers', CustomerToken) then
            Error('customers node not found.');

        if not CustomerToken.IsArray() then
            Error('customers must be an array.');

        CustomerArray := CustomerToken.AsArray();

        foreach CustomerToken in CustomerArray do begin
            CustomerObj := CustomerToken.AsObject();
            CustomerObj.WriteTo(CustomerPayload);

            codeunitcu.HandleCustomerPayload(CustomerPayload);
        end;
        // Responsetxt := 'Customers Inserted Successfully';
        JObject.ReadFrom(Payload);
        if JObject.Get('customers', JToken) then begin
            CustomersArray := JToken.AsArray();

            for i := 0 to CustomersArray.Count() - 1 do begin
                CustomersArray.Get(i, JToken);
                CustomerObj := JToken.AsObject();

                CustomerNo := CopyStr(GetJsonTextWithFallback(CustomerObj, 'accountnumber', 'no'), 1, 20);
                CustomerNos.Add(CustomerNo);
            end;
        end else begin
            // Single customer payload
            CustomerNo := CopyStr(GetJsonTextWithFallback(JObject, 'accountnumber', 'no'), 1, 20);
            CustomerNos.Add(CustomerNo);
        end;

        ResponseObj.Add('status', 'accepted');
        ResponseObj.Add('customers', CustomerNos);
        ResponseObj.WriteTo(Responsetxt);
    end;

    [ServiceEnabled]
    procedure UpdateCustomerPayload(Payload: Text): Text
    var
        Handler: Codeunit "CRM Inbound API Handler";
        ResponseObj: JsonObject;
        ResponseText: Text;
        JObject: JsonObject;
        CustomerNo: Code[20];
    begin
        if Payload = '' then
            exit('{"status":"failed","error":"Payload is empty"}');

        if not TryUpdateCustomerPayload(Handler, Payload) then begin
            ResponseObj.Add('status', 'failed');
            ResponseObj.Add('error', GetLastErrorText());
            ResponseObj.WriteTo(ResponseText);
            exit(ResponseText);
        end;

        JObject.ReadFrom(Payload);
        CustomerNo := CopyStr(GetJsonTextWithFallback(JObject, 'accountnumber', 'no'), 1, 20);

        ResponseObj.Add('status', 'success');
        ResponseObj.Add('Customer No.', CustomerNo);
        ResponseObj.Add('message', 'Customer updated successfully');
        ResponseObj.WriteTo(ResponseText);

        exit(ResponseText);
    end;

    [ServiceEnabled]
    procedure DeleteCustomerPayload(Payload: Text): Text
    var
        Handler: Codeunit "CRM Inbound API Handler";
        ResponseObj: JsonObject;
        ResponseText: Text;
        JObject: JsonObject;
        CustomerNo: Code[20];
    begin
        if Payload = '' then
            exit('{"status":"failed","error":"Payload is empty"}');

        if not TryDeleteCustomerPayload(Handler, Payload) then begin
            ResponseObj.Add('status', 'failed');
            ResponseObj.Add('error', GetLastErrorText());
            ResponseObj.WriteTo(ResponseText);
            exit(ResponseText);
        end;

        JObject.ReadFrom(Payload);
        CustomerNo := CopyStr(GetJsonTextWithFallback(JObject, 'accountnumber', 'no'), 1, 20);

        ResponseObj.Add('status', 'success');
        ResponseObj.Add('Customer No.', CustomerNo);
        ResponseObj.Add('message', 'Customer deleted successfully');
        ResponseObj.WriteTo(ResponseText);

        exit(ResponseText);
    end;

    [ServiceEnabled]
    procedure DeleteShipToPayload(Payload: Text): Text
    var
        Handler: Codeunit "CRM Inbound API Handler";
        ResponseObj: JsonObject;
        ResponseText: Text;
        JObject: JsonObject;
        CustomerNo: Code[20];
        ShipToCode: Code[20];
    begin
        if Payload = '' then
            exit('{"status":"failed","error":"Payload is empty"}');

        if not TryDeleteShipToPayload(Handler, Payload) then begin
            ResponseObj.Add('status', 'failed');
            ResponseObj.Add('error', GetLastErrorText());
            ResponseObj.WriteTo(ResponseText);
            exit(ResponseText);
        end;

        JObject.ReadFrom(Payload);

        CustomerNo := CopyStr(GetJsonTextWithFallback(JObject, 'accountnumber', 'customerNo'), 1, 20);
        ShipToCode := CopyStr(GetJsonText(JObject, 'code'), 1, 10);

        ResponseObj.Add('status', 'success');
        ResponseObj.Add('Customer No.', CustomerNo);
        ResponseObj.Add('Ship-To Code', ShipToCode);
        ResponseObj.Add('message', 'Ship-To Address deleted successfully');
        ResponseObj.WriteTo(ResponseText);

        exit(ResponseText);
    end;

    [ServiceEnabled]
    procedure ReceiveCustomerPayload(Payload: Text): Text
    var
        Handler: Codeunit "CRM Inbound API Handler";
        ResponseObj: JsonObject;
        ResponseText: Text;
        jobject: JsonObject;
        CustomerNo: code[20];
    begin
        clear(CustomerNo);
        if Payload = '' then
            exit('{"status":"failed","error":"Payload is empty"}');

        if not TryStageCustomerPayload(Handler, Payload) then begin
            ResponseObj.Add('status', 'failed');
            ResponseObj.Add('error', GetLastErrorText());
            ResponseObj.WriteTo(ResponseText);
            exit(ResponseText);
        end;
        jobject.ReadFrom(payload);
        CustomerNo := CopyStr(GetJsonTextWithFallback(JObject, 'accountnumber', 'no'), 1, 20);

        ResponseObj.Add('status', 'accepted');
        ResponseObj.Add('Customer No.', CustomerNo);
        ResponseObj.WriteTo(ResponseText);
        exit(ResponseText);
    end;


    [ServiceEnabled]
    procedure HandleMultipleShipToPayload(Payload: Text) Responsetxt: Text
    var
        RootObj: JsonObject;
        ShipToArray: JsonArray;
        ShipToToken: JsonToken;
        ShipToObj: JsonObject;
        ShipToPayload: Text;
        Handler: Codeunit "CRM Inbound API Handler";
        ResponseObj: JsonObject;
        ResponseArray: JsonArray;
        ResultObj: JsonObject;

        CustomerNo: Code[20];
        ShipToCode: Code[20];

    //  Responsetxt: text;
    begin
        Responsetxt := '';
        if not RootObj.ReadFrom(Payload) then
            Error('Invalid JSON.');

        if not RootObj.Get('shiptos', ShipToToken) then
            Error('shiptos node not found.');

        if not ShipToToken.IsArray() then
            Error('shiptos must be an array.');

        ShipToArray := ShipToToken.AsArray();

        foreach ShipToToken in ShipToArray do begin
            ShipToObj := ShipToToken.AsObject();
            ShipToObj.WriteTo(ShipToPayload);

            Handler.HandleShipToPayload(ShipToPayload);
            CustomerNo := CopyStr(GetJsonTextWithFallback(ShipToObj, 'accountnumber', 'customerNo'), 1, 20);
            ShipToCode := CopyStr(GetJsonText(ShipToObj, 'code'), 1, 10);

            Clear(ResultObj);
            ResultObj.Add('customerNo', CustomerNo);
            ResultObj.Add('shipToCode', ShipToCode);

            ResponseArray.Add(ResultObj);
        end;
        //   Responsetxt := 'Ship-Tos Inserted Successfully';

        ResponseObj.Add('status', 'accepted');
        // ResponseObj.Add('message', 'Ship-Tos inserted successfully.');
        ResponseObj.Add('shiptos', ResponseArray);

        ResponseObj.WriteTo(ResponseTxt);



    end;

    [ServiceEnabled]
    procedure ReceiveShipToPayload(Payload: Text): Text
    var
        Handler: Codeunit "CRM Inbound API Handler";
        ResponseObj: JsonObject;
        ResponseText: Text;
        jobject, jobject1 : JsonObject;
        CustomerNo: code[20];
        ShiptoCode: code[20];
    begin
        if Payload = '' then
            exit('{"status":"failed","error":"Payload is empty"}');

        if not TryStageShipToPayload(Handler, Payload) then begin
            ResponseObj.Add('status', 'failed');
            ResponseObj.Add('error', GetLastErrorText());
            ResponseObj.WriteTo(ResponseText);
            exit(ResponseText);
        end;
        jobject.ReadFrom(payload);
        CustomerNo := CopyStr(GetJsonTextWithFallback(JObject, 'accountnumber', 'customerNo'), 1, 20);
        ShiptoCode := CopyStr(GetJsonText(JObject, 'code'), 1, 10);
        // jobject1.add('customerNo', CustomerNo);
        // jobject1.add('shiptoCode', ShiptoCode);

        ResponseObj.Add('status', 'accepted');
        ResponseObj.Add('customerno', CustomerNo);
        ResponseObj.Add('shipto', ShiptoCode);
        ResponseObj.WriteTo(ResponseText);
        exit(ResponseText);
    end;

    [ServiceEnabled]
    procedure UpdateShipToPayload(Payload: Text): Text
    var
        Handler: Codeunit "CRM Inbound API Handler";
        ResponseObj: JsonObject;
        ResponseText: Text;
        JObject: JsonObject;
        CustomerNo: Code[20];
        ShipToCode: Code[20];
    begin
        if Payload = '' then
            exit('{"status":"failed","error":"Payload is empty"}');

        if not TryUpdateShipToPayload(Handler, Payload) then begin
            ResponseObj.Add('status', 'failed');
            ResponseObj.Add('error', GetLastErrorText());
            ResponseObj.WriteTo(ResponseText);
            exit(ResponseText);
        end;

        JObject.ReadFrom(Payload);

        CustomerNo := CopyStr(GetJsonTextWithFallback(JObject, 'accountnumber', 'customerNo'), 1, 20);
        ShipToCode := CopyStr(GetJsonText(JObject, 'code'), 1, 10);

        ResponseObj.Add('status', 'success');
        ResponseObj.Add('customerNo', CustomerNo);
        ResponseObj.Add('shipToCode', ShipToCode);
        ResponseObj.Add('message', 'Ship-to updated successfully');

        ResponseObj.WriteTo(ResponseText);
        exit(ResponseText);
    end;

    [TryFunction]
    local procedure TryStageCustomerPayload(var Handler: Codeunit "CRM Inbound API Handler"; Payload: Text)
    begin
        Handler.HandleCustomerPayload(Payload);
    end;

    [TryFunction]
    local procedure TryStageShipToPayload(var Handler: Codeunit "CRM Inbound API Handler"; Payload: Text)
    begin
        Handler.HandleShipToPayload(Payload);
    end;

    [TryFunction]
    local procedure TryUpdateCustomerPayload(var Handler: Codeunit "CRM Inbound API Handler"; Payload: Text)
    begin
        Handler.UpdateCustomerPayload(Payload);
    end;

    [TryFunction]
    local procedure TryDeleteCustomerPayload(var Handler: Codeunit "CRM Inbound API Handler"; Payload: Text)
    begin
        Handler.DeleteCustomerPayload(Payload);
    end;

    [TryFunction]
    local procedure TryUpdateShipToPayload(var Handler: Codeunit "CRM Inbound API Handler"; Payload: Text)
    begin
        Handler.UpdateShipToPayload(Payload);
    end;

    [Tryfunction]
    Local procedure TryDeleteShipToPayload(var Handler: Codeunit "CRM Inbound API Handler"; Payload: Text)
    begin
        Handler.DeleteShipToPayload(Payload);
    end;

    local procedure GetJsonTextWithFallback(JObject: JsonObject; PrimaryKey: Text; SecondaryKey: Text): Text
    var
        ValueText: Text;
    begin
        ValueText := GetJsonText(JObject, PrimaryKey);
        if ValueText = '' then
            ValueText := GetJsonText(JObject, SecondaryKey);

        exit(ValueText);
    end;

    local procedure GetJsonText(JObject: JsonObject; PropertyKey: Text): Text
    var
        JToken: JsonToken;
    begin
        if JObject.Get(PropertyKey, JToken) then begin
            if JToken.IsValue() then
                exit(JToken.AsValue().AsText());
        end;
        exit('');
    end;
}
