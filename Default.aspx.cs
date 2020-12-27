using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : WebPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        switch (RequestAction)
        {
            case "changePwd":
                changePwd();
                break;
        }
    }
    /// <summary>
    /// 修改密码
    /// </summary>
    private void changePwd()
    {
        string newPwd1 = Request.Form["newPwd1"];
        LoginUser.Password = newPwd1;
        Sql.Entry(LoginUser).State = System.Data.Entity.EntityState.Modified;
        Sql.SaveChanges();
        ResponseJson(new
        {
            code = 0,
            msg = ""
        });
    }
}