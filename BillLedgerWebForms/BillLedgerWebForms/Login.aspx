<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Sign in - BillRemind</title>
    <link href="Content/site.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-wrap">
            <div class="login-card">
                <div class="brand">
                    <span class="brand-icon">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="4" y="3" width="16" height="18" rx="2"/><path d="M8 8h8M8 12h8M8 16h5"/></svg>
                    </span>
                    <span class="brand-text">BillRemind</span>
                </div>
                <h1>Sign in</h1>
                <p class="sub">Enter a username to access your bills.</p>

                <div class="form-field">
                    <label for="txtUsername">Username</label>
                    <asp:TextBox ID="txtUsername" runat="server" placeholder="e.g. priya" />
                    <asp:RequiredFieldValidator ID="rfvUsername" runat="server"
                        ControlToValidate="txtUsername" ErrorMessage="Username is required."
                        CssClass="error-text" Display="Dynamic" />
                </div>

                <asp:Button ID="btnLogin" runat="server" Text="Sign in" CssClass="btn" Style="width:100%;" OnClick="btnLogin_Click" />
            </div>
        </div>
    </form>
</body>
</html>
