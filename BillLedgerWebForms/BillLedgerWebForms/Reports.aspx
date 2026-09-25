<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Reports.aspx.cs" Inherits="Reports" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Reports</h1>
    <p class="sub">A simple summary of your bill activity.</p>

    <div class="cards">
        <div class="stat-card">
            <div><div class="lbl">Total amount paid</div><div class="num"><asp:Literal ID="litPaidTotal" runat="server" /></div></div>
            <div class="stat-icon blue"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="12" r="9"/><path d="M8 12l3 3 5-6"/></svg></div>
        </div>
        <div class="stat-card">
            <div><div class="lbl">Total pending amount</div><div class="num"><asp:Literal ID="litPendingTotal" runat="server" /></div></div>
            <div class="stat-icon amber"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="3" y="5" width="18" height="16" rx="2"/><path d="M3 10h18"/></svg></div>
        </div>
        <div class="stat-card">
            <div><div class="lbl">Total bills</div><div class="num"><asp:Literal ID="litTotalBills" runat="server" /></div></div>
            <div class="stat-icon green"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M6 3h9l4 4v14a1 1 0 01-1 1H6a1 1 0 01-1-1V4a1 1 0 011-1z"/></svg></div>
        </div>
    </div>

    <div class="panel">
        <div class="panel-head"><h3>By category (pending)</h3></div>
        <asp:GridView ID="gvByCategory" runat="server" CssClass="grid" AutoGenerateColumns="false" GridLines="None" EmptyDataText="No pending bills.">
            <Columns>
                <asp:BoundField DataField="Category" HeaderText="Category" />
                <asp:BoundField DataField="Count" HeaderText="Bills" />
                <asp:BoundField DataField="Total" HeaderText="Amount" DataFormatString="{0:C2}" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
