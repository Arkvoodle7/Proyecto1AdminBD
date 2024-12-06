using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Runtime.ConstrainedExecution;
using System.Diagnostics.Contracts;

namespace Datos
{
    public class DatosEmpresa
    {

        string connectionStringOferente = ConfigurationManager.ConnectionStrings["UsuarioOferente"].ConnectionString;
        string connectionStringFuncionario = ConfigurationManager.ConnectionStrings["UsuarioFuncionario"].ConnectionString;

        public List<string> ObtenerProvedor(int id)
        {
            List<string> Provedor = new List<string>();

            using (SqlConnection conn = new SqlConnection(connectionStringOferente))
            {
                SqlCommand cmd = new SqlCommand("SP_SelectProvedo", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", id);

                try
                {
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            Provedor.Add(Convert.ToString(reader["id_proveedor"]));
                            Provedor.Add(reader["contacto"].ToString());
                            Provedor.Add(reader["direccion"].ToString());
                            Provedor.Add(reader["horario"].ToString());
                            Provedor.Add(reader["nombre_empresa"].ToString());

                            byte[] tiempoBytes = (byte[])reader["tiempo"];

                            //De bytes a Base64
                            string tiempoBase64 = Convert.ToBase64String(tiempoBytes);
                            Provedor.Add(tiempoBase64);

                        }
                    }
                }
                catch (SqlException ex)
                {
                    throw new Exception("Error al obtener el proveedor: " + ex.Message);
                }
            }

            return Provedor;
        }



        /// Productos 
        /// Insert

        public void InsertProducto(int idProvedor, string nombre, string categoria, decimal precio, int tiempoEntrega, decimal stock)
        {
            using (SqlConnection conn = new SqlConnection(connectionStringOferente))
            {
                SqlCommand cmd = new SqlCommand("SP_InsertProducto", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdProvedor", idProvedor);
                cmd.Parameters.AddWithValue("@Nombre", nombre);
                cmd.Parameters.AddWithValue("@Categoria", categoria);
                cmd.Parameters.AddWithValue("@Precio", precio);
                cmd.Parameters.AddWithValue("@Tiempo_Entrega", tiempoEntrega);
                cmd.Parameters.AddWithValue("@Stock", stock);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (SqlException ex)
                {
                    throw new Exception("Error al insertar producto" + ex.Message);
                }
            }

        }

        /// Update

        public void UpdateProducto(int idProducto, int idProvedor, string nombre, string categoria, decimal precio, int tiempoEntrega, decimal stock, byte[] timestamp)
        {
            using (SqlConnection conn = new SqlConnection(connectionStringOferente))
            {
                SqlCommand cmd = new SqlCommand("SP_UptadeProducto", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdProducto", idProducto);
                cmd.Parameters.AddWithValue("@IdProvedor", idProvedor);
                cmd.Parameters.AddWithValue("@Nombre", nombre);
                cmd.Parameters.AddWithValue("@Categoria", categoria);
                cmd.Parameters.AddWithValue("@Precio", precio);
                cmd.Parameters.AddWithValue("@Tiempo_Entrega", tiempoEntrega);
                cmd.Parameters.AddWithValue("@Stock", stock);
                cmd.Parameters.Add("@times", SqlDbType.Binary, 8).Value = timestamp;

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (SqlException ex)
                {
                    throw new Exception("Error al actualizar producto" + ex.Message);
                }
            }
        }

        /// Delete

        public void DeleteProducto(int idProducto)
        {
            using (SqlConnection conn = new SqlConnection(connectionStringOferente))
            {
                SqlCommand cmd = new SqlCommand("SP_DeleteProducto", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdProducto", idProducto);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (SqlException ex)
                {
                    throw new Exception("Error al eliminar producto" + ex.Message);
                }
            }
        }

        public List<string> ObtenerProducto(int IdProducto)
        {
            List<string> pr = new List<string>();

            using (SqlConnection conn = new SqlConnection(connectionStringOferente))
            {
                SqlCommand cmd = new SqlCommand("SP_SelectProducto", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IdProducto", IdProducto);

                try
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        pr.Add(reader["id_producto"].ToString());
                        pr.Add(reader["id_proveedor"].ToString());
                        pr.Add(reader["nombre"].ToString());
                        pr.Add(reader["categoria"].ToString());
                        pr.Add(reader["precio"].ToString());
                        pr.Add(reader["tiempo_entrega"].ToString());
                        pr.Add(reader["tiempo"].ToString());
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception("Error al encontrar el producto: " + ex.Message);
                }
            }

            return pr;
        }

        public List<List<string>> ObtenerProductosLista(string categoria)
        {
            List<List<string>> productosLista = new List<List<string>>();

            using (SqlConnection conn = new SqlConnection(connectionStringOferente))
            {
                SqlCommand cmd = new SqlCommand("SP_SelectProductoCategoria", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Categoria", categoria);


                try
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        List<string> pr = new List<string>();

                        pr.Add(reader["id_producto"].ToString());
                        pr.Add(reader["id_proveedor"].ToString());
                        pr.Add(reader["nombre"].ToString());
                        pr.Add(reader["categoria"].ToString());
                        pr.Add(reader["precio"].ToString());
                        pr.Add(reader["tiempo_entrega"].ToString());
                        pr.Add(reader["tiempo"].ToString());


                        productosLista.Add(pr);
                    }
                    return productosLista;
                }
                catch (Exception ex)
                {
                    throw new Exception("Error al encontrar productos: " + ex.Message);
                }
            }
        }


        public List<List<string>> ObtenerProductosProvedor(int provedor)
        {
            List<List<string>> productosProvedor = new List<List<string>>();

            using (SqlConnection conn = new SqlConnection(connectionStringOferente))
            {
                SqlCommand cmd = new SqlCommand("SP_SelectProductoProvedor", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Provedor", provedor);


                try
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            List<string> pr = new List<string>();

                            pr.Add(reader["id_producto"].ToString());
                            pr.Add(reader["id_proveedor"].ToString());
                            pr.Add(reader["nombre"].ToString());
                            pr.Add(reader["categoria"].ToString());
                            pr.Add(reader["precio"].ToString());
                            pr.Add(reader["tiempo_entrega"].ToString());
                            
                            byte[] tiempoBytes = (byte[])reader["tiempo"];

                            //De bytes a Base64
                            string tiempoBase64 = Convert.ToBase64String(tiempoBytes);
                            pr.Add(tiempoBase64);

                            productosProvedor.Add(pr);
                        }
                    }

                    return productosProvedor;
                }
                catch (Exception ex)
                {
                    throw new Exception("Error al encontrar productos: " + ex.Message);
                }
            }
        }


