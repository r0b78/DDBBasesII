using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace ProyectoBasesIICarroTec.VistasAdmin
{
    public partial class DashboardAdminFabrica : Form
    {
        public DashboardAdminFabrica()
        {
            InitializeComponent();
            LoadFormVehiculoFabrica();
            LoadEmpleadoFabrica();

        }

        private void button2_Click(object sender, EventArgs e)
        {

        }

        private void DashboardAdminFabrica_Load(object sender, EventArgs e)
        {

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void LoadFormVehiculoFabrica() {
            DataTable dt = new DataTable();
            ConexionBaseDeDatos conexion = new ConexionBaseDeDatos();

            SqlConnection myConn = conexion.GetConnection(); 
            myConn.Open();
            SqlCommand myCmd = new SqlCommand("SeleccionarVehiculoFabrica NULL, NULL, NULL, NULL, NULL", myConn);
      //      myCmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(myCmd);
            da.Fill(dt);
            dataGridView2.DataSource = dt;
           
        }
        private void LoadEmpleadoFabrica()
        {
            DataTable dt = new DataTable();
            ConexionBaseDeDatos conexion = new ConexionBaseDeDatos();

            SqlConnection myConn = conexion.GetConnection();
            myConn.Open();
            SqlCommand myCmd = new SqlCommand("SeleccionarEmpleado NULL, NULL, NULL, NULL, NULL,NULL,NULL,NULL", myConn);
            //      myCmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(myCmd);
            da.Fill(dt);
            dataGridView1.DataSource = dt;

        }

        private void dataGridView2_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
