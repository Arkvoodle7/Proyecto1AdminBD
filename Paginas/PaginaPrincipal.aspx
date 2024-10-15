<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Paginas/Pagina.Master" AutoEventWireup="true" CodeBehind="PaginaPrincipal.aspx.cs" Inherits="Proyecto1AdminBD.Paginas.PaginaPrincipal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Página Principal
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Página Principal</h1>
        <h3 class="mt-4">
            <asp:Button ID="btnRopa" runat="server" BackColor="White" Height="33px" OnClick="btnRopa_Click" Text="Ropa" Width="172px" />
            <asp:Button ID="btnZapatos" runat="server" BackColor="White" Height="33px" OnClick="btnZapatos_Click" Text="Zapatos" Width="172px" />
            <asp:Button ID="btnComida" runat="server" BackColor="White" Height="33px" OnClick="btnComida_Click" Text="Comida" Width="172px" />
            <asp:Button ID="btnAgregarCarrito" runat="server" OnClick="btnAgregarCarrito_Click" Text="Agregar al carrito" />
        </h3>

        <div class="card-body">
            <table id="ProductosTable" runat="server" class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Provedor</th>
                        <th>Producto</th>
                        <th>Categoría</th>
                        <th>Precio</th>
                        <th>Tiempo de entrega</th>
                        <th>Agregar al carrito</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Las filas se agregan aqio -->
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>