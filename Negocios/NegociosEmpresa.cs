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

        public void ObtenerProvedor(int id)
        {
            if (id<0)
            {
                throw new ArgumentException("El id de la empresa no puede estar vacio.");
            }
            Empresa.ObtenerProvedor(id);
        }


 
    }
}
