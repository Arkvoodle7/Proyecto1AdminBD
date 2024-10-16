using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;

namespace Datos
{
    public class DatosTransportista
    {
        string connectionString = ConfigurationManager.ConnectionStrings["SistemaEnviosDB"].ConnectionString;


        public Transportista ObtenerTransportistaPorId(int id)
        {
            Transportista transportista = null;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("sp_ObtenerTransPorID", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id_transportista", id);

                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        transportista = new Transportista
                        {
                            Id = reader.GetInt32(0), // id_transportista
                            TipoTransporte = reader.GetString(1), // tipo_transporte
                            Contacto = reader.GetString(2) // contacto
                        };
                    }
                }
            }
            return transportista;
        }


        // Método para actualizar el tipo de transporte de un transportista usando id_transportista
        public void ActualizarTransportista(int id, string tipoTransporte, string contacto)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("UPDATE Transportistas SET tipo_transporte = @tipo_transporte, contacto = @contacto WHERE id_transportista = @id_transportista", conn);

                cmd.Parameters.AddWithValue("@id_transportista", id);
                cmd.Parameters.AddWithValue("@tipo_transporte", tipoTransporte);
                cmd.Parameters.AddWithValue("@contacto", contacto);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        // Eliminar transportista
        public void EliminarTransportista(int id)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM Transportistas WHERE id_transportista = @id_transportista", conn);
                cmd.Parameters.AddWithValue("@id_transportista", id);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }
        public void AsignarTransportistaAPedido(int idPedido, int idTransportista)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("sp_ActualizarEstadoYAsignarTransportista", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id_pedido", idPedido);
                cmd.Parameters.AddWithValue("@id_transportista", idTransportista);
                cmd.Parameters.AddWithValue("@nuevoEstado", "en camino");

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (SqlException ex)
                {
                    // Lanza una excepción personalizada si el error proviene del trigger
                    if (ex.Number == 50000) // Número del error específico lanzado desde el trigger
                    {
                        throw new Exception("El transportista ya tiene un envío activo.");
                    }
                    else
                    {
                        throw; // Relanza la excepción para que sea manejada en la capa superior
                    }
                }
            }
        }


        // Método para obtener todos los pedidos
        public List<Pedido> ObtenerTodosLosPedidos()
        {
            List<Pedido> pedidos = new List<Pedido>();
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("sp_ObtenerTodosLosPedidos", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Pedido pedido = new Pedido
                        {
                            IdPedido = reader.GetInt32(0),                      // id_pedido
                            IdCliente = reader.GetInt32(1),                     // id_cliente
                            IdProducto = reader.GetInt32(2),                    // id_producto
                                                                                // Si no necesitas id_transportista, no lo incluyas
                            FechaPedido = reader.GetDateTime(4),                 // fecha_pedido (5ta columna)
                            Estado = reader.GetString(5),                        // estado (6ta columna)
                            CostoTotal = reader.GetDecimal(6)                    // costo_total (7ma columna)
                        };
                        pedidos.Add(pedido);
                    }
                }
            }
            return pedidos;
        }

    }
    public class Pedido
    {
        public int IdPedido { get; set; }        // id_pedido
        public int IdCliente { get; set; }       // id_cliente
        public int IdProducto { get; set; }      // id_producto
        public DateTime FechaPedido { get; set; } // fecha_pedido
        public string Estado { get; set; }       // estado
        public decimal CostoTotal { get; set; }  // costo_total
    }

    public class Transportista
    {
        public int Id { get; set; }
        public string TipoTransporte { get; set; }
        public string Contacto { get; set; }
    }
}
