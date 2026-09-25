using System;
using System.Linq;

public partial class Settings : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null) return;

        if (!IsPostBack)
        {
            int def = (Session["DefaultReminderDays"] as int?) ?? 3;
            ddlDefaultReminder.SelectedValue = def.ToString();
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        Session["DefaultReminderDays"] = int.Parse(ddlDefaultReminder.SelectedValue);
        litSaved.Visible = true;
    }

    protected void btnClearAll_Click(object sender, EventArgs e)
    {
        string user = (string)Session["Username"];
        var mine = BillRepository.GetByOwner(user);
        foreach (var b in mine.ToList())
        {
            BillRepository.Delete(b.Id);
        }
        litCleared.Visible = true;
    }
}
