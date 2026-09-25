using System;
using System.Linq;
using System.Text;

public partial class Dashboard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string user = (string)Session["Username"];
        if (user == null) return; // master page already redirects

        var bills = BillRepository.GetByOwner(user);

        litTotal.Text = bills.Count.ToString();
        litUpcoming.Text = bills.Count(b => b.Status == "Pending" && b.DaysUntilDue() >= 0).ToString();
        litOverdue.Text = bills.Count(b => b.Status == "Pending" && b.DaysUntilDue() < 0).ToString();
        litPaid.Text = bills.Count(b => b.Status == "Paid").ToString();
        litAmountDue.Text = bills.Where(b => b.Status == "Pending").Sum(b => b.Amount).ToString("C0");

        var upcoming = bills.Where(b => b.Status == "Pending")
                             .OrderBy(b => b.DueDate)
                             .Take(5)
                             .ToList();

        if (upcoming.Count == 0)
        {
            litEmpty.Visible = true;
            gvUpcoming.Visible = false;
        }
        else
        {
            gvUpcoming.DataSource = upcoming;
            gvUpcoming.DataBind();
        }

        BindMiniCalendar(bills);
    }

    private void BindMiniCalendar(System.Collections.Generic.List<Bill> bills)
    {
        var today = DateTime.Today;
        litMonthLabel.Text = today.ToString("MMMM yyyy");
        var cells = CalendarHelper.BuildMonthGrid(today.Year, today.Month, bills);

        rptCalendar.DataSource = cells;
        rptCalendar.DataBind();

        for (int i = 0; i < cells.Count; i++)
        {
            var cell = cells[i];
            var lit = (System.Web.UI.WebControls.Literal)rptCalendar.Items[i].FindControl("litCell");
            if (cell.IsBlank)
            {
                lit.Text = "<div class='cal-cell blank'>&nbsp;</div>";
            }
            else
            {
                var cls = new StringBuilder("cal-cell");
                if (cell.IsToday) cls.Append(" today");
                if (cell.BillCount > 0) cls.Append(" has-bill");
                lit.Text = "<div class='" + cls + "' title='" + cell.BillCount + " bill(s) due'>" + cell.Day + "</div>";
            }
        }
    }

    protected string GetPillClass(Bill b)
    {
        var d = b.DaysUntilDue();
        if (d < 0) return "pill overdue";
        if (d <= b.ReminderDays) return "pill soon";
        return "pill upcoming";
    }

    protected string GetPillText(Bill b)
    {
        var d = b.DaysUntilDue();
        if (d < 0) return "Overdue";
        if (d <= b.ReminderDays) return "Due Soon";
        return "Upcoming";
    }
}
