<%@ Page Title="Clientes" Language="C#" MasterPageFile="~/Paginas/Pagina.Master" AutoEventWireup="true" CodeBehind="PaginaCliente.aspx.cs" Inherits="Proyecto1AdminBD.Paginas.PaginaCliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Gestión de Clientes
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Gestión de Clientes</h1>
        <h3 class="mt-4"></h3>

        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-user me-1"></i>
                Información Personal
            </div>
            <div class="card-body">
                <asp:Panel ID="PanelCliente" runat="server">
                    <div class="mb-3">
                        <label for="lblIdCliente" class="form-label">ID del Cliente</label>
                        <asp:Label ID="lblIdCliente" runat="server" Text="" CssClass="form-control" ReadOnly="true" style="max-width: 200px;"></asp:Label>
                    </div>
                    <div class="mb-3">
                        <label for="telefono" class="form-label">Telefono</label>
                        <asp:TextBox ID="telefono" runat="server" CssClass="form-control" style="max-width: 300px;"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="direccion" class="form-label">Dirección</label>
                        <asp:TextBox ID="direccion" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" style="max-width: 300px;"></asp:TextBox>
                    </div>
                    <div class="d-flex justify-content-between">
                        <asp:Button ID="btnActualizar" runat="server" Text="Actualizar" CssClass="btn btn-primary" OnClick="btnActualizar_Click" />
                        <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn btn-danger" OnClick="btnEliminar_Click" />
                    </div>
                    <asp:Label ID="lblMensaje" runat="server" ForeColor="Red" Visible="False" CssClass="mt-3"></asp:Label>
                </asp:Panel>
            </div>
        </div>
    </div>
</asp:Content>
