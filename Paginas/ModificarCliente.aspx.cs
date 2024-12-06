using Microsoft.SqlServer.Types;
using Negocios;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web.UI.WebControls;

namespace Proyecto1AdminBD.Paginas
{
    public partial class ModificarCliente : System.Web.UI.Page
    {
        private NegociosRegistro negocioRegistro = new NegociosRegistro();
        private int idCliente; // Variable para almacenar el ID del cliente a modificar

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Obtener el ID del cliente desde la query string
                if (int.TryParse(Request.QueryString["idCliente"], out idCliente))
                {
                    // Almacenar idCliente en ViewState
                    ViewState["idCliente"] = idCliente;
                    CargarDatosCliente(idCliente);
                }
                else
                {
                    lblMensaje.Text = "ID de cliente no válido.";
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Visible = true;
                    btnModificar.Enabled = false;
                }
            }
        }

        private void CargarDatosCliente(int idCliente)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["UsuarioFuncionario"].ConnectionString))
                {
                    using (SqlCommand command = new SqlCommand("SP_ObtenerDatosCliente", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@IdUsuario", idCliente);

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
                                txtDireccion.Text = reader["direccion"].ToString();
                                txtTelefono.Text = reader["telefono"].ToString();

                                txtTimestamp1.Text = Convert.ToBase64String((byte[])reader["tiempo"]);
                                txtTimestamp2.Text = Convert.ToBase64String((byte[])reader["tiempo2"]);

                                // Verificar si ubicacion_geografica no es nulo
                                if (!reader.IsDBNull(reader.GetOrdinal("ubicacion_geografica")))
                                {
                                    SqlGeography ubicacion = (SqlGeography)reader["ubicacion_geografica"];
                                    double latitud = ubicacion.Lat.Value;
                                    double longitud = ubicacion.Long.Value;
                                    txtGeografia.Text = $"{latitud.ToString(CultureInfo.InvariantCulture)},{longitud.ToString(CultureInfo.InvariantCulture)}";
                                }
                                else
                                {
                                    txtGeografia.Text = string.Empty;
                                }
                            }
                            else
                            {
                                lblMensaje.Text = "Cliente no encontrado.";
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
                lblMensaje.Text = $"Error al cargar los datos del cliente: {ex.Message}";
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Visible = true;
            }
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            try
            {
                // Recuperar idCliente desde ViewState
                if (ViewState["idCliente"] != null)
                {
                    idCliente = (int)ViewState["idCliente"];
                }
                else
                {
                    throw new Exception("No se pudo obtener el ID del cliente.");
                }

                // Obtener y limpiar los valores de los campos de la interfaz
                string nombre = txtNombre.Text.Trim();
                string apellido = txtApellido.Text.Trim();
                string email = txtEmail.Text.Trim();
                string password = txtPassword.Text.Trim();
                string direccion = txtDireccion.Text.Trim();
                string telefono = txtTelefono.Text.Trim();
                string fechaNacimiento = txtFechaNacimiento.Text.Trim();
                byte[] tiempo = Convert.FromBase64String(txtTimestamp1.Text);
                byte[] tiempo2 = Convert.FromBase64String(txtTimestamp2.Text);


                // Validar que geografía no esté vacía
                string coordenadas = txtGeografia.Text.Trim();
                if (string.IsNullOrEmpty(coordenadas))
                {
                    throw new ArgumentException("Las coordenadas de geografía son obligatorias.");
                }

                string[] partes = coordenadas.Split(',');
                if (partes.Length != 2)
                {
                    throw new ArgumentException("Las coordenadas deben estar en el formato 'latitud,longitud'.");
                }

                if (!double.TryParse(partes[0], NumberStyles.Any, CultureInfo.InvariantCulture, out double latitud) ||
                    !double.TryParse(partes[1], NumberStyles.Any, CultureInfo.InvariantCulture, out double longitud))
                {
                    throw new FormatException("Las coordenadas deben ser números válidos.");
                }

                SqlGeography ubicacion = SqlGeography.Point(latitud, longitud, 4326);

                // Llamar a la capa de negocios para modificar el cliente
                negocioRegistro.ModificarCliente(idCliente, nombre, apellido, email, password, direccion, telefono, fechaNacimiento, ubicacion, tiempo, tiempo2);

                lblMensaje.Text = "Cliente modificado con éxito.";
                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Visible = true;
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
