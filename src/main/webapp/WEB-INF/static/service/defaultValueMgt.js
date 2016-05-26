$(function(){
	
	initComponent();
	
	$("#add").bind("click",addItem);
	$("#edit").bind("click",editItem);
	$("#delete").bind("click",deleteItem);
	
	$("#save").bind("click",saveItem);
	$("#reset").bind("click",resetForm);
	
	$("#search").bind("click",doSearch);
});

function doSearch(){
	
	var zbname = $.trim($("#s_zbname").val());
	var field = $.trim($("#s_field").val());
	
	$("#mainGrid").datagrid("load",{
		filter:"zbname="+zbname+"&field="+field
	});
//	refreshItem();
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
		}
	}
}

function addItem(){
	
	showWindow("添加阙值信息");
}

function editItem(){
	
	var r = $("#mainGrid").datagrid('getChecked');
	if(!r||r.length==0){
		alert('请选择待修改的记录!');
		return;
	}
	if(r.length!=1){
		alert('只能选择一条记录进行修改！');
		return;
	}
	
	showWindow("修改阙值信息");
	$("#form").form('load',r[0]);
}

function deleteItem(){
	
	
	var r = $("#mainGrid").datagrid('getChecked');
	if(!r||r.length==0){
		alert('请选择待删除的记录!');
		return;
	}
	if(!confirm('你确认要删除选中项吗?')){
		return;
	}
	
	var ids = new Array();
	for(var i=0;i<r.length;i++){
		ids.push(r[i].id);
	}
	
	$.post('defaultValue/delete.do',{ids:ids.join(',')},function(data){
		
		//var data = eval('(' + data + ')'); // change the JSON string to
		// javascript object
		if (data.success) {
			alert("删除成功！");

			$("#window").window('close');
			refreshItem();
		} else {
			alert(data.msg);
		}
	},"JSON");
}

function refreshItem(){
	
	$("#mainGrid").datagrid('reload');
}
function initComponent(){
	
	initGrid();
	initForm();
}

function showWindow(title){
	
	$("#window").window({
		title : title || "新增阙值",
		width : 600,
		height : 320,
		modal : true
	}).show();
	
	$('#form').form('reset');
}

function initForm(){
	
	$('#form').form({
		url : "defaultValue/save.do",
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

			var data = eval('(' + data + ')'); // change the JSON string to
												// javascript object
			if (data.success) {
				alert("保存成功！");

				$("#window").window('close');
				refreshItem();
			} else {
				alert(data.msg);
			}
		}
	});
}

function initGrid(){
	
	$('#mainGrid').datagrid({
	    url:'defaultValue/findAll.do',
	    toolbar:"#toolbar",
	    queryParams:{
//	    	filter:"zbname="+$.trim($("#s_zbname").val())+"&field="+$.trim($("#s_field").val())
	    },
	    columns:[[
	        {field:'id',title:'主键',checkbox:true,width:120},
	        {field:'zbname',title:'指标表名称',width:100},
	        {field:'field',title:'指标表字段',width:80},
	        {field:'yjVal',title:'预警值',width:230},
	        {field:'yjOpr',title:'预警关系',width:80},
	        {field:'gjVal',title:'告警值',width:80},
	        {field:'gjOpr',title:'告警关系',width:80},
	        {field:'crtime',title:'创建时间',width:80,formatter : dateFormater},
	        {field:'cruser',title:'创建人',width:80}
	    ]],
	    rownumbers:true,
	    singleSelect:false,
	    autoRowHeight:false,
		fitColumns : true,
	    pagination:true
	});
}