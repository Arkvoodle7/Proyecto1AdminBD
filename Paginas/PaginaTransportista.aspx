<%@ Page Title="Transportistas" Language="C#" MasterPageFile="~/Paginas/Pagina.Master" AutoEventWireup="true" CodeBehind="PaginaTransportista.aspx.cs" Inherits="Proyecto1AdminBD.Paginas.PaginaTransportista" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Gestión de Transportistas
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Gestión de Transportistas</h1>
        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-truck me-1"></i>
                Datos Personales
            </div>
            <div class="card-body">
                <asp:Panel ID="PanelTransportista" runat="server">
                    <div class="mb-3">
                        <label for="lblIdTransportista" class="form-label">ID del Transportista</label>
                        <asp:Label ID="lblIdTransportista" runat="server" Text="" CssClass="form-control" ReadOnly="true" style="max-width: 200px;"></asp:Label>
                    </div>
                    <div class="mb-3">
                        <label for="contacto" class="form-label">Contacto</label>
                        <asp:TextBox ID="contacto" runat="server" CssClass="form-control" style="max-width: 300px;"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="tipoTransporte" class="form-label">Tipo de Transporte</label>
                        <asp:TextBox ID="tipoTransporte" runat="server" CssClass="form-control" style="max-width: 300px;"></asp:TextBox>
                    </div>
                    <div class="d-flex justify-content-between">
                        <asp:Button ID="btnActualizar" runat="server" Text="Actualizar" CssClass="btn btn-primary" OnClick="btnActualizar_Click" />
                        <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn btn-danger" OnClick="btnEliminar_Click" />
                    </div>
                    <asp:Label ID="lblMensaje" runat="server" ForeColor="Red" Visible="False" CssClass="mt-3"></asp:Label>                
                </asp:Panel>
            </div>
        </div>
        <asp:TextBox ID="txtTimeStamp" runat="server" Visible="false"></asp:TextBox>
    </div>
</asp:Content>
