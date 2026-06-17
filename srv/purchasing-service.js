
const cds = require('@sap/cds');

module.exports = srv => {

    console.log('purchasing-service.js loaded');


    // =====================================================
    // SUBMIT PO
    // =====================================================

    srv.on('submit', 'PurchaseOrders', async (req) => {

        const { ID } = req.params[0];

        await UPDATE('com.epm.PurchaseOrders')
            .set({
                status: 'OPEN',
                statusCriticality: 2
            })
            .where({ ID });



        console.log('\n📋 PO Submitted\n');

        await UPDATE('com.epm.PurchaseOrders')
        .set({
            status: 'Submitted',
            poNumberEditable: 1,
            supplierEditable: 1
            })
            .where({ ID });

        return {
            status: 'OPEN',
            message: 'PO submitted successfully'
        };

    });


    // =====================================================
    // APPROVE PO
    // =====================================================

    srv.on('approve', 'PurchaseOrders', async (req) => {

        const { ID } = req.params[0];

        await UPDATE('com.epm.PurchaseOrders')
            .set({
                status: 'APPROVED',
                statusCriticality: 3
            })
            .where({ ID });

        console.log('\n✅ PO Approved\n');

        return {
            status: 'APPROVED',
            message: 'PO approved successfully'
        };

    });


    // =====================================================
    // REJECT PO
    // =====================================================

    srv.on('reject', 'PurchaseOrders', async (req) => {

        const { ID } = req.params[0];
        const { reason } = req.data;

        await UPDATE('com.epm.PurchaseOrders')
            .set({
                status: 'REJECTED',
                statusCriticality: 1
            })
            .where({ ID });

        console.log('\n❌ PO Rejected\n');

        return {
            status: 'REJECTED',
            message: `PO rejected: ${reason}`
        };

    });


    // =====================================================
    // RECEIVE PO
    // =====================================================

    srv.on('receive', 'PurchaseOrders', async (req) => {

        const { ID } = req.params[0];

        await UPDATE('com.epm.PurchaseOrders')
            .set({
                status: 'CLOSED',
                statusCriticality: 3
            })
            .where({ ID });

        console.log('\n📦 PO Received\n');

        return {
            status: 'CLOSED',
            message: 'PO received successfully'
        };

    });


    // =====================================================
    // GET SUMMARY
    // =====================================================

    srv.on('getSummary', 'PurchaseOrders', async (req) => {

        const { ID } = req.params[0];

        const po = await SELECT.one
            .from('com.epm.PurchaseOrders')
            .where({ ID });

        return {
            poNumber: po.poNumber,
            status: po.status,
            totalAmount: po.totalAmount
        };

    });


    // =====================================================
    // DASHBOARD
    // =====================================================

    srv.on('getPurchasingDashboard', async () => {

        const pos = await SELECT.from('com.epm.PurchaseOrders');

        return {
            totalPOs: pos.length
        };

    });


    // =====================================================
    // CONFIRM
    // =====================================================

    srv.on('confirm', async () => {

        return 'Confirmed Successfully';

    });

};
