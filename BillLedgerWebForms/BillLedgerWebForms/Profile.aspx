<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Profile.aspx.cs" Inherits="ProfilePage" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Profile</h1>
    <p class="sub">Manage how your name appears in the app.</p>

    <div class="panel" style="max-width:420px;">
        <asp:Literal ID="litSaved" runat="server" Visible="false" Text="<p style='color:#16A34A;font-size:13px;'>Saved.</p>" />

        <div class="form-field">
            <label>Username (used for sign-in)</label>
            <asp:TextBox ID="txtUsernameVal" runat="server" ReadOnly="true" style="background:#F3F4F6;" />
        </div>
        <div class="form-field">
            <label for="txtDisplayName">Display name</label>
            <asp:TextBox ID="txtDisplayName" runat="server" placeholder="e.g. Sadhna" />
        </div>
        <asp:Button ID="btnSave" runat="server" Text="Save changes" CssClass="btn" OnClick="btnSave_Click" />
    </div>
</asp:Content>
