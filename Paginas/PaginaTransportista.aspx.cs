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
            if (!IsPostBack)
            {
                if (Session["IdUsuario"] != null)
                {
                    int idTransportista = (int)Session["IdUsuario"];
                    CargarDatosTransportista(idTransportista);
                }
            }
        }
        private void CargarDatosTransportista(int id)
        {
            var transportista = negocio.ObtenerTransportistaPorId(id);
            if (transportista != null)
            {
                lblIdTransportista.Text = transportista.Id.ToString(); // Muestra el ID del transportista
                contacto.Text = transportista.Contacto; // Muestra el contacto
                tipoTransporte.Text = transportista.TipoTransporte; // Muestra el tipo de transporte
                txtTimeStamp.Text = transportista.Stamp;
            }
            else
            {
                lblMensaje.Text = "No se encontraron datos para el transportista.";
                lblMensaje.Visible = true;
            }
        }


        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            try
            {
                // Obtenemos los valores de los TextBox de la página
                int idTransportista = int.Parse(lblIdTransportista.Text);
                string tipoTransporteValue = tipoTransporte.Text;
                string contactoValue = contacto.Text;
                byte[] timestamp = Convert.FromBase64String(txtTimeStamp.Text);

                // Llamada a la capa de negocio para actualizar un transportista (sin modificar el ID)
                negocio.ActualizarTransportista(idTransportista, tipoTransporteValue, contactoValue, timestamp);


                // Mostrar un mensaje de éxito
                lblMensaje.Text = "Informacion actualizada correctamente.";
                lblMensaje.Visible = true;
            }
            catch (Exception ex)
            {
                // Mostrar mensaje de error
                lblMensaje.Text = ("Error:" + ex.Message);
                lblMensaje.Visible = true;
            }
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                // Obtenemos el ID del transportista a eliminar
                int idTransportista = int.Parse(lblIdTransportista.Text); // El ID se obtiene de algún TextBox o selección

                // Llamada a la capa de negocio para eliminar un transportista
                negocio.EliminarTransportista(idTransportista);

                // Mostrar un mensaje de éxito
                lblMensaje.Text = "Transportista eliminado exitosamente.";
                lblMensaje.Visible = true;
            }
            catch (Exception ex)
            {
                // Mostrar mensaje de error
                lblMensaje.Text = ("Error:" + ex.Message);
                lblMensaje.Visible = true;
            }
        }
    }
}