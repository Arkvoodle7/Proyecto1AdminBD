<%@ Page Title="Empresas" Language="C#" AutoEventWireup="true" CodeBehind="PaginaEmpresa.aspx.cs" Inherits="Proyecto1AdminBD.Paginas.PaginaEmpresa" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Empresas</title>
    <!-- Agrega las referencias a Bootstrap y Font Awesome -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body>
    <form runat="server">
        <div class="container-fluid px-4">
            <h1 class="mt-4">Empresas</h1>
            <h3 class="mt-4"></h3>

            <div class="card mb-4">
                <div class="card-header">
                    <i class="fas fa-building me-1"></i>
                    Información de la Empresa
                </div>
                <div class="card-body">
                    <!-- Primera fila con Nombre Empresa y Dirección -->
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

                    <!-- Segunda fila con Contacto y Horario -->
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

                    <!-- Tercera fila con Ubicación y botón -->
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="lblUbicacion" class="form-label">Ubicación:</label>
                            <asp:TextBox ID="txtUbicacion" runat="server" CssClass="form-control" Placeholder="Ingrese la ubicación:"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <asp:Button ID="btnActualizaV" runat="server" OnClick="btnActualizaV_Click" Text="Actualizar datos" Width="172px" />
                        </div>
                        
                    </div>
                    <asp:Label ID="lblMensaje" runat="server" ForeColor="Red" Visible="False" CssClass="mt-3"></asp:Label>  
                </div>
            </div>

            <div class="card mb-4">
                <div class="card-header">
                    <i class="fas fa-boxes me-1"></i>
                    Registrar Productos
                </div>

                    <!-- Primera fila con Nombre Producto y Categoría -->
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

                    <!-- Segunda fila con Categoría, Precio y Tiempo de entrega -->
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
                            <label for="lblStock" class="form-label">Stock actual:</label>
                            <asp:TextBox ID="txtStock" runat="server" CssClass="form-control" Placeholder="Ingrese el stock"></asp:TextBox>
                        </div>
                    </div>

                    <!-- Botones -->
                    <div class="mb-3">
                        <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-primary" OnClick="btnGuardar_Click" />
                        <asp:Button ID="btnActualizar" runat="server" Text="Actualizar" CssClass="btn btn-primary" OnClick="btnActualizar_Click" Visible ="false" />
                        <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn btn-primary" OnClick="btnEliminar_Click" Visible ="false" />
                    </div>
                </div>
            </div>

            <div class="card mb-4">
                <div class="card-header">
                    <i class="fas fa-boxes me-1"></i>
                    Productos Registrados
                </div>
                <div class="card-body">
                    <table id="ProductosTable" runat="server" class="table table-striped">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Proveedor</th>
                                <th>Producto</th>
                                <th>Categoría</th>
                                <th>Precio</th>
                                <th>Tiempo de entrega</th>
                                <th style="display: none;">Stamp</th> 
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Las filas se agregarán aquí -->
                        </tbody>
                    </table>
                </div>
            </div>
        <asp:TextBox ID="txtTimeStampProducto" runat="server" Visible="false"></asp:TextBox>
        <asp:TextBox ID="txtTimeStampProvedor" runat="server" Visible="false"></asp:TextBox>
        </div>
    </form>

    <!-- Agrega las referencias a Bootstrap JS y Font Awesome JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>