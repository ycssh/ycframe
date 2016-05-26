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

<title>系统日志查看</title>

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
<script type="text/javascript" src="<%=basePath %>static/service/syslog.js"></script>

</head>

<body>

	<!-- Grid -->
	<div id="toolbar">
		<div>
			<!-- <div id="scan" class="easyui-linkbutton"
			data-options="iconCls:'icon-ok',plain:true">查看日志</div> -->
			<!-- <div id="delete" class="easyui-linkbutton"
				data-options="iconCls:'icon-remove',plain:true">删除日志</div> -->
		</div>
		<div>
			<table id="searchTable">
				<tr>
					<td>标题：</td>
					<td><input id="s_title" class="easyui-textbox" ></td>
					<td>操作人：</td>
					<td><input id="s_userid" class="easyui-textbox" ></td>
					<td>日志类型：</td>
					<td><select id="logType" class="easyui-combobox" data-options="editable:false" style="width: 150px;"
							name="logType">
								<option value="0" selected="selected">全部</option>
								<option value="1">系统日志</option>
								<option value="2">业务日志</option>
						</select>
					</td>
					<td>排序方式：</td>
					<td><select id="orderType" class="easyui-combobox" data-options="editable:false" style="width: 150px;"
							name="orderType">
								<option value="1">时间</option>
								<option value="2">操作人</option>
						</select>
					</td>
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
}"> </td>
					<td >结束时间：</td>
					<td ><input id="s_endTime" name="s_endTime" class="easyui-datebox" data-options="editable:false,formatter:function(date){
	var y = date.getFullYear();
	var m = date.getMonth()+1;
	var d = date.getDate();
	if(m<10){m = '0'+m;}
	if(d<10){d = '0'+d;}
	return y+'-'+m+'-'+d;
}"></td>
					<td colspan="2"> <a id="search" href="#" class="easyui-linkbutton" iconCls="icon-search">检索</a>
					<a id="s_reset" href="#" class="easyui-linkbutton" iconCls="icon-reset">重置</a></td>
				</tr>
			</table>
			
		</div>
		
	</div>
	<table id="mainGrid"></table>
	
	<!-- Window -->
	<div id="window" style="display: none;">

		<form id="form" method="post">

			<input class="easyui-validatebox" type="text" id="id" name="id"
				style="width:350;display: none;" />

			<fieldset style="margin-top: 10px">
				<legend>信息</legend>
				<table width="100%">
					
					<tr>
						<td><label for="name">日志标题:</label>
						</td>
						<td colspan="3"><input id="title" name="title" readonly="readonly" style="width: 400px" class="easyui-validatebox"  >
						</td>
					</tr>
					
					<tr>
						<td><label for="name">日志内容:</label>
						</td>
						<td colspan="3"><textarea rows="5" readonly="readonly" cols="60" name="content"></textarea>
						</td>
					</tr>
					
					<tr>
						<td><label for="name">操作类型:</label>
						</td>
						<td><input id="operType" name="operType" readonly="readonly" class="easyui-validatebox"  >
						</td>
						<td><label for="name">操作时间:</label>
						</td>
						<td><input id="opertime" name="opertime" readonly="readonly" class="easyui-validatebox"  >
						</td>
					</tr>
					
					<tr>
						<td><label for="name">操作人:</label>
						</td>
						<td><input id="userid" name="userid" readonly="readonly" class="easyui-validatebox"  >
						</td>
						<td><label for="name">操作人IP:</label>
						</td>
						<td><input id="ip" name="ip" readonly="readonly" class="easyui-validatebox"  >
						</td>
					</tr>
					
				</table>
			</fieldset>

		</form>

	</div>
	
	
	
</body>
</html>
