using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class StudentInfo : WebPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        switch (RequestAction)
        {
            case "queryStudentInfo":
                queryStudentInfo();
                break;
            case "addStudentInfo":
                addStudentInfo();
                break;
            case "editStudentInfo":
                editStudentInfo();
                break;
            case "delSelectedData":
                delSelectedData();
                break;
        }
    }

    private void delSelectedData()
    {
        string data = Request.Form["data"];
        var tmpArray = Newtonsoft.Json.JsonConvert.DeserializeObject<StudInfo[]>(data);
        
        foreach(var tmp in tmpArray)
        {
            Sql.Entry(tmp).State = System.Data.Entity.EntityState.Deleted;
        }
        Sql.SaveChanges();

        ResponseJson(new { code = 0, msg = "" });
    }

    /// <summary>
    /// 修改学生信息
    /// </summary>
    private void editStudentInfo()
    {
        string StudNo = Request.Form["StudNo"];
        StudInfo studInfo = Sql.StudInfo.Find(StudNo);
        if (studInfo == null)
        {
            ResponseJson(new { code = 1, msg = "学生信息不存在" });
        }

        studInfo.StudName = Request.Form["StudName"];
        studInfo.StudSex = Request.Form["StudSex"];
        studInfo.Email = Request.Form["Email"];

        Sql.Entry(studInfo).State = System.Data.Entity.EntityState.Modified;
        Sql.SaveChanges();
        ResponseJson(new { code = 0, msg = "" });

    }
    /// <summary>
    /// 新增学生信息
    /// </summary>
    private void addStudentInfo()
    {
        StudInfo studInfo = new StudInfo();
        studInfo.StudNo = Request.Form["StudNo"];
        studInfo.StudName = Request.Form["StudName"];
        studInfo.StudSex = Request.Form["StudSex"];
        studInfo.Email = Request.Form["Email"];

        Sql.StudInfo.Add(studInfo);
        Sql.SaveChanges();
        ResponseJson(new { code = 0, msg = "" });
    }

    /// <summary>
    /// 查询学生信息
    /// </summary>
    private void queryStudentInfo()
    {
        int page = Request.QueryString["page"].AsInt();
        int limit = Request.QueryString["limit"].AsInt();

        string studNo = Request.QueryString["studNo"].AsString();
        string studName = Request.QueryString["studName"].AsString();
        string studSex = Request.QueryString["studSex"].AsString();
        var query = Sql.StudInfo.AsQueryable();
        if (!string.IsNullOrEmpty(studNo))
        {
            query = query.Where(a => a.StudNo == studNo);
        }
        if (!string.IsNullOrEmpty(studName))
        {
            query = query.Where(a => a.StudName.Contains(studName));
        }
        if (!string.IsNullOrEmpty(studSex))
        {
            query = query.Where(a => a.StudSex == studSex);
        }
        int count = query.Count();
        var data = query.OrderBy(a=>a.StudNo).Skip((page - 1) * limit).Take(limit).ToList();

        ResponseJson(new { code = 0, data, count, msg = "" });

    }
}