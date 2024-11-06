using System;
using Datos;
using System.Collections.Generic;
using System.Linq;

namespace Negocios
{
    public class NegociosCompra
    {
        private readonly DatosCompra datosCompra = new DatosCompra();

        public Producto ObtenerProductoPorId(int idProducto)
        {
            if (idProducto <= 0)
            {
                throw new ArgumentException("El ID del producto debe ser un número positivo.");
            }

            Datos.Producto productoDatos = datosCompra.ObtenerProductoPorId(idProducto);

            if (productoDatos == null)
            {
                throw new Exception("Producto no encontrado.");
            }

            return MapearProducto(productoDatos);
        }

        public string RealizarCompra(int idCliente, List<CarritoItem> carritoItems)
        {
            if (carritoItems == null || !carritoItems.Any())
            {
                return "El carrito está vacío.";
            }

            foreach (var item in carritoItems)
            {
                var stockDisponible = datosCompra.VerificarStock(item.IdProducto);
                if (stockDisponible < item.Cantidad)
                {
                    return $"No hay suficiente stock disponible para el producto {item.Nombre}.";
                }
            }

            decimal costoTotal = carritoItems.Sum(item => item.Precio * item.Cantidad);
            DateTime fechaPedido = DateTime.Now;
            int idProductoPrincipal = carritoItems.First().IdProducto;
            int idPedido = datosCompra.CrearOrdenDeCompra(idCliente, fechaPedido, idProductoPrincipal, costoTotal);

            List<DatosCompra.CarritoItem> carritoItemsDatos = carritoItems.Select(item => new DatosCompra.CarritoItem
            {
                IdProducto = item.IdProducto,
                Nombre = item.Nombre,
                Precio = item.Precio,
                Cantidad = item.Cantidad,
                Subtotal = item.Subtotal,
                Impuestos = item.Impuestos,
                Total = item.Total
            }).ToList();

            datosCompra.CrearDetallePedido(idPedido, carritoItemsDatos);

            return "Compra realizada con éxito.";
        }

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
            List<DatosCompra.CarritoItem> datosCarritoItems = carritoItems.Select(item => new DatosCompra.CarritoItem
            {
                IdProducto = item.IdProducto,
                Cantidad = item.Cantidad
            }).ToList();

            List<DatosCompra.CarritoItem> datosResultado = datosCompra.CalcularTotalesCarrito(datosCarritoItems);

            return datosResultado.Select(item => new CarritoItem
            {
                IdProducto = item.IdProducto,
                Nombre = item.Nombre,
                Precio = item.Precio,
                Cantidad = item.Cantidad,
                Subtotal = item.Subtotal,
                Impuestos = item.Impuestos,
                Total = item.Total
            }).ToList();
        }

        public decimal CambiarEntregado(int idPedido)
        {
            decimal costoTotal;
            decimal resultado = datosCompra.CalcularCostoEnvio(idPedido, out costoTotal);

            if (costoTotal >= 0 && costoTotal <= 12)
            {
                return resultado;
            }
            else
            {
                return -1;
            }
        }



        public decimal CalcularDistancia(int idPedido)
        {
            decimal costoTotal;
            try
            {
                costoTotal = datosCompra.CalcularCostoEnvio(idPedido, out decimal distancia);

                // Si la distancia está fuera del rango permitido, devolvemos un costo de envío de -1
                if (distancia > 12)
                {
                    return -1; // Indicando que está fuera de cobertura
                }

                // Si la distancia es válida, devolvemos el costo total
                return costoTotal;

            }
            catch (Exception ex)
            {
                throw new Exception("Error al calcular el costo de envío: " + ex.Message);
            }
        }



        public List<PedidoDet> ObtenerPendientes(int idCliente)
        {
            var listaPedidosDatos = datosCompra.ObtenerPedidosPendientes(idCliente);

            return listaPedidosDatos.Select(pedido => new PedidoDet
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
            }).ToList();
        }
    }

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

    public class Producto
    {
        public int IdProducto { get; set; }
        public string Nombre { get; set; }
        public decimal Precio { get; set; }
        public int TiempoEntrega { get; set; }
    }

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
