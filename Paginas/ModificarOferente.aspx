﻿<%@ Page Title="Modificar Oferente" Language="C#" MasterPageFile="~/Paginas/Pagina.Master" AutoEventWireup="true" CodeBehind="ModificarOferente.aspx.cs" Inherits="Proyecto1AdminBD.Paginas.ModificarOferente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Modificar Oferente
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Modificar Oferente</h1>

        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-building me-1"></i>
                Modificar Información del Oferente
            </div>
            <div class="card-body">
                <asp:Panel ID="PanelModificarOferente" runat="server">
                    <div class="mb-3">
                        <label for="txtNombre" class="form-label">Nombre</label>
                        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" style="max-width: 300px;"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="txtApellido" class="form-label">Apellido</label>
                        <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" style="max-width: 300px;"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="txtEmail" class="form-label">Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" style="max-width: 300px;"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="txtPassword" class="form-label">Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" style="max-width: 300px;"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="txtFechaNacimiento" class="form-label">Fecha de Nacimiento</label>
                        <asp:TextBox ID="txtFechaNacimiento" runat="server" CssClass="form-control" placeholder="Fecha de Nacimiento" TextMode="Date" />
                    </div>
                    <div class="mb-3">
                        <label for="txtNombreEmpresa" class="form-label">Nombre Empresa</label>
                        <asp:TextBox ID="txtNombreEmpresa" runat="server" CssClass="form-control" style="max-width: 300px;"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="txtDireccion" class="form-label">Dirección</label>
                        <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" style="max-width: 300px;"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="txtContacto" class="form-label">Contacto</label>
                        <asp:TextBox ID="txtContacto" runat="server" CssClass="form-control" style="max-width: 300px;"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="txtHorario" class="form-label">Horario</label>
                        <asp:TextBox ID="txtHorario" runat="server" CssClass="form-control" style="max-width: 300px;"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="txtGeografia" class="form-label">Geografía</label>
                        <asp:TextBox ID="txtGeografia" runat="server" CssClass="form-control" style="max-width: 300px;"></asp:TextBox>
                    </div>
                    <asp:Button ID="btnModificar" runat="server" Text="Modificar Oferente" CssClass="btn btn-primary" OnClick="btnModificar_Click" />
                    <asp:Label ID="lblMensaje" runat="server" Visible="False" CssClass="mt-3"></asp:Label>
                </asp:Panel>
            </div>
        </div>
    </div>
</asp:Content>