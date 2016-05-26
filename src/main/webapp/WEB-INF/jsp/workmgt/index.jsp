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

<title>待办任务管理</title>

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
<script type="text/javascript" src="<%=basePath %>static/service/workmgt.js"></script>

</head>

<body >

	<div id="mainTab" class="easyui-tabs" style="min-width:1096px;min-height:460px;">
	    <div title="待办任务" data-options="closable:true" style="overflow:auto;padding:5px;">
	        <!-- Grid -->
			<div id="toolbar_db">
				<div>
					<div id="dealWork" class="easyui-linkbutton"
					data-options="iconCls:'icon-add',plain:true">处理任务</div>
				</div>
				<div>
					<table id="searchTable">
						<tr>
							<td>工作流名称：</td>
							<td><input id="s_flowName" class="easyui-textbox" ></td>
							<td >任务对象：</td>
							<td width="350px"><input id="s_targetName" class="easyui-textbox" ></td>
						</tr>
						<tr>
							<td >开始时间：</td>
							<td ><input id="s_startTime" name="s_startTime" class="easyui-datebox" data-options="editable:false,formatter:function(date){
			var y = date.getFullYear();
			var m = date.getMonth()+1;
			var d = date.getDate();
			if(m<10){m = '0'+m;}
			if(d<10){d = '0'+d;}
			return y+'-'+m+'-'+d;
		}" style="width: 150px" > </td>
							<td >结束时间：</td>
							<td ><input id="s_endTime" name="s_endTime" class="easyui-datebox" data-options="editable:false,formatter:function(date){
			var y = date.getFullYear();
			var m = date.getMonth()+1;
			var d = date.getDate();
			if(m<10){m = '0'+m;}
			if(d<10){d = '0'+d;}
			return y+'-'+m+'-'+d;
		}" style="width: 150px" > <a id="searchDB" href="#" class="easyui-linkbutton" iconCls="icon-search">检索</a>
							<a id="resetDB" href="#" class="easyui-linkbutton" iconCls="icon-reset">重置</a></td>
						</tr>
					</table>
					
				</div>
				
			</div>
			<table id="dbGrid"></table>
			
			<!-- Window -->
			<div id="dealWin" style="display: none;">
		
				<form id="dealForm" method="post">
		
					<input class="easyui-validatebox" type="text" id="id" name="id"
						style="width:350;display: none;" />
		
					<fieldset style="margin-top: 10px">
						<legend>信息一览</legend>
						<iframe id="targetMsgShowFrame" width="550" height="300" src="" frameborder="0" scrolling="no"></iframe>
					</fieldset>
		
					<table id = "dealFormTable" width="100%">
						<tr>
							<td align="center"><a id="doDeal" href="#"
								class="easyui-linkbutton" data-options="iconCls:'icon-save'">处理</a></td>
						</tr>
					</table>
		
				</form>
		
			</div>
			
	
	    </div>
	    <div title="已办任务" data-options="closable:true" style="overflow:auto;padding:5px;">
	        <!-- Grid -->
			<div id="toolbar_yb">
				<div>
					<div id="WorkInfo" class="easyui-linkbutton"
					data-options="iconCls:'icon-add',plain:true">查看任务</div>
				</div>
				<div>
					<table id="searchTable_yb">
						<tr>
							<td>工作流名称：</td>
							<td><input id="s_flowName_yb" class="easyui-textbox" ></td>
							<td >任务对象：</td>
							<td width="350px"><input id="s_targetName_yb" class="easyui-textbox" ></td>
						</tr>
						<tr>
							<td >开始时间：</td>
							<td ><input id="s_startTime_yb" name="s_startTime" class="easyui-datebox" data-options="editable:false,formatter:function(date){
			var y = date.getFullYear();
			var m = date.getMonth()+1;
			var d = date.getDate();
			if(m<10){m = '0'+m;}
			if(d<10){d = '0'+d;}
			return y+'-'+m+'-'+d;
		}" style="width: 150px" > </td>
							<td >结束时间：</td>
							<td ><input id="s_endTime_yb" name="s_endTime" class="easyui-datebox" data-options="editable:false,formatter:function(date){
			var y = date.getFullYear();
			var m = date.getMonth()+1;
			var d = date.getDate();
			if(m<10){m = '0'+m;}
			if(d<10){d = '0'+d;}
			return y+'-'+m+'-'+d;
		}" style="width: 150px" > <a id="searchYB" href="#" class="easyui-linkbutton" iconCls="icon-search">检索</a>
							<a id="resetYB" href="#" class="easyui-linkbutton" iconCls="icon-reset">重置</a></td>
						</tr>
					</table>
					
				</div>
				
			</div>
			<table id="ybGrid"></table>
	    </div>
	</div>

	
	
</body>
</html>
