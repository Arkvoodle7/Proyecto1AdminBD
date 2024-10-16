 using System;
using Negocios;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Proyecto1AdminBD.Paginas
{
    public partial class HistorialCompras : System.Web.UI.Page
    {
        NegociosCliente negociosHistorial = new NegociosCliente();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMensaje.Visible = false; // Ocultar el mensaje al cargar la página

                if (Session["IdUsuario"] != null)
                {
                    int idCliente = (int)Session["IdUsuario"];
                    CargarHistorialCompras(idCliente);
                }
                else
                {
                    lblMensaje.Text = "No se ha encontrado información del usuario.";
                    lblMensaje.Visible = true;
                }
            }
        }
        private void CargarHistorialCompras(int idCliente)
        {
            try
            {
                var historialCompras = negociosHistorial.ObtenerHistorialPorCliente(idCliente);

                if (historialCompras.Count > 0)
                {
                    gvHistorialCompras.DataSource = historialCompras;
                    gvHistorialCompras.DataBind();
                }
                else
                {
                    lblMensaje.Text = "No se encontraron compras anteriores.";
                    lblMensaje.Visible = true;
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error: " + ex.Message;
                lblMensaje.Visible = true;
            }
        }
    }
}