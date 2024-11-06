using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos
{
    public class DatosCompra
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["SistemaEnviosDB"].ConnectionString;

        // Método para verificar el stock de un producto
        public int VerificarStock(int idProducto)
        {
            int stock = 0;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("sp_VerificarStock", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@id_producto", idProducto);

                    conn.Open();
                    stock = Convert.ToInt32(cmd.ExecuteScalar());
                }
                catch (Exception ex)
                {
                    // Manejar la excepción o registrar el error según lo necesario
                    throw new Exception("Error al verificar el stock: " + ex.Message);
                }
            }

            return stock;
        }

        // Método para crear una orden de compra
        public int CrearOrdenDeCompra(int idCliente, DateTime fechaPedido)
        {
            int idPedido = 0;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("sp_CrearOrdenDeCompra", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Agregar parámetros necesarios
                    cmd.Parameters.AddWithValue("@id_cliente", idCliente);
                    cmd.Parameters.AddWithValue("@fecha_pedido", fechaPedido);
                    cmd.Parameters.AddWithValue("@estado", "Pendiente"); // Estado inicial de la compra
                    cmd.Parameters.AddWithValue("@id_transportista", DBNull.Value); // Inicialmente nulo

                    conn.Open();
                    // Ejecutar y obtener el id_pedido generado
                    idPedido = Convert.ToInt32(cmd.ExecuteScalar());
                }
                catch (Exception ex)
                {
                    throw new Exception("Error al crear la orden de compra: " + ex.Message);
                }
            }

            return idPedido;
        }

        // Método para crear los detalles del pedido
        public void CrearDetallePedido(int idPedido, List<CarritoItem> carritoItems)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    foreach (var item in carritoItems)
                    {
                        // Insertar cada detalle en la tabla DetallePedido
                        SqlCommand cmd = new SqlCommand("INSERT INTO DetallePedido (id_pedido, id_producto, cantidad, precio_unitario) VALUES (@id_pedido, @id_producto, @cantidad, @precio_unitario)", conn);
                        cmd.Parameters.AddWithValue("@id_pedido", idPedido);
                        cmd.Parameters.AddWithValue("@id_producto", item.IdProducto);
                        cmd.Parameters.AddWithValue("@cantidad", item.Cantidad);
                        cmd.Parameters.AddWithValue("@precio_unitario", item.Precio);

                        cmd.ExecuteNonQuery();

                        // Actualizar el stock del producto
                        SqlCommand cmdUpdateStock = new SqlCommand("UPDATE Productos SET StockDisponible = StockDisponible - @cantidad WHERE id_producto = @id_producto", conn);
                        cmdUpdateStock.Parameters.AddWithValue("@cantidad", item.Cantidad);
                        cmdUpdateStock.Parameters.AddWithValue("@id_producto", item.IdProducto);

                        cmdUpdateStock.ExecuteNonQuery();
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception("Error al crear los detalles del pedido: " + ex.Message);
                }
            }
        }


        // Método para obtener un producto por su ID
        public Producto ObtenerProductoPorId(int idProducto)
        {
            Producto producto = null;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("sp_GetProductoPorId", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@id_producto", idProducto);

                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            producto = new Producto
                            {
                                IdProducto = reader.GetInt32(reader.GetOrdinal("id_producto")),
                                Nombre = reader.GetString(reader.GetOrdinal("nombre")),
                                Precio = reader.GetDecimal(reader.GetOrdinal("precio")),
                                TiempoEntrega = reader.GetInt32(reader.GetOrdinal("tiempo_entrega"))
                            };
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Manejar la excepción o registrar el error según lo necesario
                    throw new Exception("Error al obtener el producto: " + ex.Message);
                }
            }

            return producto;
        }

        public List<CarritoItem> CalcularTotalesCarrito(List<CarritoItem> carritoItems)
        {
            List<CarritoItem> resultado = new List<CarritoItem>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("sp_CalcularTotalesCarrito", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Crear DataTable para el parámetro table-valued
                    DataTable cartItemsTable = new DataTable();
                    cartItemsTable.Columns.Add("id_producto", typeof(int));
                    cartItemsTable.Columns.Add("cantidad", typeof(int));

                    foreach (var item in carritoItems)
                    {
                        cartItemsTable.Rows.Add(item.IdProducto, item.Cantidad);
                    }

                    SqlParameter param = cmd.Parameters.AddWithValue("@CartItems", cartItemsTable);
                    param.SqlDbType = SqlDbType.Structured;
                    param.TypeName = "CartItemType"; // Nombre del tipo de tabla definido por el usuario

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        CarritoItem item = new CarritoItem
                        {
                            IdProducto = reader.GetInt32(reader.GetOrdinal("id_producto")),
                            Nombre = reader.GetString(reader.GetOrdinal("nombre")),
                            Precio = reader.GetDecimal(reader.GetOrdinal("precio")),
                            Cantidad = reader.GetInt32(reader.GetOrdinal("cantidad")),
                            Subtotal = reader.GetDecimal(reader.GetOrdinal("Subtotal")),
                            Impuestos = reader.GetDecimal(reader.GetOrdinal("Impuestos")),
                            Total = reader.GetDecimal(reader.GetOrdinal("Total"))
                        };
                        resultado.Add(item);
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception("Error al calcular los totales del carrito: " + ex.Message);
                }
            }

            return resultado;
        }

        //Metodo para el calculo del precio por kilometro
        public decimal CalcularCostoEnvio(int idPedido)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                decimal distancia;
                SqlCommand cmd = new SqlCommand("SP_CalcularCostoEnvio", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@comand", 1);
                cmd.Parameters.AddWithValue("@IdPedido", idPedido);

                // Salida
                SqlParameter outputParam = new SqlParameter("@Distancia", SqlDbType.Decimal)
                {
                    Direction = ParameterDirection.Output,
                    Precision = 10,
                    Scale = 2
                };
                cmd.Parameters.Add(outputParam);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();


                    distancia = (decimal)outputParam.Value;

                    return distancia;


                }
                catch (SqlException ex)
                {
                    throw new Exception("Error al calcular la distancia del envio: " + ex.Message);
                }
            }
        }

        public decimal CalcularDistancia(int idPedido)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                decimal distancia;
                SqlCommand cmd = new SqlCommand("SP_CalcularCostoEnvio", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@comand", 2);
                cmd.Parameters.AddWithValue("@IdPedido", idPedido);

                // Salida
                SqlParameter outputParam = new SqlParameter("@Distancia", SqlDbType.Decimal)
                {
                    Direction = ParameterDirection.Output,
                    Precision = 10,
                    Scale = 2
                };
                cmd.Parameters.Add(outputParam);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();


                    distancia = (decimal)outputParam.Value;

                    return distancia;


                }
                catch (SqlException ex)
                {
                    throw new Exception("Error al calcular la distancia del envio: " + ex.Message);
                }
            }
        }
        public List<PedidoDatos> ObtenerPedidosPendientes(int idCliente)
        {
            List<PedidoDatos> listaPedidos = new List<PedidoDatos>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SP_PedidosPendientes", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", idCliente);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    PedidoDatos pedido = new PedidoDatos
                    {
                        IdPedido = (int)reader["id_pedido"],
                        FechaPedido = (DateTime)reader["fecha_pedido"],
                        Estado = reader["estado"].ToString(),
                        Subtotal = (decimal)reader["Subtotal"],
                        Impuestos = (decimal)reader["Impuestos"],
                        Total = (decimal)reader["Total"]
                    };

                    listaPedidos.Add(pedido);
                }
            }

            return listaPedidos;
        }




        // Clase CarritoItem en la capa de Datos
        public class CarritoItem
        {
            public int IdProducto { get; set; }
            public string Nombre { get; set; }
            public decimal Precio { get; set; }
            public int Cantidad { get; set; }
            public decimal Subtotal { get; set; }
            public decimal Impuestos { get; set; }
            public decimal Total { get; set; }
        }

    }

    // Clase Producto que modela la entidad Producto
    public class Producto
    {
        public int IdProducto { get; set; }
        public string Nombre { get; set; }
        public decimal Precio { get; set; }
        public int TiempoEntrega { get; set; }
    }

    public class PedidoDatos
    {
        public int IdPedido { get; set; }
        public DateTime FechaPedido { get; set; }
        public string Estado { get; set; }
        public decimal Subtotal { get; set; }
        public decimal Impuestos { get; set; }
        public decimal Total { get; set; }
        public string Transportista { get; set; }
        public int TiempoEntrega { get; set; }
        public string ContactoTransportista { get; set; }
    }


}