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
                    CommandArgument = producto[0],
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
                string Cedula = data[1];


                empresa.InsertCarrito(int.Parse(Cedula), int.Parse(idProducto));
            }
        }
    }
}