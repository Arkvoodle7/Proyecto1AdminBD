<%@ Page Title="Empresas" Language="C#" MasterPageFile="~/Paginas/Pagina.Master" AutoEventWireup="true" CodeBehind="PaginaEmpresa.aspx.cs" Inherits="Proyecto1AdminBD.Paginas.PaginaCliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Gestión de Clientes
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Clientes</h1>
        <h3 class="mt-4"></h3>
        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-table me-1"></i>
                Información Personal
            </div>
            <div class="card-body">
                <form>
                    <div class="mb-3">
                        <label for="nombre" class="form-label">Nombre Completo</label>
                        <input type="text" class="form-control" id="nombre" placeholder="Juan Pérez">
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Correo Electrónico</label>
                        <input type="email" class="form-control" id="email" placeholder="correo@ejemplo.com">
                    </div>
                    <div class="mb-3">
                        <label for="direccion" class="form-label">Dirección</label>
                        <textarea class="form-control" id="direccion" rows="3"></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">Actualizar</button>
                    <button type="submit" class="btn btn-primary">Eliminar</button>
                </form>
            </div>
        </div>

        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-shopping-cart me-1"></i>
                Historial de Compras
            </div>
            <div class="card-body">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Fecha</th>
                            <th>Producto</th>
                            <th>Cantidad</th>
                            <th>Precio</th>
                            <th>Estado</th>
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
