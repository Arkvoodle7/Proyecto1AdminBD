<%@ Page Title="Seguimiento de Pedidos" Language="C#" MasterPageFile="~/Paginas/Pagina.Master" AutoEventWireup="true" CodeBehind="PaginaSeguimiento.aspx.cs" Inherits="Proyecto1AdminBD.Paginas.PaginaSeguimiento" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Seguimiento de Pedidos</h1>
        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-truck me-1"></i>
                Pedidos en Curso
            </div>
            <div class="card-body">
                <asp:GridView ID="gvSeguimientoPedidos" runat="server" AutoGenerateColumns="False" CssClass="table table-striped">
                    <Columns>
                        <asp:BoundField DataField="IdPedido" HeaderText="ID Pedido" />
                        <asp:BoundField DataField="FechaPedido" HeaderText="Fecha del Pedido" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:BoundField DataField="Estado" HeaderText="Estado" />
                        <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" DataFormatString="{0:C2}" />
                        <asp:BoundField DataField="Impuestos" HeaderText="Impuestos" DataFormatString="{0:C2}" />
                        <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="{0:C2}" />
                        <asp:BoundField DataField="Transportista" HeaderText="Transportista" />
                        <asp:BoundField DataField="TiempoEntrega" HeaderText="Tiempo de Entrega (días)" />
                        <asp:BoundField DataField="ContactoTransportista" HeaderText="Contacto Transportista" />
                        <asp:BoundField DataField="CostoEntrega" HeaderText="Costo de entrega" />
                    </Columns>
                </asp:GridView>
            </div>
            <asp:Label ID="lblMensaje" runat="server" Text="" CssClass="text-danger" Visible="false"></asp:Label>
        </div>
    </div>
</asp:Content>
