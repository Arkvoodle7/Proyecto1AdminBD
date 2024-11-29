<%@ Page Title="Mantenimiento de Oferentes" Language="C#" MasterPageFile="~/Paginas/Pagina.Master" AutoEventWireup="true" CodeBehind="PaginaMantenimientoOferentes.aspx.cs" Inherits="Proyecto1AdminBD.Paginas.PaginaMantenimientoOferentes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Mantenimiento de Oferentes
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <h2>Mantenimiento de Oferentes</h2>
        <asp:Button ID="btnAgregarOferente" runat="server" Text="Agregar Oferente" OnClick="btnAgregarOferente_Click" CssClass="btn btn-primary mb-3" />
        <asp:GridView ID="gvOferentes" runat="server" AutoGenerateColumns="False" CssClass="table table-striped" OnRowCommand="gvOferentes_RowCommand">
            <Columns>
                <asp:BoundField DataField="IdUsuario" HeaderText="ID" />
                <asp:BoundField DataField="NombreEmpresa" HeaderText="Nombre Empresa" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
                <asp:BoundField DataField="Contacto" HeaderText="Contacto" />
                <asp:BoundField DataField="Direccion" HeaderText="Dirección" />
                <asp:BoundField DataField="Horario" HeaderText="Horario" />
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
