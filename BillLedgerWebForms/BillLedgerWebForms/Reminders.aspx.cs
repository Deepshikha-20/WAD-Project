using System;
using System.Linq;

public partial class Reminders : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null) return;

        string user = (string)Session["Username"];
        var bills = BillRepository.GetByOwner(user).Where(b => b.Status == "Pending").ToList();

        var dueToday = bills.Where(b => b.DaysUntilDue() == 0).ToList();
        var dueSoon = bills.Where(b => b.DaysUntilDue() > 0 && b.DaysUntilDue() <= 3).ToList();

        if (dueToday.Count == 0) { litNoDueToday.Visible = true; }
        else { rptDueToday.DataSource = dueToday; rptDueToday.DataBind(); }

        if (dueSoon.Count == 0) { litNoDueSoon.Visible = true; }
        else { rptDueSoon.DataSource = dueSoon; rptDueSoon.DataBind(); }
    }
}
