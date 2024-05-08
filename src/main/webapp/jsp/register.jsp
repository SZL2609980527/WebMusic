<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>注册页面</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/layui/2.8.17/css/layui.css" rel="stylesheet"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/layui/2.8.17/layui.js"></script>
    <script type="text/javascript" src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
    <style>
        body {
            background-image: url("/img/login.png");
            background-repeat: no-repeat;
            background-size: cover;
        }
        .demo-reg-container {
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
    <div class="demo-reg-container">
        <h2 style=" text-align: center;">注册账户</h2>
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
            <div class="layui-inline">
                <label class="layui-form-pane layui-form-label" style="text-align: center; background-color: white">密保问题</label>
                <div class="layui-input-block">
                    <select name="question" lay-filter="mibao">
                        <option value="你最喜欢的一首歌是什么？">你最喜欢的一首歌是什么？</option>
                        <option value="你最喜欢的作家是谁？" selected>你最喜欢的作家是谁？</option>
                        <option value="你最喜欢的一部电影是什么？">你最喜欢的一部电影是什么？</option>
                        <option value="你最想去哪旅游？">你最想去哪旅游？</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-wrap">
                <div class="layui-input-prefix">
                    <i class="layui-icon layui-icon-key"></i>
                </div>
                <input type="text" name="answer" value="" lay-verify="required" placeholder="密保问题答案" autocomplete="off" class="layui-input"  lay-affix="eye">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-wrap">
                <div class="layui-input-prefix">
                    <i class="layui-icon layui-icon-username"></i>
                </div>
                <input type="text" name="username" value="" lay-verify="required" placeholder="账号（唯一）" autocomplete="off" class="layui-input" lay-affix="clear">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-wrap">
                <div class="layui-input-prefix">
                    <i class="layui-icon layui-icon-password"></i>
                </div>
                <input type="password" name="password" value="" lay-verify="required" placeholder="密码" autocomplete="off" class="layui-input" id="reg-password" lay-affix="eye">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-wrap">
                <div class="layui-input-prefix">
                    <i class="layui-icon layui-icon-password"></i>
                </div>
                <input type="password" name="confirmPassword" value="" lay-verify="required|confirmPassword" placeholder="确认密码" autocomplete="off" class="layui-input" lay-affix="eye">
            </div>
        </div>

        <div class="layui-form-item">
            <input type="checkbox" name="agreement" lay-verify="required" lay-skin="primary" title="同意">
            <a href="#terms" target="_blank" style="position: relative; top: 6px; left: -15px;">
                <ins>用户协议</ins>
            </a>
        </div>
        <div class="layui-form-item">
            <button class="layui-btn layui-btn-fluid" lay-submit lay-filter="demo-reg">注册</button>
        </div>
        <div class="layui-form-item demo-reg-other">
            <a href="<c:url value="/index.jsp"/>" style="float: right; margin-top: 7px;">登录已有帐号</a>
        </div>
    </div>
</form>


<script>
    layui.use(function(){
        var $ = layui.$;
        var form = layui.form;
        var layer = layui.layer;
        var util = layui.util;

        // 自定义验证规则
        form.verify({
            // 确认密码
            confirmPassword: function(value, item){
                var passwordValue = $('#reg-password').val();
                if(value !== passwordValue){
                    return '两次密码输入不一致';
                }
            }
        });

        // 提交事件
        form.on('submit(demo-reg)', function(data){
            var field = data.field; // 获取表单字段值

            var requestData = {
                username: field.username,
                password: field.password,
                question: field.question,
                answer: field.answer,
                phone:field.phone,
            };
            // 是否勾选同意
            if(!field.agreement){
                layer.msg('您必须勾选同意用户协议才能注册');
                return false;
            }
            $.ajax({
                type: "POST",
                url: "/getOneByPhone",
                data: field,
                dataType:"TEXT",  //返回类型 字符串
                success: function(response) {
                    switch (response) {
                        // 处理后端返回的数据
                        case "SUCCESS": layer.msg("已有账号");
                            window.location="main.jsp";break;
                        case "NO": reg();break;
                        default: layer.msg("验证码错误!!!", {icon: 5});
                    }
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    // 处理请求失败的情况
                    layer.msg("请求失败：" + textStatus, {icon: 5});
                }
            });
            function reg() {
                $.ajax({
                    type: "POST",
                    url: "/insertUser",
                    data: JSON.stringify(requestData),
                    contentType: "application/json",
                    dataType:"TEXT",//返回类型 字符串
                    success: function(response) {
                        // 处理后端返回的数据
                        if (response === "SUCCESS") {
                            layer.msg("创建成功");
                            window.location = "/index.jsp"
                        }else
                            layer.msg("用户名或密码错误！", {icon: 5});
                    },
                    error: function(XMLHttpRequest, textStatus, errorThrown) {
                        // 处理请求失败的情况
                        layer.msg("请求失败：" + textStatus, {icon: 5});
                    }
                });
            }


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
