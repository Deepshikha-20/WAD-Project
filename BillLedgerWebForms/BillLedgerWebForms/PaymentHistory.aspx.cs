using System;
using System.Linq;
using System.Web.UI.WebControls;

public partial class PaymentHistory : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null) return;
        if (!IsPostBack) BindGrid();
    }

    private void BindGrid()
    {
        string user = (string)Session["Username"];
        var paid = BillRepository.GetByOwner(user).Where(b => b.Status == "Paid").OrderByDescending(b => b.DueDate).ToList();
        litTotalPaid.Text = paid.Sum(b => b.Amount).ToString("C2");
        gvHistory.DataSource = paid;
        gvHistory.DataBind();
    }

    protected void gvHistory_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName != "MarkPending") return;
        Guid id;
        if (!Guid.TryParse((string)e.CommandArgument, out id)) return;

        var bill = BillRepository.GetById(id);
        if (bill != null && bill.Owner == (string)Session["Username"])
        {
            bill.Status = "Pending";
            BillRepository.Update(bill);
        }
        BindGrid();
    }
}
