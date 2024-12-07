using System;
using System.Web.UI.WebControls;
using Negocios;

namespace Proyecto1AdminBD.Paginas
{
    public partial class PaginaMantenimientoClientes : System.Web.UI.Page
    {
        private NegociosCliente negocioCliente = new NegociosCliente();
        private NegociosRegistro negocioRegistro = new NegociosRegistro();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarClientes();
            }
        }

        // Método para cargar todos los clientes en el GridView
        private void CargarClientes()
        {
            gvClientes.DataSource = negocioCliente.ObtenerTodosLosClientes(); // Método que retorna una lista con los datos de clientes
            gvClientes.DataBind();
        }

        // Evento para agregar un nuevo cliente
        protected void btnAgregarCliente_Click(object sender, EventArgs e)
        {
            Response.Redirect("AgregarCliente.aspx"); // Redirecciona a una página para agregar cliente
        }

        // Evento RowCommand para manejar modificar y eliminar
        protected void gvClientes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Modificar")
            {
                // Obtener el id del cliente desde el CommandArgument
                int idCliente = Convert.ToInt32(e.CommandArgument);

                // Redirigir a la página de modificar con el ID del cliente
                Response.Redirect($"ModificarCliente.aspx?idCliente={idCliente}");
            }
            else if (e.CommandName == "Eliminar")
            {
                int idCliente = Convert.ToInt32(e.CommandArgument);
                negocioRegistro.EliminarCliente(idCliente);
                CargarClientes();
            }
        }
    }
}
