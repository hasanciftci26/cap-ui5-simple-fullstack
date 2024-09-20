entity Products {
    key ID               : UUID                                    @Common.Label: 'Product ID';
        name             : String(50)                              @Common.Label: 'Product Name';
        description      : String(255)                             @Common.Label: 'Product Description';
        brand            : String(50)                              @Common.Label: 'Brand';
        price            : Decimal(13, 2) not null                 @Common.Label: 'Price';
        currency         : Currencies:ID not null                  @Common.Label: 'Currency';
        quantityInStock  : Integer                                 @Common.Label: 'Quantity In Stock';
        categoryID       : Categories:ID not null                  @Common.Label: 'Category ID';
        supplierID       : Suppliers:ID not null                   @Common.Label: 'Supplier ID';
        firstReleaseDate : Date                                    @Common.Label: 'First Release Date';
        isActive         : Boolean                                 @Common.Label: 'Active Product';
        toCategory       : Association to one Categories
                               on toCategory.ID = $self.categoryID @Common.Label: 'To Category Navigation';
        toSupplier       : Association to one Suppliers
                               on toSupplier.ID = $self.supplierID @Common.Label: 'To Supplier Navigation';
        toCurrency       : Association to one Currencies
                               on toCurrency.ID = $self.currency   @Common.Label: 'To Currency Navigation';
};

entity Categories {
    key ID         : UUID                                 @Common.Label: 'Category ID';
        name       : String(50) not null                  @Common.Label: 'Category Name';
        toProducts : Association to many Products
                         on toProducts.toCategory = $self @Common.Label: 'To Products Navigation';
};

entity Suppliers {
    key ID             : UUID                                          @Common.Label: 'Supplier ID';
        companyName    : String(100) not null                          @Common.Label: 'Company Name';
        contactName    : String(100)                                   @Common.Label: 'Contact Name';
        contactTitle   : String(100)                                   @Common.Label: 'Contact Title';
        country        : Countries:code                                @Common.Label: 'Country';
        city           : String(80)                                    @Common.Label: 'City';
        paymentTerms   : PaymentTerms:ID                               @Common.Label: 'Payment Terms';
        toProducts     : Association to many Products
                             on toProducts.toSupplier = $self          @Common.Label: 'To Products Navigation';
        toCountry      : Association to one Countries
                             on toCountry.code = $self.country         @Common.Label: 'To Country Navigation';
        toPaymentTerms : Association to one PaymentTerms
                             on toPaymentTerms.ID = $self.paymentTerms @Common.Label: 'To Payment Terms Navigation';
};

entity Customers {
    key ID        : String(10)                            @Common.Label: 'Customer ID';
        name      : String(100) not null                  @Common.Label: 'Customer Name';
        country   : Countries:code                        @Common.Label: 'Country';
        city      : String(80)                            @Common.Label: 'City';
        toOrders  : Association to many OrderHeaders
                        on toOrders.toCustomer = $self    @Common.Label: 'To Orders Navigation';
        toCountry : Association to one Countries
                        on toCountry.code = $self.country @Common.Label: 'To Country Navigation';
};

entity OrderHeaders {
    key ID              : String(10)                                      @Common.Label: 'Order ID';
        customerID      : Customers:ID not null                           @Common.Label: 'Customer ID';
        date            : DateTime                                        @Common.Label: 'Order Date';

        @Common.Label: 'Order Status'
        status          : String(10) enum {
            PENDING    = 'Pending';
            PROCESSING = 'Processing';
            SHIPPED    = 'Shipped';
            DELIVERED  = 'Delivered';
        } not null;
        totalPrice      : Decimal(13, 2)                                  @Common.Label: 'Total Price';
        currency        : Currencies:ID                                   @Common.Label: 'Currency';
        paymentMethod   : PaymentMethods:ID                               @Common.Label: 'Payment Method';
        shippingAddress : String(255)                                     @Common.Label: 'Shipping Address';
        billingAddress  : String(255)                                     @Common.Label: 'Billing Address';
        toItems         : Composition of many OrderItems
                              on toItems.toHeader = $self                 @Common.Label: 'To Order Items Navigation';
        toCustomer      : Association to one Customers
                              on toCustomer.ID = $self.customerID         @Common.Label: 'To Customer Navigation';
        toPaymentMethod : Association to one PaymentMethods
                              on toPaymentMethod.ID = $self.paymentMethod @Common.Label: 'To Payment Method Navigation';
        toCurrency      : Association to one Currencies
                              on toCurrency.ID = $self.currency           @Common.Label: 'To Currency Navigation';
};

entity OrderItems {
    key ID         : OrderHeaders:ID                       @Common.Label: 'Order ID';
    key itemNo     : Integer                               @Common.Label: 'Item No';
        productID  : Products:ID not null                  @Common.Label: 'Product ID';
        quantity   : Integer                               @Common.Label: 'Quantity';
        unitPrice  : Products:price                        @Common.Label: 'Unit Price';
        totalPrice : Decimal(13, 2)                        @Common.Label: 'Total Price';

        @Common.Label: 'Order Status'
        status     : String(10) enum {
            PENDING    = 'Pending';
            PROCESSING = 'Processing';
            SHIPPED    = 'Shipped';
            DELIVERED  = 'Delivered';
        } not null;
        toHeader   : Association to one OrderHeaders
                         on toHeader.ID = $self.ID         @Common.Label: 'To Order Header Navigation';
        toProduct  : Association to one Products
                         on toProduct.ID = $self.productID @Common.Label: 'To Product Navigation';
};

entity Countries {
    key code    : String(3)   @Common.Label: 'Country Code';
        country : String(100) @Common.Label: 'Country';
};

entity Currencies {
    key ID          : String(5)  @Common.Label: 'Currency ID';
        description : String(50) @Common.Label: 'Currency';
};

entity PaymentMethods {
    key ID          : String(10)  @Common.Label: 'Payment Method ID';
        description : String(100) @Common.Label: 'Payment Method Description';
};

entity PaymentTerms {
    key ID          : String(20)  @Common.Label: 'Payment Terms ID';
        description : String(100) @Common.Label: 'Payment Terms Description';
};
