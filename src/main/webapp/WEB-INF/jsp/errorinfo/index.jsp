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

<title>异常事件管理</title>

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
<script type="text/javascript" src="<%=basePath %>static/service/errorinfo.js"></script>

</head>

<body>

	<!-- Grid -->
	<div id="toolbar">
		<div>
			<div id="addAuto" class="easyui-linkbutton"
				data-options="iconCls:'icon-add',plain:true">自动添加异常事件</div>
			<div id="add" class="easyui-linkbutton"
			data-options="iconCls:'icon-add',plain:true">新增</div>
			<div id="edit" class="easyui-linkbutton"
				data-options="iconCls:'icon-edit',plain:true">修改</div>
			<div id="delete" class="easyui-linkbutton"
				data-options="iconCls:'icon-remove',plain:true">删除</div>
		</div>
		<div>
			<table id="searchTable">
				<tr>
					<td style="white-space: nowrap;">异常情况描述：</td>
					<td><input id="s_descr"  class="easyui-textbox" ></td>
					<td >责任部门：</td>
					<td ><input id="s_dept" class="easyui-combobox" style="width: 150px" data-options="editable:false,valueField: 'name',textField: 'name',
					onSelect: function(rec){
			        	
			        }"></td>
			        <td style="white-space: nowrap;">异常状态：</td>
					<td ><input id="s_status" class="easyui-combobox" style="width: 150px" data-options="editable:false,valueField: 'name',textField: 'name',
					onSelect: function(rec){
			        	
			        }"></td>
				</tr>
				<tr>
				<td style="white-space: nowrap;">异常分类：</td>
					<td ><input id="s_ycfl" class="easyui-combobox" style="width: 150px" data-options="editable:false,valueField: 'name',textField: 'name',
					onSelect: function(rec){
			        	
			        }"></td>
					<td style="white-space: nowrap;">开始时间：</td>
					<td ><input id="s_startTime" name="s_startTime" class="easyui-datebox" data-options="editable:false,formatter:function(date){
	var y = date.getFullYear();
	var m = date.getMonth()+1;
	var d = date.getDate();
	if(m<10){m = '0'+m;}
	if(d<10){d = '0'+d;}
	return y+'-'+m+'-'+d;
}" style="width: 150px" > </td>
					<td style="white-space: nowrap;">结束时间：</td>
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
	
	<!-- Window -->
	<div id="window" style="display: none;">

		<form id="form" method="post">

			<input class="easyui-validatebox" type="text" id="id" name="id"
				style="width:350;display: none;" />
			<input class="easyui-validatebox" type="text" id="type" name="type"
				style="width:350;display: none;" value="1" />

			<fieldset style="margin-top: 10px">
				<legend>信息</legend>
				<table width="100%">
					
					<tr>
						<td><label for="name">异常事件描述:</label>
						</td>
						<td><textarea rows="8" cols="60" name="descr"  validType="length[0,125]" invalidMessage="异常事件描述过长，请重新输入！" ></textarea>
						</td>
					</tr>
					
					<tr>
						<td><label for="name">责任部门:</label>
						</td>
						<td><input id="dept" name="dept"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'name',
        textField: 'name',
        required:true,
        editable:false,
        url: 'zbDict/findByType.do?type=dept',
        onLoadSuccess:function(rec){
        	$('#s_'+this.id).combobox('loadData',rec);
        }">
						</td>
					</tr>
					<tr>
						<td><label for="name">异常状态:</label>
						</td>
						<td><input id="status" name="status"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'name',
        textField: 'name',
        required:true,
        editable:false,
        url: 'zbDict/findByType.do?type=ycInfoSta',
        onLoadSuccess:function(rec){
        	$('#s_'+this.id).combobox('loadData',rec);
        }">
						</td>
					</tr>
					<tr>
						<td><label for="name">异常分类:</label>
						</td>
						<td><input id="ycfl" name="ycfl"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'name',
        textField: 'name',
        required:true,
        editable:false,
        url: 'zbDict/findByType.do?type=ycfl',
        onLoadSuccess:function(rec){
        	$('#s_'+this.id).combobox('loadData',rec);
        }">
						</td>
					</tr>
					<tr>
						<td><label for="name">异常发生时间:</label>
						</td>
						<td><input class="easyui-datetimebox" id="errorTimeDesc" name="errorTimeDesc" 
        data-options="showSeconds:false,editable:false,required:true,formatter:function(date){
        	var y = date.getFullYear();
			var m = date.getMonth()+1;
			m = m<10?'0'+m:m;
			var d = date.getDate();
			d = d<10?'0'+d:d;
			var h = date.getHours();
			h = h<10?'0'+h:h;
			var mi = date.getMinutes();
			mi = mi<10?'0'+mi:mi;
			return y+'-'+m+'-'+d+' '+h+':'+mi;
        }"  style="width: 350px">
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
