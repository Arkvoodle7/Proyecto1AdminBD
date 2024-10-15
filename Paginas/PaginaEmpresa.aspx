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
                    <label for="nombreEmpresa" class="form-label">Nombre de la Empresa</label>
                    <asp:TextBox ID="nombreEmpresa" runat="server" CssClass="form-control" Placeholder="Empresa ABC"></asp:TextBox>
                </div>
                <div class="mb-3">
                    <label for="emailEmpresa" class="form-label">Correo Electrónico</label>
                    <asp:TextBox ID="emailEmpresa" runat="server" CssClass="form-control" Placeholder="empresa@ejemplo.com"></asp:TextBox>
                </div>
                <div class="mb-3">
                    <label for="ubicacion" class="form-label">Ubicación</label>
                    <asp:TextBox ID="ubicacion" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
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
                            <th>Provedor</th>
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