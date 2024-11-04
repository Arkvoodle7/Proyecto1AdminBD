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
        NegociosCompra negocio = new NegociosCompra();

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

                
                negocio.CambiarEntregado(idPedido);
            }
        }

        private void CargarPedidos()
        {
            List<PedidoDet> pedidos = negocio.ObtenerPendientes(Convert.ToInt32(Session["IdUsuario"]));

            gvPedidos.DataSource = pedidos;
            gvPedidos.DataBind();
        }

    }
}