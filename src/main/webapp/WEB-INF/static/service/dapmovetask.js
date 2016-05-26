$(function(){
	
	initComponent();
	
	$("#add").bind("click",addItem);
	$("#edit").bind("click",editItem);
	$("#delete").bind("click",deleteItem);
	
	$("#save").bind("click",saveItem);
	$("#reset").bind("click",resetForm);
	
	$("#search").bind("click",doSearch);
	$("#s_reset").bind("click",resetSearchBox);
	
	$("#run").bind("click",runTask);
	$("#runZb").bind("click",runZbTask);
	$("#runDap").bind("click",runDapTask);
	$("#addToQueue").bind("click",addToQueue);
	$("#openRunning").bind("click",openRunning);
});

function openRunning(){
	
	window.open('dapmovetask/runningTasks');
}

function addToQueue(){
	
	var r = $("#mainGrid").datagrid('getChecked');
	if(!r||r.length==0){
		alert('请选择待操作的记录！');
		return;
	}
	
	var ids = new Array();
	for(var i=0;i<r.length;i++){
		if(!r[i].startTime){
			//alert('非定时任务不允许加入定时队列，请选择定时任务！');
			//return;
			continue;
		}
		ids.push(r[i].id);
	}
	
	$.post('dapmovetask/addToQueue.do',{ids:ids.join(',')},function(data){
		
		//var data = eval('(' + data + ')'); // change the JSON string to
		// javascript object
		if (data.success) {
			alert('执行成功！');

		} else {
			alert(data.msg);
		}
	},"JSON");
}

function runZbTask(){
	runTask('zb');
}

function runDapTask(){
	
	runTask('dap');
}

function runTask(tp){
	var r = $("#mainGrid").datagrid('getChecked');
	if(!r||r.length==0){
		alert('请选择待执行的记录！');
		return;
	}
	if(!confirm('你确定要执行选中的记录吗?')){
		return;
	}
	
	var ids = new Array();
	for(var i=0;i<r.length;i++){
		ids.push(r[i].id);
	}
	var type = tp=="zb"||tp=="dap"?tp:'';
	
	$.post('dapmovetask/runTask.do',{ids:ids.join(','),type:type},function(data){
		
		//var data = eval('(' + data + ')'); // change the JSON string to
		// javascript object
		if (data.success) {
			alert('执行成功！');

		} else {
			alert(data.msg);
		}
	},"JSON");
}

function resetSearchBox(){
	
	$("#s_beanName").val('');
	$("#s_beanDesc").val('');
}

function doSearch(){
	
	var beanName = $.trim($("#s_beanName").val());
	var beanDesc = $.trim($("#s_beanDesc").val());
		if(top.specialCharacter(beanName))
	{
		alert("任务名称中包含特殊字符，请重新输入.");
		return;
	}
		if(top.specialCharacter(beanDesc))
	{
		alert("任务说明中包含特殊字符，请重新输入.");
		return;
	}	
	$("#mainGrid").datagrid("load",{
		filter:"beanName="+beanName+"&beanDesc="+beanDesc
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
	
//	alert(r[0].startTime);
	showWindow("修改信息");
	$("#form").form('load',r[0]);
	
	if(r[0].startTime){
		$("#startTimeDesc").datetimebox('setValue',dateFormat2(new Date(r[0].startTime)));
	}
	
}

function dateformat(t){
	var d = new Date(t);
	
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
	
	$.post('dapmovetask/delete.do',{ids:ids.join(',')},function(data){
		
		//var data = eval('(' + data + ')'); // change the JSON string to
		// javascript object
		if (data.success) {
			alert('删除成功！');

//			$("#window").window('close');
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
		width : 600,
		height : 320,
		modal : true
	}).show();
	
	$('#form').form('reset');
}

function initForm(){
	
	$('#form').form({
		url : "dapmovetask/save.do",
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
	    url:'dapmovetask/findAll.do',
	    toolbar:"#toolbar",
	    queryParams:{
//	    	filter:"zbname="+$.trim($("#s_zbname").val())+"&field="+$.trim($("#s_field").val())
	    },
	    columns:[[
	        {field:'id',title:'编号',checkbox:true,width:120},
	        {field:'beanName',title:'任务bean',width:100},
	        {field:'beanDesc',title:'任务说明',width:200},
	        {field:'startTime',title:'开始时间',width:80,formatter : dateFormater},
	        {field:'period',title:'执行间隔（单位：分钟）',width:80},
	        {field:'crtime',title:'创建时间',width:100,formatter : dateFormater},
	        {field:'cruser',title:'创建人',width:80}
	    ]],
	    rownumbers:true,
	    singleSelect:false,
	    autoRowHeight:true,
		fitColumns : true,
	    pagination:true,
	    pageSize:20,
	    onLoadSuccess:function(data){
	    	
	    }
	});
}