using Negocios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Proyecto1AdminBD.Paginas
{
    public partial class PaginaCarrito : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarCarrito();
            }
        }

        private void CargarCarrito()
        {
            List<CarritoItem> carrito = Session["Carrito"] as List<CarritoItem> ?? new List<CarritoItem>();

            if (carrito.Any())
            {
                NegociosCompra compraNegocios = new NegociosCompra();
                carrito = compraNegocios.CalcularTotalesCarrito(carrito);
                Session["Carrito"] = carrito; // Actualizar la sesión con los valores calculados

                gvCarrito.DataSource = carrito;
                gvCarrito.DataBind();
            }
            else
            {
                gvCarrito.DataSource = null;
                gvCarrito.DataBind();
            }
        }

        protected void btnFinalizarCompra_Click(object sender, EventArgs e)
        {
            int idCliente = Convert.ToInt32(Session["IdUsuario"]);
            List<CarritoItem> carrito = Session["Carrito"] as List<CarritoItem>;

            if (carrito == null || !carrito.Any())
            {
                lblMensajeCompra.Text = "El carrito está vacío.";
                return;
            }

            NegociosCompra compraNegocios = new NegociosCompra();
            lblMensajeCompra.Text = "";

            foreach (var item in carrito)
            {
                string mensaje = compraNegocios.RealizarCompra(idCliente, item.IdProducto, item.Cantidad);
                lblMensajeCompra.Text += $"{item.Nombre}: {mensaje}<br />";
            }

            Session["Carrito"] = null; // Vaciar el carrito después de la compra
        }

        protected void gvCarrito_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                List<CarritoItem> carrito = Session["Carrito"] as List<CarritoItem> ?? new List<CarritoItem>();

                decimal totalGeneral = carrito.Sum(item => item.Total);

                e.Row.Cells[4].Text = "Total a Pagar:";
                e.Row.Cells[4].HorizontalAlign = HorizontalAlign.Right;
                e.Row.Cells[5].Text = totalGeneral.ToString("C");
                e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Right;
                e.Row.Font.Bold = true;
            }
        }

    }
}