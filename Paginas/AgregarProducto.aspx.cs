using Negocios;
using System;
using System.Linq;
using System.Web.UI.WebControls;

namespace Proyecto1AdminBD.Paginas
{
    public partial class AgregarProducto : System.Web.UI.Page
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
                string idProveedorStr = txtIdProveedor.Text.Trim();
                if (!int.TryParse(idProveedorStr, out int idProveedor))
                {
                    throw new FormatException("ID Proveedor debe ser un número entero válido.");
                }

                string nombre = txtNombre.Text.Trim();
                string categoria = ddlCategoria.SelectedValue;

                string precioStr = txtPrecio.Text.Trim();
                if (!decimal.TryParse(precioStr, out decimal precio))
                {
                    throw new FormatException("Precio debe ser un número decimal válido.");
                }

                string tiempoEntregaStr = txtTiempoEntrega.Text.Trim();
                if (!int.TryParse(tiempoEntregaStr, out int tiempoEntrega))
                {
                    throw new FormatException("Tiempo de Entrega debe ser un número entero válido.");
                }

                string stockDisponibleStr = txtStockDisponible.Text.Trim();
                if (!int.TryParse(stockDisponibleStr, out int stockDisponible))
                {
                    throw new FormatException("Stock Disponible debe ser un número entero válido.");
                }

                // Validar campos adicionales si es necesario
                if (string.IsNullOrEmpty(nombre))
                {
                    throw new ArgumentException("El nombre del producto no puede estar vacío.");
                }

                // Registrar producto
                negocioRegistro.RegistrarProducto(idProveedor, nombre, categoria, precio, tiempoEntrega, stockDisponible);

                // Mostrar mensaje de éxito
                lblMensaje.Text = "Producto agregado con éxito.";
                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Visible = true;

                // Limpiar los campos después de agregar
                PanelAgregarProducto.Controls.OfType<TextBox>().ToList().ForEach(tb => tb.Text = string.Empty);
                ddlCategoria.SelectedIndex = 0;
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
