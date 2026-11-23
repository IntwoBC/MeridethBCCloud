xmlport 50097 "VARStreet Product Groups"
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
                XmlName = 'Product_Group';
                fieldelement(ICCode; "Item Category"."Parent Category")
                {
                }
                fieldelement(Code; "Item Category".Code)
                {
                }
                fieldelement(Desc; "Item Category".Description)
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

