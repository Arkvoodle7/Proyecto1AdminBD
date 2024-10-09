using Negocios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Proyecto1AdminBD.Paginas
{
    public partial class PaginaLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Si ya está logueado, redirigir a la página principal
            if (Session["RolUsuario"] != null)
            {
                Response.Redirect("PaginaPrincipal.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text;
            string password = txtPassword.Text;

            // Llama a NegociosLogin para verificar las credenciales
            var resultado = NegociosLogin.IniciarSesion(email, password);
            bool loginExitoso = resultado.Item1;
            string rolUsuario = resultado.Item2;
            int idUsuario = resultado.Item3;

            if (loginExitoso)
            {
                // Manejar la sesión en la capa de presentación
                Session["RolUsuario"] = rolUsuario;
                Session["IdUsuario"] = idUsuario;

                // Redirigir al usuario a la página principal
                Response.Redirect("PaginaPrincipal.aspx");
            }
            else
            {
                // Mostrar mensaje de error si las credenciales son incorrectas
                lblMensaje.Text = "Credenciales incorrectas. Por favor, intente de nuevo.";
            }
        }
    }
}