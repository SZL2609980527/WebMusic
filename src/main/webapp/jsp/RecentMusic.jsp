<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>最近播放</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/layui/2.8.17/css/layui.css" rel="stylesheet"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/layui/2.8.17/layui.js"></script>
    <script type="text/javascript" src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
    <style>
        .layui-table-cell{
            height: 100px;
        }
        .layui-table-header{
            height: 50px;
            width: 1100px;
        }
        .body-data span {
            float: left; /* 图片浮动到左侧 */
            margin-right: 100px; /* 图片距离左边100px */
        }

        .body-data .data-list {
            float: left; /* 数据列表浮动到左侧 */
            margin-top: 50px;
        }
    </style>
</head>
<body>
<div id="LAY_music">
    <div class="layui-header" style="text-align: center;">
        <ul class="layui-nav layui-bg-break">
            <li class="layui-nav-item">
                <a href="main.jsp" >发现音乐</a>
            </li>
            <li class="layui-nav-item">
                <a href="TopList.jsp">排行榜</a>
            </li>
            <li class="layui-nav-item">
                <a href="TypeList.jsp">分类歌单</a>
            </li>
            <li class="layui-nav-item  layui-this">
                <a href="List.jsp?listId=5">我的音乐</a>
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
    <div class="body">
        <div class="body-data">
                <span>
                    <img style="width: 300px;height: 300px;margin-left: 150px;">
                </span>
            <div class="data-list">
                <h1 class="list-title" ></h1>
                <label>简介：</label>
                <p class="list-description" style="width: 300px"> < /p>
            </div>
        </div>
    </div>

    <div class="body-table" style=" margin: 0 auto; width: 1150px; ">
        <br><br><hr />
        <table id="listMusic" lay-filter="test" ></table>
    </div>

    <!-- 底部固定区域 -->
    <div class="layui-footer" style=" width: 100%; height: 150px; background-color: #333; color: white; text-align: center; line-height: 40px;">
        版权所有 &copy; 2023
    </div>
    <div class="audio-container" style=" position: fixed; bottom: 0;left: 0; width: 100%; background-color: #f0f0f0; padding: 10px; text-align: center;">
        <audio controls autoplay style="width: 100%" id="audio">

        </audio>
    </div>
</div>
    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-xs" lay-event="play">
            <i class="layui-icon layui-icon-play"></i>播放
        </a>
        <a class="layui-btn layui-btn-xs" lay-event="like">喜欢</a>
    </script>

<script>
    $(".body-data").ready(function() {
        $.ajax({
            url: "/getOneList?id=6", // 后端处理数据的URL
            type: "GET",
            dataType: "json",
            success: function(data) {
                // 假设从数据库获取的数据是一个JSON对象，包含title和description字段
                var title = data.title;
                var description = data.description;

                // 更新HTML标签的内容
                $(".list-title").text(title);
                $(".list-description").text(description);

                // 如果需要更新图片的src属性
                var imageUrl = data.listImg; // 从数据中获取图片的URL
                $(".body-data img").attr("src", imageUrl);
            },
            error: function() {
                // 处理请求失败的情况
                alert("Failed to retrieve data from the server.");
            }
        });
    });
</script>
<script>
    layui.use(function() {
        var table = layui.table;
        var user = "${sessionScope.user.username}";
        table.render({
            elem: '#listMusic',
            url: '/getRecent?username='+user,
            skin: 'line',
            cols: [[
                {field: 'musicId', width: 25, title: ''},
                {field: 'img', width: 150, title: '',templet: '<div style="height: 100px"><img src="{{ d.img }}" style="display:table-cell; vertical-align: middle; height: 80px; width: 80px;"/></div>'},
                {field: 'musicName', width: 250, title: '歌名'},
                {field: 'singer',width: 150, title: '歌手'},
                {field: 'album', width: 150, title: '专辑'},
                {field: 'type', width: 100, title: '类型'},
                {field: 'number', width: 125, title: '播放次数'},
                {fixed: 'right', title:'操作', width: 150, minWidth: 125, toolbar: '#barDemo'}
            ]],
        });

        //工具栏事件
        table.on('tool(test)', function(obj){
            var user = "${sessionScope.user.username}";
            var data = obj.data;
            if(obj.event === 'play'){
                $.ajax({//播放音乐
                    url: '/getOneMusic',
                    data: {id: data.musicId},
                    type: 'get',
                    dataType: 'text',
                    success: function(res){
                        $('#audio').attr('src', res);
                    }
                });
                $.ajax({//添加到最近播放
                    url: '/addRecentMusic',
                    data: {musicId: data.musicId,
                        username: user
                    },
                    type: 'get',
                    dataType: 'text',
                });
            }else if(obj.event === 'like'){//利用ajax将musicId的值给后端，后端处理喜欢的逻辑
                $.ajax({
                    url: '/addLikeMusic',
                    data: {
                        username: user, // 将username属性值传递给后端
                        musicId: data.musicId // 将musicId传递给后端
                    },
                    type: 'post',
                    dataType:"TEXT",//返回类型 字符串
                    success: function(res){
                        if(res === "SUCCESS"){
                            layer.msg("成功添加到我的喜欢");
                        }else{
                            layer.msg('已经添加过了哦');
                        }
                    },
                    error: function(XMLHttpRequest, textStatus, errorThrown) {
                        // 处理请求失败的情况
                        layer.msg("请求失败：" + textStatus, {icon: 5});
                    }
                });
            }
        });
    });
</script>
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
