using System;
using Negocios;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Proyecto1AdminBD.Paginas
{
    public partial class PaginaCliente : System.Web.UI.Page
    {
        NegociosCliente Cliente = new NegociosCliente();    
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["IdUsuario"] != null)
                {
                    int idTransportista = (int)Session["IdUsuario"];
                    CargarDatosCliente(idTransportista);
                }
            }
        }
        private void CargarDatosCliente(int id)
        {
            var cliente = Cliente.ObtenerClientePorId(id);
            if (cliente != null)
            {
                lblIdCliente.Text = cliente.Id.ToString(); // Muestra el ID del cliente
                telefono.Text = cliente.Telefono; 
                direccion.Text = cliente.Direccion; // Muestra la dirección
            }
            else
            {
                lblMensaje.Text = "No se encontraron datos para el cliente.";
                lblMensaje.Visible = true;
            }
        }


        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            try
            {
                // Obtenemos los valores de los TextBox de la página
                int idCliente = int.Parse(lblIdCliente.Text);
                string telefonolValue = telefono.Text;
                string direccionValue = direccion.Text;

                // Llamada a la capa de negocio para actualizar un cliente (sin modificar el ID)
                Cliente.ActualizarCliente(idCliente,telefonolValue, direccionValue);

                // Mostrar un mensaje de éxito
                lblMensaje.Text = "Información actualizada correctamente.";
                lblMensaje.Visible = true;
            }
            catch (Exception ex)
            {
                // Mostrar mensaje de error
                lblMensaje.Text = ("Error: " + ex.Message);
                lblMensaje.Visible = true;
            }
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                // Obtenemos el ID del cliente a eliminar
                int idCliente = int.Parse(lblIdCliente.Text); // El ID se obtiene de la etiqueta o un campo de texto

                // Llamada a la capa de negocio para eliminar un cliente
                Cliente.EliminarCliente(idCliente);

                // Mostrar un mensaje de éxito
                lblMensaje.Text = "Cliente eliminado exitosamente.";
                lblMensaje.Visible = true;
            }
            catch (Exception ex)
            {
                // Mostrar mensaje de error
                lblMensaje.Text = ("Error: " + ex.Message);
                lblMensaje.Visible = true;
            }
        }
    }
}