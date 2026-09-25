<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BillList.aspx.cs" Inherits="BillList" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>My Bills</h1>
    <p class="sub">All bills on record.</p>

    <div class="filter-row">
        <div class="form-field">
            <label for="txtSearch">Search</label>
            <asp:TextBox ID="txtSearch" runat="server" placeholder="Search by bill name..." AutoPostBack="true" OnTextChanged="Filter_Changed" />
        </div>
        <div class="form-field">
            <label for="ddlCategoryFilter">Category</label>
            <asp:DropDownList ID="ddlCategoryFilter" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed">
                <asp:ListItem Text="All Categories" Value="" />
                <asp:ListItem Text="Electricity" /><asp:ListItem Text="Internet" /><asp:ListItem Text="Water" />
                <asp:ListItem Text="Rent" /><asp:ListItem Text="Insurance" /><asp:ListItem Text="Credit Card" />
                <asp:ListItem Text="Subscription" /><asp:ListItem Text="Phone" /><asp:ListItem Text="Other" />
            </asp:DropDownList>
        </div>
        <div class="form-field">
            <label for="ddlStatusFilter">Status</label>
            <asp:DropDownList ID="ddlStatusFilter" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed">
                <asp:ListItem Text="All Statuses" Value="" />
                <asp:ListItem Text="Pending" />
                <asp:ListItem Text="Paid" />
            </asp:DropDownList>
        </div>
    </div>

    <asp:GridView ID="gvBills" runat="server" CssClass="grid" AutoGenerateColumns="false"
        GridLines="None" DataKeyNames="Id" EmptyDataText="No bills match your filters."
        OnRowCommand="gvBills_RowCommand" OnRowDataBound="gvBills_RowDataBound">
        <Columns>
            <asp:BoundField DataField="Name" HeaderText="Bill" />
            <asp:BoundField DataField="Category" HeaderText="Category" />
            <asp:BoundField DataField="Amount" HeaderText="Amount" DataFormatString="{0:C2}" />
            <asp:BoundField DataField="DueDate" HeaderText="Due Date" DataFormatString="{0:dd MMM yyyy}" />
            <asp:TemplateField HeaderText="Reminder">
                <ItemTemplate><%# Eval("ReminderDays") %> day(s)</ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <span class='<%# (string)Eval("Status") == "Paid" ? "pill paid" : "pill pending" %>'>
                        <%# Eval("Status") %>
                    </span>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="">
                <ItemTemplate>
                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditBill"
                        CommandArgument='<%# Eval("Id") %>' CssClass="btn ghost small">Edit</asp:LinkButton>
                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteBill"
                        CommandArgument='<%# Eval("Id") %>' CssClass="btn danger small"
                        OnClientClick='return confirm("Delete this bill? This cannot be undone.");'>Delete</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
