<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>忘记密码</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/layui/2.8.17/css/layui.css" rel="stylesheet"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/layui/2.8.17/layui.js"></script>
    <script type="text/javascript" src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
    <style>
        body {
            background-image: url("/img/login.png");
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
        <h2 style=" text-align: center;">修改密码</h2>
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
                    <i class="layui-icon layui-icon-password"></i>
                </div>
                <input type="password" name="password" value="" lay-verify="required" placeholder="输入新密码" autocomplete="off" class="layui-input" id="reg-password" lay-affix="eye">
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
            <button class="layui-btn layui-btn-fluid" lay-submit lay-filter="demo-login">确认</button>
        </div>
    </div>
</form>

<script>
    layui.use(function(){
        var form = layui.form;
        var layer = layui.layer;

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
        form.on('submit(demo-login)', function(data){
            var field = data.field; // 获取表单字段值

            var requestData = {
                username: field.username,
                password: field.password,
                question: field.question,
                answer: field.answer,
            };

            $.ajax({
                type: "POST",
                url: "/password",
                data: JSON.stringify(field),
                contentType: "application/json",
                dataType:"TEXT",//返回类型 字符串
                success: function(response) {
                    // 处理后端返回的数据
                    if (response === "SUCCESS")
                        window.location="/index.jsp"
                    else
                        layer.msg("账号或密保问题有误，请重试！", {icon: 5});
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