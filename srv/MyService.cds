using{epmview.cds} from '../db/CDSView';
using {epm.db.master} from '../db/data-modle';


service MyService@(path:'MyService') {

entity productOrdersSet as projection on cds.CDSViews.productOrders;
entity ReadEmployeeSrv as projection on master.employees;
}