using System;
using System.IO;
using System.Linq;
using System.Web.UI.HtmlControls;

public partial class SiteMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null)
        {
            Response.Redirect("Login.aspx");
            return;
        }

        string username = (string)Session["Username"];
        string displayName = Session["DisplayName"] as string;
        if (string.IsNullOrWhiteSpace(displayName)) displayName = username;

        litUserName.Text = Server.HtmlEncode(displayName);
        litAvatar.Text = displayName.Length > 0 ? displayName.Substring(0, 1).ToUpperInvariant() : "?";

        var bills = BillRepository.GetByOwner(username);
        var alertBills = bills.Where(b => b.Status == "Pending" && b.DaysUntilDue() <= b.ReminderDays).ToList();

        if (alertBills.Count > 0)
        {
            litBellBadge.Text = "<span class='bell-badge'>" + (alertBills.Count > 9 ? "9+" : alertBills.Count.ToString()) + "</span>";
        }

        litNotifyData.Text = BuildAlertsJson(alertBills, username);

        string page = Path.GetFileName(Request.Path);
        HighlightIfCurrent(navDashboard, "Dashboard.aspx", page);
        HighlightIfCurrent(navBills, "BillList.aspx", page);
        HighlightIfCurrent(navAdd, "AddBill.aspx", page);
        HighlightIfCurrent(navCalendar, "Calendar.aspx", page);
        HighlightIfCurrent(navHistory, "PaymentHistory.aspx", page);
        HighlightIfCurrent(navReports, "Reports.aspx", page);
        HighlightIfCurrent(navProfile, "Profile.aspx", page);
        HighlightIfCurrent(navSettings, "Settings.aspx", page);
    }

    private string BuildAlertsJson(System.Collections.Generic.List<Bill> alertBills, string username)
    {
        var sb = new System.Text.StringBuilder();
        sb.Append("[");
        for (int i = 0; i < alertBills.Count; i++)
        {
            var b = alertBills[i];
            bool overdue = b.DaysUntilDue() < 0;
            string body = overdue
                ? (Math.Abs(b.DaysUntilDue()) + " day(s) overdue \u2014 " + b.Amount.ToString("C0"))
                : (b.DaysUntilDue() == 0 ? "Due today \u2014 " + b.Amount.ToString("C0") : "Due in " + b.DaysUntilDue() + " day(s) \u2014 " + b.Amount.ToString("C0"));

            sb.Append("{");
            sb.Append("\"id\":\"" + JsonEscape(username + "-" + b.Id) + "\",");
            sb.Append("\"title\":\"" + JsonEscape(b.Name + " (" + b.Category + ")") + "\",");
            sb.Append("\"body\":\"" + JsonEscape(body) + "\"");
            sb.Append("}");
            if (i < alertBills.Count - 1) sb.Append(",");
        }
        sb.Append("]");
        return sb.ToString();
    }

    private string JsonEscape(string s)
    {
        return s.Replace("\\", "\\\\").Replace("\"", "\\\"");
    }

    private void HighlightIfCurrent(HtmlAnchor anchor, string target, string current)
    {
        if (string.Equals(target, current, StringComparison.OrdinalIgnoreCase))
        {
            anchor.Attributes["class"] = "navitem active";
        }
        else
        {
            anchor.Attributes["class"] = "navitem";
        }
    }
}