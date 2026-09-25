using System;

public partial class ProfilePage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null) return;

        if (!IsPostBack)
        {
            txtUsernameVal.Text = (string)Session["Username"];
            txtDisplayName.Text = (Session["DisplayName"] as string) ?? (string)Session["Username"];
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        var name = txtDisplayName.Text.Trim();
        Session["DisplayName"] = string.IsNullOrEmpty(name) ? (string)Session["Username"] : name;
        litSaved.Visible = true;
    }
}
