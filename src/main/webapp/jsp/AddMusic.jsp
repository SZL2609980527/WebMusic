<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>添加音乐</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/layui/2.8.17/css/layui.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/layui/2.8.17/layui.js"></script>
    <script type="text/javascript" src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
</head>
<body>
<form id="stuForm" lay-filter="editForm" class="layui-form">
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
            <button class="layui-btn" lay-submit lay-filter="demo2">立即提交</button>
        </div>
    </div>
</form>
<script>
    layui.use(['form'], function() {
        var form = layui.form;
        var layer = layui.layer;

        // 提交事件
        form.on('submit(demo2)', function (data) {
            var field = data.field; // 获取表单字段值

            $.ajax({
                type: "POST",
                url: "/addMusic",
                data: JSON.stringify(field),
                contentType: "application/json",
                dataType: "TEXT",//返回类型 字符串
                success: function (response) {
                    if (response === "SUCCESS")
                        layer.msg("添加成功");
                    else
                        layer.msg("添加失败");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    // 处理请求失败的情况
                    layer.msg("请求失败：" + textStatus, {icon: 5});
                }
            });
            return false;
        });
    });
</script>
</body>
</html>
