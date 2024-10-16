using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace Proyecto1AdminBD.Paginas
{
    public partial class PaginaPrincipal : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["SistemaEnviosDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarCategorias();

                // Verificar si el usuario está logueado
                if (Session["IdUsuario"] != null)
                {
                    lblMensaje.Text = "Usuario logueado con ID: " + Session["IdUsuario"].ToString();
                    lblMensaje.Visible = true;

                    // Si el usuario está logueado, activar los botones de compra
                    ActivarBotonesCompra();
                }
                else
                {
                    lblMensaje.Text = "Inicie sesión para poder realizar compras.";
                    lblMensaje.Visible = true;
                }
            }

        }
        private void ActivarBotonesCompra()
        {
            foreach (ListViewItem item in lvProductos.Items)
            {
                Button btnComprar = (Button)item.FindControl("btnComprar");
                if (btnComprar != null)
                {
                    // Verificar si el botón fue encontrado y activar
                    btnComprar.Visible = true;  //za
                }
            }
        }

        protected void ComprarProducto_Click(object sender, EventArgs e)
        {
            Button btnComprar = (Button)sender;
            int idProducto = Convert.ToInt32(btnComprar.CommandArgument);

            // Redirigir a la página de compra o realizar la acción deseada
            Response.Redirect($"PaginaCompra.aspx?productoId={idProducto}");
        }

        // Cargar categorías de la base de datos
        private void CargarCategorias()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("sp_GetCategorias", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                rptCategorias.DataSource = reader;
                rptCategorias.DataBind();
            }
        }
        protected void CategoriaSeleccionada(object sender, EventArgs e)
        {
            LinkButton btnCategoria = (LinkButton)sender;
            string categoria = btnCategoria.CommandArgument;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("sp_GetProductosPorCategoria", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@categoria", categoria);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                lvProductos.DataSource = reader;
                lvProductos.DataBind();
            }

            // Verificar si hay productos cargados
            lblMensaje.Text = "Número de productos cargados: " + lvProductos.Items.Count.ToString();

            if (Session["IdUsuario"] != null && lvProductos.Items.Count > 0)
            {
                ActivarBotonesCompra();
            }
        }

        protected void btnContactanos_Click(object sender, EventArgs e)
        {
            Response.Redirect("PaginaContacto.aspx"); // Redirige a la página de contacto
        }
    }
}