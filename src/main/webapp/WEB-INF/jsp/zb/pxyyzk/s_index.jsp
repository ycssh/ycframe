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

<title>短训班培训运营状况监测</title>

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

<script type="text/javascript" src="<%=basePath %>static/service/s_pxyyzk.js"></script>

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
					<td >开始时间：</td>
					<td><input id="s_startTime" name="s_startTime" class="easyui-datebox" data-options="formatter:function(date){
	var y = date.getFullYear();
	var m = date.getMonth()+1;
	var d = date.getDate();
	if(m<10){m = '0'+m;}
	if(d<10){d = '0'+d;}
	return y+'-'+m+'-'+d;
}" style="width: 150px" > </td>
			        <td>结束时间：</td>
					<td><input id="s_endTime" name="s_endTime" class="easyui-datebox" data-options="formatter:function(date){
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
						<td><label for="name">专业培训部:</label>
						</td>
						<td><input id="deptId" name="manageDep"  style="width: 350px" class="easyui-combobox" data-options="
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
						<td><label for="name">培训计划:</label>
						</td>
						<td><input id="planId" name="planId"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'id',
        textField: 'trainName',
        required:true,
        url: 'monthplan/find.do?filter=type=2',
        onSelect: function(rec){
        },
        onLoadSuccess:function(rec){
        	
        }">
						</td>
					</tr>
					
					<tr>
						<td><label for="name">创建项目:</label>
						</td>
						<td><input id="project" name="project"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        required:true,
        data:[{value:1,name:'已完成'},{value:2,name:'预警'},{value:3,name:'告警'},{value:4,name:'未开始'}]"></td>
					</tr>
					
					
					<tr>
						<td><label for="name">培训方案编制:</label>
						</td>
						<td><input id="solution" name="solution"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        required:true,
        data:[{value:1,name:'已完成'},{value:2,name:'预警'},{value:3,name:'告警'},{value:4,name:'未开始'}]"></td>
					</tr>
					
					<tr>
						<td><label for="name">培训任务书编制:</label>
						</td>
						<td><input id="mission" name="mission"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        required:true,
        data:[{value:1,name:'已完成'},{value:2,name:'预警'},{value:3,name:'告警'},{value:4,name:'未开始'}]"></td>
					</tr>
					
					<tr>
						<td><label for="name">报名人员信息管理:</label>
						</td>
						<td><input id="bm" name="bm"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        required:true,
        data:[{value:1,name:'已完成'},{value:2,name:'预警'},{value:3,name:'告警'},{value:4,name:'未开始'}]"></td>
					</tr>

					<tr>
						<td><label for="name">系统分班:</label>
						</td>
						<td><input id="fb" name="fb"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        required:true,
        data:[{value:1,name:'已完成'},{value:2,name:'预警'},{value:3,name:'告警'},{value:4,name:'未开始'}]"></td>
					</tr>
					
					<tr>
						<td><label for="name">课程表编制:</label>
						</td>
						<td><input id="kcb" name="kcb"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        required:true,
        data:[{value:1,name:'已完成'},{value:2,name:'预警'},{value:3,name:'告警'},{value:4,name:'未开始'}]"></td>
					</tr>
					
					<tr>
						<td><label for="name">学员报到:</label>
						</td>
						<td><input id="bd" name="bd"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        required:true,
        data:[{value:1,name:'已完成'},{value:2,name:'预警'},{value:3,name:'告警'},{value:4,name:'未开始'}]"></td>
					</tr>
					
					<tr>
						<td><label for="name">成绩报送:</label>
						</td>
						<td><input id="cj" name="cj"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        required:true,
        data:[{value:1,name:'已完成'},{value:2,name:'预警'},{value:3,name:'告警'},{value:4,name:'未开始'}]"></td>
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
