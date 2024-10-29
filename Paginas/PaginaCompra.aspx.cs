using System;
using Negocios;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace Proyecto1AdminBD.Paginas
{
    public partial class PaginaCompra : System.Web.UI.Page
    {
        NegociosCompra compraNegocios = new NegociosCompra();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                if (Request.QueryString["productoId"] != null)
                {
                    int productoId = Convert.ToInt32(Request.QueryString["productoId"]);
                    CargarDetallesProducto(productoId);
                }
                else
                {
                    lblMensajeCompra.Text = "No se ha seleccionado un producto.";
                }
            }
        }

        protected void btnAgregarAlCarrito_Click(object sender, EventArgs e)
        {
            if (int.TryParse(txtCantidad.Text, out int cantidad) && cantidad > 0)
            {
                int idProducto = Convert.ToInt32(Request.QueryString["productoId"]);
                Producto producto = compraNegocios.ObtenerProductoPorId(idProducto);

                List<CarritoItem> carrito = Session["Carrito"] as List<CarritoItem> ?? new List<CarritoItem>();

                var itemExistente = carrito.FirstOrDefault(p => p.IdProducto == idProducto);
                if (itemExistente != null)
                {
                    itemExistente.Cantidad += cantidad;
                }
                else
                {
                    carrito.Add(new CarritoItem
                    {
                        IdProducto = producto.IdProducto,
                        Nombre = producto.Nombre,
                        Precio = producto.Precio,
                        Cantidad = cantidad
                    });
                }

                Session["Carrito"] = carrito;
                lblMensajeCompra.Text = "Producto agregado al carrito.";
            }
            else
            {
                lblMensajeCompra.Text = "Por favor, ingrese una cantidad válida.";
            }
        }

        protected void btnIrAlCarrito_Click(object sender, EventArgs e)
        {
            Response.Redirect("PaginaCarrito.aspx");
        }


        private void CargarDetallesProducto(int productoId)
        {
            try
            {
                Producto producto = compraNegocios.ObtenerProductoPorId(productoId);

                lblProducto.Text = "Producto: " + producto.Nombre;
                lblPrecio.Text = "Precio: " + producto.Precio.ToString("C");
            }
            catch (Exception ex)
            {
                lblMensajeCompra.Text = "Error: " + ex.Message;
            }
        }

        protected void Salir_Click(object sender, EventArgs e)
        {
            Response.Redirect("PaginaPrincipal.aspx");
        }
    }
}