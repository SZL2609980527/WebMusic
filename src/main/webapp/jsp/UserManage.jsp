<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>用户管理</title>
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
                    <a class="" href="MusicManage.jsp">音乐管理</a>
                </li>
                <li class="layui-nav-item">
                    <a href="UserManage.jsp">用户管理</a>
                </li>
                <li class="layui-nav-item">
                    <a href="manage.jsp">Music数据</a>
                </li>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 15px;">
            <div class="main-table">
                <table  class="layui-hide" id="allUser" lay-filter="test" ></table>
            </div>
        </div>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        底部固定区域
    </div>
</div>


<form id="stuForm" lay-filter="editForm" class="layui-form" style="display: none">
    <div class="layui-form-item">
        <label class="layui-form-label">账号</label>
        <div class="layui-input-block">
            <input type="text" readonly name="username" lay-verify="title" autocomplete="off"  class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">昵称</label>
        <div class="layui-input-block">
            <input type="text" name="nickname" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">手机号</label>
        <div class="layui-input-block">
            <input type="text" readonly name="phone" autocomplete="off" placeholder="请输入歌曲名" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">生日</label>
        <div class="layui-input-block">
            <input type="text" readonly name="birthday" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">密保问题</label>
        <div class="layui-input-block">
            <input type="text" readonly name="question" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="demo1">立即提交</button>
        </div>
    </div>
</form>

<%--<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="addData">新增歌曲</button>
    </div>
</script>--%>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script>
    layui.use(['table','form'], function() {
        var table = layui.table;
        var form = layui.form;
        var layer = layui.layer;

        table.render({
            elem: '#allUser',
            height: 600,
            url: '/getAllUser' ,
            toolbar: '#toolbarDemo',
            skin: 'line',
            cols: [[
                {field: 'username', width: 100, title: '账号'},
                {field: 'phone', width: 150, title: '手机号'},
                {field: 'nickname', width: 150, title: '昵称'},
                {field: 'birthday',width: 150, title: '生日',templet: function(d){
                        // 将时间戳转换为日期字符串
                        return new Date(d.birthday).toLocaleDateString();
                    }},
                {field: 'question', width: 300, title: '密保问题'},
                {fixed: 'right', title:'操作', width: 150, minWidth: 125, toolbar: '#barDemo'}
            ]]
        });

        // 提交事件
        form.on('submit(demo1)', function(data){
            var field = data.field; // 获取表单字段值

            $.ajax({
                type: "POST",
                url: "/updUser",
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
        function formatTimestamp(timestamp) {
            var date = new Date(timestamp);
            var year = date.getFullYear();
            var month = ('0' + (date.getMonth() + 1)).slice(-2);
            var day = ('0' + date.getDate()).slice(-2);
            return year + '-' + month + '-' + day;
        }

        //行单击事件（双击事件为：rowDouble）
        table.on('row(test)', function(obj){
            var data = obj.data;
            layer.open({
                type: 1,
                content: '<table><tr style="height:50px"><td style="width:100px;text-align:center"">账号</td><td>'+data.username+'</td></tr>'+
                    '<tr style="height:50px"><td style="width:100px;text-align:center"">手机号</td><td>'+ data.phone +'</td></tr>'+
                    '<tr style="height:50px"><td style="width:100px;text-align:center"">昵称</td><td>'+data.nickname+'</td></tr>'+
                    '<tr style="height:50px"><td style="width:100px;text-align:center"">生日</td><td>'+formatTimestamp(data.birthday)+'</td></tr>'+
                    '<tr style="height:50px"><td style="width:100px;text-align:center"">密保问题</td><td>'+data.question+'</td></tr>'+
                    '</table>',
                area: ['50%', '50%']
            });
            //标注选中样式
            obj.tr.addClass('layui-table-click').siblings().removeClass('layui-table-click');
        });

        //触发单元格工具事件
        table.on('tool(test)', function(obj){
            var data = obj.data;
            var username = data["username"];
            if(obj.event === 'del'){
                layer.confirm('真的删除行么', function(index){
                    obj.del();
                    layer.close(index);
                    window.location="/deleteUser?username="+username;
                });
            } else if(obj.event === 'edit'){
                layer.open({
                    title: '编辑（只能修改用户的昵称）',
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
