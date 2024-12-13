const cds = require('@sap/cds');
const { employees } = cds.entities("epm.db.master")


module.exports = (srv)=> {


srv.on("READ","ReadEmployeeSrv",async(req) =>{

// return{

//     "ID":"2222-22",
//     "NAME FIRST":"dudu"

// } 




// calling db and to get 5 record and change the value of name middle
const tx = await cds.tx(req);
var returndata = [];
var results = await tx.run(SELECT.from(employees).limit(5));
for (let i = 0; i < results.length; i++)
{
const element = results[i];
element.nameMiddle = 'hello'
returndata.push(element);
}
return returndata;





})};  