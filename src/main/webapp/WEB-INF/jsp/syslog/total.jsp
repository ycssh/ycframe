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
<script type="text/javascript" src="<%=basePath %>static/service/sysTotallog.js"></script>

</head>

<body>

	<!-- Grid -->
	<div id="toolbar">
		<div>
			<table id="searchTable">
				<tr>
					<td >日志类型：</td>
					<td width="150px"><select id="logType" class="easyui-combobox"
							name="logType" style="width:100px;">
								<option value="" selected="selected">全部</option>
								<option value="1">系统日志</option>
								<option value="2">业务日志</option>
						</select>
					</td>
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
}" style="width: 150px" > <a id="search" href="#" class="easyui-linkbutton" iconCls="icon-search">检索</a>
					<a id="s_reset" href="#" class="easyui-linkbutton" iconCls="icon-reset">重置</a></td>
				</tr>
			</table>
			
		</div>
		
	</div>
	<table id="mainGrid"></table>
	
</body>
</html>
