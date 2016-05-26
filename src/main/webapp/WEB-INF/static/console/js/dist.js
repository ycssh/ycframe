$(function(){
	
	initDistComponent();
	
	$("#dist_opr_refresh").click(refreshDistGrid);
	
	$("#dist_opr_run").click(runMoverTask);
	
	$("#dist_filter").combobox({
		onSelect:filterSelected
	});
	
	
});

function filterSelected(r){
	
	$('#dist_grid').datagrid('load',{
		filter: 'type='+r.value
	});
}

function runMoverTask(){
	
	var _r = $("#dist_grid").datagrid("getChecked");
	
	if(_r==null||_r.length==0){
		alert("请选择待处理的表!");
		return false;
	}
	
	if(!confirm("你确认要清空后重新生成选中的表的数据吗？")){
		return;
	}
	
	var ids = [];
	
	for(var i=0;i<_r.length;i++){
		ids.push(_r[i].id);
	}
	
	$.post("moverDist/runTask",{ids:ids.join(",")},function(data){
		
		//var data = eval('(' + data + ')');  // change the JSON string to javascript object
		var data = eval(data);
        if (data.success){
            alert("操作成功！");
            
            refreshDistGrid();
        }else{
        	alert(data.msg);
        }
        
	},"JSON");
}

function initDistComponent(){
	
	initDistGrid();
}


function refreshDistGrid(){
	$('#dist_grid').datagrid("reload");
}

function initDistGrid(){
	
	$('#dist_grid').datagrid({
	    url:'moverDist/find',
	    toolbar:"#dist_toolbar",
	    columns:[[
{field:'id',title:'ID',checkbox:true,width:80},
	        {field:'dataMoverTask',title:'实体表名',width:80,formatter: function(value,row,index){
				return value.name;
			}},
	        {field:'pxNum',title:'培训管理系统数据量',width:80},
	        {field:'yyNum',title:'运监系统数据量',width:80},
	        {field:'s',title:'是否存在差异',width:80,formatter: function(value,row,index){
				if(row.pxNum==row.yyNum){
					return '否';
				}else{
					return '<font color=red>是</font>';
				}
			}}
	    ]],
	    rownumbers:true,
	    pagination:true,
	    pageSize:20,
	    fitColumns : true,
	    singleSelect:false
	});
}