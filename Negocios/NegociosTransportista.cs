﻿using System;
using Datos;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;

namespace Negocios
{
    public class NegociosTransportista
    {
        DatosTransportista datos = new DatosTransportista();
        public Negocios.Transportista ObtenerTransportistaPorId(int id)
        {
            var datosTransportista = datos.ObtenerTransportistaPorId(id);
            return ConvertirADatosTransportista(datosTransportista);
        }

        private Negocios.Transportista ConvertirADatosTransportista(Datos.Transportista datosTransportista)
        {
            if (datosTransportista == null) return null;

            return new Negocios.Transportista
            {
                Id = datosTransportista.Id,
                Contacto = datosTransportista.Contacto,
                TipoTransporte = datosTransportista.TipoTransporte,
                Stamp = datosTransportista.Stamp,
            };
        }

        public void ActualizarTransportista(int id, string tipoTransporte, string contacto, byte[] timestamp)
        {
            if (id <= 0)
            {
                throw new ArgumentException("El ID del transportista no es válido.");
            }

            if (string.IsNullOrEmpty(tipoTransporte))
            {
                throw new ArgumentException("El tipo de transporte no puede estar vacío.");
            }

            if (string.IsNullOrEmpty(contacto))
            {
                throw new ArgumentException("El contacto no puede estar vacío.");
            }

            // Solo actualizamos los otros campos, no el ID
            datos.ActualizarTransportista(id, tipoTransporte, contacto, timestamp);
        }

        // Eliminar Transportista
        public void EliminarTransportista(int id)
        {
            if (id <= 0)
            {
                throw new ArgumentException("El ID del transportista no es válido.");
            }

            datos.EliminarTransportista(id);
        }
        public void AsignarTransportista(int idPedido, int idTransportista)
        {
            try
            {
                datos.AsignarTransportistaAPedido(idPedido, idTransportista);
            }
            catch (Exception ex)
            {
                // Puedes agregar más lógica aquí si es necesario
                throw new Exception("Error al asignar transportista: " + ex.Message);
            }
        }


        public List<Pedido> ObtenerTodosLosPedidos()
        {
            var listaPedidosDatos = datos.ObtenerTodosLosPedidos();

            List<Pedido> listaPedidosNegocios = new List<Pedido>();
            foreach (var pedido in listaPedidosDatos)
            {
                listaPedidosNegocios.Add(new Pedido
                {
                    IdPedido = pedido.IdPedido,
                    IdCliente = pedido.IdCliente,
                    IdProducto = pedido.IdProducto,
                    IdTransportista = pedido.IdTransportista,
                    FechaPedido = pedido.FechaPedido,
                    Estado = pedido.Estado,
                    CostoTotal = pedido.CostoTotal
                });
            }

            return listaPedidosNegocios;
        }

        // Obtener todos los transportistas con sus detalles completos
        public List<TransportistaCompletoDto> ObtenerTodosLosTransportistas()
        {
            var listaTransportistasDatos = datos.ObtenerTodosLosTransportistasCompletos();
            return listaTransportistasDatos.Select(transportista => new TransportistaCompletoDto
            {
                IdUsuario = transportista.IdUsuario,
                Nombre = transportista.Nombre,
                Apellido = transportista.Apellido,
                Email = transportista.Email,
                Password = transportista.Password,
                Rol = transportista.Rol,
                FechaNacimiento = transportista.FechaNacimiento,
                TipoTransporte = transportista.TipoTransporte,
                Contacto = transportista.Contacto
            }).ToList();
        }

        public class TransportistaCompletoDto
        {
            public int IdUsuario { get; set; }
            public string Nombre { get; set; }
            public string Apellido { get; set; }
            public string Email { get; set; }
            public string Password { get; set; }
            public string Rol { get; set; }
            public DateTime FechaNacimiento { get; set; }
            public string TipoTransporte { get; set; }
            public string Contacto { get; set; }
        }

    }
    public class Pedido
    {
        public int IdPedido { get; set; }
        public int? IdCliente { get; set; }
        public int? IdProducto { get; set; }
        public int? IdTransportista { get; set; }
        public DateTime? FechaPedido { get; set; }
        public string Estado { get; set; }
        public decimal? CostoTotal { get; set; }
    }


    public class Transportista
    {
        public int Id { get; set; }
        public string Contacto { get; set; }
        public string TipoTransporte { get; set; }
        public string Stamp { get; set; }

    }

}


