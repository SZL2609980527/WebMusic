<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>个人信息</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/layui/2.8.17/css/layui.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/layui/2.8.17/layui.js"></script>
    <script type="text/javascript" src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
    <style>
        .body-data span {
            float: left;
            margin-right: 100px;
        }

        .body-data .data-form {
            float: left; /* 数据列表浮动到左侧 */
            margin: 0 auto;
        }
    </style>
</head>
<body>

<div class="information-body">
    <div class="layui-header" style="text-align: center;">
        <ul class="layui-nav layui-bg-break">
            <li class="layui-nav-item">
                <a href="main.jsp" >发现音乐</a>
            </li>
            <li class="layui-nav-item">
                <a href="TopList.jsp">排行榜</a>
            </li>
            <li class="layui-nav-item  layui-this">
                <a href="TypeList.jsp">分类歌单</a>
            </li>
            <li class="layui-nav-item">
                <a href="List.jsp?listId=5" >我的音乐</a>
                <dl class="layui-nav-child">
                    <dd>
                        <a href="List.jsp?listId=5">我的喜欢</a>
                    </dd>
                    <dd>
                        <a href="RecentMusic.jsp">最近播放</a>
                    </dd>
                </dl>
            </li>
            <li class="layui-nav-item layui-hide-xs" lay-unselect>
                <input id="searchInput" type="text" placeholder="搜索..." autocomplete="off" class="layui-input layui-input-search">
                <div class="layui-input-split layui-input-suffix" style="cursor: pointer; display: flex; align-items: center;">
                    <i id="searchIcon" class="layui-icon layui-icon-search" style="position: absolute; top: 50%; transform: translateY(-50%);"></i>
                </div>
            </li>
            <li class="layui-nav-item " lay-unselect >
                &nbsp;&nbsp;&nbsp;
                <img src="../img/headimg.jpg" class="layui-nav-img">
                <label>${sessionScope.user.username}</label>
                <dl class="layui-nav-child">
                    <dd>
                        <a href="UserHome.jsp">我的主页</a>
                    </dd>
                    <dd>
                        <a href="UserInformation.jsp">个人信息</a>
                    </dd>
                    <dd>
                        <a href="forget.jsp">修改密码</a>
                    </dd>
                    <dd style="text-align: center;">
                        <a href="../index.jsp">退出</a>
                    </dd>
                </dl>
            </li>
        </ul>
    </div>
    <div class="body-data">
            <span>
                <img src="../img/headimg.jpg" style="width: 300px;height: 300px;margin-left: 150px;">
            </span>
        <div class="data-form">
            <form class="layui-form layui-form-pane">
                <div class="layui-form-item">
                    <label class="layui-form-label">账号</label>
                    <div class="layui-input-block">
                        <input type="text" name="username" value="${sessionScope.user.username}" lay-verify="required" readonly class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">昵称</label>
                    <div class="layui-input-block">
                        <input type="text" name="nickname" value="${sessionScope.user.nickname}" placeholder="请输入昵称" lay-verify="required" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">手机号</label>
                    <div class="layui-input-block">
                        <input type="text" name="phone" value="${sessionScope.user.phone}" lay-verify="required" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">生日</label>
                    <div class="layui-input-block">
                        <input type="text" name="birthday" value="${sessionScope.user.birthday}" id="date1" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <button class="layui-btn" lay-submit lay-filter="demo2">确认</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    layui.use(['form'], function(){
        var form = layui.form;
        var layer = layui.layer;
        var laydate = layui.laydate;

        laydate.render({
            elem: '#date1'
        });
        // 提交事件
        form.on('submit(demo2)', function(data){
            var field = data.field;

            var requestData = {
                username: field.username,
                birthday: field.birthday,
                nickname: field.nickname,
                phone: field.phone
            };
            $.ajax({
                url:  '/updUser',
                type: 'post',
                data: JSON.stringify(requestData),
                contentType: "application/json",
                dataType: "TEXT",
                success: function(res){
                   if (res === "SUCCESS")
                       layer.msg("修改成功");
                   else
                       layer.msg("暂时不能修改!")
                },
                error: function(){
                   layer.msg('修改失败');
                }
           });
            return false;
        });
    });
</script>
</body>
</html>

