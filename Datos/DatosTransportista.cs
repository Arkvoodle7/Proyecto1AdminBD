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
        string connectionStringTransportista = ConfigurationManager.ConnectionStrings["UsuarioTransportista"].ConnectionString;
        string connectionStringFuncionario = ConfigurationManager.ConnectionStrings["UsuarioFuncionario"].ConnectionString;

        public Transportista ObtenerTransportistaPorId(int id)
        {
            Transportista transportista = null;
            using (SqlConnection conn = new SqlConnection(connectionStringTransportista))
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
            using (SqlConnection conn = new SqlConnection(connectionStringTransportista))
            {
                SqlCommand cmd = new SqlCommand("sp_UpdateTransportista", conn);
                cmd.CommandType = CommandType.StoredProcedure;

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
            using (SqlConnection conn = new SqlConnection(connectionStringTransportista))
            {
                SqlCommand cmd = new SqlCommand("sp_DeleteTransportista", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@id_transportista", id);
                
                
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }
        public void AsignarTransportistaAPedido(int idPedido, int idTransportista)
        {
            using (SqlConnection conn = new SqlConnection(connectionStringTransportista))
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
                    Console.WriteLine($"Error Number: {ex.Number}, Message: {ex.Message}");
                    throw; // Lanza la excepción para ser manejada en la capa superior
                }

            }
        }


        // Método para obtener todos los pedidos
        public List<Pedido> ObtenerTodosLosPedidos()
        {
            List<Pedido> pedidos = new List<Pedido>();
            using (SqlConnection conn = new SqlConnection(connectionStringTransportista))
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
                            IdPedido = reader.GetInt32(0), // id_pedido (nunca es nulo si es PK)
                            IdCliente = reader.IsDBNull(1) ? (int?)null : reader.GetInt32(1), // id_cliente
                            IdProducto = reader.IsDBNull(2) ? (int?)null : reader.GetInt32(2), // id_producto
                            IdTransportista = reader.IsDBNull(3) ? (int?)null : reader.GetInt32(3), // id_transportista
                            FechaPedido = reader.IsDBNull(4) ? (DateTime?)null : reader.GetDateTime(4), // fecha_pedido
                            Estado = reader.IsDBNull(5) ? null : reader.GetString(5), // estado
                            CostoTotal = reader.IsDBNull(6) ? (decimal?)null : reader.GetDecimal(6) // costo_total
                        };
                        pedidos.Add(pedido);
                    }
                }
            }
            return pedidos;
        }

        public List<TransportistaCompleto> ObtenerTodosLosTransportistasCompletos()
        {
            List<TransportistaCompleto> listaTransportistasCompletos = new List<TransportistaCompleto>();
            using (SqlConnection conn = new SqlConnection(connectionStringFuncionario))
            {
                SqlCommand cmd = new SqlCommand("sp_ObtenerTodosLosTransportistasCompletos", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        listaTransportistasCompletos.Add(new TransportistaCompleto
                        {
                            IdUsuario = reader.GetInt32(reader.GetOrdinal("id_usuario")),
                            Nombre = reader.GetString(reader.GetOrdinal("nombre")),
                            Apellido = reader.GetString(reader.GetOrdinal("apellido")),
                            Email = reader.GetString(reader.GetOrdinal("email")),
                            Password = reader.GetString(reader.GetOrdinal("password")),
                            Rol = reader.GetString(reader.GetOrdinal("rol")),
                            FechaNacimiento = reader.GetDateTime(reader.GetOrdinal("fecha_nacimiento")),
                            TipoTransporte = reader.GetString(reader.GetOrdinal("tipo_transporte")),
                            Contacto = reader.GetString(reader.GetOrdinal("contacto"))
                        });
                    }
                }
            }
            return listaTransportistasCompletos;
        }

        public class TransportistaCompleto
        {
            public int IdUsuario { get; set; }
            public string Nombre { get; set; }
            public string Apellido { get; set; }
            public string Email { get; set; }
            public string Password { get; set; }
            public string Rol { get; set; }
            public DateTime FechaNacimiento { get; set; }
            public string TipoTransporte { get; set; }
            public string Contacto { get; set; }
        }


    }
    public class Pedido
    {
        public int IdPedido { get; set; }
        public int? IdCliente { get; set; }
        public int? IdProducto { get; set; }
        public int? IdTransportista { get; set; }
        public DateTime? FechaPedido { get; set; }
        public string Estado { get; set; }
        public decimal? CostoTotal { get; set; }
    }


    public class Transportista
    {
        public int Id { get; set; }
        public string TipoTransporte { get; set; }
        public string Contacto { get; set; }
    }
}
