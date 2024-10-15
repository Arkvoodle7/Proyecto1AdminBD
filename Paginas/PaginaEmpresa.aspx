<%@ Page Title="Empresas" Language="C#" MasterPageFile="~/Paginas/Pagina.Master" AutoEventWireup="true" CodeBehind="PaginaEmpresa.aspx.cs" Inherits="Proyecto1AdminBD.Paginas.PaginaEmpresa" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Gestión de Empresas
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Empresas</h1>
        <h3 class="mt-4"></h3>
        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-building me-1"></i>
                Información de la Empresa
            </div>
            <div class="card-body">
                <div class="mb-3">
                    <label for="lblNombreE" class="form-label">Nombre Empresa:</label>
                    <asp:Label ID="lblNombreE" runat="server" CssClass="form-control">Empresa ABC</asp:Label>
                </div>
                <div class="mb-3">
                    <label for="lblDireccion" class="form-label">Dirección:</label>
                    <asp:Label ID="lblDireccion" runat="server" CssClass="form-control">Calle Ejemplo 123</asp:Label>
                </div>
                <div class="mb-3">
                    <label for="lblContacto" class="form-label">Contacto:</label>
                    <asp:Label ID="lblContacto" runat="server" CssClass="form-control">contacto@ejemplo.com</asp:Label>
                </div>
                <div class="mb-3">
                    <label for="lblHorario" class="form-label">Horario:</label>
                    <asp:Label ID="lblHorario" runat="server" CssClass="form-control">Lunes a Viernes 9am - 5pm</asp:Label>
                </div>
                <div class="mb-3">
                    <label for="lblUbicacion" class="form-label">Ubicación:</label>
                    <asp:Label ID="lblUbicacion" runat="server" CssClass="form-control">Ciudad Ejemplo</asp:Label>
                </div>

                <asp:Button ID="btnActualizar" runat="server" Text="Actualizar" CssClass="btn btn-primary" OnClick="btnActualizar_Click" />
                <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn btn-primary" OnClick="btnEliminar_Click" />
            </div>
        </div>

        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-boxes me-1"></i>
                Productos Registrados
            </div>
            <div class="card-body">
                <table id="ProductosTable" runat="server" class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Proveedor</th>
                            <th>Producto</th>
                            <th>Categoría</th>
                            <th>Precio</th>
                            <th>Tiempo de entrega</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Las filas se agregan aquí -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
