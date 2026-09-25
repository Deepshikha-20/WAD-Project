<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Calendar.aspx.cs" Inherits="CalendarPage" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Calendar</h1>
    <p class="sub">Browse your bills by due date.</p>

    <div class="calendar-full">
        <div class="panel">
            <div class="cal-head">
                <button type="button" class="cal-nav-btn" onclick="__doPostBack('btnPrev','')">&lsaquo;</button>
                <span class="month"><asp:Literal ID="litMonthLabel" runat="server" /></span>
                <button type="button" class="cal-nav-btn" onclick="__doPostBack('btnNext','')">&rsaquo;</button>
            </div>
            <asp:LinkButton ID="btnPrev" runat="server" OnClick="btnPrev_Click" style="display:none;" />
            <asp:LinkButton ID="btnNext" runat="server" OnClick="btnNext_Click" style="display:none;" />
            <asp:LinkButton ID="btnToday" runat="server" OnClick="btnToday_Click" style="display:none;" />

            <div class="cal-grid full">
                <div class="dow">Sun</div><div class="dow">Mon</div><div class="dow">Tue</div><div class="dow">Wed</div><div class="dow">Thu</div><div class="dow">Fri</div><div class="dow">Sat</div>
                <asp:Repeater ID="rptCalendar" runat="server" OnItemCommand="rptCalendar_ItemCommand">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnDay" runat="server" CssClass='<%# GetCellClass(Container.DataItem) %>'
                            CommandName="SelectDay" CommandArgument='<%# GetCellArg(Container.DataItem) %>'
                            Enabled='<%# !((CalendarHelper.DayCell)Container.DataItem).IsBlank %>'
                            Text='<%# GetCellText(Container.DataItem) %>' />
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <div style="margin-top:12px;">
                <asp:LinkButton ID="lnkToday" runat="server" CssClass="btn ghost small" OnClick="btnToday_Click" Text="Jump to Today" />
            </div>
        </div>

        <div class="panel">
            <div class="panel-head"><h3><asp:Literal ID="litSelectedDate" runat="server" /></h3></div>
            <asp:Literal ID="litNoBills" runat="server" Visible="false" Text="<div class='empty-state'>No bills due on this day.</div>" />
            <asp:Repeater ID="rptDayBills" runat="server">
                <ItemTemplate>
                    <div class="reminder-item <%# (string)Eval("Status") == "Pending" && ((Bill)Container.DataItem).DaysUntilDue() < 0 ? "" : "soon" %>" style="border-left-color: <%# ((Bill)Container.DataItem).Status == "Paid" ? "#2563EB" : (((Bill)Container.DataItem).DaysUntilDue() < 0 ? "#DC2626" : "#D97706") %>;">
                        <div>
                            <strong><%# Eval("Name") %></strong><br />
                            <small><%# Eval("Category") %> &middot; <%# Eval("Status") %></small>
                        </div>
                        <div class="amt"><%# Eval("Amount", "{0:C0}") %></div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
