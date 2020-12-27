using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// WebPage 的摘要说明
/// </summary>
public class WebPage: System.Web.UI.Page
{
    protected SqlDbContext Sql = new SqlDbContext();
    protected UserInfo LoginUser { get; private set; }
    protected string RequestAction { get; private set; }
    public WebPage()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }

    protected override void OnPreLoad(EventArgs e)
    {
        LoadLoginUser();
        LoadRequestAction();
        base.OnPreLoad(e);
    }

    private void LoadRequestAction()
    {
        RequestAction = Request.QueryString["action"];
        if (string.IsNullOrEmpty(RequestAction))
        {
            RequestAction = Request.Form["action"];
        }
    }

    void LoadLoginUser()
    {
        if (Session["登录用户"] != null)
        {
            string name = Session["登录用户"].ToString();
            //获取登录用户信息
            if (!string.IsNullOrEmpty(name))
            {
                LoginUser = Sql.UserInfo.Find(name);
            }
        }
    }
    protected void ResponseJson(object obj)
    {
        string result = JsonConvert.SerializeObject(obj);
        Response.ContentType = "application/json";
        Response.Write(result);
        Response.End();
    }
}