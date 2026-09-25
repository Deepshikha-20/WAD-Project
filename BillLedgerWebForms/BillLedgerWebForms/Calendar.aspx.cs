using System;
using System.Collections.Generic;
using System.Linq;

public partial class CalendarPage : System.Web.UI.Page
{
    private int Year
    {
        get { return (int)(ViewState["CalYear"] ?? DateTime.Today.Year); }
        set { ViewState["CalYear"] = value; }
    }

    private int Month
    {
        get { return (int)(ViewState["CalMonth"] ?? DateTime.Today.Month); }
        set { ViewState["CalMonth"] = value; }
    }

    private DateTime SelectedDate
    {
        get { return (DateTime)(ViewState["CalSelected"] ?? DateTime.Today); }
        set { ViewState["CalSelected"] = value; }
    }

    private List<Bill> Bills
    {
        get { return BillRepository.GetByOwner((string)Session["Username"]); }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null) return;

        if (!IsPostBack)
        {
            Year = DateTime.Today.Year;
            Month = DateTime.Today.Month;
            SelectedDate = DateTime.Today;
        }

        BindCalendar();
        BindDayList();
    }

    private void BindCalendar()
    {
        litMonthLabel.Text = new DateTime(Year, Month, 1).ToString("MMMM yyyy");
        var cells = CalendarHelper.BuildMonthGrid(Year, Month, Bills);
        rptCalendar.DataSource = cells;
        rptCalendar.DataBind();
    }

    private void BindDayList()
    {
        litSelectedDate.Text = SelectedDate.ToString("dddd, dd MMMM yyyy");
        var dayBills = Bills.Where(b => b.DueDate.Date == SelectedDate.Date)
                             .OrderBy(b => b.Name)
                             .ToList();
        if (dayBills.Count == 0)
        {
            litNoBills.Visible = true;
            rptDayBills.Visible = false;
        }
        else
        {
            litNoBills.Visible = false;
            rptDayBills.Visible = true;
            rptDayBills.DataSource = dayBills;
            rptDayBills.DataBind();
        }
    }

    protected void btnPrev_Click(object sender, EventArgs e)
    {
        var d = new DateTime(Year, Month, 1).AddMonths(-1);
        Year = d.Year; Month = d.Month;
        BindCalendar();
        BindDayList();
    }

    protected void btnNext_Click(object sender, EventArgs e)
    {
        var d = new DateTime(Year, Month, 1).AddMonths(1);
        Year = d.Year; Month = d.Month;
        BindCalendar();
        BindDayList();
    }

    protected void btnToday_Click(object sender, EventArgs e)
    {
        Year = DateTime.Today.Year;
        Month = DateTime.Today.Month;
        SelectedDate = DateTime.Today;
        BindCalendar();
        BindDayList();
    }

    protected void rptCalendar_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "SelectDay")
        {
            DateTime picked;
            if (DateTime.TryParse((string)e.CommandArgument, out picked))
            {
                SelectedDate = picked;
                BindCalendar();
                BindDayList();
            }
        }
    }

    protected string GetCellClass(object dataItem)
    {
        var cell = (CalendarHelper.DayCell)dataItem;
        if (cell.IsBlank) return "cal-cell blank";
        var cls = "cal-cell";
        if (cell.IsToday) cls += " today";
        if (cell.BillCount > 0) cls += " has-bill";
        if (cell.Date.Date == SelectedDate.Date) cls += " selected";
        return cls;
    }

    protected string GetCellText(object dataItem)
    {
        var cell = (CalendarHelper.DayCell)dataItem;
        return cell.IsBlank ? "" : cell.Day.ToString();
    }

    protected string GetCellArg(object dataItem)
    {
        var cell = (CalendarHelper.DayCell)dataItem;
        return cell.IsBlank ? "" : cell.Date.ToString("yyyy-MM-dd");
    }
}
