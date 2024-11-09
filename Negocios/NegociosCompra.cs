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

        public void CambiarEntregado(int idTrans)
        {
            datosCompra.ActualizarEstadoPedido(idTrans);
        }



        public decimal CalcularDistancia(int idPedido)
        {
            try
            {
                // Llamar al método que devuelve como   (distancia, costoTotal)
                var resultado = datosCompra.CalcularKilometros(idPedido);

                decimal distancia = resultado.distancia;
                decimal costoTotal = resultado.costoTotal;

                //Distancia invalida
                if (distancia > 12)
                {
                    return -1; 
                }

                //Dsitancia valida
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
                Total = pedido.Total, 
                //TiempoEntrega = pedido.TiempoEntrega,
                IdCliente = pedido.IdCliente,
                Telefono = pedido.Telefono,
            }).ToList();
        }
    }

    public class PedidoDet
    {
        public int IdPedido { get; set; }
        public DateTime FechaPedido { get; set; }
        public string Estado { get; set; }
        public decimal Total { get; set; }
        //public int TiempoEntrega { get; set; }
        public int IdCliente { get; set; }
        public string Telefono { get; set; }
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
