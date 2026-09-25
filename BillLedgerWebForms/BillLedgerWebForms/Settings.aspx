<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Settings.aspx.cs" Inherits="Settings" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Settings</h1>
    <p class="sub">Preferences for how bills are managed.</p>

    <div class="panel" style="max-width:420px; margin-bottom:16px;">
        <h3 style="margin-top:0;font-size:14px;">Device notifications</h3>
        <p class="sub" style="margin-bottom:10px;">Get a real desktop/device notification when a bill is within its reminder window.</p>
        <p style="font-size:13px;margin-bottom:12px;">Status: <strong id="notifyStatus">checking...</strong></p>
        <button type="button" class="btn" id="btnEnableNotify" onclick="handleEnableClick()">Enable Notifications</button>
    </div>

    <div class="panel" style="max-width:420px; margin-bottom:16px;">
        <asp:Literal ID="litSaved" runat="server" Visible="false" Text="<p style='color:#16A34A;font-size:13px;'>Preference saved.</p>" />
        <div class="form-field">
            <label for="ddlDefaultReminder">Default reminder window for new bills</label>
            <asp:DropDownList ID="ddlDefaultReminder" runat="server">
                <asp:ListItem Text="1 day before" Value="1" />
                <asp:ListItem Text="2 days before" Value="2" />
                <asp:ListItem Text="3 days before" Value="3" />
            </asp:DropDownList>
        </div>
        <asp:Button ID="btnSave" runat="server" Text="Save preference" CssClass="btn" OnClick="btnSave_Click" />
    </div>

    <div class="panel" style="max-width:420px; border-color:#FCA5A5;">
        <h3 style="margin-top:0;color:#DC2626;font-size:14px;">Danger zone</h3>
        <p class="sub" style="margin-bottom:14px;">Permanently delete all your bills. This cannot be undone.</p>
        <asp:Literal ID="litCleared" runat="server" Visible="false" Text="<p style='color:#16A34A;font-size:13px;'>All bills cleared.</p>" />
        <asp:Button ID="btnClearAll" runat="server" Text="Clear all my bills" CssClass="btn danger"
            OnClientClick="return confirm('This will permanently delete all your bills. Continue?');"
            OnClick="btnClearAll_Click" />
    </div>

    <script type="text/javascript">
        function refreshNotifyStatus() {
            var el = document.getElementById('notifyStatus');
            var btn = document.getElementById('btnEnableNotify');
            if (!('Notification' in window)) {
                el.textContent = 'Not supported in this browser';
                btn.style.display = 'none';
                return;
            }
            if (Notification.permission === 'granted') {
                el.textContent = 'Enabled';
                btn.textContent = 'Notifications enabled \u2713';
            } else if (Notification.permission === 'denied') {
                el.textContent = 'Blocked (enable it in your browser\'s site settings)';
            } else {
                el.textContent = 'Not enabled yet';
            }
        }
        function handleEnableClick() {
            enableBillNotifications(function (result) {
                refreshNotifyStatus();
                if (result === 'granted') {
                    new Notification('BillRemind', { body: 'Notifications are on. We\'ll alert you as bills near their due date.' });
                }
            });
        }
        refreshNotifyStatus();
    </script>
</asp:Content>