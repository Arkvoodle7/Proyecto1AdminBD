<%@ Page Title="Historial de Compras" Language="C#" MasterPageFile="~/Paginas/Pagina.Master" AutoEventWireup="true" CodeBehind="HistorialCompras.aspx.cs" Inherits="Proyecto1AdminBD.Paginas.HistorialCompras" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Historial de Compras</h1>
        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-shopping-cart me-1"></i>
                Compras Anteriores
            </div>
            <div class="card-body">
                <asp:GridView ID="gvHistorialCompras" runat="server" AutoGenerateColumns="False" CssClass="table table-striped">
                    <Columns>
                        <asp:BoundField DataField="IdHistorial" HeaderText="Historial" /> 
                        <asp:BoundField DataField="IdPedido" HeaderText="Pedido" />
                        <asp:BoundField DataField="FechaEntrega" HeaderText="Fecha de Entrega" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:BoundField DataField="Observaciones" HeaderText="Observaciones" />
                    </Columns>
                </asp:GridView>
            </div>
            <asp:Label ID="lblMensaje" runat="server" Text="Label"></asp:Label>
        </div>
    </div>
</asp:Content>
