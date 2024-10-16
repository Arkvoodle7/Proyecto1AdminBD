<%@ Page Title="Contáctenos" Language="C#" MasterPageFile="~/Paginas/Pagina.Master" AutoEventWireup="true" CodeBehind="PaginaContacto.aspx.cs" Inherits="Proyecto1AdminBD.Paginas.PaginaContacto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Contáctenos
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4 text-center text-success">Contáctenos</h1>
        <p>Si tiene alguna pregunta, no dude en contactarnos mediante el siguiente formulario.</p>
        
        <div class="mb-3">
            <asp:Label ID="lblMensaje" runat="server" Text="" CssClass="alert alert-warning mt-3 text-center"></asp:Label>
        </div>
        
        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" Placeholder="Nombre"></asp:TextBox>
        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control mt-2" Placeholder="Email"></asp:TextBox>
        <asp:TextBox ID="txtMensaje" runat="server" TextMode="MultiLine" CssClass="form-control mt-2" Placeholder="Mensaje" Rows="4"></asp:TextBox>
        
        <div class="text-center mt-4">
            <asp:Button ID="btnEnviar" runat="server" Text="Enviar" CssClass="btn btn-primary" OnClick="btnEnviar_Click" />
        </div>
    </div>
</asp:Content>
