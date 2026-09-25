<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddBill.aspx.cs" Inherits="AddBill" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><asp:Literal ID="litTitle" runat="server" Text="Add Bill" /></h1>
    <p class="sub">Enter the details for a bill.</p>

    <asp:Literal ID="litError" runat="server" Visible="false" />

    <div class="form-field">
        <label for="txtName">Bill name</label>
        <asp:TextBox ID="txtName" runat="server" placeholder="e.g. Electricity" />
        <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName"
            ErrorMessage="Bill name is required." CssClass="error-text" Display="Dynamic" />
    </div>

    <div class="form-field">
        <label for="ddlCategory">Category</label>
        <asp:DropDownList ID="ddlCategory" runat="server">
            <asp:ListItem Text="Electricity" />
            <asp:ListItem Text="Internet" />
            <asp:ListItem Text="Water" />
            <asp:ListItem Text="Rent" />
            <asp:ListItem Text="Insurance" />
            <asp:ListItem Text="Credit Card" />
            <asp:ListItem Text="Subscription" />
            <asp:ListItem Text="Phone" />
            <asp:ListItem Text="Other" />
        </asp:DropDownList>
    </div>

    <div class="form-field">
        <label for="txtAmount">Amount (₹)</label>
        <asp:TextBox ID="txtAmount" runat="server" TextMode="Number" step="0.01" />
        <asp:RequiredFieldValidator ID="rfvAmount" runat="server" ControlToValidate="txtAmount"
            ErrorMessage="Amount is required." CssClass="error-text" Display="Dynamic" />
        <asp:CompareValidator ID="cvAmount" runat="server" ControlToValidate="txtAmount"
            Operator="GreaterThanEqual" ValueToCompare="0" Type="Currency"
            ErrorMessage="Amount must be zero or more." CssClass="error-text" Display="Dynamic" />
    </div>

    <div class="form-field">
        <label for="txtDueDate">Due date</label>
        <asp:TextBox ID="txtDueDate" runat="server" TextMode="Date" />
        <asp:RequiredFieldValidator ID="rfvDueDate" runat="server" ControlToValidate="txtDueDate"
            ErrorMessage="Due date is required." CssClass="error-text" Display="Dynamic" />
    </div>

    <div class="form-field">
        <label for="ddlReminder">Remind before</label>
        <asp:DropDownList ID="ddlReminder" runat="server">
            <asp:ListItem Text="1 day" Value="1" />
            <asp:ListItem Text="2 days" Value="2" />
            <asp:ListItem Text="3 days" Value="3" Selected="True" />
        </asp:DropDownList>
    </div>

    <div class="form-field">
        <label for="ddlStatus">Status</label>
        <asp:DropDownList ID="ddlStatus" runat="server">
            <asp:ListItem Text="Pending" />
            <asp:ListItem Text="Paid" />
        </asp:DropDownList>
    </div>

    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn amber" OnClick="btnSave_Click" />
    <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn ghost" OnClick="btnReset_Click" CausesValidation="false" />
</asp:Content>
