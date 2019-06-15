namespace ProyectoBasesIICarroTec.VistasAdmin
{
    partial class DashboardAdminFabrica
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.seleccionarEmpleadoBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.proyecto_BasesIIDataSet = new ProyectoBasesIICarroTec.Proyecto_BasesIIDataSet();
            this.seleccionarVehiculoFabricaBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.seleccionarVehiculoFabricaTableAdapter = new ProyectoBasesIICarroTec.Proyecto_BasesIIDataSetTableAdapters.SeleccionarVehiculoFabricaTableAdapter();
            this.tableAdapterManager = new ProyectoBasesIICarroTec.Proyecto_BasesIIDataSetTableAdapters.TableAdapterManager();
            this.seleccionarEmpleadoTableAdapter = new ProyectoBasesIICarroTec.Proyecto_BasesIIDataSetTableAdapters.seleccionarEmpleadoTableAdapter();
            this.proyecto_BasesIIDataSet1 = new ProyectoBasesIICarroTec.Proyecto_BasesIIDataSet();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.dataGridView2 = new System.Windows.Forms.DataGridView();
            ((System.ComponentModel.ISupportInitialize)(this.seleccionarEmpleadoBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.proyecto_BasesIIDataSet)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.seleccionarVehiculoFabricaBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.proyecto_BasesIIDataSet1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView2)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(130, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(116, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Ver Empleados Fabrica";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(847, 9);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(110, 13);
            this.label2.TabIndex = 1;
            this.label2.Text = "Ver Vehiculos Fabrica";
            // 
            // seleccionarEmpleadoBindingSource
            // 
            this.seleccionarEmpleadoBindingSource.DataMember = "seleccionarEmpleado";
            this.seleccionarEmpleadoBindingSource.DataSource = this.proyecto_BasesIIDataSet;
            // 
            // proyecto_BasesIIDataSet
            // 
            this.proyecto_BasesIIDataSet.DataSetName = "Proyecto_BasesIIDataSet";
            this.proyecto_BasesIIDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // seleccionarVehiculoFabricaBindingSource
            // 
            this.seleccionarVehiculoFabricaBindingSource.DataMember = "SeleccionarVehiculoFabrica";
            this.seleccionarVehiculoFabricaBindingSource.DataSource = this.proyecto_BasesIIDataSet;
            // 
            // seleccionarVehiculoFabricaTableAdapter
            // 
            this.seleccionarVehiculoFabricaTableAdapter.ClearBeforeFill = true;
            // 
            // tableAdapterManager
            // 
            this.tableAdapterManager.BackupDataSetBeforeUpdate = false;
            this.tableAdapterManager.CaracteristicaTableAdapter = null;
            this.tableAdapterManager.CaracteristicaXVehiculoTableAdapter = null;
            this.tableAdapterManager.ClienteTableAdapter = null;
            this.tableAdapterManager.CombustibleTableAdapter = null;
            this.tableAdapterManager.ComisionTableAdapter = null;
            this.tableAdapterManager.Connection = null;
            this.tableAdapterManager.DescuentoTableAdapter = null;
            this.tableAdapterManager.DescuentoXDetalleFacturaTableAdapter = null;
            this.tableAdapterManager.DetalleFacturaTableAdapter = null;
            this.tableAdapterManager.EmpleadoTableAdapter = null;
            this.tableAdapterManager.EntregaTableAdapter = null;
            this.tableAdapterManager.ExtraTableAdapter = null;
            this.tableAdapterManager.ExtraXVehiculoTableAdapter = null;
            this.tableAdapterManager.FabricaTableAdapter = null;
            this.tableAdapterManager.FacturaTableAdapter = null;
            this.tableAdapterManager.FacturaXVehiculoTableAdapter = null;
            this.tableAdapterManager.FotoVehiculoTableAdapter = null;
            this.tableAdapterManager.ImpuestoTableAdapter = null;
            this.tableAdapterManager.ImpuestoXDetalleFacturaTableAdapter = null;
            this.tableAdapterManager.InventarioTableAdapter = null;
            this.tableAdapterManager.PedidoTableAdapter = null;
            this.tableAdapterManager.PedidoXVehiculoTableAdapter = null;
            this.tableAdapterManager.PuestoEmpleadoTableAdapter = null;
            this.tableAdapterManager.SucursalTableAdapter = null;
            this.tableAdapterManager.TipoModalidadTableAdapter = null;
            this.tableAdapterManager.TipoPagoTableAdapter = null;
            this.tableAdapterManager.TipoVehiculoTableAdapter = null;
            this.tableAdapterManager.UpdateOrder = ProyectoBasesIICarroTec.Proyecto_BasesIIDataSetTableAdapters.TableAdapterManager.UpdateOrderOption.InsertUpdateDelete;
            this.tableAdapterManager.UsuarioTableAdapter = null;
            this.tableAdapterManager.VehiculoFabricaTableAdapter = null;
            this.tableAdapterManager.VehiculoFabricaXEmpleadoTableAdapter = null;
            this.tableAdapterManager.VehiculoTableAdapter = null;
            this.tableAdapterManager.VehiculoXSucursalTableAdapter = null;
            // 
            // seleccionarEmpleadoTableAdapter
            // 
            this.seleccionarEmpleadoTableAdapter.ClearBeforeFill = true;
            // 
            // proyecto_BasesIIDataSet1
            // 
            this.proyecto_BasesIIDataSet1.DataSetName = "Proyecto_BasesIIDataSet";
            this.proyecto_BasesIIDataSet1.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // dataGridView1
            // 
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Location = new System.Drawing.Point(49, 56);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.Size = new System.Drawing.Size(411, 266);
            this.dataGridView1.TabIndex = 8;
            this.dataGridView1.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dataGridView1_CellContentClick);
            // 
            // dataGridView2
            // 
            this.dataGridView2.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView2.Location = new System.Drawing.Point(704, 56);
            this.dataGridView2.Name = "dataGridView2";
            this.dataGridView2.Size = new System.Drawing.Size(364, 273);
            this.dataGridView2.TabIndex = 9;
            this.dataGridView2.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dataGridView2_CellContentClick);
            // 
            // DashboardAdminFabrica
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1090, 458);
            this.Controls.Add(this.dataGridView2);
            this.Controls.Add(this.dataGridView1);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Name = "DashboardAdminFabrica";
            this.Text = "DashboardAdminFabrica";
            this.Load += new System.EventHandler(this.DashboardAdminFabrica_Load);
            ((System.ComponentModel.ISupportInitialize)(this.seleccionarEmpleadoBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.proyecto_BasesIIDataSet)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.seleccionarVehiculoFabricaBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.proyecto_BasesIIDataSet1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView2)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private Proyecto_BasesIIDataSet proyecto_BasesIIDataSet;
        private System.Windows.Forms.BindingSource seleccionarVehiculoFabricaBindingSource;
        private Proyecto_BasesIIDataSetTableAdapters.SeleccionarVehiculoFabricaTableAdapter seleccionarVehiculoFabricaTableAdapter;
        private Proyecto_BasesIIDataSetTableAdapters.TableAdapterManager tableAdapterManager;
        private System.Windows.Forms.BindingSource seleccionarEmpleadoBindingSource;
        private Proyecto_BasesIIDataSetTableAdapters.seleccionarEmpleadoTableAdapter seleccionarEmpleadoTableAdapter;
        private Proyecto_BasesIIDataSet proyecto_BasesIIDataSet1;
        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.DataGridView dataGridView2;
    }
}