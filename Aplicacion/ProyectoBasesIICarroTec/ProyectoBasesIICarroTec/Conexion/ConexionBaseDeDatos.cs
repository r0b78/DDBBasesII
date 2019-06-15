using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ProyectoBasesIICarroTec
{

    class ConexionBaseDeDatos
    {
        private string ConnectionString = "Data Source=DESKTOP-DOJPP4E;Initial Catalog=Proyecto_BasesII;Integrated Security=True";
        SqlConnection con;
        public ConexionBaseDeDatos() {
            con = new SqlConnection(ConnectionString);
        }
        public void OpenConection()
        {
            con.Open();
        }
        public void CloseConnection()
        {
            con.Close();
        }
        public void ExecuteQuery(string Query_)
        {
            SqlCommand cmd = new SqlCommand(Query_, con);
            cmd.ExecuteNonQuery();
        }

        public SqlConnection GetConnection()
        {
            return this.con;
        }
    }
}
