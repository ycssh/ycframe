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

<title>月度计划流程监测</title>

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
<link rel="stylesheet" type="text/css" href="<%=basePath %>static/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath %>static/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=basePath %>static/new/stylesheets/approval.css">
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
	$("#ywcnum").bind("click",function(){
		$("#wcqk").val("ywc");
		totalSearch();
	});
	$("#wwcnum").bind("click",function(){
		$("#wcqk").val("wwc");
		totalSearch();
	});
	searchNum();
});
function searchNum(){
	$.post("<%=basePath%>approvalcontent/mission/counts",{
		filter:"counts="+$.trim($("#jd").combobox('getValue'))+"&type=mission&deptId="+$.trim($("#s_deptId").combobox('getValue'))+"&startTime="+$.trim($("#startTime").datebox('getValue'))+"&endTime="+$.trim($("#endTime").datebox('getValue'))
	},function(data){
		$("#ywcnum").text(data.ywc);
		$("#wwcnum").text(data.wwc);
	},"json");
}

function resetSearchBox(){
	$("#s_deptId").combobox('setValue',null);
	$("#startTime").datebox('setValue',null);
	$("#endTime").datebox('setValue',null);
}

function doSearch(){
	var deptId = $.trim($("#s_deptId").combobox('getValue'));

	var startTime = $.trim($("#startTime").datebox('getValue'));
	var endTime = $.trim($("#endTime").datebox('getValue'));

	if(startTime!=""&&endTime!=""){
		var arr1 = startTime.split("-");
		var starttimes = new Date(arr1[0], arr1[1], arr1[2]);
		var arr2 = endTime.split("-");
		var endtimes = new Date(arr2[0], arr2[1], arr2[2]);
		 if (starttimes > endtimes) {
			 alert("开始时间不能大于结束时间")
	         return false;
	     }
	}
	$("#mainGrid").datagrid("load",{
		filter:"type=mission&deptId="+deptId+"&startTime="+startTime+"&endTime="+endTime
	});
	totalSearch();
}
function totalSearch(){
	searchNum();
	$("#totalGrid").datagrid("load",{
    	filter:"wcqk="+$("#wcqk").val()+"&counts="+$.trim($("#jd").combobox('getValue'))+"&type=mission&deptId="+$.trim($("#s_deptId").combobox('getValue'))+"&startTime="+$.trim($("#startTime").datebox('getValue'))+"&endTime="+$.trim($("#endTime").datebox('getValue'))
	});
}

