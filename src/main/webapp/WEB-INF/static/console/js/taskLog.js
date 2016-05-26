$(function(){
	
	initTaskLogComponent();
	
	$("#tasklog_opr_refresh").click(refreshTaskLogGrid);
	
	$("#tasklog_opr_delete").click(deleteTaskLog);
	
	$("#tasklog_opr_scan").click(scanTaskLog);
	
	$("#tasklog_form_close").click(closeTaskLogWin);
	
	$("#tasklog_opr_clear").click(clearAllTaskLog);
});

function initTaskLogComponent(){
	
	initTaskLogGrid();
}

function clearAllTaskLog(){
	
	if(!confirm("你确认要删除所有记录吗？")){
		return;
	}
	
	
	$.post("tasklog/clearAll",{},function(data){
		
		//var data = eval('(' + data + ')');  // change the JSON string to javascript object
		var data = eval(data);
        if (data.success){
            alert("删除成功！");
            
            refreshTaskLogGrid();
        }else{
        	alert(data.msg);
        }
        
	},"JSON");
}

function refreshTaskLogGrid(){
	
//	$("#tasklog_grid").datagrid("reload");
	
	$('#tasklog_grid').datagrid({
		queryParams : {
			//filter : 'taskIds=' + _ids.join(",")
		}
	});
}

function scanTaskLog(){
	
	var _r = $("#tasklog_grid").datagrid("getSelected");
	
	_r = formatTaskLogRecord(_r);
	
	if(_r==null){
		alert("请选择一条待查看的记录!");
		return false;
	}
	
	$("#tasklog_win").window({
		title:"任务执行日志详情",
		width:600,
	    height:500,
	    modal:true
	}).show();
	
	$("#tasklog_form").form("reset");
	
	$("#tasklog_form").form("load",_r);
}

function closeTaskLogWin(){
	
	$("#tasklog_win").window("close");
}

function formatTaskLogRecord(_r){
	if(!_r){
		return null;
	}
	
	if(_r.crTime){
		var d = new Date(_r.crTime);
		_r.crTime = dateFormat(d);
	}
	
	if(_r.methodName){
		_r.type = formatTaskLogType(_r.methodName);
	}
	
	return _r;
}

function formatTaskLogType(v){
	if(v=='run'){
		return "同步增量";
	}else if(v=='runAll'){
		return "同步全部";
	}else if(v=='runAdd'){
		return "同步新增";
	}else if(v=='runEdit'){
		return "同步修改";
	}else if(v=='runDelete'){
		return '同步删除';
	}
	return v;
}

function deleteTaskLog(){
	var _r = $("#tasklog_grid").datagrid("getSelections");
	
	if(_r==null||_r.length==0){
		alert("请选择待删除的记录!");
		return false;
	}
	
	if(!confirm("你确认要删除该条记录吗？")){
		return;
	}
	
	var ids = [];
	
	for(var i=0;i<_r.length;i++){
		ids.push(_r[i].id);
	}
	
	$.post("tasklog/delete",{ids:ids.join(",")},function(data){
		
		//var data = eval('(' + data + ')');  // change the JSON string to javascript object
		var data = eval(data);
        if (data.success){
            alert("删除成功！");
            
            refreshTaskLogGrid();
        }else{
        	alert(data.msg);
        }
        
	},"JSON");
}

function initTaskLogGrid(){
	
	$('#tasklog_grid').datagrid({
	    url:'tasklog/findAll',
	    toolbar:"#tasklog_toolbar",
	    columns:[[
	        {field:'id',title:'主键',checkbox:true,width:120},
	        {field:'entityName',title:'实体表名称',width:100},
	        {field:'beanName',title:'迁移器bean',width:80},
	        {field:'toolClass',title:'迁移工具类',width:230},
	        {field:'methodName',title:'执行方法名',width:80},
	        {field:'type',title:'迁移类型',width:80,formatter:function(v,_r){
	        	if(_r){
	        		return formatTaskLogType(_r.methodName);
	        	}
	        	return v;
	        }},
	        {field:'success',title:'是否成功',width:80},
	        {field:'crTime',title:'迁移时间',width:150,formatter: dateFormater},
	        {field:'addition',title:'备注',width:280}
	    ]],
	    rownumbers:true,
	    singleSelect:false,
//	    pagePosition:"top",
	    autoRowHeight:false,
		fitColumns : true,
	    pagination:true
	});
}