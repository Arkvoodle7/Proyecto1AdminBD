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
    public class DatosCliente
    {
        string connectionString = ConfigurationManager.ConnectionStrings["SistemaEnviosDB"].ConnectionString;

        // Obtener Cliente por Id
        public Cliente ObtenerClientePorId(int id)
        {
            Cliente cliente = null;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("sp_ObtenerClientePorID", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id_cliente", id);

                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        cliente = new Cliente
                        {
                            Id = reader.GetInt32(0),        // id_cliente
                            Telefono = reader.GetString(1),    // email
                            Direccion = reader.GetString(2) // direccion
                        };
                    }
                }
            }
            return cliente;
        }

        // Actualizar Cliente
        public void ActualizarCliente(int id, string telefono, string direccion)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("sp_UpdateCliente", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@id_cliente", id);
                cmd.Parameters.AddWithValue("@telefono", telefono);
                cmd.Parameters.AddWithValue("@direccion", direccion);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        // Eliminar Cliente
        public void EliminarCliente(int id)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("sp_DeleteCliente", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@id_cliente", id);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }
        public List<HistorialCompra> ObtenerHistorialCompras(int idCliente)
        {
            List<HistorialCompra> listaHistorial = new List<HistorialCompra>();

            // Configurar la conexión a la base de datos
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("sp_ObtenerHistorialComprasPorCliente", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IdCliente", idCliente);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    HistorialCompra historial = new HistorialCompra
                    {
                        IdHistorial = (int)reader["id_historial"],
                        IdPedido = (int)reader["id_pedido"],
                        FechaEntrega = (DateTime)reader["fecha_entrega"],
                        Observaciones = reader["observaciones"].ToString()
                    };

                    listaHistorial.Add(historial);
                }
            }

            return listaHistorial;
        }
    }
    public class Cliente
    {
        public int Id { get; set; }           // id_cliente
        public string Telefono { get; set; }     // email
        public string Direccion { get; set; } // direccion
    }
    public class HistorialCompra
    {
        public int IdHistorial { get; set; }
        public int IdPedido { get; set; }
        public DateTime FechaEntrega { get; set; }
        public string Observaciones { get; set; }
    }
}
