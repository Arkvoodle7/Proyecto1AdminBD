using System;
using Negocios;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Proyecto1AdminBD.Paginas
{
    public partial class Envios : System.Web.UI.Page
    {
        NegociosTransportista negocioPedidos = new NegociosTransportista();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
          
                CargarPedidos(); 
            }
        }


        protected void gvPedidos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "AsignarTransportista")
            {
                // Obtén el ID del pedido desde el CommandArgument
                int idPedido = Convert.ToInt32(e.CommandArgument);

                // Obtén el ID del transportista desde la sesión
                if (Session["IdUsuario"] != null)
                {
                    int idTransportista = (int)Session["IdUsuario"];

                    try
                    {
                        // Asignar el transportista al pedido
                        negocioPedidos.AsignarTransportista(idPedido, idTransportista);

                        // Mostrar un mensaje de éxito
                        lblMensaje.Text = "Transportista asignado con éxito.";
                        lblMensaje.ForeColor = System.Drawing.Color.Green; // Cambia el color del mensaje
                    }
                    catch (Exception ex)
                    {
                        // Mostrar el mensaje de error
                        lblMensaje.Text = ex.Message; // Muestra el mensaje de error que viene de la capa de negocio
                        lblMensaje.ForeColor = System.Drawing.Color.Red; // Cambia el color del mensaje
                    }
                    finally
                    {
                        // Asegúrate de que el mensaje sea visible
                        lblMensaje.Visible = true;

                        // Re-cargar el GridView
                        CargarPedidos(); // Asegúrate de implementar este método
                    }
                }
                else
                {
                    // Manejar el caso en el que no haya un transportista asignado en la sesión
                    lblMensaje.Text = "No se ha seleccionado un transportista.";
                    lblMensaje.ForeColor = System.Drawing.Color.Red; // Cambia el color del mensaje
                    lblMensaje.Visible = true;
                }
            }

        }


        private void CargarPedidos()
        {
            // Obtener la lista de pedidos desde la capa de negocios
            List<Pedido> pedidos = negocioPedidos.ObtenerTodosLosPedidos(); // Ahora retorna List<Negocios.Pedido>

            // Asignar la lista de pedidos al GridView
            gvPedidos.DataSource = pedidos;
            gvPedidos.DataBind();
        }

        protected void gvPedidos_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Aquí puedes manejar el evento de selección si es necesario
        }
    }
}