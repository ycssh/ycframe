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

<title>阙值维护</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

<link rel="stylesheet" type="text/css"
	href="<%=basePath %>static/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath %>static/easyui/themes/icon.css">
<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>

<script type="text/javascript" src="<%=basePath %>static/service/defaultValueMgt.js"></script>

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
			表名：<input id="s_zbname" class="easyui-validatebox textbox" data-options="">
			字段名：<input id="s_field" class="easyui-validatebox textbox" data-options="">
			<a id="search" href="#" class="easyui-linkbutton" iconCls="icon-search">检索</a>
		</div>
		
	</div>
	<table id="mainGrid"></table>
	
	<!-- Window -->
	<div id="window" style="display: none;">

		<form id="form" method="post">

			<input class="easyui-validatebox" type="text" id="id" name="id"
				style="width:350;display: none;" />

			<fieldset>
				<legend>阙值信息</legend>
				<table width="100%">
					<tr>
						<td><label for="name">指标表名:</label>
						</td>
						<td><input id="zbname" name="zbname"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        required:true,
        url: 'defaultValue/findZbTable.do',
        onSelect: function(rec){
        	$('#field').combobox('setValue', '');
            var url = 'defaultValue/findFieldByZbTable.do?tableName='+rec.value;
            $('#field').combobox('reload', url);
        }">
						</td>
					</tr>

					<tr>
						<td><label for="descr">指标字段名:</label>
						</td>
						<td><input id="field" name="field"  style="width: 350px" class="easyui-combobox" data-options="valueField:'value',required:true,textField:'name'">
						</td>
					</tr>

					<tr>
						<td><label for="beanName">预警值:</label>
						</td>
						<td><input class="easyui-validatebox" type="text"
							name="yjVal" data-options="required:false" style="width:350" />
						</td>
					</tr>
					
					<tr>
						<td><label for="beanName">预警关系:</label>
						</td>
						<td><input id="yjOpr" name="yjOpr" class="easyui-combobox" data-options="
        valueField: 'NAME',
        textField: 'NAME',
        url: 'defaultValue/findOprList.do'">
						</td>
					</tr>
					
					<tr>
						<td><label for="beanName">告警值:</label>
						</td>
						<td><input class="easyui-validatebox" type="text"
							name="gjVal" data-options="required:false" style="width:350" />
						</td>
					</tr>
					
					<tr>
						<td><label for="beanName">告警关系:</label>
						</td>
						<td><input id="gjOpr" name="gjOpr" class="easyui-combobox" data-options="
        valueField: 'NAME',
        textField: 'NAME',
        url: 'defaultValue/findOprList.do'">
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
