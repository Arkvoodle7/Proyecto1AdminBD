﻿using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;

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
                SqlCommand cmd = new SqlCommand("SP_SelectProvedor", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", id); 

                try
                {
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            Provedor.Add(Convert.ToString(reader["id_usuario"])); 
                            Provedor.Add(reader["nombre"].ToString());            
                            Provedor.Add(reader["apellido"].ToString());         
                            Provedor.Add(reader["email"].ToString());             
                            Provedor.Add(reader["nombre_empresa"].ToString());    
                            Provedor.Add(reader["contacto"].ToString());          
                            Provedor.Add(reader["direccion"].ToString());       
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

        public void InsertProducto(int idProvedor, string nombre, string categoria, decimal precio, int tiempoEntrega)
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

        public void UpdateProducto(int idProducto, int idProvedor, string nombre, string categoria, decimal precio, int tiempoEntrega)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SP_InsertProducto", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdProducto", idProducto);
                cmd.Parameters.AddWithValue("@IdProvedor", idProvedor);
                cmd.Parameters.AddWithValue("@Nombre", nombre);
                cmd.Parameters.AddWithValue("@Categoria", categoria);
                cmd.Parameters.AddWithValue("@Precio", precio);
                cmd.Parameters.AddWithValue("@Tiempo_Entrega", tiempoEntrega);

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

        public Productos ObtenerProducto(int IdProducto)
        {
            Productos pr = new Productos();
            
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
                        pr.Id = Convert.ToInt32(reader["IdUsuario"]);
                        pr.IdProveedor = Convert.ToInt32(reader["IdUsuario"]);
                        pr.Nombre = reader["Rol"].ToString();
                        pr.Categoria = reader["Rol"].ToString();
                        pr.Precio = Convert.ToDecimal(reader["IdUsuario"]);
                        pr.TiempoEntrega = Convert.ToInt32(reader["IdUsuario"]);
                        
                    }
                    return pr;
                }
                catch (Exception ex)
                {
                    throw new Exception("Error al encontrar un producto" + ex.Message);
                }
            }
        }



        public List<Productos> ObtenerProductosLista(string categoria)
        {
            List<Productos> listaPr = new List<Productos>();

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
                        Productos pr = new Productos();

                        pr.Id = Convert.ToInt32(reader["id_producto"]); 
                        pr.IdProveedor = Convert.ToInt32(reader["id_proveedor"]); 
                        pr.Nombre = reader["nombre"].ToString(); 
                        pr.Categoria = reader["categoria"].ToString(); 
                        pr.Precio = Convert.ToDecimal(reader["precio"]); 
                        pr.TiempoEntrega = Convert.ToInt32(reader["tiempo_entrega"]); 

                        listaPr.Add(pr);
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception("Error al encontrar productos por categoría: " + ex.Message);
                }
            }

            return listaPr;
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

        public void InsertCarrito(int IdPedido, int IdProducto)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SP_InsertCarrito", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IdCliente", IdPedido);
                cmd.Parameters.AddWithValue("@IdProducto", IdProducto);


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



    }


    public class Productos
    {
        public int Id { get; set; }
        public int IdProveedor { get; set; }
        public string Nombre { get; set; }
        public string Categoria { get; set; }
        public decimal Precio { get; set; }
        public int TiempoEntrega { get; set; }
    }
    
}

