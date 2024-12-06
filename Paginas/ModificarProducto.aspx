<%@ Page Title="Modificar Producto" Language="C#" MasterPageFile="~/Paginas/Pagina.Master" AutoEventWireup="true" CodeBehind="ModificarProducto.aspx.cs" Inherits="Proyecto1AdminBD.Paginas.ModificarProducto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Modificar Producto
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Modificar Producto</h1>

        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-box me-1"></i>
                Información del Producto
            </div>
            <div class="card-body">
                <asp:Panel ID="PanelModificarProducto" runat="server">
                    <div class="mb-3">
                        <label for="txtIdProveedor" class="form-label">ID Proveedor</label>
                        <asp:TextBox ID="txtIdProveedor" runat="server" CssClass="form-control" style="max-width: 300px;"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="txtNombre" class="form-label">Nombre</label>
                        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" style="max-width: 300px;"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="ddlCategoria" class="form-label">Categoría</label>
                        <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="form-control" style="max-width: 300px;">
                            <asp:ListItem Value="ropa">Ropa</asp:ListItem>
                            <asp:ListItem Value="comida">Comida</asp:ListItem>
                            <asp:ListItem Value="zapatos">Zapatos</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="mb-3">
                        <label for="txtPrecio" class="form-label">Precio</label>
                        <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control" style="max-width: 300px;"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="txtTiempoEntrega" class="form-label">Tiempo de Entrega (días)</label>
                        <asp:TextBox ID="txtTiempoEntrega" runat="server" CssClass="form-control" style="max-width: 300px;"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="txtStockDisponible" class="form-label">Stock Disponible</label>
                        <asp:TextBox ID="txtStockDisponible" runat="server" CssClass="form-control" style="max-width: 300px;"></asp:TextBox>
                    </div>
                    <asp:Button ID="btnModificar" runat="server" Text="Modificar Producto" CssClass="btn btn-primary" OnClick="btnModificar_Click" />
                    <asp:Label ID="lblMensaje" runat="server" Visible="False" CssClass="mt-3"></asp:Label>

                    <!-- txt invisibles para los timestamp-->
                    <asp:TextBox ID="txtTimestamp1" runat="server" Visible="False" style="display:none;"></asp:TextBox>
                </asp:Panel>
            </div>
        </div>
    </div>
</asp:Content>
