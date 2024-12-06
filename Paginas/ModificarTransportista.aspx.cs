using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using Negocios;

namespace Proyecto1AdminBD.Paginas
{
    public partial class ModificarTransportista : System.Web.UI.Page
    {
        private NegociosRegistro negocioRegistro = new NegociosRegistro();
        private int idTransportista; // Variable para almacenar el ID del transportista a modificar

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Obtener el ID del transportista desde la query string
                if (int.TryParse(Request.QueryString["idTransportista"], out idTransportista))
                {
                    // Almacenar idTransportista en ViewState
                    ViewState["idTransportista"] = idTransportista;
                    CargarDatosTransportista(idTransportista);
                }
                else
                {
                    lblMensaje.Text = "ID de transportista no válido.";
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Visible = true;
                    btnModificar.Enabled = false;
                }
            }
        }

        private void CargarDatosTransportista(int idTransportista)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["UsuarioFuncionario"].ConnectionString))
                {
                    using (SqlCommand command = new SqlCommand("SP_ObtenerDatosTransportista", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@IdUsuario", idTransportista);

                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                txtNombre.Text = reader["nombre"].ToString();
                                txtApellido.Text = reader["apellido"].ToString();
                                txtEmail.Text = reader["email"].ToString();
                                txtPassword.Text = reader["password"].ToString();
                                txtFechaNacimiento.Text = Convert.ToDateTime(reader["fecha_nacimiento"]).ToString("yyyy-MM-dd");
                                txtTipoTransporte.Text = reader["tipo_transporte"].ToString();
                                txtContacto.Text = reader["contacto"].ToString();
                                txtTimestamp1.Text = Convert.ToBase64String((byte[])reader["tiempo"]);
                                txtTimestamp2.Text = Convert.ToBase64String((byte[])reader["tiempo2"]);
                            }
                            else
                            {
                                lblMensaje.Text = "Transportista no encontrado.";
                                lblMensaje.ForeColor = System.Drawing.Color.Red;
                                lblMensaje.Visible = true;
                                btnModificar.Enabled = false;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = $"Error al cargar los datos del transportista: {ex.Message}";
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Visible = true;
            }
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            try
            {
                // Recuperar idTransportista desde ViewState
                if (ViewState["idTransportista"] != null)
                {
                    idTransportista = (int)ViewState["idTransportista"];
                }
                else
                {
                    throw new Exception("No se pudo obtener el ID del transportista.");
                }

                // Obtener y limpiar los valores de los campos de la interfaz
                string nombre = txtNombre.Text.Trim();
                string apellido = txtApellido.Text.Trim();
                string email = txtEmail.Text.Trim();
                string password = txtPassword.Text.Trim();
                string fechaNacimiento = txtFechaNacimiento.Text.Trim();
                string tipoTransporte = txtTipoTransporte.Text.Trim();
                string contacto = txtContacto.Text.Trim();

                byte[] tiempo = Convert.FromBase64String(txtTimestamp1.Text);
                byte[] tiempo2 = Convert.FromBase64String(txtTimestamp2.Text);

                // Validar campos
                negocioRegistro.ValidarCamposTransportista(nombre, apellido, email, password, tipoTransporte, contacto);

                // Llamar a la capa de negocios para modificar el transportista
                negocioRegistro.ModificarTransportista(idTransportista, nombre, apellido, email, password, fechaNacimiento, tipoTransporte, contacto, tiempo, tiempo2);

                lblMensaje.Text = "Transportista modificado con éxito.";
                lblMensaje.ForeColor = System.Drawing.Color.Green;
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
