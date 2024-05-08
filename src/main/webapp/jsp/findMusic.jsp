<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>发现音乐</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/layui/2.8.17/css/layui.css" rel="stylesheet"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/layui/2.8.17/layui.js"></script>
    <script type="text/javascript" src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            $.ajax({
                url: "/getMusicList", //后端处理数据的Servlet的URL
                type: "GET",
                dataType: "json",
                success: function(res) {
                    // 成功接收到数据后的处理逻辑
                    var ul = $("<ul></ul>").css({"padding": "0", "list-style": "none", "text-align": "center"});
                    $.each(res, function(index, item) {
                        var li = $("<li></li>").addClass("layui-ul-li").css({"display": "inline-block", "margin": "10px"});
                        var div = $("<div></div>");
                        var a = $("<a></a>").attr("href", "List.jsp?listId=" + item.listId);
                        var img = $("<img>").attr({"src": item.listImg, "alt": item.title, "width": "100", "height": "100"}).css({"width": "200px", "height": "200px"});
                        a.append(img);
                        div.append(a);
                        li.append(div);
                        li.append($("<h4></h4>").text(item.title));
                        ul.append(li);
                    });
                    $("#dynamicContent").html(ul);
                },
                error: function() {
                    // 处理请求失败的情况
                    alert("Failed to retrieve data from the server.");
                }
            });
        });
    </script>
    <style>
        .layui-table-cell{
            height: 100px;
        }
        .layui-table-header{
            height: 50px;
            width: 1100px;
        }
        .recommend {
              margin: 0 auto; /* 设置为自动居中 */
              width: 1150px; /* 设置表格宽度 */
        }
        .layui-ul-li{
            display: inline-block;
            width: 18%;
            margin-right: 2%;
            vertical-align: top;
        }
    </style>
</head>
<body>
    <div style="text-align: center;">
        <div class="layui-carousel" id="ID-carousel-demo-image" style="margin: 0 auto;">
            <div carousel-item >
                <div><img src="../img/lunbo/1.jpg" id="img1"></div>
                <div><img src="../img/lunbo/2.jpg" id="img2"></div>
                <div><img src="../img/lunbo/3.jpg" id="img3"></div>
            </div>
        </div>
        <br><br><br>
        <div class="data-list">
            <br><h2>歌单推荐</h2><hr />
            <div id="dynamicContent" style="text-align: center;">
               <!-- <ul><li>标签数据内容从数据库中读 -->
            </div>
        </div>
        <br><br><hr />
        <div class="recommend" style="margin: 0 auto;">
            <h2>猜你喜欢</h2>
            <hr />
            <table id="recommend" lay-filter="test" ></table>
        </div>

        <br><hr class="layui-border-blue"/>
    </div>
    <!-- 底部固定区域 -->
    <div class="layui-footer" style=" width: 100%; height: 150px; background-color: #333; color: white; text-align: center; line-height: 40px;">
        版权所有 &copy; 2023
    </div>
    <div class="audio-container" style=" position: fixed; bottom: 0;left: 0; width: 100%; background-color: #f0f0f0; padding: 10px; text-align: center;">
        <audio controls autoplay style="width: 100%" id="audio">
        </audio>
    </div>

    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-xs" lay-event="play">
            <i class="layui-icon layui-icon-play"></i>播放
        </a>
        <a class="layui-btn layui-btn-xs" lay-event="like">喜欢</a>
    </script>
    <script>
        layui.use('layer', function() {
            var carousel = layui.carousel; //轮播
            var table = layui.table; //推荐表
            var username = "${sessionScope.user.username}"
            // 渲染 - 图片轮播
            carousel.render({
                elem: '#ID-carousel-demo-image',
                width: '1080px',
                height: '420px',
                interval: 3000
            });

            document.getElementById('img1').onclick = function() {
                layer.msg("开始播放短暂逃离烦闷的人生");
                $.ajax({//播放音乐
                    url: '/getOneMusic',
                    data: {id: 43},
                    type: 'get',
                    dataType: 'text',
                    success: function(res){
                        $('#audio').attr('src', res);
                    }
                });
                $.ajax({//添加到最近播放
                    url: '/addRecentMusic',
                    data: {musicId: 43,
                        username: username
                    },
                    type: 'get',
                    dataType: 'text',
                });
            };

            document.getElementById('img2').onclick = function() {
                layer.msg("开始播放1.1");
                $.ajax({//播放音乐
                    url: '/getOneMusic',
                    data: {id: 42},
                    type: 'get',
                    dataType: 'text',
                    success: function(res){
                        $('#audio').attr('src', res);
                    }
                });
                $.ajax({//添加到最近播放
                    url: '/addRecentMusic',
                    data: {musicId: 42,
                        username: username
                    },
                    type: 'get',
                    dataType: 'text',
                });
            };

            document.getElementById('img3').onclick = function() {
                layer.msg("开始播放慢冷");
                $.ajax({//播放音乐
                    url: '/getOneMusic',
                    data: {id: 44},
                    type: 'get',
                    dataType: 'text',
                    success: function(res){
                        $('#audio').attr('src', res);
                    }
                });
                $.ajax({//添加到最近播放
                    url: '/addRecentMusic',
                    data: {musicId: 44,
                        username: username
                    },
                    type: 'get',
                    dataType: 'text',
                });
            };

            table.render({
                elem: '#recommend',
                url: '/getRecommend',
                skin: 'line',
                cols: [[
                    {field: 'musicId', width: 50, title: ''},
                    {field: 'img', width: 200, title: '',templet: '<div style="height: 100px"><img src="{{ d.img }}" style="display:table-cell; vertical-align: middle; height: 80px; width: 80px;"/></div>'},
                    {field: 'musicName', width: 250, title: '歌名'},
                    {field: 'singer',width: 150, title: '歌手'},
                    {field: 'album', width: 150, title: '专辑'},
                    {field: 'type', width: 150, title: '类型'},
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
