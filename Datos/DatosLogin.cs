using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Datos
{
    public class DatosLogin
    {
        public static (string, int) VerificarCredenciales(string email, string password)
        {
            // Obtener la cadena de conexión del archivo Web.config
            string connectionString = ConfigurationManager.ConnectionStrings["SistemaEnviosDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SP_IniciarSesion", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Password", password);

                try
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        string rol = reader["Rol"].ToString();
                        int idUsuario = Convert.ToInt32(reader["IdUsuario"]);
                        return (rol, idUsuario); // Devolver el rol y el id del usuario
                    }
                    else
                    {
                        return (null, 0); // Si no hay coincidencia
                    }
                }
                catch (Exception)
                {
                    // Manejo de errores
                    return (null, 0);
                }
            }
        }
    }
}