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

<title>新员工培训工作量统计</title>

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
	
	$("#s_search").bind("click",doSearch);

	$("#s_reset").bind("click",resetSearchBox);
	
	//导出
	  $("#export").bind("click",exportGZL);
});


function initGrid(){
	
	$('#mainGrid').datagrid({
	    url:'gzltj/findAll.do',
	    toolbar:"#toolbar",
	    queryParams:{
	    	filter:"type=1"
//	    	filter:"zbname="+$.trim($("#s_zbname").val())+"&field="+$.trim($("#s_field").val())
	    },
	    columns:[[
	        {field:'projectName',title:'项目名称',width:80},
	        {field:'deptName',title:'专业培训部',width:40},
	        {field:'majorName',title:'专业名称',width:40},
	        {field:'teacherTypeId',title:'教师类型',width:40},
	        {field:'teacherId',title:'教师姓名',width:40},
	        {field:'courseId',title:'课程类型',width:40},
	        {field:'gzl',title:'工作量',width:40}
	    ]],
	    singleSelect:false,
	    autoRowHeight:true,
		fitColumns : true,
	    pagination:true,
	    pageSize:20
	});
}

function doSearch(){
	
	var projectId = $.trim($("#s_projectId").combobox('getValue'));
	var deptId = $.trim($("#s_deptId").combobox('getValue'));
	var teacherTypeId = $.trim($("#s_teacherTypeId").combobox('getValue'));
	var teacherId = $.trim($("#s_teacherId").val());
	var courseId = $.trim($("#s_courseId").combobox('getValue'));
	if(top.specialCharacter(teacherId))
	{
		alert("教师姓名中包含特殊字符，请重新输入.");
		return;
	}
	$("#mainGrid").datagrid("load",{
		filter:"type=1&deptId="+deptId+"&projectId="+projectId+"&teacherTypeId="+teacherTypeId+"&teacherId="+teacherId+"&courseId="+courseId
	});
}

function exportGZL(){
	var projectId = $.trim($("#s_projectId").combobox('getValue'));
	var deptId = $.trim($("#s_deptId").combobox('getValue'));
	var teacherTypeId = $.trim($("#s_teacherTypeId").combobox('getValue'));
	var teacherId = $.trim($("#s_teacherId").val());
	var courseId = $.trim($("#s_courseId").combobox('getValue'));
	
	 var filter ="type=1&deptId="+deptId+"&projectId="+projectId+"&teacherTypeId="+teacherTypeId+"&teacherId="+teacherId+"&courseId="+courseId;
	     filter = encodeURI(encodeURI(filter));
	 var path="gzltj/exportGzl?filter="+filter;
	 window.open(path);
}

function resetSearchBox(){
	
	$("#s_projectId").combobox('setValue',null);
	$("#s_deptId").combobox('setValue',null);
	$("#s_teacherTypeId").combobox('setValue',null);
	$("#s_teacherId").val("");
	$("#s_courseId").combobox('setValue',null);
	
}


</script>
</head>

<body>

	<!-- Grid -->
	<div id="toolbar">
		<div>
			<table id="searchTable">
				<tr>
					<td>项目名称：</td>
					<td><input id="s_projectId" name="s_projectId"  style="width: 250px" class="easyui-combobox" data-options="editable:false,
        valueField: 'id',
        textField: 'name',
        url: 'project/find.do?filter=type=1',
        onSelect: function(rec){
        },
        onLoadSuccess:function(rec){
        	$('#s_'+this.id).combobox('loadData',rec);
        }">
					<td>专业培训部：</td>
					<td><input id="s_deptId" name="s_deptId"  style="width: 250px" class="easyui-combobox" data-options="editable:false,
        valueField: 'value',
        textField: 'name',
        url: 'zbDict/findByType.do?type=dept',
        onLoadSuccess:function(rec){
        	$('#s_'+this.id).combobox('loadData',rec);
        }"></td>
					<td >教师类型：</td>
					<td width="350px"><input id="s_teacherTypeId" name="s_teacherTypeId"  style="width: 250px" class="easyui-combobox" data-options="editable:false,
        valueField: 'name',
        textField: 'name',
        data:[{name:'专职培训师'},{name:'兼职培训师'}]"></td>
				</tr>
				<tr>
					<td>教师姓名：</td>
					<td><input id="s_teacherId" name="s_teacherId" class="easyui-validatebox" style="width: 250px" ></td>
					<td>课程类型：</td>
					<td colspan="3"><input id="s_courseId" name="s_courseId"  style="width: 350px" class="easyui-combobox" data-options="editable:false,
        valueField: 'name',
        textField: 'name',
        data:[{name:'理论'},{name:'实训'}],
        onLoadSuccess:function(rec){
        }"> <a id="s_search" href="#" class="easyui-linkbutton" iconCls="icon-search">检索</a>
					<a id="s_reset" href="#" class="easyui-linkbutton" iconCls="icon-reset">重置</a>
					<a id="export" href="#" class="easyui-linkbutton" iconCls="icon-template">导出</a>					
					</td>
				</tr>
			</table>
			
		</div>
		
	</div>
	<table id="mainGrid"></table>
	
	
</body>
</html>
