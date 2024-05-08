<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>主页</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/layui/2.8.17/css/layui.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/layui/2.8.17/layui.js"></script>
    <script type="text/javascript" src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
</head>

<body>
<div id="LAY_music" >
    <div class="layui-header" style="text-align: center;">
        <ul class="layui-nav layui-bg-break">
            <li class="layui-nav-item layui-this">
                <a href="main.jsp">发现音乐</a>
            </li>
            <li class="layui-nav-item">
                <a href="TopList.jsp">排行榜</a>
            </li>
            <li class="layui-nav-item">
                <a href="TypeList.jsp">分类歌单</a>
            </li>
            <li class="layui-nav-item">
                <a href="List.jsp?listId=5">我的音乐</a>
                <dl class="layui-nav-child">
                    <dd>
                        <a href="List.jsp?listId=5">我的喜欢</a>
                    </dd>
                    <dd>
                        <a href="RecentMusic.jsp" >最近播放</a>
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
    <div class="body">
        <jsp:include page="findMusic.jsp" />
    </div>
</div>
<script>
    layui.use('jquery', function() {
        var $ = layui.$;

        // 获取元素
        var searchIcon = $("#searchIcon");
        var searchInput = $("#searchInput");

        // 添加点击事件监听器
        searchIcon.click(function () {
            var musicName = searchInput.val();
            // 发起 Ajax 请求
            window.location.href="Search.jsp?musicName="+musicName;
        });
    });

</script>

</body>
</html>
