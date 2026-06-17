
using { com.epm as db } from '../db/schema';
@odata.draft.enabled
entity PurchaseOrders
    as projection on db.PurchaseOrders
    actions {
        action submit();
        action approve(comment : String);
        action reject(reason : String);
        action receive();
    };

service PurchasingService @(path : '/purchasing') {

    entity PurchaseOrders
        as projection on db.PurchaseOrders
        actions {

            action submit();

            action approve(
                comment : String
            );

            action reject(
                reason : String
            );

            action receive();

        };

    entity PurchaseOrderItems
        as projection on db.PurchaseOrderItems;

    @readonly
    entity Suppliers
        as projection on db.Suppliers;

    @readonly
    entity Products
        as projection on db.Products;

    entity Attachments
        as projection on db.Attachments;

}
