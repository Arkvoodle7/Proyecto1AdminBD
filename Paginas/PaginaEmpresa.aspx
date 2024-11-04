<%@ Page Title="Empresas" Language="C#" MasterPageFile="~/Paginas/Pagina.Master" AutoEventWireup="true" CodeBehind="PaginaEmpresa.aspx.cs" Inherits="Proyecto1AdminBD.Paginas.PaginaEmpresa" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Empresas
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Empresas</h1>
        <h3 class="mt-4"></h3>

        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-building me-1"></i>
                Información de la Empresa
            </div>
            <div class="card-body">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="lblEmpresa" class="form-label">Empresa:</label>
                        <asp:TextBox ID="txtEmpresa" runat="server" CssClass="form-control" Placeholder="Ingrese la empresa:"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label for="lblDireccion" class="form-label">Dirección:</label>
                        <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control" Placeholder="Ingrese la dirección:"></asp:TextBox>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="lblContacto" class="form-label">Contacto:</label>
                        <asp:TextBox ID="txtContacto" runat="server" CssClass="form-control" Placeholder="Ingrese el contacto:"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label for="lblHorario" class="form-label">Horario:</label>
                        <asp:TextBox ID="txtHorario" runat="server" CssClass="form-control" Placeholder="Ingrese el horario:"></asp:TextBox>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="lblUbicacion" class="form-label">Ubicación:</label>
                        <asp:TextBox ID="txtUbicacion" runat="server" CssClass="form-control" Placeholder="Ingrese la ubicación:"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <asp:Button ID="btnActualizaV" runat="server" OnClick="btnActualizaV_Click" Text="Actualizar datos" Width="172px" />
                    </div>
                </div>
            </div>
        </div>

        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-boxes me-1"></i>
                Registrar Productos
            </div>
            <div class="card-body">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="lblCodigo" class="form-label">Código Producto:</label>
                        <asp:TextBox ID="txtCodigo" runat="server" CssClass="form-control" Placeholder="Ingrese código del producto:" ReadOnly="true"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label for="lblNombre" class="form-label">Nombre Producto:</label>
                        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" Placeholder="Ingrese nombre del producto"></asp:TextBox>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-4">
                        <label for="lblCategoria" class="form-label">Categoría:</label>
                        <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="form-control">
                            <asp:ListItem Value="ropa">Ropa</asp:ListItem>
                            <asp:ListItem Value="comida">Comida</asp:ListItem>
                            <asp:ListItem Value="zapatos">Zapatos</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-4">
                        <label for="lblPrecio" class="form-label">Precio:</label>
                        <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control" Placeholder="Ingrese el precio"></asp:TextBox>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-4">
                        <label for="lblTiempo" class="form-label">Tiempo de Entrega:</label>
                        <asp:TextBox ID="txtTiempo" runat="server" CssClass="form-control" Placeholder="Ingrese tiempo en días"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label for="lblstock" class="form-label">Stock Disponible:</label>
                        <asp:TextBox ID="txtstock" runat="server" CssClass="form-control" Placeholder="Ingrese el stock"></asp:TextBox>
                    </div>
                </div>

                <div class="mb-3">
                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-primary" OnClick="btnGuardar_Click" />
                    <asp:Button ID="btnActualizar" runat="server" Text="Actualizar" CssClass="btn btn-primary" OnClick="btnActualizar_Click" Visible="false" />
                    <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn btn-primary" OnClick="btnEliminar_Click" Visible="false" />
                </div>
            </div>
        </div>

        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-boxes me-1"></i>
                Productos Registrados
            </div>
            <div class="card-body">
                <asp:GridView ID="ProductosGridView" runat="server" CssClass="table table-striped" AutoGenerateColumns="false" OnSelectedIndexChanged="ProductosGridView_SelectedIndexChanged" AutoPostBack="true">
                    <Columns>
                        <asp:CommandField ShowSelectButton="true" SelectText="Seleccionar" />
                        <asp:BoundField DataField="IdProducto" HeaderText="ID" />
                        <asp:BoundField DataField="Nombre" HeaderText="Producto" />
                        <asp:BoundField DataField="Categoria" HeaderText="Categoría" />
                        <asp:BoundField DataField="Precio" HeaderText="Precio" />
                        <asp:BoundField DataField="TiempoEntrega" HeaderText="Tiempo de entrega" DataFormatString="{0} días" />
                        <asp:BoundField DataField="Stock" HeaderText="Stock" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>