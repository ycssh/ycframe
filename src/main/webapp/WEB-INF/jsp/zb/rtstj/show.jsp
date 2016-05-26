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

<title>新员工培训人天数统计</title>

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
	
});

function resetSearchBox(){
	
	$("#s_deptId").combobox('setValue',null);
	$("#s_projectId").combobox('setValue',null);
	$("#s_startTime").datebox('setValue',null);
	$("#s_endTime").datebox('setValue',null);
	
}

function doSearch(){
	
	var deptId = $.trim($("#s_deptId").combobox('getValue'));
	var projectId = $.trim($("#s_projectId").combobox('getValue'));
	var startTime = $.trim($("#s_startTime").datebox('getValue'));
	var endTime = $.trim($("#s_endTime").datebox('getValue'));
	
	$("#mainGrid").datagrid("load",{
		filter:"type=1&deptId="+deptId+"&projectId="+projectId+"&startTime="+startTime+"&endTime="+endTime
	});
//	refreshItem();
}

function initGrid(){
	
	$('#mainGrid').datagrid({
	    url:'rtstj/findAll.do',
	    toolbar:"#toolbar",
	    queryParams:{
	    	filter:"type=1"
//	    	filter:"zbname="+$.trim($("#s_zbname").val())+"&field="+$.trim($("#s_field").val())
	    },
	    columns:[[
	        {field:'projectId',title:'项目名称',width:80},
	        {field:'deptId',title:'专业培训部',width:40},
	        {field:'majorId',title:'专业名称',width:40},
	        {field:'classId',title:'班级名称',width:40},
	        {field:'perNum',title:'班级人数',width:40},
	        {field:'courseId',title:'课程名称',width:40},
	        {field:'days',title:'培训天数',width:40},
	        {field:'perDays',title:'人天数',width:40},
	        {field:'numCount',title:'专业培训部合计',width:40}
	    ]],
	    singleSelect:false,
	    autoRowHeight:true,
		fitColumns : true,
	    pagination:true,
	    pageSize:20,
	    
	    onLoadSuccess:function(data){
			var rows = data.rows;
			var majorMergeList = new Array();
			
			var bo = null;
			var mIsFirst = true,dIsFirst = true;
			var mIndex = null,dIndex = null;
			var mNum = 1,dNum = 1;
			for(var i=0;i<rows.length;i++){
				var o = rows[i];
				if(bo==null){
					bo = o;
					continue;
				}
				
				if(o.numCount==bo.numCount){
					if(mIsFirst){
						mIndex = i>0?(i-1):0;
						mIsFirst = false;
					}
					mNum++;
				}else{
					if(!mIsFirst){
						majorMergeList.push({index:mIndex,rowspan:mNum,field:'numCount'});
					}
					mIsFirst = true;
					mNum = 1;
				}
				
				bo = o;
				
				if(i==rows.length-1){
					if(mNum>1){
						majorMergeList.push({index:mIndex,rowspan:mNum,field:'numCount'});
					}
				}
				
			}
			
			for(var i=0;i<majorMergeList.length;i++){
				$(this).datagrid('mergeCells',{
                    index: majorMergeList[i].index,
                    field: majorMergeList[i].field,
                    rowspan: majorMergeList[i].rowspan
                });
			}
			
		}
	});
}

</script>
</head>

<body>

	<!-- Grid -->
	<div id="toolbar">
		<!-- <div>
			<div id="export" class="easyui-linkbutton"
			data-options="iconCls:'icon-add',plain:true">导出</div>
		</div> -->
		<div>
			<table id="searchTable">
				
				<tr>
					<td>项目名称：</td>
					<td><input id="s_projectId" name="s_projectId"  style="width: 300px" class="easyui-combobox" data-options="
        valueField: 'id',
        textField: 'name',
        url: 'project/find.do?filter=type=1',
        onSelect: function(rec){
        },
        onLoadSuccess:function(rec){
        	
        }"></td>
					<td >专业培训部：</td>
					<td><input id="s_deptId" name="s_deptId"  style="width: 150px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        url: 'zbDict/findByType.do?type=dept',
        onLoadSuccess:function(rec){
        	
        }"></td>
					
				</tr>
				<tr>
					<td >开始时间：</td>
					<td ><input id="s_startTime" name="s_startTime" class="easyui-datebox" data-options="editable:false,formatter:function(date){
	var y = date.getFullYear();
	var m = date.getMonth()+1;
	var d = date.getDate();
	if(m<10){m = '0'+m;}
	if(d<10){d = '0'+d;}
	return y+'-'+m+'-'+d;
}" style="width: 150px" > </td>
					<td >结束时间：</td>
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
	
	
</body>
</html>
