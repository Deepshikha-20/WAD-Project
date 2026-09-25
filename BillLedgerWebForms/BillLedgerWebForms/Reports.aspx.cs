using System;
using System.Linq;

public partial class Reports : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null) return;

        string user = (string)Session["Username"];
        var bills = BillRepository.GetByOwner(user);

        decimal paidTotal = bills.Where(b => b.Status == "Paid").Sum(b => b.Amount);
        decimal pendingTotal = bills.Where(b => b.Status == "Pending").Sum(b => b.Amount);

        litPaidTotal.Text = paidTotal.ToString("C2");
        litPendingTotal.Text = pendingTotal.ToString("C2");
        litTotalBills.Text = bills.Count.ToString();

        var byCategory = bills.Where(b => b.Status == "Pending")
            .GroupBy(b => b.Category)
            .Select(g => new { Category = g.Key, Count = g.Count(), Total = g.Sum(b => b.Amount) })
            .OrderByDescending(g => g.Total)
            .ToList();

        gvByCategory.DataSource = byCategory;
        gvByCategory.DataBind();
    }
}
