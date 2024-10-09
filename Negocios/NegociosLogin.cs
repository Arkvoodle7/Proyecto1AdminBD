using Datos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace Negocios
{
    public class NegociosLogin
    {
        public static (bool, string, int) IniciarSesion(string email, string password)
        {
            var resultado = DatosLogin.VerificarCredenciales(email, password);

            string rolUsuario = resultado.Item1;
            int idUsuario = resultado.Item2;

            if (rolUsuario != null)
            {
                return (true, rolUsuario, idUsuario); // Login exitoso
            }

            return (false, null, 0); // Login fallido
        }
    }
}