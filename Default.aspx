<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <%--<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">--%>
  <title>学生信息管理系统</title>
  <link rel="stylesheet" href="layui/css/layui.css">
    <style>
        .layui-body{
            overflow-y:hidden;
            overflow-x:hidden;
        }
    </style>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <div class="layui-header">
    <div class="layui-logo"><h3>学生信息管理系统</h3></div>
    <!-- 头部区域（可配合layui已有的水平导航） -->
    <ul class="layui-nav layui-layout-left">
      <li class="layui-nav-item layui-this"><a href="Welcome.aspx" target="mainFrame">控制台</a></li>
    </ul>
    <ul class="layui-nav layui-layout-right">
      <li class="layui-nav-item">
        <a href="javascript:;">
          <%--<img src="<%=LoginUser==null?"#":LoginUser.imageUrl %>" class="layui-nav-img">--%>
          <%=LoginUser==null?"未登录":LoginUser.UserName %>
        </a>
        <dl class="layui-nav-child">
          <dd><a href="javascript:void(0)" id="xgmm" target="mainFrame">密码修改</a></dd>
          <dd><a href="Login.aspx">退出系统</a></dd>
        </dl>
      </li>
    </ul>
  </div>
  
  <div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
      <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
      <ul class="layui-nav layui-nav-tree"  lay-filter="test">
        <li class="layui-nav-item">
          <a class="" href="StudentInfo.aspx" target="mainFrame">学生管理</a>
        </li>
      </ul>
    </div>
  </div>
  
  <div class="layui-body">
    <!-- 内容主体区域 -->
    <iframe name="mainFrame" style="border:none;width:100%;height:100%;" src="Welcome.aspx"></iframe>
  </div>
  
  <div class="layui-footer">
    <!-- 底部固定区域 -->
    © 2020 - 学生信息管理系统
  </div>
</div>
<script type="text/html" id="changePwdForm">
    <form class="layui-form" action="" style="padding:10px;" lay-filter="changePwdForm">
        <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">新密码</label>
        <div class="layui-input-block">
                <input type="password" name="newPwd1" lay-verify="required" lay-reqtext="新密码是必填项，岂能为空？" autocomplete="off" placeholder="请输入新密码" class="layui-input">
        </div>
        </div>
        <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">重复新密码</label>
        <div class="layui-input-block">
                <input type="password" name="newPwd2" lay-reqtext="重复新密码是必填项，岂能为空？" autocomplete="off" placeholder="请输入重复新密码" class="layui-input">
        </div>
        </div>
            
        <div class="layui-form-item">
        <div class="layui-input-block">
            <button type="submit" class="layui-btn" lay-submit="" lay-filter="btnChangePwd" id="btnSave">修改密码</button>
        </div>
        </div>
    </form>
</script>
<script src="layui/layui.js"></script>
<script>
//JavaScript代码区域
    layui.use(['element', 'layer', 'form'], function () {
        var element = layui.element,
            $ = layui.$,
            form = layui.form,
            layer = layui.layer;


        $("#xgmm").click(function () {
            layer.open({
                type: 1,
                area: ['300px', '230px'],
                title: "修改密码",
                fixed: false, //不固定
                content: $("#changePwdForm").html(),
                success: function () {

                }
            });
        });
        form.on("submit(btnChangePwd)", function (data) {
            var formData = data.field;
            if (formData.newPwd1 !== formData.newPwd2) {
                layer.msg("两次密码输入不一致");
                return false;
            }
            formData.action = "changePwd";
            $.ajax({
                url: "/Default.aspx",
                data: formData,
                dataType: "json",
                type: "post",
                success: function (res) {
                    if (res.code === 0) { //成功
                        layer.closeAll();
                        layer.msg("修改成功");
                    } else {
                        layer.msg("修改失败\r\n错误原因：" + res.msg);
                    }
                },
                error: function (a, b, c) {
                    layer.msg("请求出错\r\n错误代码：" + a.status + ",错误原因：" + a.statusText)
                }
            });
            return false;
        });
    });
    
    function convertDateStr(d,f) {
        if (d > '') {
            return layui.util.toDateString(d, f)
        } else {
            return "";
        }
    }
</script>
</body>
</html>
