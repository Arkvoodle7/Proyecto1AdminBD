﻿using System;
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

        public string RealizarCompra(int idCliente, int idProducto, int cantidad)
        {
            // Verificar disponibilidad de stock
            var stockDisponible = datosCompra.VerificarStock(idProducto);
            if (stockDisponible < cantidad)
            {
                return "No hay suficiente stock disponible.";
            }

            // Obtener la fecha actual
            DateTime fechaPedido = DateTime.Now;

            // Crear la orden de compra
            var resultado = datosCompra.CrearOrdenDeCompra(idCliente, idProducto, cantidad, fechaPedido);

            // Corregir comparación
            if (resultado == "Compra realizada con éxito.")
            {
                return resultado;
            }
            else
            {
                return "Error al realizar la compra.";
            }
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