function initGrid(){
	$('#mainGrid').datagrid({
	    url:'approvalcontent/mission/select',
	    toolbar:"#toolbar",
	    fit:false,
	    height:(clientHeight-68)*0.6,
	    queryParams:{
			filter:"type=mission"
	    },
	    columns:[[
	        {field:'deptName',title:'专业培训部',width:80},
	        {field:'planName',title:'计划名称',width:100},
	        {field:'jd1',title:'专业组长',width:50,formatter:zkFormatter,align:'center'},
	        {field:'jd2',title:'专业培训部处长',width:50,formatter:zkFormatter,align:'center'},
	        {field:'jd3',title:'综合服务中心',width:50,formatter:zkFormatter,align:'center'},
	        {field:'jd4',title:'专业培训部主任',width:50,formatter:zkFormatter,align:'center'},
	        {field:'jd5',title:'培训教务部专责',width:50,formatter:zkFormatter,align:'center'},
	        {field:'jd6',title:'培训教务部处长',width:50,formatter:zkFormatter,align:'center'},
	        {field:'jd7',title:'培训教务部副主任',width:50,formatter:zkFormatter,align:'center'},
	        {field:'jd8',title:'培训教务部主任',width:50,formatter:zkFormatter,align:'center'},
	        {field:'jd9',title:'院领导',width:50,formatter:zkFormatter,align:'center'}
	    ]],
	    rownumbers:true,
	    singleSelect:true,
	    autoRowHeight:true,
		fitColumns : true,
		pageSize:20,
	    pagination:true,
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
	    url:'approvalcontent/mission/detail',
	    fit:false,
	    height:(clientHeight-68)*0.4,
	    queryParams:{
	    	filter:"wcqk="+$("#wcqk").val()+"&counts="+$.trim($("#jd").combobox('getValue'))+"&type=mission&deptId="+$.trim($("#s_deptId").combobox('getValue'))+"&startTime="+$.trim($("#startTime").datebox('getValue'))+"&endTime="+$.trim($("#endTime").datebox('getValue'))
	    },
	    columns:[[
	        {field:'planYear',title:'年份',width:30,align:'center'},
	        {field:'planMonth',title:'月份',width:30,align:'center'},
	        {field:'id',title:'月度计划编号',width:50,align:'center'},
	        {field:'tag',title:'公司标志',width:50,align:'center'},
	        {field:'manageDept',title:'承办部门',width:50,align:'center'},
	        {field:'planSource',title:'计划来源',width:50,align:'center'},
	        {field:'trainName',title:'培训班名称',width:125,align:'center'},
	        {field:'trainPernum',title:'培训人数',width:30,align:'center'},
	        {field:'trainDays',title:'培训天数',width:30,align:'center'},
	        {field:'trainTime',title:'开始时间',width:50,align:'center',formatter: function(value,row,index){
                var time = new Date(value);  
                var month = time.getMonth()+1;
                var day = time.getDate()<=9?'0'+time.getDate():time.getDate();
                return time.getFullYear()+"-"+(month<=9?'0'+month:month)+"-"+day;
			}},
	        {field:'trainEndtime',title:'结束时间',width:50,align:'center',formatter: function(value,row,index){
                var time = new Date(value);  
                var month = time.getMonth()+1;
                var day = time.getDate()<=9?'0'+time.getDate():time.getDate();
                return time.getFullYear()+"-"+(month<=9?'0'+month:month)+"-"+day;
			}},
	        {field:'campus',title:'培训地点',width:50,align:'center'}
	    ]],
	    rownumbers:true,
	    singleSelect:true,
	    autoRowHeight:true,
		fitColumns : true,
		pageSize:20,
	    pagination:true,
		fitColumns : true	
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
					<td><input id="s_deptId" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        url: 'zbDict/findByType.do?type=dept',
        onLoadSuccess:function(rec){
        }" ></td>
        <td >开始时间：</td>
					<td ><input id="startTime" name="startTime" class="easyui-datebox" data-options="editable:false,formatter:function(date){
	var y = date.getFullYear();
	var m = date.getMonth()+1;
	var d = date.getDate();
	if(m<10){m = '0'+m;}
	if(d<10){d = '0'+d;}
	return y+'-'+m+'-'+d;
}" style="width: 150px" > </td>
					<td >结束时间：</td>
					<td ><input id="endTime" name="endTime" class="easyui-datebox" data-options="editable:false,formatter:function(date){
	var y = date.getFullYear();
	var m = date.getMonth()+1;
	var d = date.getDate();
	if(m<10){m = '0'+m;}
	if(d<10){d = '0'+d;}
	return y+'-'+m+'-'+d;
}" style="width: 150px" ><a id="search" href="#" class="easyui-linkbutton" iconCls="icon-search">检索</a>
					<a id="s_reset" href="#" class="easyui-linkbutton" iconCls="icon-reset">重置</a></td>
					
				</tr>
			</table>
			
		</div>
		
	</div>
	<table id="mainGrid"></table>
	<div>
		<div class="col-xs-12 approval" style="padding: 0;padding-top: 5px;padding-bottom: 5px;">
			<div class="col-xs-4" style="line-height: 42px">
				<span style="font-size: 14px;">流程节点：</span>
				<select id="jd" class="easyui-combobox" data-options="editable:false,onSelect:function(value){
                totalSearch();
            	}" name="jd" style="width:200px;">  
				    <option value="1">专业组长</option>  
				    <option value="2">专业培训部处长</option>  
				    <option value="3">综合服务中心</option>  
				    <option value="4">专业培训部主任</option>  
				    <option value="5">培训教务部专责</option>  
				    <option value="6">培训教务部处长</option>  
				    <option value="7">培训教务部副主任</option>  
				    <option value="8">培训教务部主任</option>  
				    <option value="9">院领导</option>  
				</select>  
			</div>
			<div class="col-xs-2">
	             <div class="tagImg icons-yiwancheng"></div>
	             <p class="tagName">已完成</p>
	             <p class="tagNum" id="ywcnum">6</p>
	         </div>
			<div class="col-xs-2">
	             <div class="tagImg icons-weiwancheng"></div>
	             <p class="tagName">未完成</p>
	             <p class="tagNum" id="wwcnum">6</p>
	         </div>
	         <input type="hidden" value="ywc" id="wcqk">
	</div>
	<div class="col-xs-12" style="padding: 0">
	<table id="totalGrid"></table>
	</div>
	 </div>
	
</body>
</html>
