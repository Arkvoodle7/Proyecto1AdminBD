using Negocios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Proyecto1AdminBD.Paginas
{
    public partial class Formulario_web11 : System.Web.UI.Page
    {
        NegociosCompra negociosCompra = new NegociosCompra();

        protected void Page_Load(object sender, EventArgs e)
        {
            CargarPedidos();
        }

        protected void gvPedidos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            
            if (e.CommandName == "Select")
            {
                
                int index = Convert.ToInt32(e.CommandArgument);

                
                int idPedido = Convert.ToInt32(gvPedidos.DataKeys[index].Value);
                try
                {
                    decimal resp = negociosCompra.CambiarEntregado(idPedido);
                    if (resp > -1)
                    {
                        negociosCompra.CambiarEntregado(idPedido);
                    }
                    else
                    {
                        lblMensaje.Text = "La cantidad de kilometros no debe de superar los 12 km";
                        lblMensaje.Visible = true;
                    }
                }
                catch (Exception ex)
                {
                    lblMensaje.Text = ex.Message;
                    lblMensaje.Visible = true;
                }

                
            }
        }

        private void CargarPedidos()
        {
            List<PedidoDet> pedidos = negociosCompra.ObtenerPendientes(Convert.ToInt32(Session["IdUsuario"]));

            if (pedidos == null || pedidos.Count == 0)
            {
                lblMensaje.Text = "No hay entregas pendientes";
                lblMensaje.Visible = true;
            }
            else
            {
                lblMensaje.Text = "";
                lblMensaje.Visible = false;
                gvPedidos.DataSource = pedidos;
                gvPedidos.DataBind();
            }
        }

    }
}