<%@ Page Title="Productos" Language="C#" MasterPageFile="~/Paginas/Pagina.Master" AutoEventWireup="true" CodeBehind="PaginaPrincipal.aspx.cs" Inherits="Proyecto1AdminBD.Paginas.PaginaPrincipal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Productos
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4 text-center text-success">Productos</h1> <!-- Título centrado y color verde -->
        
        <!-- Mensaje informativo, en caso de que el usuario no esté logueado -->
        <div class="mb-3"> <!-- Margen inferior -->
            <asp:Label ID="lblMensaje" runat="server" Text="" CssClass="alert alert-warning mt-3 text-center"></asp:Label>  
        </div>

        <!-- Sección para mostrar categorías -->
        <h2 class="mt-4 text-info">Categorías Disponibles</h2> <!-- Título para categorías -->
        <div class="row mb-4">
            <asp:Repeater ID="rptCategorias" runat="server">
                <ItemTemplate>
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card bg-info text-white shadow">
                            <div class="card-body text-center"><%# Eval("categoria") %></div>
                            <div class="card-footer d-flex align-items-center justify-content-between">
                                <asp:LinkButton ID="lnkCategoria" runat="server" CommandArgument='<%# Eval("categoria") %>' OnClick="CategoriaSeleccionada" CssClass="small text-white stretched-link">Ver Productos</asp:LinkButton>
                                <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <!-- Lista de productos filtrada por la categoría seleccionada -->
        <h2 class="mt-4 text-info">Productos en la Categoría Seleccionada</h2> <!-- Título para productos -->
        <asp:ListView ID="lvProductos" runat="server">
            <LayoutTemplate>
                <div class="row">
                    <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
                </div>
            </LayoutTemplate>
            <ItemTemplate>
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="card shadow">
                        <div class="card-body">
                            <h5 class="card-title text-success"><%# Eval("nombre") %></h5> <!-- Título del producto -->
                            <p class="card-text">
                                Precio: <%# Eval("precio", "{0:C}") %><br />
                                Tiempo de entrega: <%# Eval("tiempo_entrega") %> días<br />
                            </p>
                            <!-- Botón para comprar, inicialmente oculto. Se puede controlar desde el code-behind. -->
                            <asp:Button ID="btnComprar" runat="server" Text="Comprar" CommandArgument='<%# Eval("id_producto") %>' OnClick="ComprarProducto_Click" Visible="false" CssClass="btn btn-success" />
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:ListView>

        <!-- Botón "Contáctenos" que redirige a la página de contacto -->
        <div class="text-center mt-4">
            <asp:Button ID="btnContactanos" runat="server" Text="Contáctenos" CssClass="btn btn-info" OnClick="btnContactanos_Click" />
        </div>
    </div>
</asp:Content>
