<%@ Page Title="Carrito" Language="C#" MasterPageFile="~/Paginas/Pagina.Master" AutoEventWireup="true" CodeBehind="PaginaCarrito.aspx.cs" Inherits="Proyecto1AdminBD.Paginas.PaginaCarrito" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4 text-center text-success">Carrito de Compras</h1>

        <div class="card mb-4 shadow">
            <div class="card-header bg-info text-white">
                <i class="fas fa-shopping-cart me-1"></i>
                Carrito de Compras
            </div>
            <div class="card-body">
                <asp:GridView ID="gvCarrito" runat="server" AutoGenerateColumns="False" CssClass="table table-striped" ShowFooter="True" OnRowDataBound="gvCarrito_RowDataBound">
                    <Columns>
                        <asp:BoundField DataField="Nombre" HeaderText="Producto" />
                        <asp:BoundField DataField="Precio" HeaderText="Precio" DataFormatString="{0:C}" />
                        <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />
                        <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" DataFormatString="{0:C}" />
                        <asp:BoundField DataField="Impuestos" HeaderText="Impuestos" DataFormatString="{0:C}" />
                        <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="{0:C}" />
                    </Columns>
                </asp:GridView>

                <asp:Button ID="btnFinalizarCompra" runat="server" Text="Finalizar Compra" CssClass="btn btn-secondary" OnClick="btnFinalizarCompra_Click" />
                <asp:Label ID="lblMensajeCompra" runat="server" ForeColor="Red" />
            </div>
        </div>
    </div>
</asp:Content>
