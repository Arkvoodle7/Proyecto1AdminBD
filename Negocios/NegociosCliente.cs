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
        public Cliente ObtenerClientePorId(int id)
        {
            Datos.Cliente datosCliente = datos.ObtenerClientePorId(id);
            return ConvertirADatosCliente(datosCliente);
        }

        private Cliente ConvertirADatosCliente(Datos.Cliente datosCliente)
        {
            if (datosCliente == null) return null;

            return new Cliente
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
            var listaPedidosDatos = datos.ObtenerPedidosEntregados(idCliente);

            List<PedidoDto> listaPedidosNegocios = new List<PedidoDto>();
            foreach (var pedido in listaPedidosDatos)
            {
                listaPedidosNegocios.Add(new PedidoDto
                {
                    IdPedido = pedido.IdPedido,
                    FechaPedido = pedido.FechaPedido,
                    Estado = pedido.Estado,
                    Subtotal = pedido.Subtotal,
                    Impuestos = pedido.Impuestos,
                    Entrega = pedido.Entrega,
                    Total = pedido.Total
                });
            }

            return listaPedidosNegocios;
        }

        public List<PedidoConDetallesDto> ObtenerPedidosEnCurso(int idCliente)
        {
            var listaPedidosDatos = datos.ObtenerPedidosConDetalles(idCliente);

            List<PedidoConDetallesDto> listaPedidosNegocios = new List<PedidoConDetallesDto>();

            foreach (var pedido in listaPedidosDatos)
            {
                listaPedidosNegocios.Add(new PedidoConDetallesDto
                {
                    IdPedido = pedido.IdPedido,
                    FechaPedido = pedido.FechaPedido,
                    Estado = pedido.Estado,
                    Subtotal = pedido.Subtotal,
                    Impuestos = pedido.Impuestos,
                    Total = pedido.Total,
                    Transportista = pedido.Transportista,
                    TiempoEntrega = pedido.TiempoEntrega,
                    ContactoTransportista = pedido.ContactoTransportista,
                    CostoEntrega = pedido.CostoEntrega
                });
            }

            return listaPedidosNegocios;
        }

        // Obtener todos los clientes con sus detalles completos
        public List<ClienteCompletoDto> ObtenerTodosLosClientes()
        {
            var listaClientesDatos = datos.ObtenerTodosLosClientesCompletos();
            return listaClientesDatos.Select(cliente => new ClienteCompletoDto
            {
                IdUsuario = cliente.IdUsuario,
                Nombre = cliente.Nombre,
                Apellido = cliente.Apellido,
                Email = cliente.Email,
                Password = cliente.Password,
                Rol = cliente.Rol,
                FechaNacimiento = cliente.FechaNacimiento,
                Direccion = cliente.Direccion,
                Telefono = cliente.Telefono
            }).ToList();
        }

        public class ClienteCompletoDto
        {
            public int IdUsuario { get; set; }
            public string Nombre { get; set; }
            public string Apellido { get; set; }
            public string Email { get; set; }
            public string Password { get; set; }
            public string Rol { get; set; }
            public DateTime FechaNacimiento { get; set; }
            public string Direccion { get; set; }
            public string Telefono { get; set; }
        }

        public class PedidoDto
        {
            public int IdPedido { get; set; }
            public DateTime FechaPedido { get; set; }
            public string Estado { get; set; }
            public decimal Subtotal { get; set; }
            public decimal Impuestos { get; set; }
            public decimal Total { get; set; }
            public decimal Entrega { get; set; }
        }

        public class PedidoConDetallesDto
        {
            public int IdPedido { get; set; }
            public DateTime FechaPedido { get; set; }
            public string Estado { get; set; }
            public decimal Subtotal { get; set; }
            public decimal Impuestos { get; set; }
            public decimal Total { get; set; }
            public string Transportista { get; set; }
            public int TiempoEntrega { get; set; }
            public string ContactoTransportista { get; set; }
            public string CostoEntrega { get; set; }
        }
    }



    public class Cliente
    {
        public int Id { get; set; }
        public string Telefono { get; set; }
        public string Direccion { get; set; }
    }
}

