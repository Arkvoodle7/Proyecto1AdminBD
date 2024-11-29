using Datos;
using System;
using System.Collections;
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


        public List<List<string>> ObtenerProductosProvedor(int Provedor)
        {
            if (Provedor < 0)
            {
                throw new ArgumentException("El id de la empresa no puede ser negativo o nullo.");
            }

            return Empresa.ObtenerProductosProvedor(Provedor);
        }

        public void InsertProducto(int idProvedor, string nombre, string categoria, decimal precio, int tiempoEntrega, decimal stock)
        {
            if (idProvedor <= 0 || tiempoEntrega < 0 || precio <= 0)
            {
                throw new ArgumentException("Solo valores enteros positivos");
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

        // Método para eliminar un producto
        public void EliminarProducto(int idProducto)
        {
            if (idProducto <= 0)
            {
                throw new ArgumentException("El ID del producto debe ser mayor a 0");
            }
            Empresa.EliminarProducto(idProducto);
        }

        // Método para eliminar un oferente
        public void EliminarOferente(int idOferente)
        {
            if (idOferente <= 0)
            {
                throw new ArgumentException("El ID del oferente debe ser mayor a 0");
            }
            Empresa.EliminarOferente(idOferente);
        }

        // Obtener todos los oferentes con sus detalles completos
        public List<OferenteCompletoDto> ObtenerTodosLosOferentes()
        {
            var listaOferentesDatos = Empresa.ObtenerTodosLosOferentesCompletos();
            return listaOferentesDatos.Select(oferente => new OferenteCompletoDto
            {
                IdUsuario = oferente.IdUsuario,
                Nombre = oferente.Nombre,
                Apellido = oferente.Apellido,
                Email = oferente.Email,
                Password = oferente.Password,
                Rol = oferente.Rol,
                FechaNacimiento = oferente.FechaNacimiento,
                NombreEmpresa = oferente.NombreEmpresa,
                Direccion = oferente.Direccion,
                Contacto = oferente.Contacto,
                Horario = oferente.Horario
            }).ToList();
        }

        public class OferenteCompletoDto
        {
            public int IdUsuario { get; set; }
            public string Nombre { get; set; }
            public string Apellido { get; set; }
            public string Email { get; set; }
            public string Password { get; set; }
            public string Rol { get; set; }
            public DateTime FechaNacimiento { get; set; }
            public string NombreEmpresa { get; set; }
            public string Direccion { get; set; }
            public string Contacto { get; set; }
            public string Horario { get; set; }
        }

        // Obtener todos los productos
        public List<ProductoDto> ObtenerTodosLosProductos()
        {
            return Empresa.ObtenerTodosLosProductos().Select(producto => new ProductoDto
            {
                IdProducto = producto.IdProducto,
                IdProveedor = producto.IdProveedor,
                Nombre = producto.Nombre,
                Categoria = producto.Categoria,
                Precio = producto.Precio,
                TiempoEntrega = producto.TiempoEntrega,
                StockDisponible = producto.StockDisponible
            }).ToList();
        }

        public class ProductoDto
        {
            public int IdProducto { get; set; }
            public int IdProveedor { get; set; }
            public string Nombre { get; set; }
            public string Categoria { get; set; }
            public decimal Precio { get; set; }
            public int TiempoEntrega { get; set; }
            public int StockDisponible { get; set; }
        }
    }

}