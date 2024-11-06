using System;
using Datos;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocios
{
    public class NegociosCompra
    {
        private readonly DatosCompra datosCompra = new DatosCompra();

        public Producto ObtenerProductoPorId(int idProducto)
        {
            // Validación adicional
            if (idProducto <= 0)
            {
                throw new ArgumentException("El ID del producto debe ser un número positivo.");
            }

            // Obtener el producto de la capa de Datos
            Datos.Producto productoDatos = datosCompra.ObtenerProductoPorId(idProducto);

            if (productoDatos == null)
            {
                throw new Exception("Producto no encontrado.");
            }

            // Convertir el producto de Datos a Negocios
            Producto productoNegocios = MapearProducto(productoDatos);

            return productoNegocios;
        }

        public string RealizarCompra(int idCliente, List<CarritoItem> carritoItems)
        {
            // Validar que el carrito no esté vacío
            if (carritoItems == null || !carritoItems.Any())
            {
                return "El carrito está vacío.";
            }

            // Verificar disponibilidad de stock para cada producto
            foreach (var item in carritoItems)
            {
                var stockDisponible = datosCompra.VerificarStock(item.IdProducto);
                if (stockDisponible < item.Cantidad)
                {
                    return $"No hay suficiente stock disponible para el producto {item.Nombre}.";
                }
            }

            // Obtener la fecha actual
            DateTime fechaPedido = DateTime.Now;

            // Crear la orden de compra y obtener el id_pedido
            int idPedido = datosCompra.CrearOrdenDeCompra(idCliente, fechaPedido);

            List<DatosCompra.CarritoItem> datosCarritoItems = carritoItems.Select(item => new DatosCompra.CarritoItem
            {
                IdProducto = item.IdProducto,
                Nombre = item.Nombre,
                Precio = item.Precio,
                Cantidad = item.Cantidad,
                Subtotal = item.Subtotal,
                Impuestos = item.Impuestos,
                Total = item.Total
            }).ToList();

            // Crear los detalles del pedido
            datosCompra.CrearDetallePedido(idPedido, datosCarritoItems);

            return "Compra realizada con éxito.";
        }

        // Método de mapeo entre Producto de Datos y Producto de Negocios
        private Producto MapearProducto(Datos.Producto productoDatos)
        {
            return new Producto
            {
                IdProducto = productoDatos.IdProducto,
                Nombre = productoDatos.Nombre,
                Precio = productoDatos.Precio,
                TiempoEntrega = productoDatos.TiempoEntrega
            };
        }

        public List<CarritoItem> CalcularTotalesCarrito(List<CarritoItem> carritoItems)
        {
            // Mapear CarritoItem de Negocios a Datos
            List<DatosCompra.CarritoItem> datosCarritoItems = carritoItems.Select(item => new DatosCompra.CarritoItem
            {
                IdProducto = item.IdProducto,
                Cantidad = item.Cantidad
            }).ToList();

            // Llamar al método de la capa de Datos
            List<DatosCompra.CarritoItem> datosResultado = datosCompra.CalcularTotalesCarrito(datosCarritoItems);

            // Mapear los resultados de Datos a Negocios
            List<CarritoItem> resultado = datosResultado.Select(item => new CarritoItem
            {
                IdProducto = item.IdProducto,
                Nombre = item.Nombre,
                Precio = item.Precio,
                Cantidad = item.Cantidad,
                Subtotal = item.Subtotal,
                Impuestos = item.Impuestos,
                Total = item.Total
            }).ToList();

            return resultado;
        }

        public decimal CambiarEntregado(int idPedido)
        {
            decimal res;
            res = datosCompra.CalcularCostoEnvio(idPedido);
            if (res >= 0 && res <= 12)
            {
                return res;
            }
            else
            {
                return -1;
            }
        }

        public decimal CalcularDistancia(int idPedido)
        {
            decimal res;
            res = datosCompra.CalcularDistancia(idPedido);
            if (res >= 0 && res <= 12) {
                return res;
            }
            else
            {
                return -1;
            }
        }

        public List<PedidoDet> ObtenerPendientes(int idCliente)
        {
            var listaPedidosDatos = datosCompra.ObtenerPedidosPendientes(idCliente);

            List<PedidoDet> listaPedidosNegocios = new List<PedidoDet>();

            foreach (var pedido in listaPedidosDatos)
            {
                listaPedidosNegocios.Add(new PedidoDet
                {
                    IdPedido = pedido.IdPedido,
                    FechaPedido = pedido.FechaPedido,
                    Estado = pedido.Estado,
                    Subtotal = pedido.Subtotal,
                    Impuestos = pedido.Impuestos,
                    Total = pedido.Total,
                    Transportista = pedido.Transportista,
                    TiempoEntrega = pedido.TiempoEntrega,
                    ContactoTransportista = pedido.ContactoTransportista
                });
            }

            return listaPedidosNegocios;
        }
        
    }
    //Detalles en negocios
    public class PedidoDet
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
    }
    // Clase Producto en la capa de Negocios
    public class Producto
    {
        public int IdProducto { get; set; }
        public string Nombre { get; set; }
        public decimal Precio { get; set; }
        public int TiempoEntrega { get; set; }
    }

    // Actualizar la clase CarritoItem en la capa de Negocios
    public class CarritoItem
    {
        public int IdProducto { get; set; }
        public string Nombre { get; set; }
        public decimal Precio { get; set; }
        public int Cantidad { get; set; }
        public decimal Subtotal { get; set; }
        public decimal Impuestos { get; set; }
        public decimal Total { get; set; }
    }
}
