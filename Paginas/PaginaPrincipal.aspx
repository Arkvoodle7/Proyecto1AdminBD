<%@ Page Title="Productos" Language="C#" MasterPageFile="~/Paginas/Pagina.Master" AutoEventWireup="true" CodeBehind="PaginaPrincipal.aspx.cs" Inherits="Proyecto1AdminBD.Paginas.PaginaPrincipal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Productos
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Productos</h1>
        
        <!-- Categorías -->
        <div class="row mb-4">
            <asp:Repeater ID="rptCategorias" runat="server">
                <ItemTemplate>
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card bg-info text-white">
                            <div class="card-body"><%# Eval("categoria") %></div>
                            <div class="card-footer d-flex align-items-center justify-content-between">
                                <asp:LinkButton ID="lnkCategoria" runat="server" CommandArgument='<%# Eval("categoria") %>' OnClick="CategoriaSeleccionada" CssClass="small text-white stretched-link">Ver Productos</asp:LinkButton>
                                <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <!-- Lista de Productos -->
        <div class="row">
            <asp:ListView ID="lvProductos" runat="server">
                <LayoutTemplate>
                    <div class="row">
                        <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
                    </div>
                </LayoutTemplate>
                <ItemTemplate>
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title"><%# Eval("nombre") %></h5>
                                <p class="card-text">
                                    Precio: <%# Eval("precio", "{0:C}") %><br />
                                    Tiempo de entrega: <%# Eval("tiempo_entrega") %> días<br />
                                </p>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:ListView>
        </div>
    </div>
</asp:Content>
