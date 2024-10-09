using System;
using Negocios;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Proyecto1AdminBD.Paginas
{
    public partial class PaginaTransportista : System.Web.UI.Page
    {
        NegociosTransportista negocio = new NegociosTransportista();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                // Obtenemos valores de los TextBox de la página
                int id = int.Parse(nombreTransportista.Text); // Este es el ID
                string contactoValue = contacto.Text;
                string tipoTransporteValue = tipoTransporte.Text;

                // Validación de valores antes de enviarlos
                if (string.IsNullOrEmpty(tipoTransporteValue) || string.IsNullOrEmpty(contactoValue))
                {
                    lblMensaje.Text = "El tipo de transporte o contacto no pueden estar vacíos.";
                    lblMensaje.Visible = true; // Asegúrate de que el label sea visible
                    return;
                }

                // Llamada a la capa de negocio para agregar un transportista
                negocio.InsertarTransportista(id, tipoTransporteValue, contactoValue);

                // Mostrar mensaje de éxito
                lblMensaje.Text = "Transportista agregado exitosamente.";
                lblMensaje.Visible = true; // Hacemos visible el label
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error: " + ex.Message;
                lblMensaje.Visible = true; // Asegúrate de que el label sea visible
            }

        }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {

        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {

        }
    }
}