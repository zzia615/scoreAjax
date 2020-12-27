<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Welcome.aspx.cs" Inherits="Welcome" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>欢迎登录本系统</title>
  <link rel="stylesheet" href="layui/css/layui.css">
</head>
<body style="padding:10px;">
<blockquote class="layui-elem-quote">欢迎【<i style="color:green;font-size:14pt;"><%=LoginUser==null?"未登录":LoginUser.UserName %></i>】登录本系统</blockquote>
<blockquote class="layui-elem-quote" id="nowTime">现在时间：<%=DateTime.Now.ToString("yyyy年MM月dd日HH:mm:ss") %></blockquote>

<script src="layui/layui.js"></script>
<script>
//JavaScript代码区域
    layui.use(['element'], function () {
        var element = layui.element,
            $ = layui.$;
        getCurrentTime();
        function getCurrentTime() {
            setTimeout(function () {
                var tt = new Date().Format("yyyy年MM月dd日hh:mm:ss");
                $("#nowTime").html("现在时间："+tt);
                getCurrentTime();
            }, 1000);
        }
    });


    Date.prototype.Format = function (fmt) { // author: meizz
        var o = {
            "M+": this.getMonth() + 1, // 月份
            "d+": this.getDate(), // 日
            "h+": this.getHours(), // 小时
            "m+": this.getMinutes(), // 分
            "s+": this.getSeconds(), // 秒
            "q+": Math.floor((this.getMonth() + 3) / 3), // 季度
            "S": this.getMilliseconds() // 毫秒
        };
        if (/(y+)/.test(fmt))
            fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    }
</script>
</body>
</html>
