using System;
using Datos;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocios
{
    public class NegociosContacto
    {
        private DatosContacto contactoData = new DatosContacto();

        public void EnviarContacto(string nombre, string email, string mensaje)
        {
            // Aquí puedes agregar validaciones si es necesario
            contactoData.InsertarContacto(nombre, email, mensaje);
        }
    }
}
