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
<script type="text/javascript" src="<%=basePath %>static/easyui/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>

<script type="text/javascript">
var clientHeight = document.documentElement.clientHeight;
$(function(){

	initGrid();

	initTotalGrid();
	$("#search").bind("click",doSearch);
	$("#s_reset").bind("click",resetSearchBox);
});


function resetSearchBox(){
	
	$("#s_deptId").combobox('setValue',null);
	$("#s_startTime").datebox('setValue',null);
	$("#s_endTime").datebox('setValue',null);
}

function doSearch(){
	
	var deptId = $.trim($("#s_deptId").combobox('getValue'));
	var startTime = $("#s_startTime").datebox('getValue');
	var endTime = $("#s_endTime").datebox('getValue');
	if(startTime>endTime){
		alert("开始时间不能大于结束时间");
		return ;
	}
	$("#mainGrid").datagrid("load",{
		filter:"type=1&deptId="+deptId+"&startTime="+startTime+"&endTime="+endTime
	});
	$("#totalGrid").datagrid("load",{
		filter:"type=1&deptId="+deptId+"&startTime="+startTime+"&endTime="+endTime
	});
}

function initGrid(){
	
	$('#mainGrid').datagrid({
	    url:'pxyyzk/findAll.do',
	    toolbar:"#toolbar",
	    queryParams:{
	    	filter:"type=1"
	    },
	    height:clientHeight-190,	    
	    columns:[[

	  	    {field:'deptName',title:'专业培训部',width:80},	              
	        {field:'planName',title:'培训计划',width:120},
	        {field:'project',title:'创建项目',width:40,formatter:zkFormatter,align:'center'},
	        {field:'ystj',title:'预算统计',width:40,formatter:zkFormatter,align:'center'}	, 
	        {field:'solution',title:'方案编制',width:40,formatter:zkFormatter,align:'center'},
	        {field:'mission',title:'任务书编制',width:50,formatter:zkFormatter,align:'center'},
	        {field:'bm',title:'报名管理',width:40,formatter:zkFormatter,align:'center'},
	        {field:'place',title:'地点设置',width:40,formatter:zkFormatter,align:'center'},
	        {field:'banji',title:'班级创建',width:40,formatter:zkFormatter,align:'center'},
	        {field:'fb',title:'系统分班',width:40,formatter:zkFormatter,align:'center'},
	        {field:'kcb',title:'课程表',width:30,formatter:zkFormatter,align:'center'},
	        {field:'bd',title:'学员报到',width:40,formatter:zkFormatter,align:'center'},
	        {field:'xhgl',title:'学号管理',width:40,formatter:zkFormatter,align:'center'},
	        {field:'cj',title:'成绩管理',width:40,formatter:zkFormatter,align:'center'},
	        {field:'pygl',title:'评优管理',width:40,formatter:zkFormatter,align:'center'},
	        {field:'zsgl',title:'证书管理',width:40,formatter:zkFormatter,align:'center'},
	        {field:'jsgl',title:'决算管理',width:40,formatter:zkFormatter,align:'center'},
	        {field:'zlgd',title:'资料归档',width:40,formatter:zkFormatter,align:'center'}

	    ]],
	    rownumbers:true,
	    singleSelect:false,
	    autoRowHeight:true,
		fitColumns : true,
		pageSize:20,
	    pagination:true,
	    onLoadSuccess:function(data){
			var rows = data.rows;
			var majorMergeList = new Array();
			
			var bo = null;
			dIsFirst = true;
			var dIndex = null;
			var dNum = 1;
			for(var i=0;i<rows.length;i++){
				var o = rows[i];
				if(bo==null){
					bo = o;
					continue;
				}
				
				if(o.deptName==bo.deptName){
					if(dIsFirst){
						dIndex = i>0?(i-1):0;
						dIsFirst = false;
					}
					dNum++;
				}else{
					if(!dIsFirst){
						majorMergeList.push({index:dIndex,rowspan:dNum,field:'deptName'});
					}
					dIsFirst = true;
					dNum = 1;
				}
				bo = o;
				
				if(i==rows.length-1){
					if(dNum>1){
						majorMergeList.push({index:dIndex,rowspan:dNum,field:'deptName'});
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

function initTotalGrid()
{
	$('#totalGrid').datagrid({
	    url:'pxyyzk/s_total.do',
	    fit:false,
	    queryParams:{
	    	filter:"type=1"
	    },	    
	    height:clientHeight*0.2,
	    columns:[[
	        {field:'deptName',title:'专业培训部',width:80,align:'center'},
	        {field:'project',title:'创建项目',width:40,align:'center'},
	        {field:'ystj',title:'预算统计',width:40,align:'center'},
	        {field:'solution',title:'方案编制',width:40,align:'center'},
	        {field:'mission',title:'任务书编制',width:50,align:'center'},
	        {field:'bm',title:'报名管理',width:40,align:'center'},
	        {field:'place',title:'地点设置',width:40,align:'center'},
	        {field:'banji',title:'班级创建',width:40,align:'center'},
	        {field:'fb',title:'系统分班',width:40,align:'center'},
	        {field:'kcb',title:'课程表',width:30,align:'center'},
	        {field:'bd',title:'学员报到',width:40,align:'center'},
	        {field:'xhgl',title:'学号管理',width:40,align:'center'},
	        {field:'cj',title:'成绩管理',width:40,align:'center'},
	        {field:'pygl',title:'评优管理',width:40,align:'center'},
	        {field:'zsgl',title:'证书管理',width:40,align:'center'},
	        {field:'jsgl',title:'决算管理',width:40,align:'center'},
	        {field:'zlgd',title:'资料归档',width:40,align:'center'}
	        	  
	    ]],
	    //rownumbers:true,
	    singleSelect:false,
	    autoRowHeight:true,
		fitColumns : true,    
	});	
}
function zkFormatter(val,row,index){
	
	return '<img src="static/images/yyzk'+val+'.png" width="20" />';
}
</script>
</head>

<body>

	<!-- Grid -->
	<div id="toolbar">
		<div>
			<table id="searchTable">
				
				<tr>
					<td>专业培训部：</td>
					<td><input id="s_deptId" class="easyui-combobox"  data-options="
        valueField: 'value',
        textField: 'name',
        url: 'zbDict/findByType.do?type=dept',
        onSelect: function(rec){
        },
        onLoadSuccess:function(rec){
        	
        }"></td>
					<td >开始时间：</td>
					<td><input id="s_startTime" name="s_startTime" class="easyui-datebox" data-options="editable:false,formatter:function(date){
	var y = date.getFullYear();
	var m = date.getMonth()+1;
	var d = date.getDate();
	if(m<10){m = '0'+m;}
	if(d<10){d = '0'+d;}
	return y+'-'+m+'-'+d;
}" style="width: 150px" > </td>
			        <td>结束时间：</td>
					<td><input id="s_endTime" name="s_endTime" class="easyui-datebox" data-options="editable:false,formatter:function(date){
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
	<table id="totalGrid"></table>
	
	
</body>
</html>
