<%@ Page Title="Envíos" Language="C#" MasterPageFile="~/Paginas/Pagina.Master" AutoEventWireup="true" CodeBehind="PaginaEnvios.aspx.cs" Inherits="Proyecto1AdminBD.Paginas.Envios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Gestión de Envíos</h1>
        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-truck me-1"></i>
                Pedidos Pendientes
            </div>
            <div class="card-body">
               <asp:GridView ID="gvPedidos" runat="server" AutoGenerateColumns="False" CssClass="table table-striped" OnRowCommand="gvPedidos_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="IdPedido" HeaderText="Pedido" /> 
                        <asp:BoundField DataField="IdCliente" HeaderText="Cliente" />
                        <asp:BoundField DataField="FechaPedido" HeaderText="Fecha de Pedido" />
                        <asp:BoundField DataField="CostoTotal" HeaderText="Costo total" />
                        <asp:BoundField DataField="Estado" HeaderText="Estado" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="btnAsignarTransportista" runat="server" Text="Tomar Pedido" CommandName="AsignarTransportista" CommandArgument='<%# Eval("IdPedido") %>' CssClass="btn btn-primary" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
              </asp:GridView>
            </div>
            <asp:Label ID="lblMensaje" runat="server" Text="Label"></asp:Label>
        </div>
    </div>
</asp:Content>
