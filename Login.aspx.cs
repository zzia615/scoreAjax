using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
public partial class Login : WebPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        switch (RequestAction)
        {
            case "loginSys":
                loginSys();
                break;
        }
    }


    void loginSys()
    {
        string name = Request.Form["name"];
        string password = Request.Form["password"];

        if (!string.IsNullOrEmpty(name) && !string.IsNullOrEmpty(password))
        {
            var user = Sql.UserInfo.Find(name);
            if (user == null)
            {
                ResponseJson(new { code = 1, msg = "用户信息不存在" });
            }

            if (user.Password != password)
            {
                ResponseJson(new { code = 1, msg = "用户密码输入有误" });
            }

            Session["登录用户"] = user.UserID;
            ResponseJson(new { code = 0, msg = "" });
        }
    }
}