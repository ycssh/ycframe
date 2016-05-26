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

<title>新员工培训兼职培训师工作量排名</title>

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

<script type="text/javascript">

$(function(){

	initGrid();
	
	$("#search").bind("click",doSearch);
	$("#s_reset").bind("click",resetSearchBox);
	//导出
	  $("#export").bind("click",exportGZL);
});

function initGrid(){
	
	$('#mainGrid').datagrid({
	    url:'pxsgzl/findAllJz.do',
	    toolbar:"#toolbar",
	    queryParams:{
	    	filter:"type=1"
//	    	filter:"zbname="+$.trim($("#s_zbname").val())+"&field="+$.trim($("#s_field").val())
	    },
	    columns:[[
	        {field:'projectName',title:'项目名称',width:80},
	       
	        {field:'deptName',title:'专业培训部',width:40},
	        {field:'majorName',title:'专业名称',width:40},
	        {field:'teacherId',title:'教师姓名',width:40},
	        {field:'gzl',title:'工作量',width:40},
	        {field:'avgSort',title:'平均工作量排名',width:40}
	    ]],
	    singleSelect:false,
	    autoRowHeight:true,
		fitColumns : true,
	    pagination:true,
	    pageSize:20
	});
}

function resetSearchBox(){
	
	$("#s_deptId").combobox('setValue',null);
	$("#s_projectId").combobox('setValue',null);
	$("#s_teacherId").val('');
	
}

function doSearch(){
	
	var deptId = $.trim($("#s_deptId").combobox('getValue'));
	var projectId = $.trim($("#s_projectId").combobox('getValue'));
	var teacherId = $.trim($("#s_teacherId").val());

	if(top.specialCharacter(teacherId)){
		alert("教师姓名中包含特殊字符，请重新输入.");
		return;
	}
	$("#mainGrid").datagrid("load",{
		filter:"type=1&deptId="+deptId+"&projectId="+projectId+"&teacherId="+teacherId
	});
//	refreshItem();
}
function exportGZL(){
	var deptId = $.trim($("#s_deptId").combobox('getValue'));
	var projectId = $.trim($("#s_projectId").combobox('getValue'));
	var teacherId = $.trim($("#s_teacherId").val());

	 var filter ="type=1&deptId="+deptId+"&projectId="+projectId+"&teacherId="+teacherId;
	     filter = encodeURI(encodeURI(filter));
	 var path="pxsgzl/exportGzlJz?filter="+filter;
	 window.open(path);
}

</script>
</head>

<body>

	<!-- Grid -->
	<div id="toolbar">
		<!-- <div>
			<div id="add" class="easyui-linkbutton"
			data-options="iconCls:'icon-add',plain:true">导出</div>
		</div> -->
		<div>
			<table id="searchTable">
				
				<tr>
				
					<td >项目名称：</td>
					<td><input id="s_projectId" class="easyui-combobox" style="width: 350px" data-options="editable:false,valueField: 'id',textField: 'name',
					onSelect: function(rec){
			        	
			        }"> </td>
						<td>专业培训部：</td>
					<td><input id="s_deptId" class="easyui-combobox" data-options="editable:false,valueField: 'value',textField: 'name'"></td>
				</tr>
				<tr>
					<td >教师姓名：</td>
					<td colspan="3"><input id="s_teacherId" name="s_teacherId" class="easyui-validatebox"  style="width: 350px" > <a id="search" href="#" class="easyui-linkbutton" iconCls="icon-search">检索</a>
					<a id="s_reset" href="#" class="easyui-linkbutton" iconCls="icon-reset">重置</a>
					<a id="export" href="#" class="easyui-linkbutton" iconCls="icon-template" >导出</a></td>
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
        url: 'project/find.do?filter=type=1',
        onSelect: function(rec){
        },
        onLoadSuccess:function(rec){
        	$('#s_'+this.id).combobox('loadData',rec);
        }">
						</td>
					</tr>
					
				
					
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
						<td><label for="name">专业名称:</label>
						</td>
						<td><input id="majorId" name="majorId"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        required:true,
        url: 'zbDict/findByType.do?type=major',
        onLoadSuccess:function(rec){
        	
        }">
						</td>
					</tr>
					
					<tr>
						<td><label for="name">教师类型:</label>
						</td>
						<td><input id="teacherTypeId" name="teacherTypeId"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'name',
        textField: 'name',
        data:[{name:'专职培训师'},{name:'兼职培训师'}]">
						</td>
					</tr>
					
					<tr>
						<td><label for="name">教师姓名:</label>
						</td>
						<td><input id="teacherId" name="teacherId" class="easyui-validatebox" data-options="required:true" style="width: 350px" >
						</td>
					</tr>
					
					<tr>
						<td><label for="name">工作量:</label>
						</td>
						<td><input id="gzl" name="gzl" required="required" class="easyui-numberspinner" 
         data-options="min:0,precision:1" style="width: 350px" ></td>
					</tr>
						<tr>
						<td><label for="name">平均工作量排名:</label>
						</td>
						<td><input id="avgSort" name="avgSort" required="required" class="easyui-numberspinner" 
         data-options="min:1" style="width: 350px" ></td>
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
