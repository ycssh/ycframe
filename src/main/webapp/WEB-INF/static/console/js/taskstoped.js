$(function(){
	
	initTaskStopedComponent();
	
	$("#taskstoped_opr_refresh").click(refreshTaskStopedGrid);
	
	$("#taskstoped_opr_run").click(runTaskStoped);
	
	$("#taskstoped_opr_delete").click(deleteRunningTask);
});

function initTaskStopedComponent(){
	
	initTaskStopedGrid();
}

function runTaskStoped(){
	var _r = $("#taskstoped_grid").datagrid("getSelections");
	
	if(_r==null||_r.length==0){
		alert("请选择待运行的任务!");
		return false;
	}
	
	if(!confirm("你确认要运行选中的任务吗？")){
		return;
	}
	
	var ids = [];
	
	for(var i=0;i<_r.length;i++){
		ids.push(_r[i].id);
	}
	
	$.post("tasklog/startTask",{ids:ids.join(",")},function(data){
		
		//var data = eval('(' + data + ')');  // change the JSON string to javascript object
		var data = eval(data);
        if (data.success){
            alert("操作成功！");
            
            refreshTaskStopedGrid();
        }else{
        	alert(data.msg);
        }
        
	},"JSON");
}

function refreshTaskStopedGrid(){
	
	$("#taskrunning_grid").datagrid("reload");
	$("#taskstoped_grid").datagrid("reload");
}

function initTaskStopedGrid(){
	
	$('#taskstoped_grid').datagrid({
	    url:'tasklog/stopedTask',
	    toolbar:"#taskstoped_toolbar",
	    columns:[[
	        {field:'id',title:'任务编号',checkbox:true,width:80},
	        {field:'name',title:'任务名称',width:80},
	        {field:'startTime',title:'任务开始时间',width:80,formatter:dateFormater},
	        {field:'stopTime',title:'任务停止时间',width:80,formatter:dateFormater},
	        {field:'period',title:'执行间隔',width:80},
	        {field:'status',title:'状态',width:80},
	        {field:'component',title:'迁移组件',width:80}
	    ]],
	    rownumbers:true,
	    fitColumns : true,
	    singleSelect:false
	});
}