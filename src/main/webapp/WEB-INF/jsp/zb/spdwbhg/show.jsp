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

<title>新员工培训各送培单位学员不合格率排名</title>

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
	
	
	//导出按钮
	$("#s_export").bind("click",exportFunction);
});


//点击导出操作
var exportFunction = function(){

	var projectId = $.trim($("#s_projectId").combobox('getValue'));
	var companyId = $.trim($("#s_companyId").combobox('getValue'));
	
	
	//项目和培训地点不可以都为空
	if( (projectId == null || projectId.length==0) && (companyId == null || companyId.length==0) ) {
		$.messager.alert("警告信息", "请选择项目或培训地点", "warning");
		return;
	}
	
	
	//下载
	window.open(encodeURI(encodeURI("spdwbhg/exportExcel/projectId="+projectId+"&companyId="+ companyId)));
	
};


function initGrid(){
	
	$('#mainGrid').datagrid({
	    url:'spdwbhg/findAll.do',
	    toolbar:"#toolbar",
	    queryParams:{
	    	filter:"type=1"
	    },
	    columns:[[
	        {field:'projectName',title:'项目名称',width:120},
	      
	        {field:'companyName',title:'送培单位',width:80},
	        {field:'perNum',title:'送培人数',width:40},
	        {field:'bhgNum',title:'不合格人数',width:40},
	        {field:'pct',title:'不合格率（%）',width:40},
	        {field:'avgSort',title:'学员不合格率排名',width:40}
	       
	    ]],
	    rownumbers:true,
	    singleSelect:false,
	    pageSize:20,
	    autoRowHeight:true,
		fitColumns : true,
	    pagination:true
	});
}

function resetSearchBox(){
	
	$("#s_projectId").combobox('setValue',null);
	$("#s_companyId").combobox('setValue',null);
	
}

function doSearch(){
	
	var projectId = $.trim($("#s_projectId").combobox('getValue'));
	var companyId = $.trim($("#s_companyId").combobox('getValue'));
	
	$("#mainGrid").datagrid("load",{
		filter:"type=1&projectId="+projectId+"&companyId="+companyId
	});
}

</script>
</head>

<body>

	<!-- Grid -->
	<div id="toolbar">
		<!-- <div>
			<div id="export" class="easyui-linkbutton"
			data-options="iconCls:'icon-ok',plain:true">导出</div>
		</div> -->
		<div>
			<table id="searchTable">
				
				<tr>
					<td >项目名称：</td>
					<td><input id="s_projectId" class="easyui-combobox" style="width: 350px" data-options="editable:false,valueField: 'id',textField: 'name',
					url: 'project/find.do?filter=type=1',
					onSelect: function(rec){
			        	
			        }"> </td>
					<td >送培单位：</td>
					<td colspan="5"><input id="s_companyId" name="s_companyId"  style="width: 350px" class="easyui-combobox" data-options="editable:false,
        valueField: 'value',
        textField: 'name',
        url: 'zbDict/findByType.do?type=company'"> <a id="search" href="#" class="easyui-linkbutton" iconCls="icon-search">检索</a>
					<a id="s_reset" href="#" class="easyui-linkbutton" iconCls="icon-reset">重置</a>
					
					<a id="s_export" href="#" class="easyui-linkbutton" iconCls="icon-template">导出</a>				
					
					</td>
				</tr>
			</table>
			
		</div>
		
	</div>
	<table id="mainGrid"></table>
	
	
</body>
</html>
