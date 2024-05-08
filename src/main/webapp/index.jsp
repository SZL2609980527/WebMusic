<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>用户登录</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/layui/2.8.17/css/layui.css" rel="stylesheet"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/layui/2.8.17/layui.js"></script>
    <script type="text/javascript" src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
    <style>
        body {
            background-image: url("img/login.png");
            background-repeat: no-repeat;
            background-size: cover;
        }
        .demo-login-container {
            background-color: rgba(241, 241, 241, 0.5);
            padding: 20px;
            border-radius: 5px;
            width: 320px;
            margin: 21px auto 0;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }
    </style>
</head>
<body>
<form class="layui-form">
    <div class="demo-login-container">
        <h2 style=" text-align: center;">用户登录</h2>
        <br />
        <div class="layui-form-item">
            <div class="layui-input-wrap">
                <div class="layui-input-prefix">
                    <i class="layui-icon layui-icon-username"></i>
                </div>
                <input type="text" name="username" value="" lay-verify="required" placeholder="账号" lay-reqtext="请填写用户名" autocomplete="off" class="layui-input" lay-affix="clear">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-wrap">
                <div class="layui-input-prefix">
                    <i class="layui-icon layui-icon-password"></i>
                </div>
                <input type="password" name="password" value="" lay-verify="required" placeholder="密   码" lay-reqtext="请填写密码" autocomplete="off" class="layui-input" lay-affix="eye">
            </div>
        </div>
        <div class="layui-form-item">
            <input type="checkbox" name="remember" lay-skin="primary" title="记住密码">
            <a href="jsp/forget.jsp" style="float: right; margin-top: 7px;">忘记密码？</a>
        </div>
        <div class="layui-form-item">
            <button class="layui-btn layui-btn-fluid" lay-submit lay-filter="demo-login">登录</button>
        </div>
        <div class="layui-form-item">
            <a href="jsp/PhoneLogin.jsp" style="float: right; margin-top: 7px;">使用手机号登录</a>
            <a href="jsp/register.jsp" style="float: left; margin-top: 7px;">注册帐号</a>
        </div>
    </div>
</form>

<script>
    layui.use(function(){
        var form = layui.form;
        var layer = layui.layer;
        // 提交事件
        form.on('submit(demo-login)', function(data){
            var field = data.field; // 获取表单字段值
            $.ajax({
                type: "POST",
                url: "/getOne",
                data: JSON.stringify(field),
                contentType: "application/json",
                dataType:"TEXT",//返回类型 字符串
                success: function(response) {
                    switch (response) {
                        // 处理后端返回的数据
                        case "SUCCESS": window.location="jsp/main.jsp";break;
                        case "admin": window.location="jsp/manage.jsp";break;
                        default: layer.msg("用户名或密码错误！", {icon: 5});
                    }
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    // 处理请求失败的情况
                    layer.msg("请求失败：" + textStatus, {icon: 5});
                }
            });
            return false; // 阻止表单提交，因为我们已经处理了登录逻辑
        });
    });
</script>
</body>
</html>