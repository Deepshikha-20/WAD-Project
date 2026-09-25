<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Reminders.aspx.cs" Inherits="Reminders" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Reminders</h1>
    <p class="sub">Bills that need your attention.</p>

    <h3>Due Today</h3>
    <asp:Repeater ID="rptDueToday" runat="server">
        <ItemTemplate>
            <div class="reminder-item">
                <div>
                    <strong><%# Eval("Name") %></strong><br />
                    <small><%# Eval("Category") %> &middot; Due <%# Eval("DueDate", "{0:dd MMM yyyy}") %></small>
                </div>
                <div class="amt"><%# Eval("Amount", "{0:C2}") %></div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
    <asp:Literal ID="litNoDueToday" runat="server" Visible="false" Text="<p>No bills due today.</p>" />

    <h3>Due in Next 3 Days</h3>
    <asp:Repeater ID="rptDueSoon" runat="server">
        <ItemTemplate>
            <div class="reminder-item soon">
                <div>
                    <strong><%# Eval("Name") %></strong><br />
                    <small><%# Eval("Category") %> &middot; Due <%# Eval("DueDate", "{0:dd MMM yyyy}") %></small>
                </div>
                <div class="amt"><%# Eval("Amount", "{0:C2}") %></div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
    <asp:Literal ID="litNoDueSoon" runat="server" Visible="false" Text="<p>Nothing due in the next 3 days.</p>" />
</asp:Content>
