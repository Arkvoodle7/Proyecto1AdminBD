using Datos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocios
{
    public class NegociosCliente
    {
        DatosCliente datos = new DatosCliente();

        // Obtener Cliente por Id
        public Negocios.Cliente ObtenerClientePorId(int id)
        {
            var datosCliente = datos.ObtenerClientePorId(id);
            return ConvertirADatosCliente(datosCliente);
        }

        private Negocios.Cliente ConvertirADatosCliente(Datos.Cliente datosCliente)
        {
            if (datosCliente == null) return null;

            return new Negocios.Cliente
            {
                Id = datosCliente.Id,
                Telefono = datosCliente.Telefono,
                Direccion = datosCliente.Direccion
            };
        }

        // Actualizar Cliente
        public void ActualizarCliente(int id, string telefono, string direccion)
        {
            if (id <= 0)
            {
                throw new ArgumentException("El ID del cliente no es válido.");
            }
            if (string.IsNullOrEmpty(telefono))
            {
                throw new ArgumentException("El correo electrónico no puede estar vacío.");
            }

            if (string.IsNullOrEmpty(direccion))
            {
                throw new ArgumentException("La dirección no puede estar vacía.");
            }

            // Solo actualizamos los otros campos, no el ID
            datos.ActualizarCliente(id, telefono, direccion);
        }

        // Eliminar Cliente
        public void EliminarCliente(int id)
        {
            if (id <= 0)
            {
                throw new ArgumentException("El ID del cliente no es válido.");
            }

            datos.EliminarCliente(id);
        }
        public List<HistorialCompraDto> ObtenerHistorialPorCliente(int idCliente)
        {
            // Obtener la lista de historial de la capa de datos
            var listaHistorialDatos = datos.ObtenerHistorialCompras(idCliente);

            // Convertir la lista de datos a lista de negocios
            List<HistorialCompraDto> listaHistorialNegocios = new List<HistorialCompraDto>();
            foreach (var historial in listaHistorialDatos)
            {
                listaHistorialNegocios.Add(new HistorialCompraDto
                {
                    IdHistorial = historial.IdHistorial,
                    IdPedido = historial.IdPedido,
                    FechaEntrega = historial.FechaEntrega,
                    Observaciones = historial.Observaciones
                });
            }

            return listaHistorialNegocios;
        }
    }
    public class HistorialCompraDto
    {
        public int IdHistorial { get; set; }
        public int IdPedido { get; set; }
        public DateTime FechaEntrega { get; set; }
        public string Observaciones { get; set; }
    }

    public class Cliente
    {
        public int Id { get; set; }
        public string Telefono { get; set; }
        public string Direccion { get; set; }
    }
}

