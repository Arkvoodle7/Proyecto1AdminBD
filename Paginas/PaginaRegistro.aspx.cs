using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocios;

namespace Proyecto1AdminBD.Paginas
{
    public partial class PaginaRegistro : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            string nombre = txtNombre.Text;
            string apellido = txtApellido.Text;
            string email = txtEmail.Text;
            string password = txtPassword.Text;
            string tipoUsuario = ddlTipoUsuario.SelectedValue;

            NegociosRegistro negociosRegistro = new NegociosRegistro();

            try
            {
                if (tipoUsuario == "cliente")
                {
                    string direccion = txtDireccion.Text;
                    string telefono = txtTelefono.Text;
                    string fechanac= txtFechaNacimiento.Text;   
                    negociosRegistro.ValidarCamposCliente(nombre, apellido, email, password, direccion, telefono);
                    negociosRegistro.RegistrarCliente(nombre, apellido, email, password, direccion, telefono, fechanac);
                }
                else if (tipoUsuario == "proveedor")
                {
                    string nombreEmpresa = txtNombreEmpresa.Text;
                    string direccion = txtDireccionProveedor.Text;
                    string contacto = txtContacto.Text;
                    string horario = txtHorario.Text;
                    string ubicacion = txtUbicacion.Text;
                    string fechanac = txtFechaNacimiento.Text;
                    negociosRegistro.ValidarCamposProveedor(nombre, apellido, email, password, nombreEmpresa, direccion, contacto, horario, ubicacion);
                    negociosRegistro.RegistrarProveedor(nombre, apellido, email, password, nombreEmpresa, direccion, contacto, horario, ubicacion, fechanac);
                }
                else if (tipoUsuario == "transportista")
                {
                    string tipoTransporte = txtTipoTransporte.Text;
                    string contacto = txtContactoTransporte.Text;
                    string fechanac= txtFechaNacimiento.Text;
                    negociosRegistro.ValidarCamposTransportista(nombre, apellido, email, password, tipoTransporte, contacto);
                    negociosRegistro.RegistrarTransportista(nombre, apellido, email, password, tipoTransporte, contacto, fechanac);
                }

                // Mostrar mensaje de éxito
                lblMensaje.Text = "Usuario registrado con éxito!";
            }
            catch (Exception ex)
            {
                // Mostrar mensaje de error
                lblMensaje.Text = ex.Message; 
            }
        }

        protected void ddlTipoUsuario_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Ocultar todos los campos específicos por defecto
            clienteFields.Visible = false;
            proveedorFields.Visible = false;
            transportistaFields.Visible = false;

            // Mostrar los campos correspondientes según el tipo de usuario
            string tipoUsuario = ddlTipoUsuario.SelectedValue;

            if (tipoUsuario == "cliente")
            {
                clienteFields.Visible = true;
            }
            else if (tipoUsuario == "proveedor")
            {
                proveedorFields.Visible = true;
            }
            else if (tipoUsuario == "transportista")
            {
                transportistaFields.Visible = true;
            }
        }

    }
}