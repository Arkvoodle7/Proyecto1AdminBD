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
        string connectionString = ConfigurationManager.ConnectionStrings["UsuarioCliente"].ConnectionString;

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
        public List<Pedido> ObtenerPedidosEntregados(int idCliente)
        {
            List<Pedido> listaPedidos = new List<Pedido>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("sp_ObtenerPedidosEntregadosPorCliente", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IdCliente", idCliente);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    Pedido pedido = new Pedido
                    {
                        IdPedido = (int)reader["id_pedido"],
                        FechaPedido = (DateTime)reader["fecha_pedido"],
                        Estado = reader["estado"].ToString(),
                        Subtotal = (decimal)reader["Subtotal"],
                        Impuestos = (decimal)reader["Impuestos"],
                        Entrega = (decimal)reader["costo_total"],
                        Total = (decimal)reader["Total"]
                    };

                    listaPedidos.Add(pedido);
                }
            }

            return listaPedidos;
        }

        public List<PedidoConDetallesDto> ObtenerPedidosConDetalles(int idCliente)
        {
            List<PedidoConDetallesDto> listaPedidos = new List<PedidoConDetallesDto>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("sp_ObtenerPedidosConDetalles", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IdCliente", idCliente);

                conn.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        listaPedidos.Add(new PedidoConDetallesDto
                        {
                            IdPedido = reader.GetInt32(reader.GetOrdinal("IdPedido")),
                            FechaPedido = reader.GetDateTime(reader.GetOrdinal("FechaPedido")),
                            Estado = reader.GetString(reader.GetOrdinal("Estado")),
                            Subtotal = reader.GetDecimal(reader.GetOrdinal("Subtotal")),
                            Impuestos = reader.GetDecimal(reader.GetOrdinal("Impuestos")),
                            Total = reader.GetDecimal(reader.GetOrdinal("Total")),
                            Transportista = reader.IsDBNull(reader.GetOrdinal("Transportista")) ? null : reader.GetString(reader.GetOrdinal("Transportista")),
                            ContactoTransportista = reader.IsDBNull(reader.GetOrdinal("ContactoTransportista")) ? null : reader.GetString(reader.GetOrdinal("ContactoTransportista")),
                            TiempoEntrega = reader.GetInt32(reader.GetOrdinal("TiempoEntrega")),
                            CostoEntrega = reader.IsDBNull(reader.GetOrdinal("CostoEntrega")) ? "0" : reader.GetDecimal(reader.GetOrdinal("CostoEntrega")) == 1050 ? "0" : reader.GetDecimal(reader.GetOrdinal("CostoEntrega")).ToString("F2")
                        });
                    }
                }
            }

            return listaPedidos;
        }


        public class Pedido
        {
            public int IdPedido { get; set; }
            public DateTime FechaPedido { get; set; }
            public string Estado { get; set; }
            public decimal Subtotal { get; set; }
            public decimal Impuestos { get; set; }
            public decimal Total { get; set; }
            public decimal Entrega { get; set; }
        }

        public class PedidoConDetallesDto
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
            public string CostoEntrega { get; set; }
        }

    }

    public class Cliente
    {
        public int Id { get; set; }
        public string Telefono { get; set; }
        public string Direccion { get; set; }
    }
}
