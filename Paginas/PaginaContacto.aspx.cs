using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Negocios;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Proyecto1AdminBD.Paginas
{
    public partial class PaginaContacto : System.Web.UI.Page
    {
        private NegociosContacto contactoNegocios = new NegociosContacto();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnEnviar_Click(object sender, EventArgs e)
        {
            string nombre = txtNombre.Text;
            string email = txtEmail.Text;
            string mensaje = txtMensaje.Text;

            // Llamar al método de negocio para enviar el contacto
            contactoNegocios.EnviarContacto(nombre, email, mensaje);

            // Mostrar un mensaje de confirmación
            lblMensaje.Text = "Su mensaje ha sido enviado exitosamente. Nos pondremos en contacto pronto.";

            // Limpiar los campos del formulario
            txtNombre.Text = "";
            txtEmail.Text = "";
            txtMensaje.Text = "";
        }
    }
}