namespace com.epm;

using {
    cuid,
    managed,
    Currency,
    Country
} from '@sap/cds/common';

entity Suppliers : cuid {

    name      : String(100);
    contact   : String(100);
    email     : String(100);
    phone     : String(20);
    city      : String(50);
    country   : Country;
    isActive  : Boolean;
}

entity Categories : cuid {

    name        : String(100);
    description : String(255);
}

entity Products : cuid, managed {

    name        : String(100);
    description : String(255);
    price       : Decimal(15,2);
    stock       : Integer;
    minStock    : Integer;

    supplier    : Association to Suppliers;
    category    : Association to Categories;
}

entity Customers : cuid, managed {

    name     : String(100);
    email    : String(100);
    phone    : String(20);
    city     : String(50);
    country  : Country;
}

type Status : String enum {

    OPEN      = 'OPEN';
    APPROVED  = 'APPROVED';
    REJECTED  = 'REJECTED';
    CLOSED    = 'CLOSED';
}

type Priority : String enum {

    HIGH      = 'HIGH';
    MEDIUM    = 'MEDIUM';
    LOW       = 'LOW';
}

entity PurchaseOrders : cuid, managed {

    poNumber      : String(20);

    supplier      : Association to Suppliers;

    orderDate     : Date;

    expectedDate  : Date;

    totalAmount   : Decimal(15,2);

    currency      : Currency;

    status        : Status;

    priority      : Priority;

    rating        : Decimal(3,1);
    confirmed        : Boolean;

    completion    : Integer;

    poNumberEditable : Integer default 3;
    supplierEditable : Integer default 3;

    statusCriticality : Integer;

    notes         : String(500);

    items : Composition of many PurchaseOrderItems
        on items.order = $self;

    attachments : Composition of many Attachments
        on attachments.purchaseOrder = $self;
}

entity PurchaseOrderItems : cuid {

    order         : Association to PurchaseOrders;

    product       : Association to Products;

    quantity      : Integer;

    unitPrice     : Decimal(15,2);

    totalPrice    : Decimal(15,2);

    receivedQty   : Integer;

    notes         : String(255);
}

entity Attachments : cuid, managed {

    fileName      : String(255);

    mediaType     : String(100);

    url           : String(500);

    purchaseOrder : Association to PurchaseOrders;
}