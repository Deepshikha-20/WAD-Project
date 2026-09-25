using System;
using System.Globalization;

public partial class AddBill : System.Web.UI.Page
{
    private Guid? EditId
    {
        get
        {
            Guid g;
            if (Guid.TryParse(Request.QueryString["id"], out g)) return g;
            return null;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null) return;

        if (!IsPostBack)
        {
            if (EditId.HasValue)
            {
                var bill = BillRepository.GetById(EditId.Value);
                if (bill != null)
                {
                    litTitle.Text = "Edit Bill";
                    txtName.Text = bill.Name;
                    ddlCategory.SelectedValue = bill.Category;
                    txtAmount.Text = bill.Amount.ToString(CultureInfo.InvariantCulture);
                    txtDueDate.Text = bill.DueDate.ToString("yyyy-MM-dd");
                    ddlReminder.SelectedValue = bill.ReminderDays.ToString();
                    ddlStatus.SelectedValue = bill.Status;
                }
            }
            else
            {
                int def = (Session["DefaultReminderDays"] as int?) ?? 3;
                ddlReminder.SelectedValue = def.ToString();
            }
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid) return;

        string user = (string)Session["Username"];

        decimal amount;
        DateTime dueDate;
        if (!decimal.TryParse(txtAmount.Text, NumberStyles.Any, CultureInfo.InvariantCulture, out amount) ||
            !DateTime.TryParse(txtDueDate.Text, CultureInfo.InvariantCulture, DateTimeStyles.None, out dueDate))
        {
            litError.Text = "<p class='error-text'>Please check the amount and due date values.</p>";
            litError.Visible = true;
            return;
        }

        var bill = new Bill
        {
            Owner = user,
            Name = txtName.Text.Trim(),
            Category = ddlCategory.SelectedValue,
            Amount = amount,
            DueDate = dueDate,
            ReminderDays = int.Parse(ddlReminder.SelectedValue),
            Status = ddlStatus.SelectedValue
        };

        if (EditId.HasValue)
        {
            bill.Id = EditId.Value;
            BillRepository.Update(bill);
        }
        else
        {
            BillRepository.Add(bill);
        }

        Response.Redirect("BillList.aspx");
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        Response.Redirect(EditId.HasValue ? "AddBill.aspx?id=" + EditId.Value : "AddBill.aspx");
    }
}
