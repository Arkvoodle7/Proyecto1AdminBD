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
            CargarProductos(Convert.ToInt32(Session["IdUsuario"]));
        }

        private void CargarProductos(int cedula)
        {
            List<List<string>> productos = empresa.ObtenerProductosProvedor(cedula);
            LlenarTabla(productos);
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
    }
}