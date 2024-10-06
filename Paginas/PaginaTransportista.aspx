<%@ Page Title="Transportistas" Language="C#" MasterPageFile="~/Paginas/Pagina.Master" AutoEventWireup="true" CodeBehind="PaginaTransportista.aspx.cs" Inherits="Proyecto1AdminBD.Paginas.PaginaTransportista" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Gestión de Transportistas
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Transportistas</h1>
        <h3 class="mt-4"></h3>
        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-truck me-1"></i>
                Datos Personales
            </div>
            <div class="card-body">
                <form>
                    <div class="mb-3">
                        <label for="nombreTransportista" class="form-label">Nombre Completo</label>
                        <input type="text" class="form-control" id="nombreTransportista" placeholder="Carlos Ramírez">
                    </div>
                    <div class="mb-3">
                        <label for="contacto" class="form-label">Contacto</label>
                        <input type="text" class="form-control" id="contacto" placeholder="Teléfono/Correo">
                    </div>
                    <div class="mb-3">
                        <label for="tipoTransporte" class="form-label">Tipo de Transporte</label>
                        <input type="text" class="form-control" id="tipoTransporte" placeholder="Motocicleta/Camión">
                    </div>
                    <button type="submit" class="btn btn-primary">Actualizar</button>
                    <button type="submit" class="btn btn-primary">Eliminar</button>
                </form>
            </div>
        </div>

        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-shopping-cart me-1"></i>
                Ventas Disponibles para Envío
            </div>
            <div class="card-body">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Venta</th>
                            <th>Producto</th>
                            <th>Destino</th>
                            <th>Tiempo de Entrega</th>
                            <th>Acción</th>
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