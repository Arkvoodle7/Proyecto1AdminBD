using Datos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocios
{
    public class NegociosEmpresa
    {
        DatosEmpresa Empresa = new DatosEmpresa();

        public List<string> ObtenerProvedor(int id)
        {
            if (id < 0)
            {
                throw new ArgumentException("El id de la empresa no puede estar vacío.");
            }

            return Empresa.ObtenerProvedor(id);
        }

        public List<List<string>> ObtenerProductosLista(string categoria)
        {
            if (string.IsNullOrWhiteSpace(categoria))
            {
                throw new ArgumentException("El id de la empresa no puede estar vacío.");
            }

            return Empresa.ObtenerProductosLista(categoria);
        }

        public void InsertProducto(int idProvedor, string nombre, string categoria, decimal precio, int tiempoEntrega)
        {
            if (idProvedor <= 0 || tiempoEntrega < 0 || precio <= 0)
            {
                throw new ArgumentException("Solo valores enteros positivos");
            }

            if (string.IsNullOrWhiteSpace(categoria) || string.IsNullOrWhiteSpace(nombre))
            {
                throw new ArgumentException("El nombre y la categoría del producto no puede ir vacios.");
            }

            Empresa.InsertProducto(idProvedor, nombre, categoria, precio, tiempoEntrega);
        }

        public void UpdateProducto(int idProducto, int idProvedor, string nombre, string categoria, decimal precio, int tiempoEntrega)
        {
            if (idProducto <= 0 || idProvedor <= 0 || precio <= 0 || tiempoEntrega < 0)
            {
                throw new ArgumentException("Solo numero enteros positivos");
            }

            if (idProvedor <= 0)
            {
                throw new ArgumentException("El id del proveedor no puede estar vacío o ser menor que cero.");
            }
            Empresa.UpdateProducto(idProducto, idProvedor, nombre, categoria, precio, tiempoEntrega);
        }

        public void DeleteProducto(int idProducto)
        {
            if (idProducto <= 0)
            {
                throw new ArgumentException("El id debe de ser mayor a 0");
            }
            Empresa.DeleteProducto(idProducto);
        }

        public void InsertCarrito(int IdPedido, int IdProducto)
        {
            if (IdPedido < 0 || IdProducto < 0)
            {
                throw new ArgumentException("El valor debe de ser mayor a 0");
            }
            Empresa.InsertCarrito(IdPedido, IdProducto);
        }

        public void InsertPedido(int idCliente, int idProducto, int idTransportista, DateTime fechaPedido, string estado)
        {
            if (idCliente <= 0 || idProducto < 0 || idTransportista < 0)
            {
                throw new ArgumentException("Los id deben de ser mayores a 0");
            }

            if (string.IsNullOrWhiteSpace(estado) || (estado != "pendiente" && estado != "en camino" && estado != "entregado"))
            {
                throw new ArgumentException("El estado debe ser 'pendiente', 'en camino' o 'entregado'.");
            }
            Empresa.InsertPedido(idCliente, idProducto, idTransportista, fechaPedido, estado);
        }

        public void UpdatePedido(int IdPedido, string NuevoEstado)
        {
            if (IdPedido < 0)
            {
                throw new ArgumentException("El id debe de ser mayor a 0");
            }
            Empresa.UpdatePedido(IdPedido, NuevoEstado);
        }

        public List<string> ObtenerProducto(int id)
        {
            if (id < 0)
            {
                throw new ArgumentException("El id del producto no puede estar vacío.");
            }

            return Empresa.ObtenerProducto(id);
        }
    }
}