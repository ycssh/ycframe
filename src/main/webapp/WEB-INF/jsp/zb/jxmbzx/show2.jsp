<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /> 
    <base href="<%=basePath%>">
    
    <title>1111绩效目标执行监测</title>
    
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
<script type="text/javascript" src="<%=basePath %>static/easyui/easyui-lang-zh_CN.js"></script>
	
	<script
	src="${pageContext.request.contextPath}/static/hcharts/js/highcharts.src.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/hcharts/js/dark-green.js"></script>
<!--<script src="${pageContext.request.contextPath}/static/hcharts/js/modules/exporting.js"></script>
		-->
	
	<script type="text/javascript">

	var url = "<%=basePath%>jxmbzx/findShowData.do";
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
			var finishList = [];
			var planList = [];
			var percentList = [];
			var minusList = [];
			
			for(var i=0;i<dataList.length;i++){
				xz.push(dataList[i].name);
				finishList.push(dataList[i].finished);
				planList.push(dataList[i].plan);
				percentList.push(dataList[i].percent);
				minusList.push(dataList[i].minus);
			}
			
			
			$('#container')
				.highcharts(
						{
							chart : {
								type : 'line'
							},
							title : {
								text : currYear+'年度绩效目标执行监测'
							},
							subtitle : {
								text : '年份: '+currYear
							},
							xAxis : {
								categories : xz
							},
							yAxis : {
								title : {
									text : '年度值 '
								}
							},
							tooltip : {
								enabled : true,
								formatter : function() {
									return '<b>' + this.series.name
											+ '</b><br>' + this.x + ': '
											+ this.y + '°C';
								}
							},
							plotOptions : {
								line : {
									dataLabels : {
										enabled : true
									},
									enableMouseTracking : false
								}
							},
							series : [
									{
										name : '年累计值',
										data : finishList
									},
									{
										name : '年度目标值',
										data : planList
									} ,
									{
										name : '与目标差值',
										data : minusList
									} ,
									{
										name : '年计划完成率',
										data : percentList
									} ]
						});
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
        value:new Date().getFullYear(),
        url: 'jxmbzx/findShowYears.do',
        onSelect: function(rec){
            
            reDraw(rec.value);
        }">
  	</div>
  	<p>
    <div id="container"
		style="min-width: 310px;height: 90%; margin: 0 auto"></div>
  </body>
</html>
