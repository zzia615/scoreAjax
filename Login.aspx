<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>用户登录 - 学生信息管理系统</title>
    <link href="layui/css/layui.css" rel="stylesheet" />
    <style>
        body{
            background:url(/img/bg-login.jpg);
            background-repeat:no-repeat;
            background-size:100% 100% cover;
            background-position:center;
        }
        .layui-card{
            width:400px;
            height:220px;
            margin:100px auto;
        }
        .layui-card-header{
            padding:0px;
        }
        .layui-card-body{
            padding:20px;
        }
    </style>
</head>
<body>
    <div class="layui-card">
        <div class="layui-card-header">
            <blockquote class="layui-elem-quote" style="margin:0;background:#009688;color:#fff">用户登录 - 学生信息管理系统</blockquote>
        </div>
        <div class="layui-card-body">
            <form id="form1" class="layui-form">
                <div class="layui-form-item">
                    <label class="layui-form-label">用户名<i class="layui-icon layui-icon-username"></i></label>
                    <div class="layui-input-block">
                        <input type="text" name="name" lay-verify="required" lay-reqtext="用户名是必填项，岂能为空？" autocomplete="off" placeholder="请输入用户名" class="layui-input" />
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">密码<i class="layui-icon layui-icon-password"></i></label>
                    <div class="layui-input-block">
                        <input type="password" name="password" lay-verify="required" lay-reqtext="密码是必填项，岂能为空？" autocomplete="off" placeholder="请输入密码" class="layui-input" />
                    </div>
                </div>
            
            
                <div class="layui-form-item">
                    <div class="layui-input-block">            
                        <button type="submit" class="layui-btn" lay-submit="" lay-filter="btnSave">登录</button>
                        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <script src="layui/layui.js"></script>
    <script>
        layui.use(["element", "form", "layer"], function () {
            var element = layui.element,
                form = layui.form,
                layer = layui.layer,
                $ = layui.$;
            form.on("submit(btnSave)", function (data) {
                var formData = data.field;
                var index = layer.load(0, {
                    shade: [0.1, '#fff'] //0.1透明度的白色背景
                });
                formData.action = "loginSys";
                $.ajax({
                    url: "/Login.aspx",
                    data: formData,
                    dataType: "json",
                    type: "post",
                    success: function (res) {
                        layer.close(index);
                        if (res.code === 0) { //成功
                            layer.msg("登录成功");
                            window.location.href = "/Default.aspx";
                        } else {
                            layer.msg("登录失败\r\n错误原因：" + res.msg);
                        }
                    },
                    error: function (a, b, c) {
                        layer.close(index);
                        layer.msg("请求出错\r\n错误代码：" + a.status + ",错误原因：" + a.statusText)
                    }
                });

                return false;
            });
        });
    </script>
</body>
</html>