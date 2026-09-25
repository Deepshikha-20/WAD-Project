using System;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack && Session["Username"] != null)
        {
            Response.Redirect("Dashboard.aspx");
        }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid) return;

        Session["Username"] = txtUsername.Text.Trim().ToLowerInvariant();
        Response.Redirect("Dashboard.aspx");
    }
}
