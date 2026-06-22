using { com.epm as db } from '../db/schema';

service PurchasingService
@(path : '/purchasing')
@(requires : 'authenticated-user')
{

    @odata.draft.enabled
    entity PurchaseOrders
    @(restrict: [
        { grant: 'READ', to: 'Viewer' },
        { grant: ['READ','WRITE'], to: 'PurchaseManager' },
        { grant: '*', to: 'Administrator' }
    ])
    as projection on db.PurchaseOrders
    actions {

        @requires: 'PurchaseManager'
        action submit();

        @requires: 'PurchaseManager'
        action approve(
            comment : String
        );

        @requires: 'PurchaseManager'
        action reject(
            reason : String
        );

        @requires: 'PurchaseManager'
        action receive();

    };

    entity PurchaseOrderItems
    @(restrict: [
        { grant: 'READ', to: 'Viewer' },
        { grant: ['READ','WRITE'], to: 'PurchaseManager' },
        { grant: '*', to: 'Administrator' }
    ])
    as projection on db.PurchaseOrderItems;

    @readonly
    entity Suppliers
    @(restrict: [
        { grant: 'READ', to: 'Viewer' },
        { grant: 'READ', to: 'PurchaseManager' },
        { grant: '*', to: 'Administrator' }
    ])
    as projection on db.Suppliers;

    @readonly
    entity Products
    @(restrict: [
        { grant: 'READ', to: 'Viewer' },
        { grant: 'READ', to: 'PurchaseManager' },
        { grant: '*', to: 'Administrator' }
    ])
    as projection on db.Products;

    entity Attachments
    @(restrict: [
        { grant: 'READ', to: 'Viewer' },
        { grant: ['READ','WRITE'], to: 'PurchaseManager' },
        { grant: '*', to: 'Administrator' }
    ])
    as projection on db.Attachments;

}