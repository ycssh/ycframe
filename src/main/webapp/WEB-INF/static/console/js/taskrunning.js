$(function(){
	
	initTaskRunningComponent();
	
	$("#taskrunning_opr_refresh").click(refreshTaskRunningGrid);
	
	$("#taskrunning_opr_stop").click(stopRunningTask);
	
	$("#taskrunning_opr_delete").click(deleteRunningTask);
});

function initTaskRunningComponent(){
	
	initTaskRunningGrid();
}

function deleteRunningTask(){
	var _r = $("#taskrunning_grid").datagrid("getSelections");
	
	if(_r==null||_r.length==0){
		alert("请选择待删除的任务!");
		return false;
	}
	
	if(!confirm("你确认要删除选中的任务吗？")){
		return;
	}
	
	var ids = [];
	
	for(var i=0;i<_r.length;i++){
		ids.push(_r[i].id);
	}
	
	$.post("tasklog/deleteTask",{ids:ids.join(",")},function(data){
		
		//var data = eval('(' + data + ')');  // change the JSON string to javascript object
		var data = eval(data);
        if (data.success){
            alert("操作成功！");
            
            refreshTaskRunningGrid();
        }else{
        	alert(data.msg);
        }
        
	},"JSON");
}

function stopRunningTask(){
	
	var _r = $("#taskrunning_grid").datagrid("getSelections");
	
	if(_r==null||_r.length==0){
		alert("请选择待停止的任务!");
		return false;
	}
	
	if(!confirm("你确认要停止选中的任务吗？")){
		return;
	}
	
	var ids = [];
	
	for(var i=0;i<_r.length;i++){
		ids.push(_r[i].id);
	}
	
	$.post("tasklog/stopTask",{ids:ids.join(",")},function(data){
		
		//var data = eval('(' + data + ')');  // change the JSON string to javascript object
		var data = eval(data);
        if (data.success){
            alert("操作成功！");
            
            refreshTaskRunningGrid();
        }else{
        	alert(data.msg);
        }
        
	},"JSON");
}

function refreshTaskRunningGrid(){
	
	$("#taskrunning_grid").datagrid("reload");
	$("#taskstoped_grid").datagrid("reload");
}

function initTaskRunningGrid(){
	
	$('#taskrunning_grid').datagrid({
	    url:'tasklog/runningTask',
	    toolbar:"#taskrunning_toolbar",
	    columns:[[
	        {field:'id',title:'任务编号',checkbox:true,width:80},
	        {field:'name',title:'任务名称',width:80},
	        {field:'timer',title:'定时器（Timer）',width:80},
	        {field:'startTime',title:'任务开始时间',width:80,formatter:dateFormater},
	        {field:'period',title:'执行间隔',width:80},
	        {field:'status',title:'状态',width:80},
	        {field:'component',title:'迁移组件',width:80}
	    ]],
	    rownumbers:true,
	    fitColumns : true,
	    singleSelect:false
	});
}