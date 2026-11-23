xmlport 50099 VARStreet
{
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Item Category"; "Item Category")
            {
                XmlName = 'Item_Category';
                fieldelement(Code; "Item Category".Code)
                {
                }
                fieldelement(Description; "Item Category".Description)
                {
                }
                fieldelement(BurdenRate; "Item Category"."Burden Rate")
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
}

