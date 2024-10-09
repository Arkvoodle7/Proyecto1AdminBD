using System;
using Datos;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocios
{
    public class NegociosTransportista
    {
        DatosTransportista datos = new DatosTransportista();


        public void InsertarTransportista(int id, string tipoTransporte, string contacto)
        {
            // Validación de entrada
            if (string.IsNullOrEmpty(tipoTransporte))
            {
                throw new ArgumentException("El tipo de transporte no puede estar vacío.");
            }
            if (string.IsNullOrEmpty(contacto))
            {
                throw new ArgumentException("El contacto no puede estar vacío.");
            }

            // Llamada a la capa de datos para insertar
            datos.InsertarTransportista(id, tipoTransporte, contacto);
        }

        public void ActualizarTransportista(int id, string tipoTransporte)
        {
            // Validación de entrada
            if (string.IsNullOrEmpty(tipoTransporte))
            {
                throw new ArgumentException("El tipo de transporte no puede estar vacío.");
            }

            // Llamada a la capa de datos para actualizar
            datos.ActualizarTransportista(id, tipoTransporte);
        }

        public void EliminarTransportista(int id)
        {
            // Llamada a la capa de datos para eliminar
            datos.EliminarTransportista(id);
        }
    }
}

