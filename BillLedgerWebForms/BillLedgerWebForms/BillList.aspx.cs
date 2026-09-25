using System;
using System.Linq;
using System.Web.UI.WebControls;

public partial class BillList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null) return;

        if (!IsPostBack)
        {
            BindGrid();
        }
    }

    protected void Filter_Changed(object sender, EventArgs e)
    {
        BindGrid();
    }

    private void BindGrid()
    {
        string user = (string)Session["Username"];
        var bills = BillRepository.GetByOwner(user).AsEnumerable();

        string search = txtSearch.Text.Trim();
        if (!string.IsNullOrEmpty(search))
        {
            bills = bills.Where(b => b.Name.IndexOf(search, StringComparison.OrdinalIgnoreCase) >= 0);
        }
        if (!string.IsNullOrEmpty(ddlCategoryFilter.SelectedValue))
        {
            bills = bills.Where(b => b.Category == ddlCategoryFilter.SelectedValue);
        }
        if (!string.IsNullOrEmpty(ddlStatusFilter.SelectedValue))
        {
            bills = bills.Where(b => b.Status == ddlStatusFilter.SelectedValue);
        }

        gvBills.DataSource = bills.ToList();
        gvBills.DataBind();
    }

    protected void gvBills_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Guid id;
        if (!Guid.TryParse((string)e.CommandArgument, out id)) return;

        if (e.CommandName == "EditBill")
        {
            Response.Redirect("AddBill.aspx?id=" + id);
        }
        else if (e.CommandName == "DeleteBill")
        {
            var bill = BillRepository.GetById(id);
            if (bill != null && bill.Owner == (string)Session["Username"])
            {
                BillRepository.Delete(id);
            }
            BindGrid();
        }
    }

    protected void gvBills_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType != DataControlRowType.DataRow) return;

        var bill = (Bill)e.Row.DataItem;
        if (bill.IsOverdue() || bill.IsDueSoon())
        {
            e.Row.CssClass = "row-danger";
        }
    }
}
