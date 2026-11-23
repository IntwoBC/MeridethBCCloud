tableextension 50032 tableextension70000333 extends "Handled IC Outbox Trans."
{
    fields
    {
        modify(Status)
        {
            OptionCaption = 'Sent to IC Partner,Rejection Sent to IC Partner,Cancelled';
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "ShowDetails(PROCEDURE 1)".

}

