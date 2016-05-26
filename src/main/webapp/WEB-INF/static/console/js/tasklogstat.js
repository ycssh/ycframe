$(function(){
	
	initTaskLogStatComponent();
	
	$("#tasklogstat_opr_refresh").click(refreshTaskLogStatGrid);
});

function initTaskLogStatComponent(){
	
	initTaskLogStatGrid();
}

function refreshTaskLogStatGrid(){
	
	$("#tasklogstat_grid").datagrid("reload");
}

function initTaskLogStatGrid(){
	
	$('#tasklogstat_grid').datagrid({
	    url:'tasklog/statPavList',
	    toolbar:"#tasklogstat_toolbar",
	    columns:[[
	        {field:'ENTITYNAME',title:'实体表名称',width:80},
	        {field:'TOOLCLASS',title:'迁移工具类',width:80},
	        {field:'METHODNAME',title:'执行方法名',width:80},
	        {field:'ALLNUM',title:'执行次数',width:80},
	        {field:'SUCCESSNUM',title:'成功次数',width:80},
	        {field:'FAILURENUM',title:'失败次数',width:80}
	    ]],
	    rownumbers:true,
	    fitColumns : true,
	    singleSelect:false,
	    pagination:true
	});
}