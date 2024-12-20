﻿using Negocios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Proyecto1AdminBD.Paginas
{
    public partial class PaginaEmpresa : System.Web.UI.Page
    {

        NegociosEmpresa empresa = new NegociosEmpresa();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargaEmpresa();
                CargarProductos(Convert.ToInt32(Session["IdUsuario"]));
            }
        }

        private void Recarga()
        {
            CargaEmpresa();
            CargarProductos(Convert.ToInt32(Session["IdUsuario"]));
        }

        private void CargarProductos(int cedula)
        {
            
            var productos = empresa.ObtenerProductosProveedorNegocio(cedula);
            
            gvProductos.DataSource = productos;
            gvProductos.DataBind();
        }

        private void CargaEmpresa()
        {
            if (Session["IdUsuario"] != null)
            {
                List<string> provedor = empresa.ObtenerProvedor((Convert.ToInt32(Session["IdUsuario"])));
                txtContacto.Text = provedor[1];
                txtDireccion.Text = provedor[2];
                txtHorario.Text = provedor[3];
                txtEmpresa.Text = provedor[4];
                txtTimeStampProvedor.Text = provedor[5];
            }
            else
            {
                txtCodigo.Text = "Usuario no registrado";
                txtContacto.Text = "Usuario no registrado";
                txtHorario.Text = "Usuario no registrado";
                txtEmpresa.Text = "Usuario no registrado";
            }

        }

        //Seleccionar un producto y cargarlo
        protected void gvProductos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Seleccionar")
            {
                // Obtén el índice de la fila seleccionada
                int index = Convert.ToInt32(e.CommandArgument);

                // Obtén los datos de la fila seleccionada
                GridViewRow row = gvProductos.Rows[index];

                // Asigna los datos a los TextBox
                txtCodigo.Text = row.Cells[0].Text;
                txtNombre.Text = row.Cells[1].Text;
                ddlCategoria.SelectedValue = row.Cells[3].Text; 
                txtPrecio.Text = row.Cells[4].Text;
                txtTiempo.Text = row.Cells[5].Text;
                txtStock.Text = row.Cells[6].Text;
                txtTimeStampProducto.Text = row.Cells[8].Text;

                //Volver Visibles los botones
                btnActualizar.Visible = true;
                btnEliminar.Visible = true;
            }
        }

        /*
        private void LlenarTabla(List<List<string>> productos)
        {
            foreach (var producto in productos)
            {
                var row = new System.Web.UI.HtmlControls.HtmlTableRow();
                for (int i = 0; i < producto.Count; i++)
                {
                    var fila = new System.Web.UI.HtmlControls.HtmlTableCell();
                    fila.InnerText = producto[i];
                    row.Cells.Add(fila);
                }

                var accion = new System.Web.UI.HtmlControls.HtmlTableCell();


                LinkButton btnAccion = new LinkButton
                {
                    Text = "Seleccionar",
                    CommandArgument = producto[0] + "," + producto[1] + "," + producto[3] + "," + producto[4] + "," + producto[5] + "," + producto[6],
                    CommandName = "SelecionarProducto"
                };
                accion.Controls.Add(btnAccion);
                row.Cells.Add(accion);

                ProductosTable.Rows.Add(row);
            }
        }
        */

        protected void RowCommand(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "SelecionarProducto")
            {
                string[] data = e.CommandArgument.ToString().Split(',');
                if (data.Length == 6)
                {
                    string idProducto = data[0];
                    string provedor = data[1];
                    string producto = data[2];
                    string categoria = data[3];
                    string precio = data[4];
                    string tiempo = data[5];
                    string stock = data[6];
                    string stamp = data[7];

                    txtCodigo.Text = idProducto;
                    txtNombre.Text = producto;
                    txtPrecio.Text = precio;
                    txtTiempo.Text = tiempo;
                    ddlCategoria.SelectedValue = categoria;
                    txtTimeStampProducto.Text = stamp;

                    btnEliminar.Visible = true;
                    btnEliminar.Visible = true;
                }
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            empresa.InsertProducto(Convert.ToInt32(Session["IdUsuario"]), txtNombre.Text, ddlCategoria.SelectedValue, Convert.ToDecimal(txtPrecio.Text), Convert.ToInt32(txtTiempo.Text), Convert.ToDecimal(txtStock.Text));
            txtCodigo.Text = string.Empty;
            txtNombre.Text = string.Empty;
            txtPrecio.Text = string.Empty;
            txtTiempo.Text = string.Empty;
            Recarga();
        }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            try
            {
                byte[] timestamp = Convert.FromBase64String(txtTimeStampProducto.Text);
                empresa.UpdateProducto(Convert.ToInt32(txtCodigo.Text), Convert.ToInt32(Session["IdUsuario"]), txtNombre.Text, ddlCategoria.SelectedValue, Convert.ToDecimal(txtPrecio.Text), Convert.ToInt32(txtTiempo.Text), Convert.ToDecimal(txtStock.Text), timestamp);
                btnActualizar.Visible = false;
                btnEliminar.Visible = false;
                Recarga();
            }catch (Exception ex) 
            {
                // Mostrar mensaje de error
                lblMensaje.Text = ("Error:" + ex.Message);
                lblMensaje.Visible = true;
            }
            Recarga();
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            empresa.DeleteProducto(Convert.ToInt32(txtCodigo.Text));
            btnEliminar.Visible = false;
            btnEliminar.Visible = false;
            Recarga();
        }

        protected void btnActualizaV_Click(object sender, EventArgs e)
        {
            try
            {
                int idP = Convert.ToInt32(Session["IdUsuario"]);
                string nombreEmpresa = txtNombre.Text;
                string dire = txtDireccion.Text;
                string conta = txtContacto.Text;
                string horar = txtHorario.Text;
                string ubi = txtUbicacion.Text;

                byte[] timestamp = Convert.FromBase64String(txtTimeStampProvedor.Text);

                empresa.UpdateProvedor(idP, nombreEmpresa, dire, conta, horar, ubi, timestamp);
                
            }
            catch (Exception ex)
            {                
                // Mostrar mensaje de error
                lblMensaje.Text = ("Error:" + ex.Message);
                lblMensaje.Visible = true;
            }
            Recarga();

        }
    }
}