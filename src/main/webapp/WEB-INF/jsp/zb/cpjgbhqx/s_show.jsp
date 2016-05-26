<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /> 
    <base href="<%=basePath%>">
    
    <title>短训班/团青培训测评结果变化曲线</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript"
	src="<%=basePath%>static/js/jquery-1.11.0.min.js"></script>
	
	<link rel="stylesheet" type="text/css"
	href="<%=basePath %>static/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath %>static/easyui/themes/icon.css">
<script type="text/javascript" src="<%=basePath %>static/easyui/jquery.easyui.min.js"></script>
	
<!--<script src="${pageContext.request.contextPath}/static/hcharts/js/modules/exporting.js"></script>
		-->
	
	<script src="<%=basePath %>static/new/javascript/echarts-all.js" charset="UTF-8" type="text/javascript"></script>
	<script type="text/javascript">
	var url = "<%=basePath%>cpjgbhqx/findShowData.do?type=2";
	var currYear = null;
	var dataList = null;
	$(function() {
	
		reDraw();
		
	}); 
	
	function reDraw(y){
	
		var filter = "";
		if(y){
			filter = "year="+y;
		}
		
		$.post(url,{filter:filter},function(data){
		
			currYear = data.year;
			dataList = data.rows;
			
			var xz = [];
			var pxzlList = [];
			var jxfwList = [];
			var hqfwList = [];
			var ztpjList = [];
			
			for(var i=0;i<dataList.length;i++){
				xz.push(dataList[i].yf);
				pxzlList.push(dataList[i].pxzl);
				jxfwList.push(dataList[i].jxfw);
				hqfwList.push(dataList[i].hqfw);
				ztpjList.push(dataList[i].ztpj);
			}

        	var myChart = echarts
			.init(document.getElementById('container'));
			option = {
				    title : {
				        text: currYear+'年度短训班/团青培训测评结果变化曲线',
				    },
				    tooltip : {
				        trigger: 'axis'
				    },
				    legend: {
				        data:['培训质量评价满意率','教学服务满意率','后勤服务满意率','总体评价满意率'],
				        y:'bottom'
				    },
				    calculable : true,
				    xAxis : [
				        {
				            type : 'category',
				            boundaryGap : false,
				            data : xz
				        }
				    ],
				    yAxis : [
				        {
				            type : 'value',
				            axisLabel : {
				                formatter: '{value} %'
				            },
				            min:85,
				            max:100,
				            splitNumber:3
				        }
				    ],
				    series : [
				        {
				            name:'培训质量评价满意率',
				            type:'line',
				            data:pxzlList,
				            markLine : {
				                data : [
				                    {type : 'average', name: '平均值'}
				                ]
				            }
				        },
				        {
				            name:'教学服务满意率',
				            type:'line',
				            data:jxfwList,
				            markLine : {
				                data : [
				                    {type : 'average', name : '平均值'}
				                ]
				            }
				        },
				        {
				            name:'后勤服务满意率',
				            type:'line',
				            data:hqfwList,
				            markLine : {
				                data : [
				                    {type : 'average', name : '平均值'}
				                ]
				            }
				        },
				        {
				            name:'总体评价满意率',
				            type:'line',
				            data:ztpjList,
				            markLine : {
				                data : [
				                    {type : 'average', name : '平均值'}
				                ]
				            }
				        }
				    ]
				};
			myChart.setOption(option);
			var ecConfig = echarts.config;
			function focus(param) {
				if(param.name == '平均值')
				{
					return;
				}
				top.addTab('502','短期班测评结果监测','/pxcpjg/s_show?time='+param.name);
			}
			myChart.on(ecConfig.EVENT.CLICK, focus);
		},"JSON"); 
	}
	
</script> 
  </head>
  
  <body>
  	<div>
  		<span style="font-size: 12px;">请选择年份：</span><input id="year" name="year"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        required:true,
        value:2015,
        url: 'cpjgbhqx/findShowYears.do?type=2',
        onSelect: function(rec){
            
            reDraw(rec.value);
        }">
  	</div>
  	<p>
    <div id="container"
		style="min-width: 310px;height: 90%;min-height:400px; margin: 0 auto"></div>
  </body>
</html>
