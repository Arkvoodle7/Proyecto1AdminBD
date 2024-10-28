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
        public List<PedidoDto> ObtenerHistorialPorCliente(int idCliente)
        {
            // Obtener la lista de pedidos entregados desde la capa de datos
            var listaPedidosDatos = datos.ObtenerPedidosEntregados(idCliente);

            // Convertir la lista de datos a una lista de DTO para la capa de negocios
            List<PedidoDto> listaPedidosNegocios = new List<PedidoDto>();
            foreach (var pedido in listaPedidosDatos)
            {
                listaPedidosNegocios.Add(new PedidoDto
                {
                    IdPedido = pedido.IdPedido,
                    FechaPedido = pedido.FechaPedido,
                    Estado = pedido.Estado,
                    CostoTotal = pedido.CostoTotal
                });
            }

            return listaPedidosNegocios;
        }
        public List<PedidoConDetallesDto> ObtenerPedidosEnCurso(int idCliente)
        {
            // Llama al método de la capa de datos para obtener los pedidos con detalles
            var listaPedidosDatos = datos.ObtenerPedidosConDetalles(idCliente);

            List<PedidoConDetallesDto> listaPedidosNegocios = new List<PedidoConDetallesDto>();

            foreach (var pedido in listaPedidosDatos)
            {
                listaPedidosNegocios.Add(new PedidoConDetallesDto
                {
                    IdPedido = pedido.IdPedido,
                    FechaPedido = pedido.FechaPedido,
                    Estado = pedido.Estado,
                    CostoTotal = pedido.CostoTotal,
                    Transportista = pedido.Transportista,
                    TiempoEntrega = pedido.TiempoEntrega, // Se asegura que se incluye
                    ContactoTransportista = pedido.ContactoTransportista
                });
            }

            return listaPedidosNegocios;
        }


    }
    public class PedidoConDetallesDto
    {
        public int IdPedido { get; set; }
        public DateTime FechaPedido { get; set; }
        public string Estado { get; set; }
        public decimal CostoTotal { get; set; }
        public string Transportista { get; set; }
        public int TiempoEntrega { get; set; }
        public string ContactoTransportista { get; set; }
    }
    public class PedidoDto
    {
        public int IdPedido { get; set; }
        public DateTime? FechaPedido { get; set; }
        public string Estado { get; set; }
        public decimal? CostoTotal { get; set; }
    }

    public class Cliente
    {
        public int Id { get; set; }
        public string Telefono { get; set; }
        public string Direccion { get; set; }
    }
}

