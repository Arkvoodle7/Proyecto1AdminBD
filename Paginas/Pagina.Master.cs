using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Proyecto1AdminBD.Paginas
{
    public partial class Pagina : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Verificar si hay sesión
                if (Session["RolUsuario"] != null)
                {
                    string rol = Session["RolUsuario"].ToString();

                    // Mostrar opciones según el rol del usuario
                    if (rol == "cliente")
                    {
                        OpcionesClientes.Visible = true;
                    }
                    else if (rol == "proveedor")
                    {
                        OpcionesProveedores.Visible = true;
                    }
                    else if (rol == "transportista")
                    {
                        OpcionesTransportistas.Visible = true;
                    }

                    // Mostrar el ícono de usuario si hay sesión
                    IconoUsuario.Visible = true;
                }
                else
                {
                    // Si no hay sesión iniciada, mostrar la vista general
                    OpcionesGenerales.Visible = true;

                    // Ocultar el ícono de usuario en la vista general
                    IconoUsuario.Visible = false;
                }
            }
        }

        protected void CerrarSesion_Click(object sender, EventArgs e)
        {
            // Limpiar la sesión
            Session.Clear();
            Session.Abandon();

            // Redirigir a la página de inicio o login (vista general)
            Response.Redirect("PaginaLogin.aspx");
        }

    }
}