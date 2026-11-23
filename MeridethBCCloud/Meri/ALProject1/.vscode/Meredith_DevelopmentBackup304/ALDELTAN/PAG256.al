pageextension 50100 PaymentJournalExt extends "Payment Journal"
{
    layout
    {
        addafter(WorkflowStatusBatch)
        {
            part(WorkflowStatus_Line; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Caption = 'Line Workflows';
                Editable = false;
                Enabled = false;
            }
        }
    }

    actions
    {
        modify("Insert Conv. LCY Rndg. Lines")
        {
            Caption = 'Insert Conv. LCY Rndg. Lines';
        }

        addfirst("P&osting")
        {
            action(Reconsi)
            {
                Caption = 'Reconcile';
                Image = Reconcile;
                ShortCutKey = 'Ctrl+F11';
                ApplicationArea = All;

                trigger OnAction()
                var
                //GLReconcile: Codeunit Recon;
                begin
                    // GLReconcile.SetGenJnlLine(Rec);
                    // GLReconcile.Run();
                end;
            }
        }

        addafter("A&ccount")
        {
            action(PrintExtendedStub)
            {
                ApplicationArea = all;
                Caption = 'Print Extended Check Stub';


                trigger OnAction()
                begin
                    PrintExtendedCheckStub();
                end;
            }
        }
    }

    var
        ExtendAPCheckStub: Record "Extended Check Stub";
        LowCheckNo: Code[20];
        HighCheckNo: Code[20];

    procedure PrintExtendedCheckStub()
    var
        GenJnlLine: Record "Gen. Journal Line";
    begin
        GenJnlLine.Reset();
        GenJnlLine.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Document No.");
        GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
        GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        GenJnlLine.SetRange("Account Type", GenJnlLine."Account Type"::"Bank Account");

        if GenJnlLine.FindFirst() then
            LowCheckNo := GenJnlLine."Document No.";

        if GenJnlLine.FindLast() then
            HighCheckNo := GenJnlLine."Document No.";

        ExtendAPCheckStub.Reset();
        ExtendAPCheckStub.SetRange("Journal Template Name", Rec."Journal Template Name");
        ExtendAPCheckStub.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        ExtendAPCheckStub.SetRange("Check No.", LowCheckNo, HighCheckNo);

        if ExtendAPCheckStub.FindFirst() then begin
            if Confirm(
                'Attached Document Ready to Print,\\Remove Any Preprinted Check stock.',
                false)
            then begin
                Report.RunModal(
                    Report::"Extended AP Check Stub",
                    false,
                    true,
                    ExtendAPCheckStub);
            end;
        end;

        LowCheckNo := '';
        HighCheckNo := '';
    end;
}