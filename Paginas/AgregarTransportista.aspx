﻿<%@ Page Title="Agregar Transportista" Language="C#" MasterPageFile="~/Paginas/Pagina.Master" AutoEventWireup="true" CodeBehind="AgregarTransportista.aspx.cs" Inherits="Proyecto1AdminBD.Paginas.AgregarTransportista" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Agregar Transportista
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Agregar Transportista</h1>

        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-truck me-1"></i>
                Información del Transportista
            </div>
            <div class="card-body">
                <asp:Panel ID="PanelAgregarTransportista" runat="server">
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
                        <label for="txtTipoTransporte" class="form-label">Tipo de Transporte</label>
                        <asp:TextBox ID="txtTipoTransporte" runat="server" CssClass="form-control" style="max-width: 300px;"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="txtContacto" class="form-label">Contacto</label>
                        <asp:TextBox ID="txtContacto" runat="server" CssClass="form-control" style="max-width: 300px;"></asp:TextBox>
                    </div>
                    <asp:Button ID="btnAgregar" runat="server" Text="Agregar Transportista" CssClass="btn btn-primary" OnClick="btnAgregar_Click" />
                    <asp:Label ID="lblMensaje" runat="server" Visible="False" CssClass="mt-3"></asp:Label>
                </asp:Panel>
            </div>
        </div>
    </div>
</asp:Content>
