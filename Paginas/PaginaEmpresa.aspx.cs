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
                lblContacto.Text = provedor[1];
                lblDireccion.Text = provedor[2];
                lblHorario.Text = provedor[3];
                lblNombreE.Text = provedor[4];
                lblUbicacion.Text = provedor[5];
            }
            else
            {
                lblContacto.Text = "Usuario no registrado";
                lblDireccion.Text = "Usuario no registrado";
                lblHorario.Text = "Usuario no registrado";
                lblNombreE.Text = "Usuario no registrado";
                lblUbicacion.Text = "Usuario no registrado";
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
                ddlCategoria.Text = categoria;
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            empresa.InsertProducto(Convert.ToInt32(Session["IdUsuario"]), txtNombre.Text, ddlCategoria.SelectedValue, Convert.ToDecimal(txtPrecio.Text), Convert.ToInt32(txtTiempo.Text));
            CargarProductos(Convert.ToInt32(Session["IdUsuario"]));
        }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            empresa.UpdateProducto(Convert.ToInt32(txtCodigo.Text), Convert.ToInt32(Session["IdUsuario"]), txtNombre.Text, ddlCategoria.SelectedValue, Convert.ToDecimal(txtPrecio.Text), Convert.ToInt32(txtTiempo.Text));
            CargarProductos(Convert.ToInt32(Session["IdUsuario"]));
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            empresa.DeleteProducto(Convert.ToInt32(txtCodigo.Text));
            CargarProductos(Convert.ToInt32(Session["IdUsuario"]));
        }
    }
}