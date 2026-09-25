<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Dashboard" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Dashboard</h1>
    <p class="sub">A snapshot of where your bills stand today.</p>

    <div class="cards">
        <div class="stat-card">
            <div><div class="lbl">Total Bills</div><div class="num"><asp:Literal ID="litTotal" runat="server" /></div></div>
            <div class="stat-icon green"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M6 3h9l4 4v14a1 1 0 01-1 1H6a1 1 0 01-1-1V4a1 1 0 011-1z"/><path d="M9 11h6M9 15h6"/></svg></div>
        </div>
        <div class="stat-card">
            <div><div class="lbl">Upcoming Bills</div><div class="num"><asp:Literal ID="litUpcoming" runat="server" /></div></div>
            <div class="stat-icon amber"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="3" y="5" width="18" height="16" rx="2"/><path d="M3 10h18M8 3v4M16 3v4"/></svg></div>
        </div>
        <div class="stat-card">
            <div><div class="lbl">Overdue Bills</div><div class="num"><asp:Literal ID="litOverdue" runat="server" /></div></div>
            <div class="stat-icon red"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M12 9v4M12 17h.01"/><path d="M10.3 3.9L2.5 17a1.9 1.9 0 001.6 2.9h15.8a1.9 1.9 0 001.6-2.9L13.7 3.9a1.9 1.9 0 00-3.4 0z"/></svg></div>
        </div>
        <div class="stat-card">
            <div><div class="lbl">Paid Bills</div><div class="num"><asp:Literal ID="litPaid" runat="server" /></div></div>
            <div class="stat-icon blue"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="12" r="9"/><path d="M8 12l3 3 5-6"/></svg></div>
        </div>
        <div class="stat-card">
            <div><div class="lbl">Total Amount Due</div><div class="num"><asp:Literal ID="litAmountDue" runat="server" /></div></div>
            <div class="stat-icon green"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="12" r="9"/><path d="M9 9h5.5a1.5 1.5 0 010 3H10a1.5 1.5 0 000 3h5"/><path d="M12 7v2M12 15v2"/></svg></div>
        </div>
    </div>

    <div class="dash-grid">
        <div class="panel">
            <div class="panel-head">
                <h3>Upcoming Bills</h3>
                <a href="BillList.aspx">View All</a>
            </div>
            <asp:Literal ID="litEmpty" runat="server" Visible="false" Text="<div class='empty-state'>No upcoming bills. You're all caught up.</div>" />
            <asp:GridView ID="gvUpcoming" runat="server" CssClass="grid" AutoGenerateColumns="false" GridLines="None">
                <Columns>
                    <asp:BoundField DataField="Name" HeaderText="Bill Name" />
                    <asp:BoundField DataField="Category" HeaderText="Category" />
                    <asp:BoundField DataField="Amount" HeaderText="Amount" DataFormatString="{0:C0}" />
                    <asp:BoundField DataField="DueDate" HeaderText="Due Date" DataFormatString="{0:dd MMM yyyy}" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class='<%# GetPillClass((Bill)Container.DataItem) %>'><%# GetPillText((Bill)Container.DataItem) %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <a href='AddBill.aspx?id=<%# Eval("Id") %>' class="btn ghost small">Edit</a>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <div class="panel">
            <div class="panel-head">
                <h3>Calendar</h3>
            </div>
            <div class="cal-head">
                <span class="month"><asp:Literal ID="litMonthLabel" runat="server" /></span>
            </div>
            <div class="cal-grid">
                <div class="dow">Su</div><div class="dow">Mo</div><div class="dow">Tu</div><div class="dow">We</div><div class="dow">Th</div><div class="dow">Fr</div><div class="dow">Sa</div>
                <asp:Repeater ID="rptCalendar" runat="server">
                    <ItemTemplate>
                        <asp:Literal ID="litCell" runat="server" />
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <div style="margin-top:10px;"><a href="Calendar.aspx" style="font-size:12.5px;color:var(--green-dark);font-weight:600;text-decoration:none;">Open full calendar &rarr;</a></div>
        </div>

        <div class="panel">
            <div class="panel-head"><h3>Quick Actions</h3></div>
            <a class="qa-btn primary" href="AddBill.aspx">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 8v8M8 12h8"/></svg>
                Add New Bill
            </a>
            <a class="qa-btn secondary" href="BillList.aspx">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M6 3h9l4 4v14a1 1 0 01-1 1H6a1 1 0 01-1-1V4a1 1 0 011-1z"/></svg>
                View All Bills
            </a>
            <a class="qa-btn tertiary" href="PaymentHistory.aspx">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3.5 2"/></svg>
                Payment History
            </a>
        </div>
    </div>
</asp:Content>
