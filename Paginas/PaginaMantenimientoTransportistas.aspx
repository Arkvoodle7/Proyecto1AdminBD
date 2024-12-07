<%@ Page Title="Mantenimiento de Transportistas" Language="C#" MasterPageFile="~/Paginas/Pagina.Master" AutoEventWireup="true" CodeBehind="PaginaMantenimientoTransportistas.aspx.cs" Inherits="Proyecto1AdminBD.Paginas.PaginaMantenimientoTransportistas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Mantenimiento de Transportistas
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <h2>Mantenimiento de Transportistas</h2>
        <asp:Button ID="btnAgregarTransportista" runat="server" Text="Agregar Transportista" OnClick="btnAgregarTransportista_Click" CssClass="btn btn-primary mb-3" />
        <asp:GridView ID="gvTransportistas" runat="server" AutoGenerateColumns="False" CssClass="table table-striped" OnRowCommand="gvTransportistas_RowCommand">
            <Columns>
                <asp:BoundField DataField="IdUsuario" HeaderText="ID" />
                <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                <asp:BoundField DataField="Apellido" HeaderText="Apellido" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
                <asp:BoundField DataField="Contacto" HeaderText="Contacto" /> 
                <asp:BoundField DataField="TipoTransporte" HeaderText="Tipo de Transporte" />
                <asp:BoundField DataField="FechaNacimiento" HeaderText="Fecha de nacimiento" />
                <asp:BoundField DataField="Rol" HeaderText="Rol" />

                <asp:TemplateField HeaderText="Acciones">
                    <ItemTemplate>
                        <asp:Button ID="btnModificar" runat="server" Text="Modificar" CommandName="Modificar" CommandArgument='<%# Eval("IdUsuario") %>' CssClass="btn btn-warning btn-sm" />
                        <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CommandName="Eliminar" CommandArgument='<%# Eval("IdUsuario") %>' CssClass="btn btn-danger btn-sm" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
