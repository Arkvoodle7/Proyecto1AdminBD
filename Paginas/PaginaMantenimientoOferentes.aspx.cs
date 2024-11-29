using System;
using System.Web.UI.WebControls;
using Negocios;

namespace Proyecto1AdminBD.Paginas
{
    public partial class PaginaMantenimientoOferentes : System.Web.UI.Page
    {
        private NegociosEmpresa negocioEmpresa = new NegociosEmpresa();
        private NegociosRegistro negocioRegistro = new NegociosRegistro();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarOferentes();
            }
        }

        private void CargarOferentes()
        {
            gvOferentes.DataSource = negocioEmpresa.ObtenerTodosLosOferentes(); // Método que retorna lista con datos de oferentes
            gvOferentes.DataBind();
        }

        protected void btnAgregarOferente_Click(object sender, EventArgs e)
        {
            Response.Redirect("AgregarOferente.aspx"); // Redirecciona a una página para agregar oferente
        }

        protected void gvOferentes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Modificar")
            {
                int idOferente = Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"ModificarOferente.aspx?idOferente={idOferente}"); // Redirecciona a la página para modificar oferente
            }
            else if (e.CommandName == "Eliminar")
            {
                int idOferente = Convert.ToInt32(e.CommandArgument);
                negocioRegistro.EliminarOferente(idOferente);
                CargarOferentes();
            }
        }
    }
}
