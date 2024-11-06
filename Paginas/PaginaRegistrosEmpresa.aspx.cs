using Negocios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static Negocios.NegociosEmpresa;

namespace Proyecto1AdminBD.Paginas
{
    public partial class Formulario_web1 : System.Web.UI.Page
    {

        NegociosEmpresa empresa = new NegociosEmpresa();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                List <PedidosNegocios> pedidos = empresa.ObtenerPedidosPorProveedor(Convert.ToInt32(Session["IdUsuario"]));
                PedidosGridView.DataSource = pedidos;
                PedidosGridView.DataBind();
            }
        }
    }
}