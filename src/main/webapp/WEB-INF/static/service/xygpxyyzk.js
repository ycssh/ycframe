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
	
	$("#s_jcfl").combobox('setValue',null);
	$("#s_deptId").combobox('setValue',null);
	$("#s_projectId").combobox('setValue',null);
	$("#s_majorId").combobox('setValue',null);
	$("#s_classId").combobox('setValue',null);
	$("#s_result").combobox('setValue',null);
}

function doSearch(){
	
	var jcfl = $.trim($("#s_jcfl").combobox('getValue'));
	var deptId = $.trim($("#s_deptId").combobox('getValue'));
	var projectId = $.trim($("#s_projectId").combobox('getValue'));
	var majorId = $.trim($("#s_majorId").combobox('getValue'));
	var classId = $.trim($("#s_classId").combobox('getValue'));
	var result = $.trim($("#s_result").combobox('getValue'));
	//alert(jcfl);
	
	$("#mainGrid").datagrid("load",{
		filter:"jcfl="+jcfl+"&deptId="+deptId+"&projectId="+projectId+"&majorId="+majorId+"&classId="+classId+"&result="+result
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
	
	showWindow("修改信息");
	$("#form").form('load',r[0]);
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
		ids.push(r[i].id);
	}
	
	$.post('xygpxyyzk/delete.do',{ids:ids.join(',')},function(data){
		
		//var data = eval('(' + data + ')'); // change the JSON string to
		// javascript object
		if (data.success) {
			alert('删除成功！');

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
		title : title || "新增",
		width : 800,
		height : 320,
		modal : true
	}).show();
	
	$('#form').form('reset');
}

function initForm(){
	
	$('#form').form({
		url : "xygpxyyzk/save.do",
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
	    url:'xygpxyyzk/findAll.do',
	    toolbar:"#toolbar",
	    queryParams:{
//	    	filter:"zbname="+$.trim($("#s_zbname").val())+"&field="+$.trim($("#s_field").val())
	    },
	    columns:[[
	        {field:'id',title:'编号',checkbox:true,width:120},
	        {field:'jcflName',title:'新员工培训运营状况监测分类',width:230},
	        {field:'deptName',title:'专业培训部',width:80},
	        {field:'projectName',title:'项目',width:80},
	        {field:'majorName',title:'专业',width:80},
	        {field:'className',title:'班级',width:100},
	        {field:'resultName',title:'完成情况',width:80}
	    ]],
	    rownumbers:true,
	    singleSelect:false,
	    autoRowHeight:false,
		fitColumns : true,
	    pagination:true
	});
}