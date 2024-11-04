using Datos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static Datos.DatosCliente;
using static Datos.DatosEmpresa;


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

        public List<ProductosNego> ObtenerProductosProvedor(int provedor)
        {
            List<Productos> productosDatos = Empresa.ObtenerProductosProvedor(provedor);

            List<ProductosNego> productosNegocios = new List<ProductosNego>();

            foreach (var producto in productosDatos)
            {
                productosNegocios.Add(new ProductosNego
                {
                    IdProducto = producto.IdProducto,
                    IdProveedor = producto.IdProveedor,
                    Nombre = producto.Nombre,
                    Categoria = producto.Categoria,
                    Precio = producto.Precio,
                    TiempoEntrega = producto.TiempoEntrega,
                    Stock = producto.StockDisponible
                });
            }
            return productosNegocios;
        }

        public void InsertProducto(int idProvedor, string nombre, string categoria, decimal precio, int tiempoEntrega, decimal stock)
        {
            if (idProvedor <= 0 || tiempoEntrega < 0 || precio <= 0 || stock < 0)
            {
                throw new ArgumentException("Solo valores enteros positivos");
            }

            if (stock < 0)
            {
                throw new ArgumentException("El stock solo puede ser 0 o mayor");
            }

            if (string.IsNullOrWhiteSpace(categoria))
            {
                throw new ArgumentException("El nombre y la categoría del producto no puede ir vacios.");
            }

            Empresa.InsertProducto(idProvedor, nombre, categoria, precio, tiempoEntrega, stock);
        }

        public void UpdateProducto(int idProducto, int idProvedor, string nombre, string categoria, decimal precio, int tiempoEntrega, decimal stock)
        {
            if (idProducto <= 0 || idProvedor <= 0 || precio <= 0 || tiempoEntrega < 0)
            {
                throw new ArgumentException("Solo numero enteros positivos");
            }

            if (stock < 0)
            {
                throw new ArgumentException("El stock solo puede ser 0 o mayor");
            }

            if (idProvedor <= 0)
            {
                throw new ArgumentException("El id del proveedor no puede estar vacío o ser menor que cero.");
            }
            Empresa.UpdateProducto(idProducto, idProvedor, nombre, categoria, precio, tiempoEntrega, stock);
        }

        public void DeleteProducto(int idProducto)
        {
            if (idProducto <= 0)
            {
                throw new ArgumentException("El id debe de ser mayor a 0");
            }
            Empresa.DeleteProducto(idProducto);
        }

        public void InsertCarrito(int cedula, int IdProducto)
        {
            if (cedula < 0 || IdProducto < 0)
            {
                throw new ArgumentException("El valor debe de ser mayor a 0");
            }
            Empresa.InsertCarrito(cedula, IdProducto);
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


        public void UpdateProvedor(int idProveedor, string nombreEmpresa, string direccion, string contacto, string horario, string ubicacion)
        {
            if (idProveedor <= 0)
            {
                throw new ArgumentException("Solo valores enteros positivos");
            }


            Empresa.UpdateProvedor(idProveedor, nombreEmpresa, direccion, contacto, horario, ubicacion);
        }


        public List<PedidosNegocios> ObtenerPedidosPorProveedor(int proveedorId)
        {
 
            List<PedidosClase> pedidosDatos = Empresa.ObtenerPedidosPorProveedor(proveedorId);


            List<PedidosNegocios> pedidosNegocios = new List<PedidosNegocios>();

   
            foreach (var pedido in pedidosDatos)
            {
                pedidosNegocios.Add(new PedidosNegocios
                {
                    IdPedido = pedido.IdPedido,
                    IdCliente = pedido.IdCliente,
                    IdProducto = pedido.IdProducto,
                    IdTransportista = pedido.IdTransportista,
                    FechaPedido = pedido.FechaPedido,
                    Estado = pedido.Estado,
                    CostoTotal = pedido.CostoTotal,
                    Cantidad = pedido.Cantidad
                });
            }

            return pedidosNegocios;
        }


        public class ProductosNego
        {
            public int IdProducto { get; set; }
            public int IdProveedor { get; set; }
            public string Nombre { get; set; }
            public string Categoria { get; set; }
            public decimal Precio { get; set; }
            public int TiempoEntrega { get; set; }
            public int? Stock { get; set; }


        }

        public class PedidosNegocios
        {
            public int IdPedido { get; set; }
            public int? IdCliente { get; set; }
            public int? IdProducto { get; set; }
            public int? IdTransportista { get; set; }
            public DateTime? FechaPedido { get; set; }
            public string Estado { get; set; }
            public decimal? CostoTotal { get; set; }
            public int Cantidad { get; set; }
        }
    }

}