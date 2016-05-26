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

<title>指标数据同步任务</title>

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

<script type="text/javascript" src="<%=basePath %>static/service/dapmovetask.js"></script>

</head>

<body>

	<!-- Grid -->
	<div id="toolbar">
		<div>
			<div id="add" class="easyui-linkbutton"
			data-options="iconCls:'icon-add',plain:true">新增</div>
			<div id="edit" class="easyui-linkbutton"
				data-options="iconCls:'icon-edit',plain:true">修改</div>
			<div id="delete" class="easyui-linkbutton"
				data-options="iconCls:'icon-remove',plain:true">删除</div>
			<div id="run" class="easyui-linkbutton"
				data-options="iconCls:'icon-ok',plain:true">生成所有数据</div>
			<div id="runZb" class="easyui-linkbutton"
				data-options="iconCls:'icon-ok',plain:true">生成指标数据</div>
			<div id="runDap" class="easyui-linkbutton"
				data-options="iconCls:'icon-ok',plain:true">生成大屏数据</div>
			<div id="addToQueue" class="easyui-linkbutton"
				data-options="iconCls:'icon-ok',plain:true">添加到定时队列</div>
			<div id="openRunning" class="easyui-linkbutton"
				data-options="iconCls:'icon-ok',plain:true">查看定时任务序列</div>
		</div>
		<div>
			任务bean：<input id="s_beanName" class="easyui-validatebox" >
			任务说明：<input id="s_beanDesc" class="easyui-validatebox" >
			
			<a id="search" href="#" class="easyui-linkbutton" iconCls="icon-search">检索</a>
			<a id="s_reset" href="#" class="easyui-linkbutton" iconCls="icon-reset">重置</a></td>
		</div>
		
	</div>
	<table id="mainGrid"></table>
	
	<!-- Window -->
	<div id="window" style="display: none;">

		<form id="form" method="post">

			<input class="easyui-validatebox" type="text" id="id" name="id"
				style="width:350;display: none;" />

			<fieldset style="margin-top: 10px">
				<legend>大屏数据推送任务详细信息</legend>
				<table width="100%">
					<tr>
						<td><label for="name">迁移任务bean:</label>
						</td>
						<td><input id="beanName" name="beanName" class="easyui-validatebox" style="width: 330px" data-options="required:true">
						</td>
					</tr>

					<tr>
						<td><label for="descr">任务说明:</label>
						</td>
						<td><input id="beanDesc" name="beanDesc" class="easyui-validatebox" style="width: 330px" >
						</td>
					</tr>

					<tr>
						<td><label for="beanName">开始时间:</label>
						</td>
						<td><input class="easyui-datetimebox" id="startTimeDesc" name="startTimeDesc" 
        data-options="showSeconds:false,formatter:function(date){
        	var y = date.getFullYear();
			var m = date.getMonth()+1;
			m = m<10?'0'+m:m;
			var d = date.getDate();
			d = d<10?'0'+d:d;
			var h = date.getHours();
			var mi = date.getMinutes();
			return y+'-'+m+'-'+d+' '+h+':'+mi;
        }"  style="width: 330px">
						</td>
					</tr>
					
					<tr>
						<td><label for="beanName">执行间隔:</label>
						</td>
						<td><input id="period" name="period" class="easyui-numberspinner" style="width: 330px"
         data-options="min:20">（单位：分钟）
						</td>
					</tr>

				</table>
			</fieldset>

			<table width="100%">
				<tr>
					<td align="center"><a id="save" href="#"
						class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
						<a id="reset" href="#" class="easyui-linkbutton"
						data-options="iconCls:'icon-reset'">重置</a></td>
				</tr>
			</table>

		</form>

	</div>
	
</body>
</html>
