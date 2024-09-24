using {
    Products       as DBProducts,
    Categories     as DBCategories,
    Countries      as DBCountries,
    Currencies     as DBCurrencies,
    Customers      as DBCustomers,
    OrderHeaders   as DBOrderHeaders,
    OrderItems     as DBOrderItems,
    PaymentMethods as DBPaymentMethods,
    PaymentTerms   as DBPaymentTerms,
    Suppliers      as DBSuppliers
} from '../db/data-models';

service OnlineShopping {
    entity Products       as select from DBProducts;
    entity Categories     as select from DBCategories;
    entity Countries      as select from DBCountries;
    entity Currencies     as select from DBCurrencies;

    entity Customers @(restrict: [
        {
            grant: 'READ',
            to   : 'Manager',
            where: 'country = $user.country'
        },
        {
            grant: [
                'CREATE',
                'UPDATE',
                'DELETE'
            ],
            to   : 'Manager'
        },
        {
            grant: '*',
            to   : 'Administrator'
        }
    ])                    as select from DBCustomers;

    entity OrderHeaders   as select from DBOrderHeaders;
    entity OrderItems     as select from DBOrderItems;
    entity PaymentMethods as select from DBPaymentMethods;
    entity PaymentTerms   as select from DBPaymentTerms;
    entity Suppliers      as select from DBSuppliers;
};
