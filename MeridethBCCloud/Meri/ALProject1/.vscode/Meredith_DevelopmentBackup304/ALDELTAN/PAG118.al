pageextension 50015 pageextension50015 extends "General Ledger Setup"
{
    // <changelog>
    //   <add id="NA0001" dev="ELYNCH" date="2006-03-22" area="BANK DEP." feature="605"
    //     releaseversion="NAVUS3.70">Add the Bank Deposits &quot;Deposit Nos.&quot; field to the Numbering tab.</add>
    //   <change id="NA0002" dev="ELYNCH" date="2006-03-22" area="BANK REC." feature="604"
    //     releaseversion="NAVUS3.70">Add the Bank Rec. &quot;Bank Rec. Adj. Doc. Nos.&quot; field to the Numbering tab.
    //     </change>
    // </changelog>
    layout
    {
        addafter("Local Cont. Addr. Format")
        {
            // field("Local ISO Code"; rec."Local ISO Code")
            // {
            // }
        }
        addafter("LCY Code")
        {
            //     field("LCY Symbol"; rec."LCY Symbol")
            //     {
            //     }
            //     field("LCY ISO Code"; rec."LCY ISO Code")
            //     {
            //     }
        }
    }


    //Unsupported feature: Property Modification (TextConstString) on "Text002(Variable 1002)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=If you delete the additional reporting currency, future general ledger entries are posted in $ only. Deleting the additional reporting currency does not affect already posted general ledger entries.\\Are you sure that you want to delete the additional reporting currency?;ESM=Si elimina la divisa adicional, los movimientos futuros se registrarán solo en la divisa local. Si elimina la divisa adicional, no se ven afectados los movimientos ya registrados.\\¿Está seguro de que desea eliminar la divisa adicional?;FRC=Si vous supprimez la devise de report additionnelle, les futures écritures sont reportées en $ uniquement. La suppression de la devise de report additionnelle n'a aucune incidence sur les écritures déjà reportées.\\Voulez-vous vraiment supprimer la devise de report additionnelle ?;ENC=If you delete the additional reporting currency, future general ledger entries are posted in $ only. Deleting the additional reporting currency does not affect already posted general ledger entries.\\Are you sure that you want to delete the additional reporting currency?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=If you delete the additional reporting currency, future general ledger entries are posted in LCY only. Deleting the additional reporting currency does not affect already posted general ledger entries.\\Are you sure that you want to delete the additional reporting currency?;ESM=Si elimina la divisa adicional, los movimientos futuros se registrarán solo en la divisa local. Si elimina la divisa adicional, no se ven afectados los movimientos ya registrados.\\¿Está seguro de que desea eliminar la divisa adicional?;FRC=Si vous supprimez la devise de report additionnelle, les futures écritures sont reportées en $ uniquement. La suppression de la devise de report additionnelle n'a aucune incidence sur les écritures déjà reportées.\\Voulez-vous vraiment supprimer la devise de report additionnelle ?;ENC=If you delete the additional reporting currency, future general ledger entries are posted in $ only. Deleting the additional reporting currency does not affect already posted general ledger entries.\\Are you sure that you want to delete the additional reporting currency?;
    //Variable type has not been exported.
}

