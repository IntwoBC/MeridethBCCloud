// ============================================================
// Enum: CRM Integration Status
// Object ID  : 50100
// Publisher  : Intwo
// Description: Shared status enum used by ALL four integration
//              staging tables (Customer, Ship-To, Item, Invoice).
//              Open  = record received / awaiting processing.
//              Success = written to BC/CRM successfully.
//              Failed  = error occurred; see Error Message field.
// ============================================================
enum 50100 "CRM Integration Status"
{
    Extensible = true;

    value(0; Open)
    {
        Caption = 'Open';
    }
    value(1; Success)
    {
        Caption = 'Success';
    }
    value(2; Failed)
    {
        Caption = 'Failed';
    }
}
