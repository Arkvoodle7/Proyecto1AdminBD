<%@ Page Title="Compra" Language="C#" MasterPageFile="~/Paginas/Pagina.Master" AutoEventWireup="true" CodeBehind="PaginaCompra.aspx.cs" Inherits="Proyecto1AdminBD.Paginas.PaginaCompra" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4 text-center text-success">Compra de Producto</h1> <!-- Título centrado y color verde -->
        
        <div class="card mb-4 shadow">
            <div class="card-header bg-info text-white">
                <i class="fas fa-shopping-cart me-1"></i>
                Detalles de la Compra
            </div>
            <div class="card-body">
                <!-- Aquí se puede mostrar el nombre y precio del producto -->
                <asp:Label ID="lblProducto" runat="server" Text="Producto: " CssClass="h5"></asp:Label><br />
                <asp:Label ID="lblPrecio" runat="server" Text="Precio: " CssClass="h5"></asp:Label><br />

                <div class="mb-3 mt-4"> <!-- Margen superior para separar el campo de cantidad -->
                    <label for="txtCantidad" class="form-label">Cantidad</label>
                    <asp:TextBox ID="txtCantidad" runat="server" CssClass="form-control" placeholder="Ingrese cantidad" />
                </div>
                
                <div class="d-flex justify-content-between mt-4"> <!-- Alinear botones -->
                    <asp:Button ID="btnAgregarAlCarrito" runat="server" Text="Agregar al Carrito" CssClass="btn btn-secondary" OnClick="btnAgregarAlCarrito_Click" />
                    <asp:Button ID="btnIrAlCarrito" runat="server" Text="Ir al Carrito" CssClass="btn btn-secondary" OnClick="btnIrAlCarrito_Click" />
                    <asp:Button ID="Salir" runat="server" Text="Salir" CssClass="btn btn-secondary" OnClick="Salir_Click" />
                </div>

                <asp:Label ID="lblMensajeCompra" runat="server" Text="" CssClass="text-danger mt-3 d-block"></asp:Label>
            </div>
        </div>
    </div>
</asp:Content>
