using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ProyectoBasesIICarroTec
{
    public partial class DashbordAdmin : Form
    {
        public DashbordAdmin()
        {
            InitializeComponent();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
           
            CrearVehiculo cV = new CrearVehiculo();
            cV.Show();
        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void button5_Click(object sender, EventArgs e)
        {
            VistasAdmin.CrearEmpleado emp = new VistasAdmin.CrearEmpleado();
            emp.Show();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            ModificarVehiculo moV = new ModificarVehiculo();
            moV.Show();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            VistasAdmin.ReporteVentas rep = new VistasAdmin.ReporteVentas();
            rep.Show();
            VistasAdmin.ReporteVentasxTipoPago rep2 = new VistasAdmin.ReporteVentasxTipoPago();
            rep.Show();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            
        }
    }
}
