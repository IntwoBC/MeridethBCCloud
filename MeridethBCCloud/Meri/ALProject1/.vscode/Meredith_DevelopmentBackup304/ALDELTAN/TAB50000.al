table 50000 "Salesperson Goal"
{

    fields
    {
        field(1; "Salesperson Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser".Code;
        }
        field(2; Year; Integer)
        {
        }
        field(3; Month; Integer)
        {
        }
        field(4; Goal; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Salesperson Code", Year, Month)
        {
        }
    }

    fieldgroups
    {
    }
}

