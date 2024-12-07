using Negocios;
using System;
using System.Linq;
using System.Web.UI.WebControls;

namespace Proyecto1AdminBD.Paginas
{
    public partial class AgregarTransportista : System.Web.UI.Page
    {
        private NegociosRegistro negocioRegistro = new NegociosRegistro();

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            try
            {
                // Obtener y limpiar los valores de los campos de la interfaz
                string nombre = txtNombre.Text.Trim();
                string apellido = txtApellido.Text.Trim();
                string email = txtEmail.Text.Trim();
                string password = txtPassword.Text.Trim();
                string tipoTransporte = txtTipoTransporte.Text.Trim();
                string contacto = txtContacto.Text.Trim();
                string fechanac = txtFechaNacimiento.Text.Trim();

                // Validar campos y registrar transportista
                negocioRegistro.ValidarCamposTransportista(nombre, apellido, email, password, tipoTransporte, contacto);
                negocioRegistro.RegistrarTransportista(nombre, apellido, email, password, tipoTransporte, contacto, fechanac);

                // Mostrar mensaje de éxito
                lblMensaje.Text = "Transportista agregado con éxito.";
                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Visible = true;

                // Limpiar los campos después de agregar
                PanelAgregarTransportista.Controls.OfType<TextBox>().ToList().ForEach(tb => tb.Text = string.Empty);
            }
            catch (FormatException ex)
            {
                lblMensaje.Text = $"Error: {ex.Message}";
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Visible = true;
            }
            catch (ArgumentException ex)
            {
                lblMensaje.Text = $"Error: {ex.Message}";
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Visible = true;
            }
            catch (Exception ex)
            {
                lblMensaje.Text = $"Error inesperado: {ex.Message}";
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Visible = true;
            }
        }
    }
}
