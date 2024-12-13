namespace  epmview.cds;

using { epm.db.master , epm.db.transaction } from '../db/data-modle';


context CDSViews {


define view![POWorklist] as

select from transaction.purchaseorder{  
    key PO_ID as![PurchaseOrderNo],
    key Items.PO_ITEM_POS as ![Position],
        PARTNER_GUID.BP_ID as ![VendorId],
        PARTNER_GUID.COMPANY_NAME as![CompanyName],
        Items.GROSS_AMOUNT as ![GrossAmount],
        Items.NET_AMOUNT as![NetAmount],
        Items.TAX_AMOUNT as![TaxAmount],
        case OVERALL_STATUS
        when 'N' then 'new'
        when 'D' then 'Delivered'
        when 'P' then 'Pending '
        when 'A' then 'Approved'
        when 'X' then 'Rejected'
        end as ![status],
        Items.PRODUCT_GUID.DESCRIPTION as![Product],
        PARTNER_GUID.ADDRESS_GUID.COUNTRY as![Country]
};
define view![ProductVH] as
    select from master.product{
        @EndUserTExt.label:[
            
            {
           language:'EN',
           text:'product Id'
        },
                    {
           language:'DE',
           text:'prodekt Id'
        },
        ]
PRODUCT_ID as![ProductId],
        @EndUserTExt.label:[ 
            {
           language:'EN',
           text:'product Name'
        },
                    {
           language:'DE',
           text:'prodekt Name'
        },
        ]

DESCRIPTION AS![ProductName]

    }
    define view![ItemView] as
select from transaction.poitems{
    PARENT_KEY.PARTNER_GUID.NODE_KEY AS![VendorId],
    PRODUCT_GUID.NODE_KEY as![ProductId],
    CURRENCY as![Currency],
    GROSS_AMOUNT as![GrossAmount],
    NET_AMOUNT as![NetAmount],
    TAX_AMOUNT as![TaxAmount],
    PARENT_KEY.OVERALL_STATUS as![status]
};


define view productOrders as select from master.product
    mixin{
        PO_ORDERS: Association[*] to ItemView on PO_ORDERS.ProductId = $projection.ProductKey
    } into
    {
    NODE_KEY as![ProductKey],
    DESCRIPTION as![ProductName],
    PRICE as![Price],
    SUPPLIER_GUID.BP_ID as![SupplierId],
    SUPPLIER_GUID.COMPANY_NAME as![SupplierName],
    PO_ORDERS as![ProductOrders]

}



};















