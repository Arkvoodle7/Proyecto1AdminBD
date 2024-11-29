using System;
using System.Web.UI.WebControls;
using Negocios;

namespace Proyecto1AdminBD.Paginas
{
    public partial class PaginaMantenimientoProductos : System.Web.UI.Page
    {
        private NegociosEmpresa negocioEmpresa = new NegociosEmpresa();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarProductos();
            }
        }

        private void CargarProductos()
        {
            gvProductos.DataSource = negocioEmpresa.ObtenerTodosLosProductos(); // Método que retorna lista con datos de productos
            gvProductos.DataBind();
        }

        protected void btnAgregarProducto_Click(object sender, EventArgs e)
        {
            Response.Redirect("AgregarProducto.aspx"); // Redirecciona a una página para agregar producto
        }

        protected void gvProductos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Modificar")
            {
                int idProducto = Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"ModificarProducto.aspx?idProducto={idProducto}");
            }
            else if (e.CommandName == "Eliminar")
            {
                int idProducto = Convert.ToInt32(e.CommandArgument);
                negocioEmpresa.EliminarProducto(idProducto);
                CargarProductos();
            }
        }

    }
}
