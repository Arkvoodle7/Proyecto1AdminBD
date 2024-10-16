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
    public class DatosContacto
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["SistemaEnviosDB"].ConnectionString;
        public void InsertarContacto(string nombre, string email, string mensaje)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("sp_InsertarContacto", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@Nombre", nombre);
                    command.Parameters.AddWithValue("@Email", email);
                    command.Parameters.AddWithValue("@Mensaje", mensaje);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }
    }
}
