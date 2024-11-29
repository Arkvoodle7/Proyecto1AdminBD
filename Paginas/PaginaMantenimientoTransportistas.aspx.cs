using System;
using System.Web.UI.WebControls;
using Negocios;

namespace Proyecto1AdminBD.Paginas
{
    public partial class PaginaMantenimientoTransportistas : System.Web.UI.Page
    {
        private NegociosTransportista negocioTransportista = new NegociosTransportista();
        private NegociosRegistro negocioRegistro = new NegociosRegistro();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarTransportistas();
            }
        }

        private void CargarTransportistas()
        {
            gvTransportistas.DataSource = negocioTransportista.ObtenerTodosLosTransportistas(); // Método que retorna lista con datos de transportistas
            gvTransportistas.DataBind();
        }

        protected void btnAgregarTransportista_Click(object sender, EventArgs e)
        {
            Response.Redirect("AgregarTransportista.aspx"); // Redirecciona a una página para agregar transportista
        }

        protected void gvTransportistas_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Modificar")
            {
                int idTransportista = Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"ModificarTransportista.aspx?idTransportista={idTransportista}"); // Redirecciona a la página para modificar transportista
            }
            else if (e.CommandName == "Eliminar")
            {
                int idTransportista = Convert.ToInt32(e.CommandArgument);
                negocioRegistro.EliminarTransportista(idTransportista);
                CargarTransportistas();
            }
        }
    }
}
