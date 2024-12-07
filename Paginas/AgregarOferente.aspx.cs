﻿using Microsoft.SqlServer.Types;
using Negocios;
using System;
using System.Globalization;
using System.Linq;
using System.Web.UI.WebControls;

namespace Proyecto1AdminBD.Paginas
{
    public partial class AgregarOferente : System.Web.UI.Page
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
                string nombreEmpresa = txtNombreEmpresa.Text.Trim();
                string direccion = txtDireccion.Text.Trim();
                string contacto = txtContacto.Text.Trim();
                string horario = txtHorario.Text.Trim();
                string fechanac = txtFechaNacimiento.Text.Trim();

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

                // Utilizar CultureInfo.InvariantCulture para asegurar el parseo correcto
                if (!double.TryParse(partes[0], NumberStyles.Any, CultureInfo.InvariantCulture, out double latitud) ||
                    !double.TryParse(partes[1], NumberStyles.Any, CultureInfo.InvariantCulture, out double longitud))
                {
                    throw new FormatException("Las coordenadas deben ser números válidos.");
                }

                SqlGeography ubicacion = SqlGeography.Point(latitud, longitud, 4326);

                // Validar campos y registrar oferente
                negocioRegistro.ValidarCamposProveedor(nombre, apellido, email, password, nombreEmpresa, direccion, contacto, horario);
                negocioRegistro.RegistrarProveedor(nombre, apellido, email, password, nombreEmpresa, direccion, contacto, horario, fechanac, ubicacion);

                // Mostrar mensaje de éxito
                lblMensaje.Text = "Oferente agregado con éxito.";
                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Visible = true;

                // Limpiar los campos después de agregar
                PanelAgregarOferente.Controls.OfType<TextBox>().ToList().ForEach(tb => tb.Text = string.Empty);
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
