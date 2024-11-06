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
        NegociosCompra negociosCompra = new NegociosCompra();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMensaje.Visible = false;  // Ocultar el mensaje al cargar la página
                CargarPedidos();
            }
        }


        protected void gvPedidos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "AsignarTransportista")
            {
                int idPedido = Convert.ToInt32(e.CommandArgument);

                if (Session["IdUsuario"] != null)
                {
                    int idTransportista = (int)Session["IdUsuario"];

                    try
                    {
                        decimal costoEnvio = negociosCompra.CalcularDistancia(idPedido);

                        // Verificamos si el costo de envío es válido
                        if (costoEnvio >= 0)
                        {
                            // Asignar el transportista solo si la distancia está dentro de cobertura
                            negocioPedidos.AsignarTransportista(idPedido, idTransportista);

                            // Mostrar mensaje de éxito
                            lblMensaje.Text = "Transportista asignado con éxito. Costo de envío: " + costoEnvio.ToString("C");
                            lblMensaje.ForeColor = System.Drawing.Color.Green;
                        }
                        else
                        {
                            // Mostrar mensaje si la distancia está fuera de cobertura
                            lblMensaje.Text = "La distancia está fuera de cobertura. No se puede asignar el transportista.";
                            lblMensaje.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                    catch (Exception ex)
                    {
                        lblMensaje.Text = ex.Message;
                        lblMensaje.ForeColor = System.Drawing.Color.Red;
                    }
                    finally
                    {
                        lblMensaje.Visible = true;
                        CargarPedidos();
                    }
                }
                else
                {
                    lblMensaje.Text = "No se ha seleccionado un transportista.";
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
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