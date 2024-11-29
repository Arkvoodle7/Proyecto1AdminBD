using System;
using System.Configuration;
using System.Data.SqlClient;
using Negocios;

namespace Proyecto1AdminBD.Paginas
{
    public partial class ModificarProducto : System.Web.UI.Page
    {
        private NegociosRegistro negocioRegistro = new NegociosRegistro();
        private int idProducto;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (int.TryParse(Request.QueryString["idProducto"], out idProducto))
                {
                    ViewState["idProducto"] = idProducto;
                    CargarDatosProducto(idProducto);
                }
                else
                {
                    lblMensaje.Text = "ID de producto no válido.";
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Visible = true;
                    btnModificar.Enabled = false;
                }
            }
        }

        private void CargarDatosProducto(int idProducto)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["UsuarioFuncionario"].ConnectionString))
                {
                    using (SqlCommand command = new SqlCommand("SP_ObtenerDatosProducto", connection))
                    {
                        command.CommandType = System.Data.CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@IdProducto", idProducto);

                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                txtIdProveedor.Text = reader["id_proveedor"].ToString();
                                txtNombre.Text = reader["nombre"].ToString();
                                ddlCategoria.SelectedValue = reader["categoria"].ToString();
                                txtPrecio.Text = reader["precio"].ToString();
                                txtTiempoEntrega.Text = reader["tiempo_entrega"].ToString();
                                txtStockDisponible.Text = reader["StockDisponible"].ToString();
                            }
                            else
                            {
                                lblMensaje.Text = "Producto no encontrado.";
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
                lblMensaje.Text = $"Error al cargar los datos del producto: {ex.Message}";
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Visible = true;
            }
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            try
            {
                if (ViewState["idProducto"] != null)
                {
                    idProducto = (int)ViewState["idProducto"];
                }
                else
                {
                    throw new Exception("No se pudo obtener el ID del producto.");
                }

                int idProveedor = int.Parse(txtIdProveedor.Text.Trim());
                string nombre = txtNombre.Text.Trim();
                string categoria = ddlCategoria.SelectedValue;
                decimal precio = decimal.Parse(txtPrecio.Text.Trim());
                int tiempoEntrega = int.Parse(txtTiempoEntrega.Text.Trim());
                int stockDisponible = int.Parse(txtStockDisponible.Text.Trim());

                negocioRegistro.ModificarProducto(idProducto, idProveedor, nombre, categoria, precio, tiempoEntrega, stockDisponible);

                lblMensaje.Text = "Producto modificado con éxito.";
                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Visible = true;
            }
            catch (FormatException ex)
            {
                lblMensaje.Text = $"Error en el formato de los datos: {ex.Message}";
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
