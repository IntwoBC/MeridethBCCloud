pageextension 50017 pageextension70000115 extends "Posted Sales Invoice"
{
    // <changelog>
    //   <add id="NA0001" dev="ELYNCH" date="2006-02-03" area="NASALESTAX" feature="617"
    //     releaseversion="NAVNA4.00">Added NA Sales Tax fields and code</add>
    //   <change id="NA0002" dev="ELYNCH" date="2006-02-03" area="NA ADDRESS" feature="2116"
    //     releaseversion="NAVNA4.00">Formatted address with State / ZIP Code</change>
    // </changelog>
    // 
    // MER0001 TLE 12/06/13 Add Commissions fast tab
    // MER0002 TLE 01/28/14 Add Commissions Factbox
    // MER0003 TLE 04/10/14 Add fields to Commissions fast tab
    // MER0004 MT  04/12/16 Edit VarStreet Order No.
    layout
    {

        //Unsupported feature: Property Modification (Level) on ""Package Tracking No."(Control 81)".

        addafter("External Document No.")
        {
            field(VARStreetOrderNo; rec."VARStreet Order No.")
            {
                Editable = HasVarStreetPermission;
                ApplicationArea = all;
            }
        }
        addafter("Shipping and Billing")
        {
            group(EFT)
            {
                Caption = 'EFT';
                field(Control37028370; '')
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                    ShowCaption = false;
                }
                field(Control37028372; '')
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                    ShowCaption = false;
                }
                field("Expiration Month / Year"; '')
                {
                    Caption = 'Expiration Month / Year';
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Control37028376; '')
                {
                    ApplicationArea = all;
                    Editable = false;
                    ShowCaption = false;
                }
            }
            group(Commissions)
            {
                Caption = 'Commissions';
                field("Credit Card Charges"; rec."Credit Card Charges")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Salesperson Misc. Charge"; rec."Salesperson Misc. Charge")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Salesperson Order Fee"; rec."Salesperson Order Fee")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
            }
        }
        addafter("Bill-to")
        {
            field(Control37028450; '')
            {
                Editable = false;
                ShowCaption = false;
                ApplicationArea = all;
            }
        }
        addfirst(FactBoxes)
        {
            part(Control1240060001; "Posted Commissions Factbox")
            {
                ApplicationArea = all;
                SubPageLink = "No." = FIELD("No.");
            }
        }
    }
    actions
    {


        //Unsupported feature: Code Modification on "Statistics(Action 8).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        OnBeforeCalculateSalesTaxStatistics(Rec);
        if "Tax Area Code" = '' then
          PAGE.RunModal(PAGE::"Sales Invoice Statistics",Rec,"No.")
        else
          PAGE.RunModal(PAGE::"Sales Invoice Stats.",Rec,"No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*


        #2..5
        // NA0001.end
        */
        //end;
        // modify(Separator171)
        // {
        //     Visible = false;
        // }
    }

    var

        HasVARStreetPermission: Boolean;


    //Unsupported feature: Code Insertion on "OnModifyRecord".

    //trigger OnModifyRecord(): Boolean
    //begin
    /*
    //MER0004 >>
    EditInvoice;
    exit(false);
    //MER0004 <<
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetSecurityFilterOnRespCenter;
    CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;

    IsOfficeAddin := OfficeMgt.IsAvailable;
    IsFoundationEnabled := ApplicationAreaMgmtFacade.IsFoundationEnabled;

    ActivateFields;
    PaymentServiceVisible := PaymentServiceSetup.IsPaymentServiceVisible;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //EFT3.00 -
    //SETFILTER("Expiration Filter", '>%1', TODAY);
    //EFT3.00 +
    SetSecurityFilterOnRespCenter;


    #2..8
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCalculateSalesTaxStatistics(PROCEDURE 1020000)".


    procedure SetVARStreetEditable()
    var
        PermissionCheck: Codeunit "VARStreet Permission";
    begin
        HasVARStreetPermission := PermissionCheck.HasVARStreetRole(false);
    end;

    procedure EditInvoice()
    var
        PermissionCheck: Codeunit "VARStreet Permission";
    begin
        PermissionCheck.EditInvoice(Rec);
        CurrPage.Update(false);
    end;
}

