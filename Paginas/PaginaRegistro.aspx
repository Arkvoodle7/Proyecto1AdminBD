<%@ Page Title="Registro" Language="C#" MasterPageFile="~/Paginas/Pagina.Master" AutoEventWireup="true" CodeBehind="PaginaRegistro.aspx.cs" Inherits="Proyecto1AdminBD.Paginas.PaginaRegistro" %> 

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Registro de Usuarios
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-5">
                <div class="card shadow-lg border-0 rounded-lg mt-5">
                    <div class="card-header">
                        <h3 class="text-center font-weight-light my-4">Crear Cuenta</h3>
                    </div>
                    <div class="card-body">
                        <!-- Mensaje de error o confirmación -->
                        <asp:Label ID="lblMensaje" runat="server" ForeColor="Red"></asp:Label>

                        <!-- Tipo de Usuario -->
                        <div class="form-group mb-3">
                            <asp:DropDownList ID="ddlTipoUsuario" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlTipoUsuario_SelectedIndexChanged">
                                <asp:ListItem Text="Seleccionar tipo de usuario" Value="" />
                                <asp:ListItem Text="Cliente" Value="cliente" />
                                <asp:ListItem Text="Proveedor" Value="proveedor" />
                                <asp:ListItem Text="Transportista" Value="transportista" />
                            </asp:DropDownList>
                        </div>

                        <!-- Nombre -->
                        <div class="form-group mb-3">
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" placeholder="Nombre" />
                        </div>

                        <!-- Apellido -->
                        <div class="form-group mb-3">
                            <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" placeholder="Apellido" />
                        </div>

                        <!-- Correo Electrónico -->
                        <div class="form-group mb-3">
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Correo Electrónico" TextMode="Email" />
                        </div>

                        <!-- Contraseña -->
                        <div class="form-group mb-3">
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="Contraseña" TextMode="Password" />
                        </div>

                         <!-- FechaNacimiento -->
                        <div class="form-group mb-3">
                         <asp:TextBox ID="txtFechaNacimiento" runat="server" CssClass="form-control" placeholder="Fecha de Nacimiento" TextMode="Date" />
                        </div>

                        <!-- Campos específicos para Cliente -->
                        <div id="clienteFields" runat="server" visible="false">
                            <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control mb-3" placeholder="Dirección" />
                            <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control mb-3" placeholder="Teléfono" />
                        </div>

                        <!-- Campos específicos para Proveedor -->
                        <div id="proveedorFields" runat="server" visible="false">
                            <asp:TextBox ID="txtNombreEmpresa" runat="server" CssClass="form-control mb-3" placeholder="Nombre de Empresa" />
                            <asp:TextBox ID="txtDireccionProveedor" runat="server" CssClass="form-control mb-3" placeholder="Dirección de Empresa" />
                            <asp:TextBox ID="txtContacto" runat="server" CssClass="form-control mb-3" placeholder="Contacto" />
                            <asp:TextBox ID="txtHorario" runat="server" CssClass="form-control mb-3" placeholder="Horario" />
                            <asp:TextBox ID="txtUbicacion" runat="server" CssClass="form-control mb-3" placeholder="Ubicación" />
                        </div>

                        <!-- Campos específicos para Transportista -->
                        <div id="transportistaFields" runat="server" visible="false">
                            <asp:TextBox ID="txtTipoTransporte" runat="server" CssClass="form-control mb-3" placeholder="Tipo de Transporte" />
                            <asp:TextBox ID="txtContactoTransporte" runat="server" CssClass="form-control mb-3" placeholder="Contacto" />
                        </div>

                        <!-- Botón Registrar -->
                        <div class="d-grid">
                            <asp:Button ID="btnRegistrar" runat="server" CssClass="btn btn-primary" Text="Crear Cuenta" OnClick="btnRegistrar_Click" />
                        </div>

                        <!-- Link para iniciar sesión -->
                        <div class="text-center mt-4">
                            <a href="PaginaLogin.aspx">¿Ya tienes una cuenta? Inicia sesión</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Script para mostrar los campos específicos según el rol seleccionado -->
    <script>
        function mostrarCamposPorRol() {
            const rolSeleccionado = document.getElementById("rol").value;
            document.getElementById("camposCliente").style.display = rolSeleccionado === "cliente" ? "block" : "none";
            document.getElementById("camposProveedor").style.display = rolSeleccionado === "proveedor" ? "block" : "none";
            document.getElementById("camposTransportista").style.display = rolSeleccionado === "transportista" ? "block" : "none";
        }
    </script>
</asp:Content>