<%@ Page Title="" Language="C#" MasterPageFile="~/Paginas/Pagina.Master" AutoEventWireup="true" CodeBehind="PaginaEstado.aspx.cs" Inherits="Proyecto1AdminBD.Paginas.Formulario_web11" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Lista de pedidos pendientes</h1>
        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-truck me-1"></i>
                Pedidos Pendientes
            </div>
            <div class="card-body">
               <asp:GridView ID="gvPedidos" runat="server" AutoGenerateColumns="False" CssClass="table table-striped" OnRowCommand="gvPedidos_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="IdPedido" HeaderText="Pedido" SortExpression="IdPedido" />
                        <asp:BoundField DataField="FechaPedido" HeaderText="Fecha de Pedido" SortExpression="FechaPedido" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="Estado" HeaderText="Estado" SortExpression="Estado" />
                        <asp:BoundField DataField="Total" HeaderText="Total" SortExpression="Total" DataFormatString="{0:C2}" HtmlEncode="false" />
                        <asp:BoundField DataField="IdCliente" HeaderText="Cliente" SortExpression="IdCliente" />
                        <asp:BoundField DataField="Telefono" HeaderText="Teléfono" SortExpression="Telefono" />
                        <asp:CommandField ShowSelectButton="true" SelectText="Cancelar" />
                    </Columns>
              </asp:GridView>
            </div>
            <asp:Label ID="lblMensaje" runat="server" Text="Label" Visible="false"></asp:Label>
        </div>
    </div>
</asp:Content>