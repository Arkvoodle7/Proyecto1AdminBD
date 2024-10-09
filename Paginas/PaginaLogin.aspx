<%@ Page Title="Login" Language="C#" MasterPageFile="~/Paginas/Pagina.Master" AutoEventWireup="true" CodeBehind="PaginaLogin.aspx.cs" Inherits="Proyecto1AdminBD.Paginas.PaginaLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-5">
                <div class="card shadow-lg border-0 rounded-lg mt-5">
                    <div class="card-header"><h3 class="text-center font-weight-light my-4">Iniciar Sesión</h3></div>
                    <div class="card-body">
                        <asp:Label ID="lblMensaje" runat="server" ForeColor="Red"></asp:Label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control mb-3" placeholder="Correo Electrónico" TextMode="Email"></asp:TextBox>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control mb-3" placeholder="Contraseña" TextMode="Password"></asp:TextBox>
                        <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-primary mt-3" Text="Iniciar Sesión" OnClick="btnLogin_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>