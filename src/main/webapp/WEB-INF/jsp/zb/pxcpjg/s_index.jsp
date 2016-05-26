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

<title>短训班/团青培训测评结果监测</title>

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

<script type="text/javascript" src="<%=basePath %>static/service/s_pxcpjg.js"></script>

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
					<td>专业培训部：</td>
					<td><input id="s_deptId" class="easyui-combobox" data-options="valueField: 'value',textField: 'name'"></td>
					<td >项目：</td>
					<td width="350px"><input id="s_projectId" class="easyui-combobox" style="width: 350px" data-options="valueField: 'id',textField: 'name',
					onSelect: function(rec){
			        	
			        }"></td>
				</tr>
				<tr>
					<td>班级：</td>
					<td colspan="3"><input id="s_classId" class="easyui-combobox" data-options="valueField: 'id',textField: 'name'">
					<a id="search" href="#" class="easyui-linkbutton" iconCls="icon-search">检索</a>
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
				style="width:350;display: none;" value="2" />

			<fieldset style="margin-top: 10px">
				<legend>短训班/团青培训测评结果变化曲线信息</legend>
				<table width="100%">
					<tr>
						<td><label for="name">专业培训部:</label>
						</td>
						<td><input id="deptId" name="deptId"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        required:true,
        url: 'zbDict/findByType.do?type=dept',
        onLoadSuccess:function(rec){
        	$('#s_'+this.id).combobox('loadData',rec);
        }">
						</td>
					</tr>

					<tr>
						<td><label for="name">项目:</label>
						</td>
						<td><input id="projectId" name="projectId"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'id',
        textField: 'name',
        required:true,
        url: 'project/find.do?filter=type=2',
        onSelect: function(rec){
        	$('#classId').combobox('setValue', '');
            var url = 'class/find.do?filter=projectId='+rec.id;
            $('#classId').combobox('reload', url);
        },
        onLoadSuccess:function(rec){
        	$('#s_'+this.id).combobox('loadData',rec);
        }">
						</td>
					</tr>
					
					<!-- <tr>
						<td><label for="name">专业:</label>
						</td>
						<td><input id="majorId" name="majorId"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        required:true,
        url: 'zbDict/findByType.do?type=major',
        onLoadSuccess:function(rec){
        	$('#s_'+this.id).combobox('loadData',rec);
        }">
						</td>
					</tr> -->
					
					<tr>
						<td><label for="name">班级:</label>
						</td>
						<td><input id="classId" name="classId"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'id',
        textField: 'name',
        required:true,
        url: 'class/find.do',
        onLoadSuccess:function(rec){
        	$('#s_'+this.id).combobox('loadData',rec);
        }">
						</td>
					</tr>
					
					<tr>
						<td><label for="name">测评时间:</label>
						</td>
						<td><input class="easyui-datebox" required="required" id="cpsjDesc" name="cpsjDesc" 
        data-options="formatter:function(date){
        	var y = date.getFullYear();
			var m = date.getMonth()+1;
			m = m<10?'0'+m:m;
			var d = date.getDate();
			d = d<10?'0'+d:d;
			return y+'-'+m+'-'+d;
        }"  style="width: 350px">
						</td>
					</tr>
					
					<tr>
						<td><label for="name">培训质量评价（短训班/团青培训）满意率:</label>
						</td>
						<td><input id="pxzlpj" name="pxzlpj" required="required" class="easyui-numberspinner" 
         data-options="min:0,max:100,precision:2" style="width: 350px" >（%）</td>
					</tr>
					<tr>
						<td><label for="name">综合服务评价（教学服务）（短训班/团青培训）满意率:</label>
						</td>
						<td><input id="jxfw" name="jxfw" required="required" class="easyui-numberspinner" 
         data-options="min:0,max:100,precision:2" style="width: 350px" >（%）</td>
					</tr>
					<tr>
						<td><label for="name">综合服务评价（后勤）（短训班/团青培训）满意率:</label>
						</td>
						<td><input id="zhfwpj" name="zhfwpj" required="required" class="easyui-numberspinner" 
         data-options="min:0,max:100,precision:2" style="width: 350px" >（%）</td>
					</tr>
					<tr>
						<td><label for="name">总体评价（短训班/团青培训）满意率:</label>
						</td>
						<td><input id="ztpj" name="ztpj" required="required" class="easyui-numberspinner" 
         data-options="min:0,max:100,precision:2" style="width: 350px" >（%）</td>
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
