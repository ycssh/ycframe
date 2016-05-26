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

<title>送培单位月报</title>

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

<script type="text/javascript" src="<%=basePath %>static/service/pxglyb.js"></script>

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
		</div>
		<div>
			<table id="searchTable">
				
				<tr>
					<td >项目名称：</td>
					<td><input id="s_projectId" class="easyui-combobox" style="width: 350px" data-options="valueField: 'id',textField: 'name',
					onSelect: function(rec){
			        	
			        }"> </td>
			        <td>送培单位：</td>
					<td><input id="s_company" name="s_company"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name'"></td>
					
				</tr>
				<tr>
					<td >开始时间：</td>
					<td ><input id="s_startTime" name="s_startTime" class="easyui-datebox" data-options="formatter:function(date){
	var y = date.getFullYear();
	var m = date.getMonth()+1;
	var d = date.getDate();
	if(m<10){m = '0'+m;}
	if(d<10){d = '0'+d;}
	return y+'-'+m+'-'+d;
}" style="width: 150px" > </td>
					<td >结束时间：</td>
					<td ><input id="s_endTime" name="s_endTime" class="easyui-datebox" data-options="formatter:function(date){
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
						<td><label for="name">项目名称:</label>
						</td>
						<td><input id="projectId" name="projectId"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'id',
        textField: 'name',
        required:true,
        url: 'project/find.do?filter=type=2',
        onSelect: function(rec){
        },
        onLoadSuccess:function(rec){
        	$('#s_'+this.id).combobox('loadData',rec);
        }">
						</td>
					</tr>
					
					<tr>
						<td><label for="name">送培单位:</label>
						</td>
						<td><input id="company" name="company"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        required:true,
        url: 'zbDict/findByType.do?type=company',
        onLoadSuccess:function(rec){
        	$('#s_'+this.id).combobox('loadData',rec);
        }">
						</td>
					</tr>
					
					<tr>
						<td><label for="name">计划人数:</label>
						</td>
						<td><input id="planNum" name="planNum" required="required" class="easyui-numberspinner" 
         data-options="min:0" style="width: 350px" >
						</td>
					</tr>
					
					<tr>
						<td><label for="name">实际人数:</label>
						</td>
						<td><input id="actualNum" name="actualNum" required="required" class="easyui-numberspinner" 
         data-options="min:0" style="width: 350px" >
						</td>
					</tr>
					
					<tr>
						<td><label for="name">参培率:</label>
						</td>
						<td><input id="cpl" name="cpl" required="required" class="easyui-numberspinner" 
         data-options="min:0,precision:2" style="width: 350px" >（%）</td>
					</tr>
					<tr>
						<td><label for="name">出勤率:</label>
						</td>
						<td><input id="cql" name="cql" required="required" class="easyui-numberspinner" 
         data-options="min:0,precision:2" style="width: 350px" >（%）</td>
					</tr>
					<tr>
						<td><label for="name">合格率:</label>
						</td>
						<td><input id="hgl" name="hgl" required="required" class="easyui-numberspinner" 
         data-options="min:0,precision:2" style="width: 350px" >（%）</td>
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
