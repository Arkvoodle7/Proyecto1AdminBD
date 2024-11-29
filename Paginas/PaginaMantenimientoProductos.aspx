<%@ Page Title="Mantenimiento de Productos" Language="C#" MasterPageFile="~/Paginas/Pagina.Master" AutoEventWireup="true" CodeBehind="PaginaMantenimientoProductos.aspx.cs" Inherits="Proyecto1AdminBD.Paginas.PaginaMantenimientoProductos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Mantenimiento de Productos
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <h2>Mantenimiento de Productos</h2>
        <asp:Button ID="btnAgregarProducto" runat="server" Text="Agregar Producto" OnClick="btnAgregarProducto_Click" CssClass="btn btn-primary mb-3" />
        <asp:GridView ID="gvProductos" runat="server" AutoGenerateColumns="False" CssClass="table table-striped" OnRowCommand="gvProductos_RowCommand">
            <Columns>
                <asp:BoundField DataField="IdProducto" HeaderText="ID Producto" />
                <asp:BoundField DataField="IdProveedor" HeaderText="ID Proveedor" />
                <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                <asp:BoundField DataField="Categoria" HeaderText="Categoría" />
                <asp:BoundField DataField="Precio" HeaderText="Precio" />
                <asp:BoundField DataField="TiempoEntrega" HeaderText="Tiempo de entrega" />
                <asp:BoundField DataField="StockDisponible" HeaderText="Stock Disponible" />

                <asp:TemplateField HeaderText="Acciones">
                    <ItemTemplate>
                        <asp:Button ID="btnModificar" runat="server" Text="Modificar" CommandName="Modificar" CommandArgument='<%# Eval("IdProducto") %>' CssClass="btn btn-warning btn-sm" />
                        <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CommandName="Eliminar" CommandArgument='<%# Eval("IdProducto") %>' CssClass="btn btn-danger btn-sm" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
