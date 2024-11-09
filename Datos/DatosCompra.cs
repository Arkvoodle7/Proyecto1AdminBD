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
        public int CrearOrdenDeCompra(int idCliente, DateTime fechaPedido, int idProductoPrincipal, decimal costoTotal)
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
                    cmd.Parameters.AddWithValue("@estado", "Pendiente");
                    cmd.Parameters.AddWithValue("@id_transportista", DBNull.Value);
                    cmd.Parameters.AddWithValue("@id_producto", idProductoPrincipal);
                    cmd.Parameters.AddWithValue("@costo_total", costoTotal); // Nuevo parámetro

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
                        // Llamar al procedimiento almacenado SP_CrearDetallePedido para insertar el detalle del pedido
                        SqlCommand cmd = new SqlCommand("SP_CrearDetallePedido", conn);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@id_pedido", idPedido);
                        cmd.Parameters.AddWithValue("@id_producto", item.IdProducto);
                        cmd.Parameters.AddWithValue("@cantidad", item.Cantidad);
                        cmd.Parameters.AddWithValue("@precio_unitario", item.Precio);

                        cmd.ExecuteNonQuery();

                        // Llamar al procedimiento almacenado SP_ActualizarStockProducto para actualizar el stock del producto
                        SqlCommand cmdUpdateStock = new SqlCommand("SP_ActualizarStockProducto", conn);
                        cmdUpdateStock.CommandType = CommandType.StoredProcedure;
                        cmdUpdateStock.Parameters.AddWithValue("@id_producto", item.IdProducto);
                        cmdUpdateStock.Parameters.AddWithValue("@cantidad", item.Cantidad);

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
        public decimal CalcularCostoEnvio(int idPedido, out decimal costoTotal)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SP_CalcularCostoEnvio", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdPedido", idPedido);

                // Parámetro de salida
                SqlParameter outputParam = new SqlParameter("@CostoTotal", SqlDbType.Decimal)
                {
                    Direction = ParameterDirection.Output,
                    Precision = 10,
                    Scale = 2
                };
                cmd.Parameters.Add(outputParam);

                conn.Open();
                cmd.ExecuteNonQuery();

                costoTotal = (decimal)outputParam.Value;
                return costoTotal;
            }
        }

        //Actualiza el estado del pedido a entregado usando el id del cliente y el transportista
        public void ActualizarEstadoPedido(int idTransportista)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SP_ActualizarEstadoPedido", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                // Parámetros de entrada
                //cmd.Parameters.AddWithValue("@IdPedido", idPedido);
                cmd.Parameters.AddWithValue("@IdTransportista", idTransportista);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }


        // Metodo para el calculo del precio por kilometro y costo total
        public (decimal distancia, decimal costoTotal) CalcularKilometros(int idPedido)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SP_CalcularDistancia", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdPedido", idPedido);

                // Parámetro de salida para la distancia
                SqlParameter outputDistancia = new SqlParameter("@DistanciaKm", SqlDbType.Decimal)
                {
                    Direction = ParameterDirection.Output,
                    Precision = 10,
                    Scale = 2
                };
                cmd.Parameters.Add(outputDistancia);

                // Parámetro de salida para el costo total
                SqlParameter outputCostoTotal = new SqlParameter("@CostoTotal", SqlDbType.Decimal)
                {
                    Direction = ParameterDirection.Output,
                    Precision = 10,
                    Scale = 2
                };
                cmd.Parameters.Add(outputCostoTotal);

                conn.Open();
                cmd.ExecuteNonQuery();

                
                decimal distancia = (decimal)outputDistancia.Value;
                decimal costoTotal = (decimal)outputCostoTotal.Value;

                
                return (distancia, costoTotal);
            }
        }

        public decimal CalcularDistancia(int idPedido)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                decimal distancia;
                SqlCommand cmd = new SqlCommand("SP_CalcularCostoEnvio", conn);
                cmd.CommandType = CommandType.StoredProcedure;

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
                SqlCommand cmd = new SqlCommand("SP_PendientesTransportista", conn);
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
                        Total = (decimal)reader["total"],
                        //TiempoEntrega = reader.IsDBNull(reader.GetOrdinal("tiempo_entrega")) ? 0 : (int)reader["tiempo_entrega"],
                        IdCliente = (int)reader["id_cliente"],
                        Telefono = reader["telefono"].ToString()
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
        public decimal Total { get; set; }
        //public int TiempoEntrega { get; set; }
        public int IdCliente { get; set; }
        public string Telefono { get; set; }
    }


}