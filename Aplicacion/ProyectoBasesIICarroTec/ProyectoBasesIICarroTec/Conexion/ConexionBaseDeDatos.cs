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

        public void OpenConection()
        {
            MessageBox.Show("Dot Net Perls is awesome.");
            con = new SqlConnection(ConnectionString);
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
