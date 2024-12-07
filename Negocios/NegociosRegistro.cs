using Datos;
using Microsoft.SqlServer.Types;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace Negocios
{
    public class NegociosRegistro
    {
        DatosRegistro datosRegistro = new DatosRegistro();
        public void RegistrarCliente(string nombre, string apellido, string email, string password, string direccion, string telefono, string fechanac, SqlGeography ubicacion)
        {
            try
            {
               
                datosRegistro.AgregarCliente(nombre, apellido, email, password, direccion, telefono, fechanac, ubicacion);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public void RegistrarProveedor(string nombre, string apellido, string email, string password, string nombreEmpresa, string direccion, string contacto, string horario, string fechanac, SqlGeography ubicacion )
        {
            try
            {
                datosRegistro.AgregarProveedor(nombre, apellido, email, password, nombreEmpresa, direccion, contacto, horario, fechanac, ubicacion);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public void RegistrarTransportista(string nombre, string apellido, string email, string password, string tipoTransporte, string contacto, string fechanac)
        {
            try
            {
                datosRegistro.AgregarTransportista(nombre, apellido, email, password, tipoTransporte, contacto, fechanac);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        //Método para validar campos del cliente
        public void ValidarCamposCliente(string nombre, string apellido, string email, string password, string direccion, string telefono)
        {
            if (string.IsNullOrWhiteSpace(nombre)) throw new ArgumentException("El nombre no puede estar vacío.");
            if (string.IsNullOrWhiteSpace(apellido)) throw new ArgumentException("El apellido no puede estar vacío.");
            if (string.IsNullOrWhiteSpace(email)) throw new ArgumentException("El email no puede estar vacío.");
            if (string.IsNullOrWhiteSpace(password)) throw new ArgumentException("La contraseña no puede estar vacía.");
            if (string.IsNullOrWhiteSpace(direccion)) throw new ArgumentException("La dirección no puede estar vacía.");
            if (string.IsNullOrWhiteSpace(telefono)) throw new ArgumentException("El teléfono no puede estar vacío.");

            // Validar formato del teléfono
            if (!Regex.IsMatch(telefono, @"^\d+$")) throw new ArgumentException("El teléfono solo puede contener dígitos.");
        }

        // Método para validar campos del proveedor
        public void ValidarCamposProveedor(string nombre, string apellido, string email, string password, string nombreEmpresa, string direccion, string contacto, string horario)
        {
            // Se pueden agregar validaciones similares a las del cliente
            if (string.IsNullOrWhiteSpace(nombre)) throw new ArgumentException("El nombre no puede estar vacío.");
            if (string.IsNullOrWhiteSpace(apellido)) throw new ArgumentException("El apellido no puede estar vacío.");
            if (string.IsNullOrWhiteSpace(email)) throw new ArgumentException("El email no puede estar vacío.");
            if (string.IsNullOrWhiteSpace(password)) throw new ArgumentException("La contraseña no puede estar vacía.");
            if (string.IsNullOrWhiteSpace(nombreEmpresa)) throw new ArgumentException("El nombre de la empresa no puede estar vacío.");
            if (string.IsNullOrWhiteSpace(direccion)) throw new ArgumentException("La dirección no puede estar vacía.");
            if (string.IsNullOrWhiteSpace(contacto)) throw new ArgumentException("El contacto no puede estar vacío.");
            if (string.IsNullOrWhiteSpace(horario)) throw new ArgumentException("El horario no puede estar vacío.");
        }

        // Método para validar campos del transportista
        public void ValidarCamposTransportista(string nombre, string apellido, string email, string password, string tipoTransporte, string contacto)
        {
            if (string.IsNullOrWhiteSpace(nombre)) throw new ArgumentException("El nombre no puede estar vacío.");
            if (string.IsNullOrWhiteSpace(apellido)) throw new ArgumentException("El apellido no puede estar vacío.");
            if (string.IsNullOrWhiteSpace(email)) throw new ArgumentException("El email no puede estar vacío.");
            if (string.IsNullOrWhiteSpace(password)) throw new ArgumentException("La contraseña no puede estar vacía.");
            if (string.IsNullOrWhiteSpace(tipoTransporte)) throw new ArgumentException("El tipo de transporte no puede estar vacío.");
            if (string.IsNullOrWhiteSpace(contacto)) throw new ArgumentException("El contacto no puede estar vacío.");
        }

        public void RegistrarProducto(int idProveedor, string nombre, string categoria, decimal precio, int tiempoEntrega, int stockDisponible)
        {
            try
            {
                datosRegistro.AgregarProducto(idProveedor, nombre, categoria, precio, tiempoEntrega, stockDisponible);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public void ModificarCliente(int idUsuario, string nombre, string apellido, string email, string password, string direccion, string telefono, string fechaNacimiento, SqlGeography ubicacion, byte[] tiempo, byte[] tiempo2)
        {
            try
            {
                datosRegistro.ModificarCliente(idUsuario, nombre, apellido, email, password, direccion, telefono, fechaNacimiento, ubicacion, tiempo, tiempo2);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public void ModificarTransportista(int idUsuario, string nombre, string apellido, string email, string password, string fechaNacimiento, string tipoTransporte, string contacto, byte[] tiempo, byte[] tiempo2)
        {
            try
            {
                datosRegistro.ModificarTransportista(idUsuario, nombre, apellido, email, password, fechaNacimiento, tipoTransporte, contacto, tiempo, tiempo2);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public void ModificarOferente(int idUsuario, string nombre, string apellido, string email, string password, string fechaNacimiento, string nombreEmpresa, string direccion, string contacto, string horario, SqlGeography ubicacion, byte[] tiempo, byte[] tiempo2)
        {
            try
            {
                datosRegistro.ModificarOferente(idUsuario, nombre, apellido, email, password, fechaNacimiento, nombreEmpresa, direccion, contacto, horario, ubicacion, tiempo, tiempo2);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public void ValidarCamposOferente(string nombre, string apellido, string email, string password, string nombreEmpresa, string direccion, string contacto, string horario)
        {
            if (string.IsNullOrWhiteSpace(nombre)) throw new ArgumentException("El nombre no puede estar vacío.");
            if (string.IsNullOrWhiteSpace(apellido)) throw new ArgumentException("El apellido no puede estar vacío.");
            if (string.IsNullOrWhiteSpace(email)) throw new ArgumentException("El email no puede estar vacío.");
            if (string.IsNullOrWhiteSpace(password)) throw new ArgumentException("La contraseña no puede estar vacía.");
            if (string.IsNullOrWhiteSpace(nombreEmpresa)) throw new ArgumentException("El nombre de la empresa no puede estar vacío.");
            if (string.IsNullOrWhiteSpace(direccion)) throw new ArgumentException("La dirección no puede estar vacía.");
            if (string.IsNullOrWhiteSpace(contacto)) throw new ArgumentException("El contacto no puede estar vacío.");
            if (string.IsNullOrWhiteSpace(horario)) throw new ArgumentException("El horario no puede estar vacío.");
        }

        public void ValidarCamposProducto(int idProveedor, string nombre, string categoria, decimal precio, int tiempoEntrega, int stockDisponible)
        {
            if (idProveedor <= 0) throw new ArgumentException("El ID del proveedor debe ser un número positivo.");
            if (string.IsNullOrWhiteSpace(nombre)) throw new ArgumentException("El nombre del producto no puede estar vacío.");
            if (string.IsNullOrWhiteSpace(categoria)) throw new ArgumentException("La categoría no puede estar vacía.");
            if (precio <= 0) throw new ArgumentException("El precio debe ser mayor que cero.");
            if (tiempoEntrega < 0) throw new ArgumentException("El tiempo de entrega no puede ser negativo.");
            if (stockDisponible < 0) throw new ArgumentException("El stock disponible no puede ser negativo.");
        }

        public void ModificarProducto(int idProducto, int idProveedor, string nombre, string categoria, decimal precio, int tiempoEntrega, int stockDisponible, byte[] tiempo)
        {
            try
            {
                ValidarCamposProducto(idProveedor, nombre, categoria, precio, tiempoEntrega, stockDisponible);
                datosRegistro.ModificarProducto(idProducto, idProveedor, nombre, categoria, precio, tiempoEntrega, stockDisponible, tiempo);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public void EliminarCliente(int idUsuario)
        {
            try
            {
                datosRegistro.EliminarCliente(idUsuario);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public void EliminarTransportista(int idUsuario)
        {
            try
            {
                datosRegistro.EliminarTransportista(idUsuario);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public void EliminarOferente(int idUsuario)
        {
            try
            {
                datosRegistro.EliminarOferente(idUsuario);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public void EliminarProducto(int idProducto)
        {
            try
            {
                datosRegistro.EliminarProducto(idProducto);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

    }
}
