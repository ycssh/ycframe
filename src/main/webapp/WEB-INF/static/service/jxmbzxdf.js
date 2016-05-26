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
	
	$("#s_year").val("");
}

function doSearch(){
	
	var year = $.trim($("#s_year").val());
	
	$("#mainGrid").datagrid("load",{
		filter:"year="+year
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
	
	$.post('jxmbzx/df/delete.do',{ids:ids.join(',')},function(data){
		
		//var data = eval('(' + data + ')'); // change the JSON string to
		// javascript object
		if (data.success) {
			alert('删除成功！');

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
		height : 520,
		modal : true
	}).show();
	
	$('#form').form('reset');
}

function initForm(){
	
	$('#form').form({
		url : "jxmbzx/df/save.do",
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
	    url:'jxmbzx/df/findAll.do',
	    toolbar:"#toolbar",
	    queryParams:{
//	    	filter:"zbname="+$.trim($("#s_zbname").val())+"&field="+$.trim($("#s_field").val())
	    },
	    columns:[[
	        {field:'id',title:'编号',checkbox:true,width:80},
	        {field:'year',title:'年度',width:80},
	        {field:'jh',title:'培训计划',width:80},
	        {field:'xygjh',title:'培训计划（新员工）',width:80},
	        {field:'dxbjh',title:'培训计划（短训班/团青）',width:80},
	        {field:'rc',title:'培训人次',width:80},
	        {field:'xygrc',title:'培训人次（新员工）',width:80},
	        {field:'dxbrc',title:'培训人次（短训班/团青）',width:100},
	        {field:'rs',title:'培训人数',width:80},
	        {field:'xygrs',title:'培训人数（新员工）',width:80},
	        {field:'dxbrs',title:'培训人数（短训班/团青）',width:80},
	        {field:'rts',title:'培训人天数',width:80},
	        {field:'xygrts',title:'培训人天数（新员工）',width:80},
	        {field:'dxbrts',title:'培训人天数（短训班/团青）',width:80},
	        {field:'gzl',title:'培训工作量',width:80},
	        {field:'xyggzl',title:'培训工作量（新员工）',width:80},
	        {field:'dxbgzl',title:'培训工作量（短训班/团青）',width:80}
	    ]],
	    rownumbers:true,
	    singleSelect:false,
	    autoRowHeight:true,
		fitColumns : true,
	    pagination:true
	});
}