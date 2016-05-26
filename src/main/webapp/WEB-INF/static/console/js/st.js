$(function(){
	
	initStComponent();
	
	$("#st_opr_refresh").click(refreshStGrid);
});

function initStComponent(){
	
	$('#st_grid').datagrid({
	    url:'datamovertask/statSt',
	    toolbar:"#st_toolbar",
	    columns:[[
//	        {field:'id',title:'主键',checkbox:true,width:120},
	        {field:'name',title:'名称',width:80},
	        {field:'descr',title:'描述',width:80},
	        {field:'num',title:'任务数',width:80}
	    ]],
	    rownumbers:true,
	    fitColumns : true,
	    singleSelect:false
	});
}

function refreshStGrid(){
	
	$('#st_grid').datagrid("reload");
}