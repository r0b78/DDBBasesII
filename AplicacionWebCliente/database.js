const sql = require('mssql/msnodesqlv8')
const connectionString = "server=DESKTOP-DOJPP4E;Database=Proyecto_BasesII;Trusted_Connection=Yes;Driver={SQL Server Native Client 11.0}"
var config = {
  driver: 'msnodesqlv8',
  connectionString: connectionString
};

const poolPromise = new sql.ConnectionPool(config)
  .connect()
  .then(pool => {
    console.log('Connected to MSSQL')
    return pool
  })
  .catch(err => console.log('Database Connection Failed! Bad Config: ', err))


module.exports = {
  sql, poolPromise
}
      