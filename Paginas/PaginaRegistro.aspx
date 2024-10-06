<%@ Page Title="Registro" Language="C#" MasterPageFile="~/Paginas/Pagina.Master" AutoEventWireup="true" CodeBehind="PaginaRegistro.aspx.cs" Inherits="Proyecto1AdminBD.Paginas.PaginaRegistro" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Registro de Usuarios
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="layoutAuthentication">
        <div id="layoutAuthentication_content">
            <main>
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-lg-7">
                            <div class="card shadow-lg border-0 rounded-lg mt-5">
                                <div class="card-header">
                                    <h3 class="text-center font-weight-light my-4">Crear Cuenta</h3>
                                </div>
                                <div class="card-body">
                                    <form id="registroForm">
                                        <!-- Selección del tipo de usuario -->
                                        <div class="form-floating mb-3">
                                            <select class="form-select" id="rol" onchange="mostrarCamposPorRol()">
                                                <option value="" selected disabled>Seleccionar tipo de usuario</option>
                                                <option value="cliente">Cliente</option>
                                                <option value="proveedor">Oferente de servicios</option>
                                                <option value="transportista">Transportista</option>
                                            </select>
                                            <label for="rol">Tipo de Usuario</label>
                                        </div>

                                        <!-- Campos comunes -->
                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="inputNombre" type="text" placeholder="Ingresa tu nombre" />
                                            <label for="inputNombre">Nombre</label>
                                        </div>
                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="inputApellido" type="text" placeholder="Ingresa tu apellido" />
                                            <label for="inputApellido">Apellido</label>
                                        </div>
                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="inputEmail" type="email" placeholder="correo@ejemplo.com" />
                                            <label for="inputEmail">Correo Electrónico</label>
                                        </div>
                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="inputPassword" type="password" placeholder="Crea una contraseña" />
                                            <label for="inputPassword">Contraseña</label>
                                        </div>

                                        <!-- Campos específicos por rol -->
                                        <div id="camposCliente" style="display:none;">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="inputDireccion" type="text" placeholder="Ingresa tu dirección" />
                                                <label for="inputDireccion">Dirección</label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="inputTelefono" type="text" placeholder="Teléfono" />
                                                <label for="inputTelefono">Teléfono</label>
                                            </div>
                                        </div>

                                        <div id="camposTransportista" style="display:none;">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="inputTipoTransporte" type="text" placeholder="Tipo de Transporte" />
                                                <label for="inputTipoTransporte">Tipo de Transporte</label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="inputContactoTransp" type="text" placeholder="Teléfono/Correo" />
                                                <label for="inputContactoTransp">Contacto</label>
                                            </div>
                                        </div>

                                        <div id="camposProveedor" style="display:none;">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="inputNombreEmpresa" type="text" placeholder="Nombre de la Empresa" />
                                                <label for="inputNombreEmpresa">Nombre de la Empresa</label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="inputDireccionEmpresa" type="text" placeholder="Dirección de la Empresa" />
                                                <label for="inputDireccionEmpresa">Dirección</label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="inputContactoEmpresa" type="text" placeholder="Teléfono/Correo" />
                                                <label for="inputContactoEmpresa">Contacto</label>
                                            </div>
                                        </div>

                                        <div class="mt-4 mb-0">
                                            <div class="d-grid">
                                                <button class="btn btn-primary btn-block" type="submit">Crear Cuenta</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div class="card-footer text-center py-3">
                                    <div class="small"><a href="PaginaLogin.aspx">¿Ya tienes una cuenta? Inicia sesión</a></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
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