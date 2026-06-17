using PurchasingService from '../../srv/purchasing-service';

annotate PurchasingService.PurchaseOrders with @(


UI.HeaderInfo : {
    TypeName : 'Purchase Order',
    TypeNamePlural : 'Purchase Orders',
    Title : { Value : poNumber },
    Description : { Value : status }
},

UI.SelectionFields : [
    poNumber,
    status,
    priority,
    supplier_ID
],

UI.LineItem : [
    { Value : poNumber, Label : 'PO Number' },
    { Value : status, Label : 'Status', Criticality : statusCriticality },
    { Value : priority, Label : 'Priority' },
    { Value : totalAmount, Label : 'Amount' },
    { Value : orderDate, Label : 'Order Date' }
],

UI.FieldGroup #General : {
    Data : [
        { Value : poNumber, Label : 'PO Number' },
        { Value : supplier.name, Label : 'Supplier' },
        { Value : status, Label : 'Status' },
        { Value : priority, Label : 'Priority' },
        { Value : totalAmount, Label : 'Amount' },
        { Value : notes, Label : 'Notes' }
    ]
},

UI.Facets : [
    {
        $Type : 'UI.ReferenceFacet',
        Label : 'General Information',
        Target : '@UI.FieldGroup#General'
    },
    {
        $Type : 'UI.ReferenceFacet',
        Label : 'Line Items',
        Target : 'items/@UI.LineItem'
    }
],

UI.Identification : [
    {
        $Type : 'UI.DataFieldForAction',
        Action : 'PurchasingService.submit',
        Label : 'Submit'
    },
    {
        $Type : 'UI.DataFieldForAction',
        Action : 'PurchasingService.approve',
        Label : 'Approve'
    },
    {
        $Type : 'UI.DataFieldForAction',
        Action : 'PurchasingService.reject',
        Label : 'Reject'
    },
    {
        $Type : 'UI.DataFieldForAction',
        Action : 'PurchasingService.receive',
        Label : 'Receive'
    }
]


);

annotate PurchasingService.PurchaseOrders with {


supplier @Common.ValueList : {
    CollectionPath : 'Suppliers',
    Parameters : [
        {
            $Type : 'Common.ValueListParameterInOut',
            LocalDataProperty : supplier_ID,
            ValueListProperty : 'ID'
        },
        {
            $Type : 'Common.ValueListParameterDisplayOnly',
            ValueListProperty : 'name'
        }
    ]
};

poNumber @Common.FieldControl : poNumberEditable;
supplier @Common.FieldControl : supplierEditable;

};

annotate PurchasingService.PurchaseOrderItems with @(


UI.HeaderInfo : {
    TypeName : 'Purchase Order Item',
    TypeNamePlural : 'Purchase Order Items',
    Title : {
        Value : product.name
    }
},

UI.LineItem : [
    {
        Value : product.name,
        Label : 'Product'
    },
    {
        Value : quantity,
        Label : 'Quantity'
    },
    {
        Value : unitPrice,
        Label : 'Unit Price'
    },
    {
        Value : totalPrice,
        Label : 'Total Price'
    }
],

UI.FieldGroup #General : {
    Data : [
        {
            Value : product.name,
            Label : 'Product'
        },
        {
            Value : quantity,
            Label : 'Quantity'
        },
        {
            Value : unitPrice,
            Label : 'Unit Price'
        },
        {
            Value : totalPrice,
            Label : 'Total Price'
        },
        {
            Value : receivedQty,
            Label : 'Received Quantity'
        },
        {
            Value : notes,
            Label : 'Notes'
        }
    ]
},

UI.Facets : [
    {
        $Type : 'UI.ReferenceFacet',
        Label : 'General Information',
        Target : '@UI.FieldGroup#General'
    }
]


);

annotate PurchasingService.PurchaseOrderItems with {


product @Common.ValueList : {
    CollectionPath : 'Products',
    Parameters : [
        {
            $Type : 'Common.ValueListParameterInOut',
            LocalDataProperty : product_ID,
            ValueListProperty : 'ID'
        },
        {
            $Type : 'Common.ValueListParameterDisplayOnly',
            ValueListProperty : 'name'
        }
    ]
};

};
