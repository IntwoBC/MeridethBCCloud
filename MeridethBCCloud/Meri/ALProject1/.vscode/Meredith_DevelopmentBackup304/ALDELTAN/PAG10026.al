pageextension 50035 pageextension70000013 extends "Sales Order Shipment"
{
    // <changelog>
    //   <add id="NA0001" dev="ELYNCH" date="2006-02-20" area="ORDERENTRY" feature="607"
    //     releaseversion="NAVNA4.00">Adapted 4.0 SO form 37 for NA SO Shipment</add>
    //   <change id="NA0003" dev="JNOZZI" date="2007-11-06" area="ORDERENTRY"  request="27985"
    //     baseversion="NAVNA4.00" releaseversion="NAVNA5.00.01">Implement Prepayment check before posting</change>
    //   <change id="NA0004" dev="V-JELI" date="2009-06-15" area="ORDERENTRY"  request="PS40380"
    //     baseversion="NAVNA4.00" releaseversion="NAVNA6.00.01">The Sales Order Shipping Form/Page in the North America
    //     Version doesn&apos;t insert the G/L Freight Expense Account Line on the Sales Order after posting the Shipment in the
    //     RTC</change>
    // </changelog>
    actions
    {


        //Unsupported feature: Code Modification on ""P&ost"(Action 75).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if ApprovalsMgmt.PrePostApprovalCheckSales(Rec) then begin
          if PrepaymentMgt.TestSalesPrepayment(Rec) then
            Error(Text001,"Document Type","No.");

          if PrepaymentMgt.TestSalesPayment(Rec) then
            Error(Text002,"Document Type","No.");

          SalesLine.Validate("Document Type","Document Type");
          SalesLine.Validate("Document No.","No.");
          SalesLine.InsertFreightLine(FreightAmount);
          CODEUNIT.Run(CODEUNIT::"Ship-Post (Yes/No)",Rec);
          if "Shipping No." = '-1' then
            Error('');
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*


        //IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN BEGIN
        //  IF PrepaymentMgt.TestSalesPrepayment(Rec) THEN
        //    ERROR(Text001,"Document Type","No.");



        //  IF PrepaymentMgt.TestSalesPayment(Rec) THEN
        //    ERROR(Text002,"Document Type","No.");

        //
        ////    ERROR(STRSUBSTNO(Text001,"Document Type","No."));
        ////
        ////  IF PrepaymentMgt.TestSalesPayment(Rec) THEN
        ////    ERROR(STRSUBSTNO(Text002,"Document Type","No."));
        ////
        ////  SalesLine.VALIDATE("Document Type","Document Type");
        ////  SalesLine.VALIDATE("Document No.","No.");
        ////  SalesLine.InsertFreightLine(FreightAmount);
        ////  CODEUNIT.RUN(CODEUNIT::"Ship-Post (Yes/No)",Rec);
        ////  IF "Shipping No." = '-1' THEN
        ////    ERROR('');
        ////END;
        ////// NA0003.end
        */
        //end;


        //Unsupported feature: Code Modification on ""Post and &Print"(Action 76).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if ApprovalsMgmt.PrePostApprovalCheckSales(Rec) then begin
          if PrepaymentMgt.TestSalesPrepayment(Rec) then
            Error(Text001,"Document Type","No.");

          if PrepaymentMgt.TestSalesPayment(Rec) then
            Error(Text002,"Document Type","No.");

          SalesLine.Validate("Document Type","Document Type");
          SalesLine.Validate("Document No.","No.");
          SalesLine.InsertFreightLine(FreightAmount);
          CODEUNIT.Run(CODEUNIT::"Ship-Post + Print",Rec);
          if "Shipping No." = '-1' then
            Error('');
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*

        //IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN BEGIN
        //  IF PrepaymentMgt.TestSalesPrepayment(Rec) THEN
        //    ERROR(Text001,"Document Type","No.");

        //  IF PrepaymentMgt.TestSalesPayment(Rec) THEN
        //    ERROR(Text002,"Document Type","No.");


        ////IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN BEGIN
        ////  IF PrepaymentMgt.TestSalesPrepayment(Rec) THEN
        //
        ////    ERROR(STRSUBSTNO(Text001,"Document Type","No."));
        ////
        ////  IF PrepaymentMgt.TestSalesPayment(Rec) THEN
        ////    ERROR(STRSUBSTNO(Text002,"Document Type","No."));
        ////
        ////  SalesLine.VALIDATE("Document Type","Document Type");
        ////  SalesLine.VALIDATE("Document No.","No.");
        ////  SalesLine.InsertFreightLine(FreightAmount);
        ////  CODEUNIT.RUN(CODEUNIT::"Ship-Post + Print",Rec);
        ////  IF "Shipping No." = '-1' THEN
        ////    ERROR('');
        ////END;
        ////// NA0003.end
        */
        //end;
    }

    //Unsupported feature: Property Modification (Attributes) on "UpdateAllowed(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "OrderOnHold(PROCEDURE 1000)".



    //Unsupported feature: Code Modification on "AfterGetCurrentRecord(PROCEDURE 19077479)".

    //procedure AfterGetCurrentRecord();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    xRec := Rec;
    SetRange("Date Filter",0D,WorkDate - 1);

    OrderOnHold("On Hold" <> '');
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    // FreightAmount := 0; // NA0004
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCalculateSalesTaxStatistics(PROCEDURE 1020000)".



    //Unsupported feature: Code Modification on "OnBeforeCalculateSalesTaxStatistics(PROCEDURE 1020000)".

    //procedure OnBeforeCalculateSalesTaxStatistics();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    {*
    // NA0004.begin
    IF FreightAmount <= 0 THEN BEGIN
      FreightAmount := 0;
      EXIT;
    END;
    // NA0004.end

    // If a freight amount is specified then the freight account must be filled in
    SalesSetup.GET;
    SalesSetup.TESTFIELD("G/L Freight Account No.");

    // Fill in the Sales Line
    SalesLine.SETRANGE("Document Type","Document Type");
    SalesLine.SETRANGE("Document No.","No.");

    // See if the Freight Line already exists
    FreightLineExists := TRUE;
    SalesLine.SETRANGE(Description,tcFreightLineDescription); // used a text constant
    SalesLine.SETRANGE("Qty. to Ship",1);
    IF NOT SalesLine.FINDFIRST THEN BEGIN
      FreightLineExists := FALSE;
      SalesLine.SETRANGE(Description);
      SalesLine.SETRANGE("Qty. to Ship");
      SalesLine.FINDLAST;
      SalesLine."Line No." := SalesLine."Line No." + 10000;
    END;
    SalesLine.INIT;
    SalesLine.VALIDATE(Type,SalesLine.Type::"G/L Account");
    SalesLine.VALIDATE("No.",SalesSetup."G/L Freight Account No.");
    SalesLine.VALIDATE(Description,tcFreightLineDescription); // used a text constant
    SalesLine.VALIDATE(Quantity,1);
    SalesLine.VALIDATE("Unit Price",FreightAmount);
    IF FreightLineExists THEN
      SalesLine.MODIFY
    ELSE
      SalesLine.INSERT;
    FreightAmount := 0; // NA0004*}
    */
    //end;
}

