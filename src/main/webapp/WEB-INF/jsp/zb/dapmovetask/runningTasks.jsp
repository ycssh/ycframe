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

<title>指标同步任务【正在执行】</title>

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
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>

<script type="text/javascript">

$(function(){

	initGrid();

	$("#remove").bind("click",removeTask);
});

function removeTask(){
	
	var r = $("#mainGrid").datagrid('getChecked');
	if(!r||r.length==0){
		alert('请选择待停止的任务！');
		return;
	}
	if(!confirm('你确定要停止选中的任务吗?')){
		return;
	}
	
	var ids = new Array();
	for(var i=0;i<r.length;i++){
		/*if(r[i].isBL!="1"){
			alert("非补录数据不允许删除，请取消选择非补录数据！");
			return;
		}*/
		ids.push(r[i].id);
	}
	
	$.post('dapmovetask/removeTask.do',{ids:ids.join(',')},function(data){
		
		//var data = eval('(' + data + ')'); // change the JSON string to
		// javascript object
		if (data.success) {
			alert('操作成功！');

			refreshItem();
		} else {
			alert(data.msg);
		}
	},"JSON");
}

function refreshItem(){
	
	$("#mainGrid").datagrid('reload');
}


function initGrid(){
	
	$('#mainGrid').datagrid({
	    url:'dapmovetask/findRunningTasks.do',
	    toolbar:"#toolbar",
	    queryParams:{
//	    	filter:"zbname="+$.trim($("#s_zbname").val())+"&field="+$.trim($("#s_field").val())
	    },
	    columns:[[
	        {field:'id',title:'编号',checkbox:true,width:120},
	        {field:'beanName',title:'任务bean',width:100},
	        {field:'beanDesc',title:'任务说明',width:200},
	        {field:'startTime',title:'开始时间',width:80,formatter : dateFormater},
	        {field:'period',title:'执行间隔（单位：分钟）',width:80},
	        {field:'crtime',title:'创建时间',width:100,formatter : dateFormater},
	        {field:'cruser',title:'创建人',width:80}
	    ]],
	    rownumbers:true,
	    singleSelect:false,
	    autoRowHeight:true,
		fitColumns : true,
	    onLoadSuccess:function(data){
	    	
	    }
	});
}

</script>
</head>

<body>

	<!-- Grid -->
	<div id="toolbar">
		<div>
			<div id="remove" class="easyui-linkbutton"
			data-options="iconCls:'icon-remove',plain:true">停止任务</div>
		</div>
		<!-- <div>
			任务bean：<input id="s_beanName" class="easyui-validatebox" >
			任务说明：<input id="s_beanDesc" class="easyui-validatebox" >
			
			<a id="search" href="#" class="easyui-linkbutton" iconCls="icon-search">检索</a>
			<a id="s_reset" href="#" class="easyui-linkbutton" iconCls="icon-reset">重置</a></td>
		</div> -->
		
	</div>
	<table id="mainGrid"></table>
	
	
</body>
</html>
