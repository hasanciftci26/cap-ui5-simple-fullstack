using {OnlineShopping as service} from '../../../srv/data-provider';

annotate service.Categories with @(UI: {
    SelectionFields: [
        ID,
        name
    ],
    LineItem       : [
        {
            $Type: 'UI.DataField',
            Value: ID
        },
        {
            $Type: 'UI.DataField',
            Value: name
        }
    ]
});

annotate service.Countries with @(UI: {
    SelectionFields: [
        code,
        country
    ],
    LineItem       : [
        {
            $Type: 'UI.DataField',
            Value: code
        },
        {
            $Type: 'UI.DataField',
            Value: country
        }
    ]
});

annotate service.Currencies with @(UI: {
    SelectionFields: [
        ID,
        description
    ],
    LineItem       : [
        {
            $Type: 'UI.DataField',
            Value: ID
        },
        {
            $Type: 'UI.DataField',
            Value: description
        }
    ]
});

annotate service.Customers with @(UI: {
    SelectionFields: [
        ID,
        name,
        country
    ],
    LineItem       : [
        {
            $Type: 'UI.DataField',
            Value: ID
        },
        {
            $Type: 'UI.DataField',
            Value: name
        },
        {
            $Type: 'UI.DataField',
            Value: country
        },
        {
            $Type: 'UI.DataField',
            Value: city
        }
    ]
});

annotate service.OrderHeaders with @(UI: {
    SelectionFields: [
        ID,
        customerID,
        date,
        paymentMethod,
        status
    ],
    LineItem       : [
        {
            $Type: 'UI.DataField',
            Value: ID
        },
        {
            $Type: 'UI.DataField',
            Value: customerID
        },
        {
            $Type: 'UI.DataField',
            Value: date
        },
        {
            $Type: 'UI.DataField',
            Value: paymentMethod
        },
        {
            $Type: 'UI.DataField',
            Value: totalPrice
        },
        {
            $Type: 'UI.DataField',
            Value: currency
        },
        {
            $Type: 'UI.DataField',
            Value: status
        },
        {
            $Type: 'UI.DataField',
            Value: shippingAddress
        }
    ]
});

annotate service.OrderItems with @(UI: {
    SelectionFields: [
        ID,
        productID,
        status
    ],
    LineItem       : [
        {
            $Type: 'UI.DataField',
            Value: ID
        },
        {
            $Type: 'UI.DataField',
            Value: itemNo
        },
        {
            $Type: 'UI.DataField',
            Value: productID
        },
        {
            $Type: 'UI.DataField',
            Value: quantity
        },
        {
            $Type: 'UI.DataField',
            Value: unitPrice
        },
        {
            $Type: 'UI.DataField',
            Value: totalPrice
        },
        {
            $Type: 'UI.DataField',
            Value: status
        }
    ]
});

annotate service.PaymentMethods with @(UI: {
    SelectionFields: [
        ID,
        description
    ],
    LineItem       : [
        {
            $Type: 'UI.DataField',
            Value: ID
        },
        {
            $Type: 'UI.DataField',
            Value: description
        }
    ]
});

annotate service.PaymentTerms with @(UI: {
    SelectionFields: [
        ID,
        description
    ],
    LineItem       : [
        {
            $Type: 'UI.DataField',
            Value: ID
        },
        {
            $Type: 'UI.DataField',
            Value: description
        }
    ]
});

annotate service.Products with @(UI: {
    SelectionFields: [
        ID,
        categoryID,
        supplierID,
        isActive,
        name,
        firstReleaseDate
    ],
    LineItem       : [
        {
            $Type: 'UI.DataField',
            Value: ID
        },
        {
            $Type: 'UI.DataField',
            Value: name
        },
        {
            $Type: 'UI.DataField',
            Value: brand
        },
        {
            $Type: 'UI.DataField',
            Value: categoryID
        },
        {
            $Type: 'UI.DataField',
            Value: supplierID
        },
        {
            $Type: 'UI.DataField',
            Value: price
        },
        {
            $Type: 'UI.DataField',
            Value: currency
        },
        {
            $Type: 'UI.DataField',
            Value: quantityInStock
        },
        {
            $Type: 'UI.DataField',
            Value: firstReleaseDate
        },
        {
            $Type: 'UI.DataField',
            Value: isActive
        }
    ]
});

annotate service.Suppliers with @(UI: {
    SelectionFields: [
        ID,
        country,
        companyName,
        contactName,
        contactTitle,
        paymentTerms
    ],
    LineItem       : [
        {
            $Type: 'UI.DataField',
            Value: ID
        },
        {
            $Type: 'UI.DataField',
            Value: companyName
        },
        {
            $Type: 'UI.DataField',
            Value: contactName
        },
        {
            $Type: 'UI.DataField',
            Value: contactTitle
        },
        {
            $Type: 'UI.DataField',
            Value: country
        },
        {
            $Type: 'UI.DataField',
            Value: city
        },
        {
            $Type: 'UI.DataField',
            Value: paymentTerms
        }
    ]
});
