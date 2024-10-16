using Datos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocios
{
    public class NegociosRegistro
    {
        DatosRegistro datosRegistro = new DatosRegistro();

        public void RegistrarCliente(string nombre, string apellido, string email, string password, string direccion, string telefono)
        {
            datosRegistro.AgregarCliente(nombre, apellido, email, password, direccion, telefono);
        }

        public void RegistrarProveedor(string nombre, string apellido, string email, string password, string nombreEmpresa, string direccion, string contacto, string horario, string ubicacion)
        {
            datosRegistro.AgregarProveedor(nombre, apellido, email, password, nombreEmpresa, direccion, contacto, horario, ubicacion);
        }

        public void RegistrarTransportista(string nombre, string apellido, string email, string password, string tipoTransporte, string contacto)
        {
            datosRegistro.AgregarTransportista(nombre, apellido, email, password, tipoTransporte, contacto);
        }
    }
}
