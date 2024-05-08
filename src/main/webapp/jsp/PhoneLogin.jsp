<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>用户手机号登录</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/layui/2.8.17/css/layui.css" rel="stylesheet"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/layui/2.8.17/layui.js"></script>
    <script type="text/javascript" src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
    <style>
        body {
            background-image: url("../img/login.png");
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
<form class="layui-form" action="/getOneByPhone" method="post">
    <div class="demo-login-container">
        <h2 style=" text-align: center;">手机号登录</h2>
        <br />
        <div class="layui-form-item">
            <div class="layui-row">
                <div class="layui-col-xs7">
                    <div class="layui-input-wrap">
                        <div class="layui-input-prefix">
                            <i class="layui-icon layui-icon-cellphone"></i>
                        </div>
                        <input type="text" name="phone" value="" lay-verify="required|phone" placeholder="手机号" lay-reqtext="请填写手机号" autocomplete="off" class="layui-input" id="reg-cellphone">
                    </div>
                </div>
                <div class="layui-col-xs5">
                    <div style="margin-left: 11px;">
                        <button type="button" class="layui-btn layui-btn-fluid layui-btn-primary" lay-on="reg-get-vercode">获取验证码</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-wrap">
                <div class="layui-input-prefix">
                    <i class="layui-icon layui-icon-vercode"></i>
                </div>
                <input type="text" name="code" value="" lay-verify="required" placeholder="验证码" lay-reqtext="请填写验证码" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <button class="layui-btn layui-btn-fluid" lay-submit lay-filter="demo-login">登录</button>
        </div>
        <div class="layui-form-item">
            <a href="register.jsp" style="float: left; margin-top: 7px;">注册帐号</a>
        </div>
    </div>
</form>

<script>
    layui.use(function(){
        var $ = layui.$;
        var form = layui.form;
        var layer = layui.layer;
        var util = layui.util;

        // 提交事件
        form.on('submit(demo-login)', function(data){
            var field = data.field; // 获取表单字段值

            $.ajax({
                type: "POST",
                url: "/getOneByPhone",
                data: field,
                dataType:"TEXT",  //返回类型 字符串
                success: function(response) {
                    switch (response) {
                        // 处理后端返回的数据
                        case "SUCCESS": window.location="main.jsp";break;
                        case "NO": layer.msg("你还没有注册!!!");break;
                        default: layer.msg("验证码错误!!!", {icon: 5});
                    }
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    // 处理请求失败的情况
                    layer.msg("请求失败：" + textStatus, {icon: 5});
                }
            });
            return false; // 阻止默认 form 跳转
        });

        // 普通事件
        util.on('lay-on', {
            // 获取验证码
            'reg-get-vercode': function(othis){
                var isvalid = form.validate('#reg-cellphone');
                var phone = $('#reg-cellphone').val(); // 获取手机号
                // 验证通过
                if(isvalid){
                    layer.msg("验证码已发送，请查收短信");
                    // 发送请求到后端
                    $.ajax({
                        url: '/sendSms/'+phone,
                        type: 'GET',
                        success: function(res){
                            if(res === "SUCCESS") {
                                layer.msg('验证码已发送，请查收短信');
                            } else {
                                layer.msg("发送失败");
                            }
                        },
                        // error: function(){
                        //     layer.msg('发送验证码失败，请重试');
                        // }
                    });
                }
            }
        });
    });
</script>
</body>
</html>