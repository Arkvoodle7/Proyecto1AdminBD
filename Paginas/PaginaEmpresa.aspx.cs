using Negocios;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static Negocios.NegociosEmpresa;

namespace Proyecto1AdminBD.Paginas
{
    public partial class PaginaEmpresa : System.Web.UI.Page
    {

        NegociosEmpresa empresa = new NegociosEmpresa();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargaEmpresa();
                CargarProductos(Convert.ToInt32(Session["IdUsuario"]));
            }
        }

        private void Recarga()
        {
            CargarProductos(Convert.ToInt32(Session["IdUsuario"]));
        }


        private void CargarProductos(int idProveedor)
        {
            List<ProductosNego> productos = empresa.ObtenerProductosProvedor(idProveedor);

            ProductosGridView.DataSource = productos;
            ProductosGridView.DataBind();
        }

        private void CargaEmpresa()
        {
            if (Session["IdUsuario"] != null)
            {
                List<string> provedor = empresa.ObtenerProvedor((Convert.ToInt32(Session["IdUsuario"])));
                txtContacto.Text = provedor[1];
                txtDireccion.Text = provedor[2];
                txtHorario.Text = provedor[3];
                txtEmpresa.Text = provedor[4];
            }
            else
            {
                txtCodigo.Text = "Usuario no registrado";
                txtContacto.Text = "Usuario no registrado";
                txtHorario.Text = "Usuario no registrado";
                txtEmpresa.Text = "Usuario no registrado";
            }

        }


        protected void ProductosGridView_SelectedIndexChanged(object sender, EventArgs e)
        {

            GridViewRow row = ProductosGridView.SelectedRow;
            int idProducto = Convert.ToInt32(row.Cells[1].Text); 
            string nombre = row.Cells[2].Text; 
            string categoria = row.Cells[3].Text;

            decimal precio = Convert.ToDecimal(row.Cells[4].Text);



            string tiempoEntregaTexto = row.Cells[5].Text.Trim();
            tiempoEntregaTexto = tiempoEntregaTexto.Replace("d&#237;as", "").Trim();
            int tiempoEntrega = Convert.ToInt32(tiempoEntregaTexto);

            int stock = Convert.ToInt32(row.Cells[6].Text); 


            txtCodigo.Text = idProducto.ToString();
            txtNombre.Text = nombre;
            ddlCategoria.SelectedValue = categoria; 
            txtPrecio.Text = precio.ToString();
            txtTiempo.Text = tiempoEntrega.ToString();
            txtstock.Text = stock.ToString();
            btnActualizar.Visible = true;
            btnEliminar.Visible = true;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            empresa.InsertProducto(Convert.ToInt32(Session["IdUsuario"]), txtNombre.Text, ddlCategoria.SelectedValue, Convert.ToDecimal(txtPrecio.Text), Convert.ToInt32(txtTiempo.Text), Convert.ToDecimal(txtstock.Text));
            txtCodigo.Text = string.Empty;
            txtNombre.Text = string.Empty;
            txtPrecio.Text = string.Empty;
            txtTiempo.Text = string.Empty;
            Recarga();
        }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            empresa.UpdateProducto(Convert.ToInt32(txtCodigo.Text), Convert.ToInt32(Session["IdUsuario"]), txtNombre.Text, ddlCategoria.SelectedValue, Convert.ToDecimal(txtPrecio.Text), Convert.ToInt32(txtTiempo.Text),Convert.ToDecimal(txtstock.Text));
            btnEliminar.Visible = false;
            btnActualizar.Visible = false;
            txtCodigo.Text = string.Empty;
            txtNombre.Text = string.Empty;
            txtPrecio.Text = string.Empty;
            txtTiempo.Text = string.Empty;
            txtstock.Text = string.Empty;
            Recarga();
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            empresa.DeleteProducto(Convert.ToInt32(txtCodigo.Text));
            btnEliminar.Visible = false;
            btnActualizar.Visible = false;
            Recarga();
        }

        protected void btnActualizaV_Click(object sender, EventArgs e)
        {
            int idP = Convert.ToInt32(Session["IdUsuario"]);
            string nombreEmpresa = txtNombre.Text;
            string dire = txtDireccion.Text;
            string conta = txtContacto.Text;
            string horar = txtHorario.Text;
            string ubi = txtUbicacion.Text;


            empresa.UpdateProvedor(idP, nombreEmpresa, dire, conta, horar, ubi);
            Recarga();
        }
    }
}