        public void InsertPedido(int idCliente, int idProducto, int idTransportista, DateTime fechaPedido, string estado)
        {
            using (SqlConnection conn = new SqlConnection(connectionStringOferente))
            {
                SqlCommand cmd = new SqlCommand("SP_CreatePedido", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IdCliente", idCliente);
                cmd.Parameters.AddWithValue("@IdProducto", idProducto);
                cmd.Parameters.AddWithValue("@IdTransportista", idTransportista);
                cmd.Parameters.AddWithValue("@FechaPedido", fechaPedido);
                cmd.Parameters.AddWithValue("@Estado", estado);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (SqlException ex)
                {
                    throw new Exception("Error al insertar pedido: " + ex.Message);
                }
            }
        }

        public void UpdatePedido(int IdPedido, string NuevoEstado)
        {
            using (SqlConnection conn = new SqlConnection(connectionStringOferente))
            {
                SqlCommand cmd = new SqlCommand("SP_UpdateEstadoPedido", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdPedido", IdPedido);
                cmd.Parameters.AddWithValue("@NuevoEstado", NuevoEstado);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (SqlException ex)
                {
                    throw new Exception("Error al modificar un estado del pedido" + ex.Message);
                }
            }
        }

        public int InsertCarrito(int cedula, int IdProducto)
        {
            int resultado;

            using (SqlConnection conn = new SqlConnection(connectionStringOferente))
            {
                SqlCommand cmd = new SqlCommand("SP_ObtenerIdPedido", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@cedula", cedula);

                try
                {
                    conn.Open();
                    resultado = cmd.ExecuteNonQuery();

                    if (resultado == 1)
                    {
                        SqlCommand car = new SqlCommand("SP_InsertCarrito", conn);
                        car.CommandType = CommandType.StoredProcedure;
                        car.Parameters.AddWithValue("@cedula", cedula);
                        car.Parameters.AddWithValue("@IdProducto", IdProducto);


                        try
                        {
                            conn.Open();
                            car.ExecuteNonQuery();
                        }
                        catch (SqlException ex)
                        {
                            throw new Exception("Error al insertar pedido: " + ex.Message);
                        }
                    }
                    else if (resultado == 2)
                    {
                        SqlCommand car2 = new SqlCommand("SP_CreatePedido", conn);
                        car2.CommandType = CommandType.StoredProcedure;
                        car2.Parameters.AddWithValue("@cedula", cedula);
                        car2.Parameters.AddWithValue("@IdProducto", IdProducto);


                        try
                        {
                            conn.Open();
                            car2.ExecuteNonQuery();
                        }
                        catch (SqlException ex)
                        {
                            throw new Exception("Error al insertar pedido: " + ex.Message);
                        }
                    }
                }
                catch (SqlException ex)
                {
                    throw new Exception("Error al obtener el pedido: " + ex.Message);
                }
            }
            return resultado;
        }

        public void UpdateProvedor(int idProveedor, string nombreEmpresa, string direccion, string contacto, string horario, string ubicacion, byte[] timestamp)
        {
            using (SqlConnection conn = new SqlConnection(connectionStringOferente))
            {
                SqlCommand cmd = new SqlCommand("SP_UpdateProveedor", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdProveedor", idProveedor);
                cmd.Parameters.AddWithValue("@NombreEmpresa", nombreEmpresa);
                cmd.Parameters.AddWithValue("@Direccion", direccion);
                cmd.Parameters.AddWithValue("@Contacto", contacto);
                cmd.Parameters.AddWithValue("@Horario", horario);
                cmd.Parameters.Add("@times", SqlDbType.Binary, 8).Value = timestamp;

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (SqlException ex)
                {
                    throw new Exception("Error al actualizar el provedor" + ex.Message);
                }
            }
        }

        // Método para eliminar un producto
        public void EliminarProducto(int idProducto)
        {
            using (SqlConnection conn = new SqlConnection(connectionStringFuncionario))
            {
                SqlCommand cmd = new SqlCommand("SP_EliminarProducto", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdProducto", idProducto);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        // Método para eliminar un oferente
        public void EliminarOferente(int idOferente)
        {
            using (SqlConnection conn = new SqlConnection(connectionStringFuncionario))
            {
                SqlCommand cmd = new SqlCommand("SP_EliminarOferente", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdOferente", idOferente);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        public List<OferenteCompleto> ObtenerTodosLosOferentesCompletos()
        {
            List<OferenteCompleto> listaOferentesCompletos = new List<OferenteCompleto>();
            using (SqlConnection conn = new SqlConnection(connectionStringFuncionario))
            {
                SqlCommand cmd = new SqlCommand("sp_ObtenerTodosLosOferentesCompletos", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        listaOferentesCompletos.Add(new OferenteCompleto
                        {
                            IdUsuario = reader.GetInt32(reader.GetOrdinal("id_usuario")),
                            Nombre = reader.GetString(reader.GetOrdinal("nombre")),
                            Apellido = reader.GetString(reader.GetOrdinal("apellido")),
                            Email = reader.GetString(reader.GetOrdinal("email")),
                            Password = reader.GetString(reader.GetOrdinal("password")),
                            Rol = reader.GetString(reader.GetOrdinal("rol")),
                            FechaNacimiento = reader.GetDateTime(reader.GetOrdinal("fecha_nacimiento")),
                            NombreEmpresa = reader.GetString(reader.GetOrdinal("nombre_empresa")),
                            Direccion = reader.GetString(reader.GetOrdinal("direccion")),
                            Contacto = reader.GetString(reader.GetOrdinal("contacto")),
                            Horario = reader.GetString(reader.GetOrdinal("horario"))
                        });
                    }
                }
            }
            return listaOferentesCompletos;
        }

        public class OferenteCompleto
        {
            public int IdUsuario { get; set; }
            public string Nombre { get; set; }
            public string Apellido { get; set; }
            public string Email { get; set; }
            public string Password { get; set; }
            public string Rol { get; set; }
            public DateTime FechaNacimiento { get; set; }
            public string NombreEmpresa { get; set; }
            public string Direccion { get; set; }
            public string Contacto { get; set; }
            public string Horario { get; set; }
        }

        // Obtener todos los productos
        public List<Producto> ObtenerTodosLosProductos()
        {
            List<Producto> productos = new List<Producto>();

            using (SqlConnection conn = new SqlConnection(connectionStringFuncionario))
            {
                SqlCommand cmd = new SqlCommand("sp_ObtenerTodosLosProductos", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Producto producto = new Producto
                        {
                            IdProducto = reader.IsDBNull(reader.GetOrdinal("id_producto")) ? 0 : reader.GetInt32(reader.GetOrdinal("id_producto")),
                            IdProveedor = reader.IsDBNull(reader.GetOrdinal("id_proveedor")) ? 0 : reader.GetInt32(reader.GetOrdinal("id_proveedor")),
                            Nombre = reader.IsDBNull(reader.GetOrdinal("nombre")) ? string.Empty : reader.GetString(reader.GetOrdinal("nombre")),
                            Categoria = reader.IsDBNull(reader.GetOrdinal("categoria")) ? string.Empty : reader.GetString(reader.GetOrdinal("categoria")),
                            Precio = reader.IsDBNull(reader.GetOrdinal("precio")) ? 0m : reader.GetDecimal(reader.GetOrdinal("precio")),
                            TiempoEntrega = reader.IsDBNull(reader.GetOrdinal("tiempo_entrega")) ? 0 : reader.GetInt32(reader.GetOrdinal("tiempo_entrega")),
                            StockDisponible = reader.IsDBNull(reader.GetOrdinal("StockDisponible")) ? 0 : reader.GetInt32(reader.GetOrdinal("StockDisponible"))
                        };

                        productos.Add(producto);
                    }
                }
            }

            return productos;
        }

        public class Producto
        {
            public int IdProducto { get; set; }
            public int IdProveedor { get; set; }
            public string Nombre { get; set; }
            public string Categoria { get; set; }
            public decimal Precio { get; set; }
            public int TiempoEntrega { get; set; }
            public int StockDisponible { get; set; }
        }

    }
}