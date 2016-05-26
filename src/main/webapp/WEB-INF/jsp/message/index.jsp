<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String version="1.3.5";
String contextPath = request.getContextPath();
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="ycfn" uri="/madmin-functions" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
<title>消息监测</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" /> 
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="easyui">
<meta http-equiv="description" content="easyui">

<link rel="stylesheet" type="text/css" href="<%=basePath%>static/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>static/easyui/themes/icon.css">
<script type="text/javascript" src="<%=basePath%>static/js/jquery-1.11.0.min.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=basePath%>static/easyui/jquery.easyui.min.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=basePath%>static/js/system.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=basePath%>static/easyui/easyui-lang-zh_CN.js" charset="utf-8"></script>


<script type="text/javascript">

//初始化函数
$(function() {	
	//表格加载函数
	tableLoad();
	
	//绑定工具栏点击事件
	$('#toRead').unbind('click').click(function(){toRead();});//标记为已读写	
	$('#tableSearchButton').unbind('click').click(function(){tableLoad();});//查询按钮
	$('#tableResetButton').unbind('click').click(function(){tableResetButton();});//重置按钮
});

//工具栏中的重置按钮函数
var tableResetButton =function(){
	//发送时间
	//$('#time').val("");
	$("#time").datebox("setValue",null);
	//消息状态
	$('#readStat').combobox("setValue","");
	
	//表格显示函数
	tableLoad();
};

/**
 * 表格展示函数
 */
var tableLoad = function(){

	//var role = $.trim($('#role').val());
	
	//发送时间
	var time = $('#time').datebox('getValue');
	//消息状态
	var readStat = $.trim($('#readStat').combobox('getValue'));
	
	//表格内容加载
	$('#dg').datagrid({
		url : '<%=basePath%>message/list',
		queryParams:{
			isSelect:'1',//是否查询，用于阻止easy-ui重复查询
			time: time,//发送时间
			readString: readStat,//消息状态
	    },
		method:'post'
	});
	
	$("#dg").datagrid('hideColumn', "id");
};

//状态标记为已读
var toRead = function(){
	
	var row = $('#dg').datagrid('getSelections');
	
	if(row ==null || row.length == 0){
		$.messager.alert('提示','请选择上要标记的记录');
    	return null;
	}
	
	var idArray = [];
	for(var index =0 ; index<row.length; index++){
		idArray.push(row[index]['id']);
	}
	
	var idString = idArray.join(',');
	
	 //注销操作
	if(confirm("确定标记为已读?")){
		$.post("<%=basePath%>message/toRead",{messageId:idString})	
			.done(function(data){
				$.messager.alert('提示','操作成功');
		    	$('#dg').datagrid('reload');
			})
			.faile(function(){
				alert("操作失败");
			});
	} 
};


</script>
		
</head>
<body>
	
<!-- 显示的表格 -->
<table id="dg"   data-options="toolbar:'#tb',singleSelect:false">
	<thead>
		<tr>
			<th data-options="field:'ck',checkbox:true"></th>
			<th data-options="field:'id'" align="center">Id</th>
			<th data-options="field:'content'" width="20%" align="center">内容</th>			
			<th data-options="field:'readString'" width="20%" align="center">状态</th>
			<th data-options="field:'timeString'" width="20%" align="center">时间</th>
			<th data-options="field:'userName'" width="20%" align="center">用户</th>
			<th data-options="field:'ip'" width="20%" align="center">IP地址</th>
		</tr>
	</thead>
</table>

<!-- 表格工具栏 -->
<div id="tb" style="padding:5px;">
	<!-- 按钮  -->
	<div style="margin-bottom:5px">
		<a href="javescript:void(0);" id ="toRead" class="easyui-linkbutton" iconCls="icon-remove" plain="true">标记为已读</a>			
	</div> 

	<!-- 筛选框  -->
	<div>
		消息发送时间：
		<input id="time" name="s_startTime" style="width: 100px" class="easyui-datebox" data-options="editable:false,formatter:function(date){
			var y = date.getFullYear();
			var m = date.getMonth()+1;
			var d = date.getDate();
			if(m<10){m = '0'+m;}
			if(d<10){d = '0'+d;}
			return y+'-'+m+'-'+d;
		}">
		&nbsp;消息状态: 
	 	<select id="readStat" class="easyui-combobox" panelHeight="auto" style="width: 100px" editable="false">
			<option value="">不限</option>
			<option value="0">未读</option>
			<option value="1">已读</option>
		</select> 
		
	   &nbsp;	
       <a id="tableSearchButton" href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-search">查询</a> 
	   <a id="tableResetButton" href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-reload">重置</a>
	</div>
	
</div>

</body>
</html>