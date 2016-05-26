$(function(){
	
	initComponent();
	
	$("#add").bind("click",addItem);
	$("#edit").bind("click",editItem);
	$("#delete").bind("click",deleteItem);
	
	$("#save").bind("click",saveItem);
	$("#reset").bind("click",resetForm);
	
	$("#search").bind("click",doSearch);
	$("#s_reset").bind("click",resetSearchBox);
	
	$("#configue").bind("click",configureFlow);
	
});


function configureFlow(){
	
	var r = $("#mainGrid").datagrid('getChecked');
	if(!r||r.length==0){
		alert('请选择待操作的信息！');
		return;
	}
	if(r.length!=1){
		alert('请选择一条待操作的信息！');
		return;
	}
	
	$("#confIframe").attr("src",'flownode/index?flowId='+r[0].id);
	$('#confDialog').window({
		title: '配置工作流',
	    width: 771,
	    height: 431,
	    modal: true
	}).show();
}


function resetSearchBox(){
	
	$("#s_startTime").datebox('setValue',null);
	$("#s_endTime").datebox('setValue',null);
	$("#s_name").val('');
	$("#s_cruser").val('');
	
}

function doSearch(){
	
	var name = $("#s_name").val();
	var cruser = $("#s_cruser").val();
	var startTime = $.trim($("#s_startTime").datebox('getValue'));
	var endTime = $.trim($("#s_endTime").datebox('getValue'));
		if(top.specialCharacter(name))
	{
		alert("工作流名称中包含特殊字符，请重新输入.");
		return;
	}
		if(top.specialCharacter(cruser))
	{
		alert("待办对象中包含特殊字符，请重新输入.");
		return;
	}	
	if(startTime>endTime){
		alert("开始时间不能大于结束时间");
		return ;
	}
	$("#mainGrid").datagrid("load",{
		filter:"name="+name+"&cruser="+cruser+"&startTime="+startTime+"&endTime="+endTime
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
	
	$.post('workflowmgt/delete.do',{ids:ids.join(',')},function(data){
		
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
		height : 400,
		modal : true
	}).show();
	
	$('#form').form('reset');
}

function initForm(){
	
	$('#form').form({
		url : "workflowmgt/save.do",
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
	    url:'workflowmgt/findAll.do',
	    toolbar:"#toolbar",
	    queryParams:{
	    	filter:""
	    },
	    columns:[[
	        {field:'id',title:'编号',checkbox:true,width:40},
	        {field:'name',title:'名称',width:120},
	        {field:'target',title:'指派目标类名',width:120},
	        {field:'cruser',title:'创建人',width:40},
	        {field:'crtime',title:'创建时间',width:40,formatter:dateFormater}
	    ]],
	    rownumbers:true,
	    singleSelect:false,
	    pageSize:20,
	    autoRowHeight:true,
		fitColumns : true,
	    pagination:true
	});
}