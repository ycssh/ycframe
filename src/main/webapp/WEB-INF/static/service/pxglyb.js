$(function(){
	
	initComponent();
	
	$("#add").bind("click",addItem);
	$("#edit").bind("click",editItem);
	$("#delete").bind("click",deleteItem);
	
	$("#save").bind("click",saveItem);
	$("#reset").bind("click",resetForm);
	
	$("#search").bind("click",doSearch);
	$("#s_reset").bind("click",resetSearchBox);
});

function resetSearchBox(){
	
	$("#s_company").combobox('setValue',null);
	$("#s_projectId").combobox('setValue',null);
	$("#s_startTime").datebox('setValue',null);
	$("#s_endTime").datebox('setValue',null);
	
}

function doSearch(){
	
	var company = $.trim($("#s_company").combobox('getValue'));
	var projectId = $.trim($("#s_projectId").combobox('getValue'));
	var startTime = $.trim($("#s_startTime").datebox('getValue'));
	var endTime = $.trim($("#s_endTime").datebox('getValue'));
	
	$("#mainGrid").datagrid("load",{
		filter:"type=1&company="+company+"&projectId="+projectId+"&startTime="+startTime+"&endTime="+endTime
	});
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

function formatDate(date){
	
	var y = date.getFullYear();
	var m = date.getMonth()+1;
	m = m<10?'0'+m:m;
	var d = date.getDate();
	d = d<10?'0'+d:d;
	return y+'-'+m+'-'+d;
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
	
	$.post('pxglyb/delete.do',{ids:ids.join(',')},function(data){
		
		//var data = eval('(' + data + ')'); // change the JSON string to
		// javascript object
		if (data.success) {
			alert('删除成功！');

			//$("#window").window('close');
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
		title : title || "新增",
		width : 800,
		height : 400,
		modal : true
	}).show();
	
	$('#form').form('reset');
}

function initForm(){
	
	$('#form').form({
		url : "pxglyb/save.do",
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
				alert('保存成功！');

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
	    url:'pxglyb/findAll.do',
	    toolbar:"#toolbar",
	    queryParams:{
	    	filter:"type=1"
//	    	filter:"zbname="+$.trim($("#s_zbname").val())+"&field="+$.trim($("#s_field").val())
	    },
	    columns:[[
	        {field:'id',title:'编号',checkbox:true,width:120},
	        {field:'projectId',title:'项目编号',width:40},
	        {field:'projectName',title:'项目名称',width:120},
	        {field:'beginTime',title:'项目开始时间',width:40},
	        {field:'endTime',title:'项目结束时间',width:40},
	        {field:'companyName',title:'送培单位',width:40},
	        {field:'planNum',title:'计划人数',width:40},
	        {field:'actualNum',title:'实际人数',width:40},
	        {field:'cpl',title:'参培率',width:40},
	        {field:'cql',title:'出勤率',width:40},
	        {field:'hgl',title:'合格率',width:40},
	        {field:'isBL',title:'是否补录数据',width:20}
	    ]],
	    rownumbers:true,
	    singleSelect:false,
	    autoRowHeight:false,
		fitColumns : true,
	    pagination:true,
	    pageSize:20
	});
}