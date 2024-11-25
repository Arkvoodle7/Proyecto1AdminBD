using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Microsoft.SqlServer.Types;
using System.Data.SqlClient;
using System.Configuration;

namespace Datos
{
    public class DatosRegistro
    {
        string connectionString = ConfigurationManager.ConnectionStrings["UsuarioGenerico"].ConnectionString;

        public void AgregarCliente(string nombre, string apellido, string email, string password, string direccion, string telefono, string fechanac, SqlGeography ubicacion)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("SP_AgregarCliente", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@Nombre", nombre);
                    command.Parameters.AddWithValue("@Apellido", apellido);
                    command.Parameters.AddWithValue("@Email", email);
                    command.Parameters.AddWithValue("@Password", password);
                    command.Parameters.AddWithValue("@Direccion", direccion);
                    command.Parameters.AddWithValue("@Telefono", telefono);
                    command.Parameters.AddWithValue("@FechaNacimiento", fechanac);

                    // Agregar el parámetro UDT
                    var geographyParam = new SqlParameter("@Ubicacion", ubicacion);
                    geographyParam.UdtTypeName = "geography"; 
                    command.Parameters.Add(geographyParam);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        public void AgregarProveedor(string nombre, string apellido, string email, string password, string nombreEmpresa, string direccion, string contacto, string horario, string fechanac, SqlGeography ubicacion)
        {
            try
            {
         
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand("SP_AgregarProveedor", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Nombre", nombre);
                    cmd.Parameters.AddWithValue("@Apellido", apellido);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", password);
                    cmd.Parameters.AddWithValue("@NombreEmpresa", nombreEmpresa);
                    cmd.Parameters.AddWithValue("@Direccion", direccion);
                    cmd.Parameters.AddWithValue("@Contacto", contacto);
                    cmd.Parameters.AddWithValue("@Horario", horario);
                    cmd.Parameters.AddWithValue("@FechaNacimiento", fechanac);
                    
                    // Agregar el parámetro UDT
                    var geographyParam = new SqlParameter("@Ubicacion", ubicacion);
                    geographyParam.UdtTypeName = "geography";
                    cmd.Parameters.Add(geographyParam);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            catch (SqlException ex)
            {
                // Lanza la excepción hacia arriba
                throw new Exception(ex.Message);
            }
        }

        public void AgregarTransportista(string nombre, string apellido, string email, string password, string tipoTransporte, string contacto, string fechanac)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand("SP_AgregarTransportista", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Nombre", nombre);
                    cmd.Parameters.AddWithValue("@Apellido", apellido);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", password);
                    cmd.Parameters.AddWithValue("@TipoTransporte", tipoTransporte);
                    cmd.Parameters.AddWithValue("@Contacto", contacto);
                    cmd.Parameters.AddWithValue("@FechaNacimiento", fechanac);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            catch (SqlException ex)
            {
                // Lanza la excepción hacia arriba
                throw new Exception(ex.Message);
            }
        }
        private SqlGeography ConvertToGeography(string geography)
        {
            // Ejemplo: Si geography es un string con coordenadas
            string[] coords = geography.Split(',');
            double latitude = double.Parse(coords[0]);
            double longitude = double.Parse(coords[1]);

            return SqlGeography.Point(latitude, longitude, 4326); // 4326 es el SRID para WGS 84
        }
    }
}
