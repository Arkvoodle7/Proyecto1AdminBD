using Datos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace Negocios
{
    public class NegociosRegistro
    {
        DatosRegistro datosRegistro = new DatosRegistro();

        public void RegistrarCliente(string nombre, string apellido, string email, string password, string direccion, string telefono, string fechanac)
        {
            try
            {
                datosRegistro.AgregarCliente(nombre, apellido, email, password, direccion, telefono, fechanac);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public void RegistrarProveedor(string nombre, string apellido, string email, string password, string nombreEmpresa, string direccion, string contacto, string horario, string ubicacion, string fechanac)
        {
            try
            {
                datosRegistro.AgregarProveedor(nombre, apellido, email, password, nombreEmpresa, direccion, contacto, horario, ubicacion, fechanac);
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

        // Método para validar campos del cliente
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
        public void ValidarCamposProveedor(string nombre, string apellido, string email, string password, string nombreEmpresa, string direccion, string contacto, string horario, string ubicacion)
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
            if (string.IsNullOrWhiteSpace(ubicacion)) throw new ArgumentException("La ubicación no puede estar vacía.");
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
    }
}
