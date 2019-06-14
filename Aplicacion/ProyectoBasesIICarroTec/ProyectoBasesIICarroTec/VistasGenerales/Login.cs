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
    public partial class Login : Form
    {
        public Login()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {

            String usuario = textBox1.Text;
            String password = textBox2.Text;
            Console.WriteLine(usuario);
            if (usuario == "1") {
                DashboardCliente dashboardCliente = new DashboardCliente();
                this.Hide();

                dashboardCliente.Show();
            }
            if (usuario == "2") {
                DashbordAdmin dashboardAdmin = new DashbordAdmin();
                this.Hide();

            }
            if (usuario == "3") {

            }
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            RegistrarCliente reg = new RegistrarCliente();
            this.Hide();
            reg.Show();
        }
    }
}
