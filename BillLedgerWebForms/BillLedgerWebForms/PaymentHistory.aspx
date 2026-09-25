<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PaymentHistory.aspx.cs" Inherits="PaymentHistory" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Payment History</h1>
    <p class="sub">Bills you've already marked as paid.</p>

    <div class="panel">
        <div class="panel-head">
            <h3>Total paid: <asp:Literal ID="litTotalPaid" runat="server" /></h3>
        </div>
        <asp:GridView ID="gvHistory" runat="server" CssClass="grid" AutoGenerateColumns="false" GridLines="None"
            DataKeyNames="Id" OnRowCommand="gvHistory_RowCommand" EmptyDataText="No paid bills yet.">
            <Columns>
                <asp:BoundField DataField="Name" HeaderText="Bill" />
                <asp:BoundField DataField="Category" HeaderText="Category" />
                <asp:BoundField DataField="Amount" HeaderText="Amount" DataFormatString="{0:C2}" />
                <asp:BoundField DataField="DueDate" HeaderText="Due Date" DataFormatString="{0:dd MMM yyyy}" />
                <asp:TemplateField HeaderText="">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnUnpay" runat="server" CommandName="MarkPending"
                            CommandArgument='<%# Eval("Id") %>' CssClass="btn ghost small">Mark as Pending</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
