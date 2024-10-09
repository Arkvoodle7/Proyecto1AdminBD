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

        // Método para actualizar el tipo de transporte de un transportista usando id_transportista
        public void ActualizarTransportista(int id, string tipoTransporte)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("sp_UpdateTransportista", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@id_transportista", id);
                cmd.Parameters.AddWithValue("@tipo_transporte", tipoTransporte);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (SqlException ex)
                {
                    throw new Exception("Error al actualizar el transportista: " + ex.Message);
                }
            }
        }

        // Método para eliminar un transportista usando id_transportista
        public void EliminarTransportista(int id)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("sp_DeleteTransportista", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@id_transportista", id);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (SqlException ex)
                {
                    throw new Exception("Error al eliminar el transportista: " + ex.Message);
                }
            }
        }
    }
}

