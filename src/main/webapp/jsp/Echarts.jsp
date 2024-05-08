<%@ page contentType="text/html;charset=UTF-8" language="java" isThreadSafe="false" %>
<html>
<head>
    <title>WebMusic数据</title>
  <script src="../js/jQuery.js"></script>
  <script src="../js/echarts.min.js"></script>
</head>
<body>
    <!-- 内容主体区域 -->
    <div id="main" style="width: 1200px; height: 600px;">

    </div>
    <div class="layui-btn-container">
        <button type="button" class="layui-btn">流行榜</button>
        <button class="layui-btn layui-btn-primary layui-border-blue">喜欢榜</button>
    </div>
<script>
    var chartDom = document.getElementById('main');
    var myChart = echarts.init(chartDom);
    var option;

    option = {
        title: {
          text: '最受欢迎的音乐(各排行榜前10首！)',
          subtext: 'WebMusic',
          left: 'center'
        },
        tooltip: {
          trigger: 'item',
          formatter: '{a} <br/>{b} : {c} ({d}%)'
        },
        legend: {
          left: 'center',
          top: 'bottom',
          data: []
        },
        toolbox: {
          show: true,
          feature: {
            mark: {
              show: true
            },
            dataView: {
              show: true,
              readOnly: false
            },
            restore: {
              show: true
            },
            saveAsImage: {
              show: true
            }
          }
        },
        series: [{
          name: 'Radius Mode',
          type: 'pie',
          radius: [20, 140],
          center: ['25%', '50%'],
          roseType: 'radius',
          itemStyle: {
            borderRadius: 5
          },
          label: {
            show: false
          },
          emphasis: {
            label: {
              show: true
            }
          },
          data: []
        },
          {
            name: 'Area Mode',
            type: 'pie',
            radius: [20, 140],
            center: ['75%', '50%'],
            roseType: 'area',
            itemStyle: {
              borderRadius: 5
            },
            data: []
          }
        ]
    };

    myChart.setOption(option);

    // 为语言按钮添加点击事件处理程序
    $('.layui-btn-container button').click(function() {
        var type = $(this).text();  // 获取点击的按钮的文本
        loadData(type);
    });

    function loadData(type) {
        if (type === "流行榜"){
            $.ajax({
                type:"get",
                url:"/getRecEData",
                async:true,   //异步
                success: function(res){
                    myChart.setOption({
                        series: [{
                            data: res
                        },{
                            data: res
                        }]
                    });
                }
            });
        }else{
            $.ajax({
            type:"get",
            url:"/getLikeNumber",
            async:true,   //异步
            success: function(res) {
                myChart.setOption({
                    series: [{
                        data: res
                    }, {
                        data: res
                    }]
                });
            }});

        }
    }
    $('.layui-btn-container button:contains("流行榜")').trigger('click');

</script>
</body>
</html>
