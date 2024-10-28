﻿using System;
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
        public string CrearOrdenDeCompra(int idCliente, int idProducto, int cantidad, DateTime fechaPedido)
        {
            string resultado;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("sp_CrearOrdenDeCompra", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Agregar parámetros necesarios
                    cmd.Parameters.AddWithValue("@id_cliente", idCliente);
                    cmd.Parameters.AddWithValue("@id_producto", idProducto);
                    cmd.Parameters.AddWithValue("@cantidad", cantidad);
                    cmd.Parameters.AddWithValue("@id_transportista", DBNull.Value); // Inicialmente nulo
                    cmd.Parameters.AddWithValue("@estado", "Pendiente"); // Estado inicial de la compra
                    cmd.Parameters.AddWithValue("@fecha_pedido", fechaPedido); // Fecha del pedido
                    cmd.Parameters.AddWithValue("@costo_total", 0); // Inicializar el costo total (se calculará en el SP)

                    conn.Open();
                    int filasAfectadas = cmd.ExecuteNonQuery();

                    resultado = filasAfectadas > 0 ? "Compra realizada con éxito." : "Error al realizar la compra.";
                }
                catch (Exception ex)
                {
                    // Manejar la excepción o registrar el error según sea necesario
                    throw new Exception("Error al crear la orden de compra: " + ex.Message);
                }
            }

            return resultado;
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
}