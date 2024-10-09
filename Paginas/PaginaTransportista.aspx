<%@ Page Title="Transportistas" Language="C#" MasterPageFile="~/Paginas/Pagina.Master" AutoEventWireup="true" CodeBehind="PaginaTransportista.aspx.cs" Inherits="Proyecto1AdminBD.Paginas.PaginaTransportista" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Gestión de Transportistas
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Transportistas</h1>
        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-truck me-1"></i>
                Datos Personales
            </div>
            <div class="card-body">
                <!-- Reemplazamos el formulario HTML por un asp:Panel -->
                <asp:Panel ID="PanelTransportista" runat="server">
                    <div class="mb-3">
                        <label for="nombreTransportista" class="form-label">Nombre Completo</label>
                        <asp:TextBox ID="nombreTransportista" runat="server"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="contacto" class="form-label">Contacto</label>
                        <asp:TextBox ID="contacto" runat="server"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="tipoTransporte" class="form-label">Tipo de Transporte</label>
                        <asp:TextBox ID="tipoTransporte" runat="server"></asp:TextBox>
                    </div>                   
                    <asp:Button ID="btnActualizar" runat="server" Text="Actualizar" OnClick="btnActualizar_Click" />
                    <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" OnClick="btnEliminar_Click" />
                    <asp:Label ID="lblMensaje" runat="server" ForeColor="Red" Visible="False"></asp:Label>                
                </asp:Panel>
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


