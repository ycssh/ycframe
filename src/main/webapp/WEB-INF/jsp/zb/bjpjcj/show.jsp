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

<title>新员工培训各班级平均成绩排名</title>

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
	//项目ID
	var projectId = $.trim($("#s_projectId").combobox('getValue'));
	//部门ID
	var deptId = $.trim($("#s_trainDep").combobox('getValue'));
	//专业ID
	var majorId = $.trim($("#s_majorId").combobox('getValue'));
	//成绩类型
	var scoreType = $.trim($("#s_scoreType").combobox('getValue'));
	//月份
	var month = $("#s_month").val();
	
	
	//若项目ID为空，提示请选择项目
	if(projectId == null || projectId.length==0) {
		$.messager.alert("警告信息", "请选择项目", "warning");
		return;
	}
	
	//如果是“月度成绩”或“月度综合素质成绩”导出时还需要输入具体月份，如果未输入，提示“请输入查询月份”；
	if(scoreType !=null && (scoreType == '月度成绩' || scoreType == '月度综合素质成绩') && (month ==null || month.length ==0 )){
		$.messager.alert("警告信息", "请输入查询月份", "warning");
		return;
	}
	

	
	//下载
	window.open(encodeURI(encodeURI("bjpjcj/exportExcel/projectId="+projectId+"&deptId="+ deptId + "&majorId=" + majorId + "&scoreType=" + scoreType+ "&month=" + month)));
	
	
};


function initGrid(){
	
	$('#mainGrid').datagrid({
	    url:'bjpjcj/findAll.do',
	    toolbar:"#toolbar",
	    queryParams:{
	    	filter:"type=1&scoreType=学员结业成绩"
//	    	filter:"zbname="+$.trim($("#s_zbname").val())+"&field="+$.trim($("#s_field").val())
	    },
	    columns:[[
	        {field:'projectName',title:'项目名称',width:120},
	        {field:'trainDepName',title:'管理部门',width:80},
	        {field:'majorName',title:'专业名称',width:80},
	        {field:'className',title:'班级名称',width:80},
	        {field:'month',title:'月份',width:40},
	        {field:'score',title:'平均成绩',width:40},
	        {field:'avgSort',title:'成绩排名',width:40}	       
	       
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
	
	$("#s_trainDep").combobox('setValue',null);
	$("#s_projectId").combobox('setValue',null);
	$("#s_majorId").combobox('setValue',null);
	$("#s_scoreType").combobox('setValue','学员结业成绩');
	$("#s_month").val('');
	
}

function doSearch(){
	
	var deptId = $.trim($("#s_trainDep").combobox('getValue'));
	var projectId = $.trim($("#s_projectId").combobox('getValue'));
	var majorId = $.trim($("#s_majorId").combobox('getValue'));
	var scoreType = $.trim($("#s_scoreType").combobox('getValue'));
	var month = $("#s_month").val();
	
	$("#mainGrid").datagrid("load",{
		filter:"type=1&deptId="+deptId+"&projectId="+projectId+"&majorId="+majorId+"&scoreType="+scoreType+"&month="+month
	});
//	refreshItem();
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
			        <td>成绩类型：</td>
					<td><input id="s_scoreType" name="s_scoreType"  style="width: 200px" class="easyui-combobox" data-options="editable:false,
        valueField: 'name',
        textField: 'name',
        value:'学员结业成绩',
        data:[{name:'企业文化和主营业务认知'},{name:'专业技能过程考核成绩'},{name:'技能笔试成绩'},{name:'技能操作成绩'},{name:'军训成绩'},{name:'月度综合素质成绩'},{name:'月度成绩'},{name:'学员结业成绩'}]"></td>
					<td>月份：</td>
					<td><input id="s_month" name="s_month"  class="easyui-numberspinner" 
         data-options="min:1,max:12" style="width: 100px" ></td>
					
				</tr>
				<tr>
					<td>管理部门：</td>
					<td><input id="s_trainDep" class="easyui-combobox" data-options="editable:false,valueField: 'value',textField: 'name',url: 'zbDict/findByType.do?type=dept'"></td>
					
					<td >专业名称：</td>
					<td colspan="3"><input id="s_majorId" name="s_majorId"  style="width: 150px" class="easyui-combobox" data-options="editable:false,
        valueField: 'value',
        textField: 'name',url: 'zbDict/findByType.do?type=major'"> <a id="search" href="#" class="easyui-linkbutton" iconCls="icon-search">检索</a>
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
