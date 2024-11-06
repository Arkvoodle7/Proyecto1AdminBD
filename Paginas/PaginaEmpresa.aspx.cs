using Negocios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
            CargaEmpresa();
            CargarProductos(Convert.ToInt32(Session["IdUsuario"]));
        }

        private void CargarProductos(int cedula)
        {
            List<List<string>> productos = empresa.ObtenerProductosProvedor(cedula);
            LlenarTabla(productos);
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


        private void LlenarTabla(List<List<string>> productos)
        {
            foreach (var producto in productos)
            {
                var row = new System.Web.UI.HtmlControls.HtmlTableRow();
                for (int i = 0; i < producto.Count; i++)
                {
                    var fila = new System.Web.UI.HtmlControls.HtmlTableCell();
                    fila.InnerText = producto[i];
                    row.Cells.Add(fila);
                }

                var accion = new System.Web.UI.HtmlControls.HtmlTableCell();


                LinkButton btnAccion = new LinkButton
                {
                    Text = "Seleccionar",
                    CommandArgument = producto[0] + ","+ producto[1] + "," + producto[3] + "," + producto[4] + "," + producto[5],
                    CommandName = "SelecionarProducto"
                };
                accion.Controls.Add(btnAccion);
                row.Cells.Add(accion);

                ProductosTable.Rows.Add(row);
            }
        }


        protected void RowCommand(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "SelecionarProducto")
            {
                string[] data = e.CommandArgument.ToString().Split(',');
                if (data.Length == 6)
                {
                    string idProducto = data[0];
                    string provedor = data[1];
                    string producto = data[2];
                    string categoria = data[3];
                    string precio = data[4];
                    string tiempo = data[5];

                    txtCodigo.Text = idProducto;
                    txtNombre.Text = producto;
                    txtPrecio.Text = precio;
                    txtTiempo.Text = tiempo;
                    ddlCategoria.SelectedValue = categoria;

                    btnEliminar.Visible = true;
                    btnEliminar.Visible = true;
                }
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            empresa.InsertProducto(Convert.ToInt32(Session["IdUsuario"]), txtNombre.Text, ddlCategoria.SelectedValue, Convert.ToDecimal(txtPrecio.Text), Convert.ToInt32(txtTiempo.Text));
            txtCodigo.Text = string.Empty;
            txtNombre.Text = string.Empty;
            txtPrecio.Text = string.Empty;
            txtTiempo.Text = string.Empty;
            Recarga();
        }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            empresa.UpdateProducto(Convert.ToInt32(txtCodigo.Text), Convert.ToInt32(Session["IdUsuario"]), txtNombre.Text, ddlCategoria.SelectedValue, Convert.ToDecimal(txtPrecio.Text), Convert.ToInt32(txtTiempo.Text));
            btnEliminar.Visible = false;
            btnEliminar.Visible = false;
            Recarga();
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            empresa.DeleteProducto(Convert.ToInt32(txtCodigo.Text));
            btnEliminar.Visible = false;
            btnEliminar.Visible = false;
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