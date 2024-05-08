<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>音乐管理</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/layui/2.8.17/css/layui.css" rel="stylesheet" />
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
    </style>
</head>
<body>
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo layui-hide-xs layui-bg-black">Web Music</div>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item layui-hide layui-show-md-inline-block">
                <a href="javascript:;">
                    <img src="../img/headimg.jpg" class="layui-nav-img">
                    ${sessionScope.user.nickname}
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="../index.jsp">退出</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item" lay-header-event="menuRight" lay-unselect>
                <a href="javascript:;">
                    <i class="layui-icon layui-icon-more-vertical"></i>
                </a>
            </li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree" lay-filter="test">
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="javascript:;">音乐管理</a>
                </li>
                <li class="layui-nav-item">
                    <a href="UserManage.jsp">用户管理</a>
                </li>
                <li class="layui-nav-item"><a href="manage.jsp">Music数据</a></li>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 15px;">
            <div class="demoTable">
                搜索歌名：
                <div class="layui-inline">
                    <input class="layui-input" name="id" id="demoReload" autocomplete="off">
                </div>
                <button class="layui-btn" data-type="reload" onclick="searchSongs()">搜索</button>
            </div>
            <table class="layui-hide" id="LAY_table_user" lay-filter="user"></table>
            <div class="main-table">
                <table  class="layui-hide" id="allMusic" lay-filter="test" ></table>
            </div>
        </div>
    </div>
</div>

    <form id="stuForm" lay-filter="editForm" class="layui-form" style="display: none">
        <div class="layui-form-item">
            <label class="layui-form-label">musicId</label>
            <div class="layui-input-block">
                <input type="text" readonly name="musicId" lay-verify="title" autocomplete="off"  class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">专辑图片</label>
            <div class="layui-input-block">
                <input type="text" name="img" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">歌曲名</label>
            <div class="layui-input-block">
                <input type="text" name="musicName" autocomplete="off" placeholder="请输入歌曲名" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">专辑名</label>
            <div class="layui-input-block">
                <input type="text" name="album" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">歌手</label>
            <div class="layui-input-block">
                <input type="text" name="singer" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">类型</label>
            <div class="layui-input-block">
                <input type="text" name="type" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">歌曲url地址</label>
            <div class="layui-input-block">
                <input type="text" name="url" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="demo1">立即提交</button>
            </div>
        </div>
    </form>

    <script type="text/html" id="toolbarDemo">
        <div class="layui-btn-container">
            <button class="layui-btn layui-btn-sm" lay-event="addMusic">添加歌曲</button>
        </div>
    </script>

    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </script>
    <script>
        //搜索
        function searchSongs() {
            var searchValue = $('#demoReload').val();
            var table = layui.table;
            table.render({
                elem: '#allMusic',
                height: 600,
                url: '/getMusicByName?musicName='+searchValue,
                toolbar: '#toolbarDemo',
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
        }
    </script>

    <script>
        layui.use(['table','form'], function() {
            var table = layui.table;
            var form = layui.form;
            var layer = layui.layer;

            table.render({
                elem: '#allMusic',
                height: 600,
                url: '/getMusic' ,
                toolbar: '#toolbarDemo',
                skin: 'line',
                cols: [[
                    {field: 'musicId', width: 50, title: ''},
                    {field: 'img', width: 200, title: '',templet: '<div style="height: 100px"><img src="{{ d.img }}" style="display:table-cell; vertical-align: middle; height: 80px; width: 80px;"/></div>'},
                    {field: 'musicName', width: 250, title: '歌名'},
                    {field: 'singer',width: 150, title: '歌手'},
                    {field: 'album', width: 150, title: '专辑'},
                    {field: 'type', width: 150, title: '类型'},
                    {fixed: 'right', title:'操作', width: 150, minWidth: 125, toolbar: '#barDemo'}
                ]]
            });

            // 提交事件
            form.on('submit(demo1)', function(data){
                var field = data.field; // 获取表单字段值

                $.ajax({
                    type: "POST",
                    url: "/updateMusic",
                    data: JSON.stringify(field),
                    contentType: "application/json",
                    dataType:"TEXT",//返回类型 字符串
                    success: function(response) {
                        if (response === "SUCCESS")
                            layer.msg("编辑成功");
                        else
                            layer.msg("编辑失败");
                    },
                    error: function(XMLHttpRequest, textStatus, errorThrown) {
                        // 处理请求失败的情况
                        layer.msg("请求失败：" + textStatus, {icon: 5});
                    }
                });
                return false;
            });

            //行单击事件（双击事件为：rowDouble）
            table.on('row(test)', function(obj){
                var data = obj.data;
                layer.open({
                    type: 1,
                    content: '<table><tr style="height:50px"><td style="width:100px;text-align:center"">id</td><td>'+data.musicId+'</td></tr>'+
                        '<tr style="height:50px"><td style="width:100px;text-align:center"">专辑照片</td><td><img src="' +data.img+'" style="width:100px; height:100px;"></td></tr>'+
                        '<tr style="height:50px"><td style="width:100px;text-align:center"">歌名</td><td>'+data.musicName+'</td></tr>'+
                        '<tr style="height:50px"><td style="width:100px;text-align:center"">专辑</td><td>'+data.album+'</td></tr>'+
                        '<tr style="height:50px"><td style="width:100px;text-align:center"">歌手</td><td>'+data.singer+'</td></tr>'+
                        '<tr style="height:50px"><td style="width:100px;text-align:center"">类型</td><td>'+data.type+'</td></tr>'+
                        '</table>',
                    area: ['40%','60%']
                });
                //标注选中样式
                obj.tr.addClass('layui-table-click').siblings().removeClass('layui-table-click');
            });
            // 工具栏事件
            table.on('toolbar(test)', function(obj){
                var id = obj.config.id;
                var checkStatus = table.checkStatus(id);
                var othis = lay(this);
                switch(obj.event){
                    case 'addMusic':
                       layer.open({
                           type: 2,
                           title: '添加音乐',
                           area: ['80%','80%'],
                           content: 'AddMusic.jsp',
                           shade: 0.0,
                       });break;
                    case 'getData':
                        var getData = table.getData(id);
                        console.log(getData);
                        layer.alert(layui.util.escape(JSON.stringify(getData)));
                        break;
                }
            });
            //触发单元格工具事件
            table.on('tool(test)', function(obj){
                var data = obj.data;
                var customerId = data["musicId"];
                if(obj.event === 'del'){
                    layer.confirm('真的删除行么', function(index){
                        obj.del();
                        layer.close(index);
                        window.location="/delOneMusic?id="+customerId;
                    });
                } else if(obj.event === 'edit'){
                    layer.open({
                        title: '编辑',
                        type: 1,
                        area: ['70%','80%'],
                        shade: 0.0,
                        content: $('#stuForm'),
                        success: function(layero, index){
                            // 把当前行的数据显示在表单中
                            form.val('editForm', data);
                        },
                        cancel:function(index){
                            layer.close;
                            $('#stuForm').css('display','none');
                        }
                    });
                }
            });
        });
    </script>

</body>
</html>
