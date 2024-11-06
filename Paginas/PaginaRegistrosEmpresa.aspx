<%@ Page Title="" Language="C#" MasterPageFile="~/Paginas/Pagina.Master" AutoEventWireup="true" CodeBehind="PaginaRegistrosEmpresa.aspx.cs" Inherits="Proyecto1AdminBD.Paginas.Formulario_web1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Registros de ventas de la empresa
</asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <asp:GridView ID="PedidosGridView" runat="server" CssClass="table table-striped" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="IdPedido" HeaderText="ID Pedido" />
            <asp:BoundField DataField="IdCliente" HeaderText="ID Cliente" />
            <asp:BoundField DataField="IdProducto" HeaderText="ID Producto" />
            <asp:BoundField DataField="IdTransportista" HeaderText="ID Transportista" />
            <asp:BoundField DataField="FechaPedido" HeaderText="Fecha de Pedido" DataFormatString="{0:dd/MM/yyyy}" />
            <asp:BoundField DataField="Estado" HeaderText="Estado" />
            <asp:BoundField DataField="CostoTotal" HeaderText="Costo Total" DataFormatString="{0:C}" />
            <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />
        </Columns>
    </asp:GridView>
</asp:Content>
