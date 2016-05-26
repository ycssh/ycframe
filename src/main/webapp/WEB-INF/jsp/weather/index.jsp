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

<title>气象环境维护</title>

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
<script type="text/javascript" src="<%=basePath %>static/js/system.js" charset="utf-8"></script>


<script type="text/javascript">

$(function(){

	initGrid();
	initForm();
	$("#search").bind("click",doSearch);
	$("#s_reset").bind("click",resetSearchBox);
	$("#add").bind("click",addItem);
	$("#edit").bind("click",editItem);
	$("#delete").bind("click",deleteItem);	
	$("#save").bind("click",saveItem);
	$("#reset").bind("click",resetForm);
	$("#template").bind("click",template);
	$("#import").bind("click",importItem);	
});

function initGrid(){
	
	$('#mainGrid').datagrid({
	    url:'weather/findAll.do',
	    toolbar:"#toolbar",
	    queryParams:{
	    	filter:"type=1"
	    },
	    columns:[[
			{field:'id',title:'编号',checkbox:true,width:40,align:'center'},
			{field:'campus',title:'地点',width:40,align:'center'},
	        {field:'weatherTime',title:'日期',width:40,align:'center'},
	        {field:'weatherType',title:'天气现象',width:40,align:'center'},
	        {field:'temperature',title:'温度',width:40,align:'center'},
	        {field:'windDirection',title:'风向',width:40,align:'center'},
	        {field:'windPower',title:'风力',width:40,align:'center'},
	        {field:'weatherQuality',title:'质量状况',width:40,align:'center'},
	        {field:'pm',title:'PM2.5',width:40,align:'center'}
	    ]],
	    singleSelect:false,
	    autoRowHeight:true,
		fitColumns : true,
	    pagination:true,
	    pageSize:10
	});
}


function initForm(){
	
	$('#form').form({
		url : "weather/save.do",
		onSubmit : function(param) {
			var isValid = $(this).form('validate');
			if (!isValid) {
				$.messager.progress('close'); // hide progress bar while the
												// form is invalid
			}
			return isValid; // return false will stop the form submission
		},
		success : function(data) {
			// alert(data)

			var data = eval('(' + data + ')'); 
												
			if (data.success) {
				alert('保存成功！');

				$("#window").window('close');
				
				refreshItem();
			} else {
				alert(data.msg);
			}
		}
	});
	
}


function doSearch(){
	
	var weatherStartTime = $.trim($("#weatherStartTime").datebox('getValue'));
	var weatherEndTime = $.trim($("#weatherEndTime").datebox('getValue'));
	var campus = $("#campus").combobox('getText');

	if(weatherStartTime!=""&&weatherEndTime!=""){
		var arr1 = weatherStartTime.split("-");
		var starttime = new Date(arr1[0], arr1[1], arr1[2]);
		var arr2 = weatherEndTime.split("-");
		var endtime = new Date(arr2[0], arr2[1], arr2[2]);
		 if (starttime > endtime) {
			 alert("开始时间不能大于结束时间")
	         return false;
	     }
	}
	$("#mainGrid").datagrid("load",{
		filter:"weatherStartTime="+weatherStartTime+"&weatherEndTime="+weatherEndTime+"&campus="+campus
	});
}

function resetSearchBox(){
	
	$("#weatherStartTime").datebox('setValue',null);
	$("#weatherEndTime").datebox('setValue',null);
	$("#weatherType").combobox('setValue',null);
	$("#campus").combobox('setValue',null);
	
}

function saveItem(){
	$('#form').submit();
}

function resetForm(){
	
	var id = $("#id").val();
	$('#form').form('reset');
	
	if(id&&id.length>0){
		var r = $("#mainGrid").datagrid('getChecked');
		
		if(r&&r.length==1){
			$("#form").form('load',r[0]);
			
			//$("#cpsjDesc").datebox('setValue',formatDate(new Date(r[0].cpsj)));
		}
	}
}

function addItem(){
	
	showWindow("新增");
}

function editItem(){
	
	var r = $("#mainGrid").datagrid('getChecked');
	if(!r||r.length==0){
		alert('请选择待修改的信息！');
		return;
	}
	if(r.length!=1){
		alert('请选择一条待修改的信息！');
		return;
	}
	/*if(r[0].isBL!="1"){
		alert("非补录数据不允许编辑！");
		return;
	}*/
	
	showWindow("修改信息");
	$("#form").form('load',r[0]);
	//$("#cpsjDesc").datebox('setValue',formatDate(new Date(r[0].cpsj)));
}

function deleteItem(){
	
	
	var r = $("#mainGrid").datagrid('getChecked');
	if(!r||r.length==0){
		alert('请选择待删除的记录！');
		return;
	}
	if(!confirm('你确定要删除选中的记录吗?')){
		return;
	}
	
	var ids = new Array();
	for(var i=0;i<r.length;i++){
		/*if(r[i].isBL!="1"){
			alert("非补录数据不允许删除，请取消选择非补录数据！");
			return;
		}*/
		ids.push(r[i].id);
	}
	
	$.post('weather/delete.do',{ids:ids.join(',')},function(data){
		
		//var data = eval('(' + data + ')'); // change the JSON string to
		// javascript object
		if (data.success) {
			alert('删除成功！');

			refreshItem();
		} else {
			alert(data.msg);
		}
	},"JSON");
	$("#mainGrid").datagrid('reload');
}
function template()
{
	window.location.href='<%=basePath%>template/download/weather';
}

