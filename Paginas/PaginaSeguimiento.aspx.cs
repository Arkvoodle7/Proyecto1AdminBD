using Negocios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Proyecto1AdminBD.Paginas
{
    public partial class PaginaSeguimiento : System.Web.UI.Page
    {
        NegociosCliente negociosPedidos = new NegociosCliente();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMensaje.Visible = false; // Ocultar el mensaje al cargar la página

                if (Session["IdUsuario"] != null)
                {
                    int idCliente = (int)Session["IdUsuario"];
                    CargarSeguimientoPedidos(idCliente);
                }
                else
                {
                    lblMensaje.Text = "No se ha encontrado información del usuario.";
                    lblMensaje.Visible = true;
                }
            }
        }
        private void CargarSeguimientoPedidos(int idCliente)
        {
            try
            {
                // Llamar al método que obtiene los pedidos en curso
                var pedidos = negociosPedidos.ObtenerPedidosEnCurso(idCliente);

                // Verificar si hay pedidos
                if (pedidos.Count > 0)
                {
                    // Asignar la lista de pedidos al GridView y enlazar los datos
                    gvSeguimientoPedidos.DataSource = pedidos;
                    gvSeguimientoPedidos.DataBind();
                }
                else
                {
                    // Mostrar un mensaje si no hay pedidos pendientes
                    lblMensaje.Text = "No se encontraron pedidos pendientes o en camino.";
                    lblMensaje.Visible = true;
                }
            }
            catch (Exception ex)
            {
                // Manejo de errores, mostrar un mensaje
                lblMensaje.Text = "Error: " + ex.Message;
                lblMensaje.Visible = true;
            }
        }
    }
}