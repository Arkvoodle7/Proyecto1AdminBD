using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using Microsoft.SqlServer.Types;
using Negocios;

namespace Proyecto1AdminBD.Paginas
{
    public partial class ModificarOferente : System.Web.UI.Page
    {
        private NegociosRegistro negocioRegistro = new NegociosRegistro();
        private int idOferente; // Variable para almacenar el ID del oferente a modificar

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Obtener el ID del oferente desde la query string
                if (int.TryParse(Request.QueryString["idOferente"], out idOferente))
                {
                    // Almacenar idOferente en ViewState
                    ViewState["idOferente"] = idOferente;
                    CargarDatosOferente(idOferente);
                }
                else
                {
                    lblMensaje.Text = "ID de oferente no válido.";
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Visible = true;
                    btnModificar.Enabled = false;
                }
            }
        }

        private void CargarDatosOferente(int idOferente)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["UsuarioFuncionario"].ConnectionString))
                {
                    using (SqlCommand command = new SqlCommand("SP_ObtenerDatosOferente", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@IdUsuario", idOferente);

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
                                txtNombreEmpresa.Text = reader["nombre_empresa"].ToString();
                                txtDireccion.Text = reader["direccion"].ToString();
                                txtContacto.Text = reader["contacto"].ToString();
                                txtHorario.Text = reader["horario"].ToString();
                                txtTimestamp1.Text = reader["tiempo"].ToString();
                                txtTimestamp2.Text = reader["tiempo2"].ToString();

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
                                lblMensaje.Text = "Oferente no encontrado.";
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
                lblMensaje.Text = $"Error al cargar los datos del oferente: {ex.Message}";
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Visible = true;
            }
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            try
            {
                // Recuperar idOferente desde ViewState
                if (ViewState["idOferente"] != null)
                {
                    idOferente = (int)ViewState["idOferente"];
                }
                else
                {
                    throw new Exception("No se pudo obtener el ID del oferente.");
                }

                // Obtener y limpiar los valores de los campos de la interfaz
                string nombre = txtNombre.Text.Trim();
                string apellido = txtApellido.Text.Trim();
                string email = txtEmail.Text.Trim();
                string password = txtPassword.Text.Trim();
                string fechaNacimiento = txtFechaNacimiento.Text.Trim();
                string nombreEmpresa = txtNombreEmpresa.Text.Trim();
                string direccion = txtDireccion.Text.Trim();
                string contacto = txtContacto.Text.Trim();
                string horario = txtHorario.Text.Trim();

                byte[] tiempo = System.Text.Encoding.UTF8.GetBytes(txtTimestamp1.Text);
                byte[] tiempo2 = System.Text.Encoding.UTF8.GetBytes(txtTimestamp2.Text);

                // Validar campos
                negocioRegistro.ValidarCamposProveedor(nombre, apellido, email, password, nombreEmpresa, direccion, contacto, horario);

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

                // Llamar a la capa de negocios para modificar el oferente
                negocioRegistro.ModificarOferente(idOferente, nombre, apellido, email, password, fechaNacimiento, nombreEmpresa, direccion, contacto, horario, ubicacion, tiempo, tiempo2);

                lblMensaje.Text = "Oferente modificado con éxito.";
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
