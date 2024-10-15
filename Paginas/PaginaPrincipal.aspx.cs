using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocios;
using static System.Net.Mime.MediaTypeNames;

namespace Proyecto1AdminBD.Paginas
{
    public partial class PaginaPrincipal : System.Web.UI.Page
    {
        
        NegociosEmpresa empresa = new NegociosEmpresa();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        private void CargarProductos(string categoria)
        {
            List<List<string>> productos = empresa.ObtenerProductosLista(categoria);
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
                    Text = "Agregar",
                    CommandArgument = producto[0] + "," + Session["IdUsuario"],
                    CommandName = "AgregarCarrito"
                };
                accion.Controls.Add(btnAccion);
                row.Cells.Add(accion);

                ProductosTable.Rows.Add(row);
            }
        }

        protected void btnComida(object sender, EventArgs e)
        {
            CargarProductos("Comida");
        }

        protected void btnZapatos(object sender, EventArgs e)
        {
            CargarProductos("Zapatos");
        }

        protected void btnRopa(object sender, EventArgs e)
        {
            CargarProductos("Ropa");
        }

        protected void RowCommand(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "AgregarCarrito")
            {

                string[] data = e.CommandArgument.ToString().Split(','); 
                string idProducto = data[0];
                string Cedula = data[1]; 

                
                empresa.InsertCarrito(int.Parse(Cedula), int.Parse(idProducto));
            }
        }
    }
}