<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /> 
<base href="<%=basePath%>">

<title>短训班异常状况统计</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style type="text/css">
table td{
	font-size: 12px;
}
</style>
<link rel="stylesheet" type="text/css"
	href="<%=basePath %>static/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath %>static/easyui/themes/icon.css">
<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/easyui/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>

<script type="text/javascript">
$(function() {
	

	
	//初始化easy-ui表格
	tableLoad();
		
	$('#search').unbind('click').click(function(){tableLoad();});//查询
	$('#s_reset').unbind('click').click(function(){resetSearchBox();});//重置
	
	
	$('#export').unbind('click').click(function(){exportFunction();});//导出
	
});


/**
 * 到处函数
 */
 var exportFunction = function(){
	var deptId = $.trim($("#s_deptId").combobox('getValue'));
	var startTime = $("#s_startTime").datebox('getValue');
	var endTime = $("#s_endTime").datebox('getValue');
	
	if(startTime>endTime){
		alert("开始时间不能大于结束时间");
		return ;
	}
	
	
	//下载
	window.open(encodeURI(encodeURI("yczktj/exportExcel?deptId="+deptId+"&startTime="+startTime+"&endTime="+endTime)));
 };


/**
 * 表格加载函数
 */
var tableLoad = function(){

	var deptId = $.trim($("#s_deptId").combobox('getValue'));
	var startTime = $("#s_startTime").datebox('getValue');
	var endTime = $("#s_endTime").datebox('getValue');
	if(startTime>endTime){
		alert("开始时间不能大于结束时间");
		return ;
	}
	
	$('#dg').datagrid({
		url : 'yczktj/yczktjForShort',
		queryParams:{
			isSelect:'1',//防止easy-ui重复加载
			deptId: deptId,//部门ID
			startTime: startTime,//开始时间
			endTime: endTime//结束时间
	    },
		method:'post',
		rownumbers:true,
	    singleSelect:false,
	    autoRowHeight:true,
		fitColumns : true,
	   // pagination:true,
	    //pageSize: 5, //页大小
        //pageList: [5, 15, 20, 25],//变更每页大小
	});
	
	
};


/**
 * 重置函数
 */
 var resetSearchBox = function(){
	$("#s_deptId").combobox('setValue',null);
	$("#s_startTime").datebox('setValue',null);
	$("#s_endTime").datebox('setValue',null);
};


</script>
</head>

<body>

	<!-- Grid -->
	<div id="toolbar">
		<div>
			<table id="searchTable">
				
				<tr>
					<td>专业培训部：</td>
					<td><input id="s_deptId" class="easyui-combobox"  data-options="
        valueField: 'value',
        textField: 'name',
        url: 'zbDict/findByType.do?type=dept',
        onSelect: function(rec){
        },
        onLoadSuccess:function(rec){
        	
        }"></td>
					<td >开始时间：</td>
					<td><input id="s_startTime" name="s_startTime" class="easyui-datebox" data-options="editable:false,formatter:function(date){
	var y = date.getFullYear();
	var m = date.getMonth()+1;
	var d = date.getDate();
	if(m<10){m = '0'+m;}
	if(d<10){d = '0'+d;}
	return y+'-'+m+'-'+d;
}" style="width: 150px" > </td>
			        <td>结束时间：</td>
					<td><input id="s_endTime" name="s_endTime" class="easyui-datebox" data-options="editable:false,formatter:function(date){
	var y = date.getFullYear();
	var m = date.getMonth()+1;
	var d = date.getDate();
	if(m<10){m = '0'+m;}
	if(d<10){d = '0'+d;}
	return y+'-'+m+'-'+d;
}" style="width: 150px" > 
                    <a id="search" href="javascript:;" class="easyui-linkbutton" iconCls="icon-search">检索</a>
					<a id="s_reset" href="javascript:;" class="easyui-linkbutton" iconCls="icon-reset">重置</a>
					<a id ="export" href="javascript:;"  class="easyui-linkbutton" iconCls="icon-template">导出</a>
					</td>
					
				</tr>
			</table>
			
		</div>
		
	</div>


	
	<!-- easy-ui显示的表格 -->
	<div data-options="region:'center',href:'',title:'dota'" style="overflow: hidden;" id="center">
		<table id="dg"  data-options="toolbar:'#tb'">
				<thead>  
						<tr> 
							<th field="deptName"   width="10" align="center" resizable="true">专业培训部</th> 
							<th field="jhycCount"  width="5"  align="center" resizable="true">计划异常</th> 
							<th field="faycCount"  width="5"  align="center" resizable="true">方案异常</th> 
							<th field="rwsycCount" width="5" align="center" resizable="true">任务书异常</th> 
							<th field="bmycCount"  width="5" align="center" resizable="true">报名异常</th> 
							<th field="kbyccCount" width="5" align="center" resizable="true">课表异常</th> 
							<th field="bdycCount"  width="5" align="center" resizable="true">报到异常</th> 
							<th field="cjycCount"  width="5" align="center" resizable="true">成绩异常</th> 
							<th field="pyycCount"  width="5" align="center" resizable="true">评优异常</th> 
							<th field="zsycCount"  width="5"align="center" resizable="true">证书异常</th> 
							<th field="jsycCount"  width="5" align="center" resizable="true">决算异常</th> 
							<th field="allCount"   width="5"align="center" resizable="true">部门小计</th> 
						</tr>  
				 </thead>  
		</table>
	</div>
	
	
</body>
</html>
