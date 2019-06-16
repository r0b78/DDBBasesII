const sql = require("msnodesqlv8");
 
const connectionString = "server=DESKTOP-DOJPP4E;Database=Proyecto_BasesII;Trusted_Connection=Yes;Driver={SQL Server Native Client 11.0}"

// "server=.;Database=Master;Trusted_Connection=Yes;Driver={SQL Server Native Client 11.0}";
exports.executeQeury = (query)=> {
  
  sql.query(connectionString, query, (err, rows) => {
  console.log(rows);
  });

}
