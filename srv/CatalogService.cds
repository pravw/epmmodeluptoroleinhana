using { epm.db.master, epm.db.transaction } from '../db/data-modle';

service CatalogService @(path:'catalogService'){

    entity BusinessPartnerSet as projection on master.businesspartner;
    entity AddressSet as projection on master.address;
    entity EmployeeSet as projection on master.employees;
    entity ProductSet as projection on master.product;
    entity POs @(

        odata.draft.enabled:true
    )as projection on transaction.purchaseorder{
         *,
  case OVERALL_STATUS
     when 'N'then 'New'
     when 'P'then 'Pending'
     when 'X'then 'Rejected'
     when 'A'then 'Approved'
     when 'D'then 'Delivered' end as OverallStatus :String(10),
     case  OVERALL_STATUS
when 'N'then 0
when 'P'then 3
when 'X'then 1
when 'A'then 3
when 'D'then 3 end as colorCoding: Integer,Items
    }
    actions{
        @cds.odata.bindingparameter.name:'_varibe'
        @Common.SideEffects:{
            TargetProperties:['_varibe/GROSS_AMOUNT']
        }
    action boost() returns  POs;
     function largestOrder() returns POs;

    };
    entity POItems as projection on transaction.poitems;
};