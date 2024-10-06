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
                <form>
                    <div class="mb-3">
                        <label for="nombreEmpresa" class="form-label">Nombre de la Empresa</label>
                        <input type="text" class="form-control" id="nombreEmpresa" placeholder="Empresa ABC">
                    </div>
                    <div class="mb-3">
                        <label for="emailEmpresa" class="form-label">Correo Electrónico</label>
                        <input type="email" class="form-control" id="emailEmpresa" placeholder="empresa@ejemplo.com">
                    </div>
                    <div class="mb-3">
                        <label for="ubicacion" class="form-label">Ubicación</label>
                        <textarea class="form-control" id="ubicacion" rows="3"></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">Actualizar</button>
                    <button type="submit" class="btn btn-primary">Eliminar</button>
                </form>
            </div>
        </div>

        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-boxes me-1"></i>
                Productos Registrados
            </div>
            <div class="card-body">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Producto</th>
                            <th>Categoría</th>
                            <th>Precio</th>
                            <th>Disponibilidad</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Datos dinámicos aquí -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</asp:Content>