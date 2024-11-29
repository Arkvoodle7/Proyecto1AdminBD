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
        string connectionStringGenerico = ConfigurationManager.ConnectionStrings["UsuarioGenerico"].ConnectionString;
        string connectionStringFuncionario = ConfigurationManager.ConnectionStrings["UsuarioFuncionario"].ConnectionString;

        public void AgregarCliente(string nombre, string apellido, string email, string password, string direccion, string telefono, string fechanac, SqlGeography ubicacion)
        {
            using (SqlConnection connection = new SqlConnection(connectionStringGenerico))
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
         
                using (SqlConnection conn = new SqlConnection(connectionStringGenerico))
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
                using (SqlConnection conn = new SqlConnection(connectionStringGenerico))
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

        public void AgregarProducto(int idProveedor, string nombre, string categoria, decimal precio, int tiempoEntrega, int stockDisponible)
        {
            using (SqlConnection connection = new SqlConnection(connectionStringFuncionario))
            {
                using (SqlCommand command = new SqlCommand("SP_AgregarProducto", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@IdProveedor", idProveedor);
                    command.Parameters.AddWithValue("@Nombre", nombre);
                    command.Parameters.AddWithValue("@Categoria", categoria);
                    command.Parameters.AddWithValue("@Precio", precio);
                    command.Parameters.AddWithValue("@TiempoEntrega", tiempoEntrega);
                    command.Parameters.AddWithValue("@StockDisponible", stockDisponible);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        public void ModificarCliente(int idUsuario, string nombre, string apellido, string email, string password, string direccion, string telefono, string fechaNacimiento, SqlGeography ubicacion)
        {
            using (SqlConnection connection = new SqlConnection(connectionStringFuncionario))
            {
                using (SqlCommand command = new SqlCommand("SP_ModificarCliente", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@IdUsuario", idUsuario);
                    command.Parameters.AddWithValue("@Nombre", nombre);
                    command.Parameters.AddWithValue("@Apellido", apellido);
                    command.Parameters.AddWithValue("@Email", email);
                    command.Parameters.AddWithValue("@Password", password);
                    command.Parameters.AddWithValue("@Direccion", direccion);
                    command.Parameters.AddWithValue("@Telefono", telefono);
                    command.Parameters.AddWithValue("@FechaNacimiento", fechaNacimiento);

                    // Agregar el parámetro UDT para la ubicación geográfica
                    var geographyParam = new SqlParameter("@Ubicacion", ubicacion);
                    geographyParam.UdtTypeName = "geography";
                    command.Parameters.Add(geographyParam);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        public void ModificarTransportista(int idUsuario, string nombre, string apellido, string email, string password, string fechaNacimiento, string tipoTransporte, string contacto)
        {
            using (SqlConnection connection = new SqlConnection(connectionStringFuncionario))
            {
                using (SqlCommand command = new SqlCommand("SP_ModificarTransportista", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@IdUsuario", idUsuario);
                    command.Parameters.AddWithValue("@Nombre", nombre);
                    command.Parameters.AddWithValue("@Apellido", apellido);
                    command.Parameters.AddWithValue("@Email", email);
                    command.Parameters.AddWithValue("@Password", password);
                    command.Parameters.AddWithValue("@FechaNacimiento", fechaNacimiento);
                    command.Parameters.AddWithValue("@TipoTransporte", tipoTransporte);
                    command.Parameters.AddWithValue("@Contacto", contacto);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        public void ModificarOferente(int idUsuario, string nombre, string apellido, string email, string password, string fechaNacimiento, string nombreEmpresa, string direccion, string contacto, string horario, SqlGeography ubicacion)
        {
            using (SqlConnection connection = new SqlConnection(connectionStringFuncionario))
            {
                using (SqlCommand command = new SqlCommand("SP_ModificarOferente", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@IdUsuario", idUsuario);
                    command.Parameters.AddWithValue("@Nombre", nombre);
                    command.Parameters.AddWithValue("@Apellido", apellido);
                    command.Parameters.AddWithValue("@Email", email);
                    command.Parameters.AddWithValue("@Password", password);
                    command.Parameters.AddWithValue("@FechaNacimiento", fechaNacimiento);
                    command.Parameters.AddWithValue("@NombreEmpresa", nombreEmpresa);
                    command.Parameters.AddWithValue("@Direccion", direccion);
                    command.Parameters.AddWithValue("@Contacto", contacto);
                    command.Parameters.AddWithValue("@Horario", horario);

                    // Agregar el parámetro UDT para la ubicación geográfica
                    var geographyParam = new SqlParameter("@Ubicacion", ubicacion);
                    geographyParam.UdtTypeName = "geography";
                    command.Parameters.Add(geographyParam);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        public void ModificarProducto(int idProducto, int idProveedor, string nombre, string categoria, decimal precio, int tiempoEntrega, int stockDisponible)
        {
            using (SqlConnection connection = new SqlConnection(connectionStringFuncionario))
            {
                using (SqlCommand command = new SqlCommand("SP_ModificarProducto", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@IdProducto", idProducto);
                    command.Parameters.AddWithValue("@IdProveedor", idProveedor);
                    command.Parameters.AddWithValue("@Nombre", nombre);
                    command.Parameters.AddWithValue("@Categoria", categoria);
                    command.Parameters.AddWithValue("@Precio", precio);
                    command.Parameters.AddWithValue("@TiempoEntrega", tiempoEntrega);
                    command.Parameters.AddWithValue("@StockDisponible", stockDisponible);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        public void EliminarCliente(int idUsuario)
        {
            using (SqlConnection connection = new SqlConnection(connectionStringFuncionario))
            {
                using (SqlCommand command = new SqlCommand("SP_EliminarCliente", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@IdUsuario", idUsuario);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        public void EliminarTransportista(int idUsuario)
        {
            using (SqlConnection connection = new SqlConnection(connectionStringFuncionario))
            {
                using (SqlCommand command = new SqlCommand("SP_EliminarTransportista", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@IdUsuario", idUsuario);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        public void EliminarOferente(int idUsuario)
        {
            using (SqlConnection connection = new SqlConnection(connectionStringFuncionario))
            {
                using (SqlCommand command = new SqlCommand("SP_EliminarOferente", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@IdUsuario", idUsuario);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        public void EliminarProducto(int idProducto)
        {
            using (SqlConnection connection = new SqlConnection(connectionStringFuncionario))
            {
                using (SqlCommand command = new SqlCommand("SP_DeleteProducto", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@IdProducto", idProducto);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

    }
}