function importItem(){
	easyui.dialog({
	    title: '数据导入',
	    width: 600,
	    height: 450,
	    closed: false,
	    cache: false,
	    href: '<%=basePath %>upload/index/weather',
	    modal: true
	});
}

function refreshItem(){
	
	$("#mainGrid").datagrid('reload');
}
function showWindow(title){
	
	$("#window").window({
		title : title || "新增",
		width : 800,
		height : 400,
		modal : true
	}).show();
	
	$('#form').form('reset');
}
</script>
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
			<div id="template" class="easyui-linkbutton"
				data-options="iconCls:'icon-template',plain:true">模板下载</div>
			<div id="import" class="easyui-linkbutton"
				data-options="iconCls:'icon-import',plain:true">导入</div>				
			
		</div>	
		<div>
			<table id="searchTable">
				<tr>
					<td>地点：</td>
					<td><input id="campus" name="campus"  style="width: 200px;height:auto;" class="easyui-combobox" data-options="editable:false,
				        valueField: 'name',
				        textField: 'name',
				        data: [{name:'济南'},{name:'泰安'}]
				        "></td>
        <td >开始时间：</td>
					<td ><input id="weatherStartTime" name="weatherStartTime" class="easyui-datebox" data-options="editable:false,formatter:function(date){
	var y = date.getFullYear();
	var m = date.getMonth()+1;
	var d = date.getDate();
	if(m<10){m = '0'+m;}
	if(d<10){d = '0'+d;}
	return y+'-'+m+'-'+d;
}" style="width: 150px" > </td>
					<td >结束时间：</td>
					<td ><input id="weatherEndTime" name="weatherEndTime" class="easyui-datebox" data-options="editable:false,formatter:function(date){
	var y = date.getFullYear();
	var m = date.getMonth()+1;
	var d = date.getDate();
	if(m<10){m = '0'+m;}
	if(d<10){d = '0'+d;}
	return y+'-'+m+'-'+d;
}" style="width: 150px" >
         <a id="search" class="easyui-linkbutton"
			iconCls="icon-search" >检索</a> <a id="s_reset" href="#" class="easyui-linkbutton" iconCls="icon-reset">重置</a></td>
					
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
			<fieldset style="margin-top: 10px">
				<legend>信息</legend>
				<table width="100%">
				
					<tr>
					<td>日期：</td>
					<td ><input id="weatherTime1" name="weatherTime1" class="easyui-datebox" data-options="required:true,editable:false,formatter:function(date){
						var y = date.getFullYear();
						var m = date.getMonth()+1;
						var d = date.getDate();
						if(m<10){m = '0'+m;}
						if(d<10){d = '0'+d;}
						return y+'-'+m+'-'+d;
					}" style="width: 150px" > </td>
					</tr>
					
					<tr>
					<td>地点：</td>
					<td><input id="campus" name="campus"  style="width: 200px;height:auto;" class="easyui-combobox" data-options="editable:false,
						required:true,
				        valueField: 'name',
				        textField: 'name',
				        data: [{name:'济南'},{name:'泰安'}]
				        ">
				    </td>
					</tr>					
					
					<tr>
					<td>天气现象：</td>
					<td><input id="weatherType" name="weatherType"  style="width: 200px;height:auto;" class="easyui-combobox" data-options="editable:false,
				        required:true,
				        valueField: 'name',
				        textField: 'name',
				        url: 'zbDict/findByType.do?type=weather',
				        onLoadSuccess:function(rec){
				        	$('#s_'+this.id).combobox('loadData',rec);
				        }">
				    </td>
					</tr>
					
					<tr>
						<td>温度:
						</td>
						<td><input maxlength="20" id="temperature" name="temperature" style="width: 100px" class="easyui-validatebox" data-options="required:true">
						</td>
					</tr>
					
					<tr>
						<td>风向:
						</td>
						<td><input maxlength="20" id="windDirection" name="windDirection" style="width: 100px" class="easyui-validatebox" data-options="required:true">
						</td>
					</tr>
					
					<tr>
						<td>风力:
						</td>
						<td><input maxlength="20" id="windPower" name="windPower" style="width: 100px" class="easyui-validatebox" data-options="required:true">
						</td>
					</tr>
					
					<tr>
						<td>空气质量:
						</td>
						<td><input maxlength="20" id="weatherQuality" name="weatherQuality" style="width: 100px" class="easyui-validatebox" data-options="required:true">
						</td>
					</tr>
					
					<tr>
						<td>PM2.5:
						</td>
						<td><input maxlength="20" id="pm" name="pm" style="width: 100px" class="easyui-validatebox" data-options="required:true">
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
