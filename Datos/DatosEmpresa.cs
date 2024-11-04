﻿using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Runtime.ConstrainedExecution;
using System.Diagnostics.Contracts;
using static Datos.DatosCliente;

namespace Datos
{
    public class DatosEmpresa
    {
        

        string connectionString = ConfigurationManager.ConnectionStrings["SistemaEnviosDB"].ConnectionString;

        public List<string> ObtenerProvedor(int id)
        {
            List<string> Provedor = new List<string>();

            using (SqlConnection conn = new SqlConnection(connectionString))
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
            using (SqlConnection conn = new SqlConnection(connectionString))
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

        public void UpdateProducto(int idProducto, int idProvedor, string nombre, string categoria, decimal precio, int tiempoEntrega, decimal stock)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
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
            using (SqlConnection conn = new SqlConnection(connectionString))
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

            using (SqlConnection conn = new SqlConnection(connectionString))
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

            using (SqlConnection conn = new SqlConnection(connectionString))
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


        public List<Productos> ObtenerProductosProvedor(int provedor)
        {
            List<Productos> productosProvedor = new List<Productos>();

            using (SqlConnection conn = new SqlConnection(connectionString))
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
                            Productos producto = new Productos
                            {
                                IdProducto = Convert.ToInt32(reader["id_producto"]),
                                IdProveedor = Convert.ToInt32(reader["id_proveedor"]),
                                Nombre = reader["nombre"].ToString(),
                                Categoria = reader["categoria"].ToString(),
                                Precio = Convert.ToDecimal(reader["precio"]),
                                TiempoEntrega = reader.IsDBNull(reader.GetOrdinal("tiempo_entrega")) ? 0 : Convert.ToInt32(reader["tiempo_entrega"]),
                                StockDisponible = reader.IsDBNull(reader.GetOrdinal("StockDisponible")) ? 0 : Convert.ToInt32(reader["StockDisponible"])
                            };

                            productosProvedor.Add(producto);
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
            using (SqlConnection conn = new SqlConnection(connectionString))
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
            using (SqlConnection conn = new SqlConnection(connectionString))
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

            using (SqlConnection conn = new SqlConnection(connectionString))
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

        public void UpdateProvedor(int idProveedor, string nombreEmpresa, string direccion, string contacto, string horario, string ubicacion)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SP_UpdateProveedor", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdProveedor", idProveedor);
                cmd.Parameters.AddWithValue("@NombreEmpresa", nombreEmpresa);
                cmd.Parameters.AddWithValue("@Direccion", direccion);
                cmd.Parameters.AddWithValue("@Contacto", contacto);
                cmd.Parameters.AddWithValue("@Horario", horario);

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


        public List<PedidosClase> ObtenerPedidosPorProveedor(int proveedorId)
        {
            List<PedidosClase> pedidosProveedor = new List<PedidosClase>();


            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("sp_ObtenerPedidosPorProveedor", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id_proveedor", proveedorId);

                try
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            PedidosClase pedido = new PedidosClase
                            {
                                IdPedido = Convert.ToInt32(reader["id_pedido"]),
                                IdCliente = reader.IsDBNull(reader.GetOrdinal("id_cliente")) ? (int?)null : Convert.ToInt32(reader["id_cliente"]),
                                IdProducto = reader.IsDBNull(reader.GetOrdinal("id_producto")) ? (int?)null : Convert.ToInt32(reader["id_producto"]),
                                IdTransportista = reader.IsDBNull(reader.GetOrdinal("id_transportista")) ? (int?)null : Convert.ToInt32(reader["id_transportista"]),
                                FechaPedido = reader.IsDBNull(reader.GetOrdinal("fecha_pedido")) ? (DateTime?)null : Convert.ToDateTime(reader["fecha_pedido"]),
                                Estado = reader["estado"].ToString(),
                                CostoTotal = reader.IsDBNull(reader.GetOrdinal("costo_total")) ? (decimal?)null : Convert.ToDecimal(reader["costo_total"]),
                                Cantidad = Convert.ToInt32(reader["cantidad"])
                            };

                            pedidosProveedor.Add(pedido);
                        }
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception("Error al obtener los pedidos: " + ex.Message);
                }
            }

            return pedidosProveedor;
        }

        public class Productos
        {
            public int IdProducto { get; set; }
            public int IdProveedor { get; set; }
            public string Nombre { get; set; }
            public string Categoria { get; set; }
            public decimal Precio { get; set; }
            public int TiempoEntrega { get; set; }
            public int? StockDisponible { get; set; }


        }

        public class PedidosClase
        {
            public int IdPedido { get; set; }
            public int? IdCliente { get; set; }
            public int? IdProducto { get; set; }
            public int? IdTransportista { get; set; }
            public DateTime? FechaPedido { get; set; }
            public string Estado { get; set; }
            public decimal? CostoTotal { get; set; }
            public int Cantidad { get; set; }
        }
    }
}