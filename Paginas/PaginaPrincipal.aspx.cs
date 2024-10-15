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
            }
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
        }
    }
}