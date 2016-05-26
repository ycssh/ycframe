$(function(){
	
	initTableInfoComponent();
	
	$("#tableinfo_opr_refresh").click(refreshTableInfoGrid);
	
	$("#tableinfo_opr_clear").click(clearTableInfo);
	
	$("#tableinfo_opr_remake").click(remakeTableInfo);
	
});

function initTableInfoComponent(){
	
	initTableInfoGrid();
}

function clearTableInfo(){
	var _r = $("#tableinfo_grid").datagrid("getSelections");
	
	if(_r==null||_r.length==0){
		alert("请选择待清空的表!");
		return false;
	}
	
	if(!confirm("你确认要清空选中的表吗？")){
		return;
	}
	
	var ids = [];
	
	for(var i=0;i<_r.length;i++){
		ids.push(_r[i].NAME);
	}
	
	$.post("tasklog/clearTableInfo",{ids:ids.join(",")},function(data){
		
		//var data = eval('(' + data + ')');  // change the JSON string to javascript object
		var data = eval(data);
        if (data.success){
            alert("操作成功！");
            
            refreshTableInfoGrid();
        }else{
        	alert(data.msg);
        }
        
	},"JSON");
}

function remakeTableInfo(){
	var _r = $("#tableinfo_grid").datagrid("getSelections");
	
	if(_r==null||_r.length==0){
		alert("请选择待处理的表!");
		return false;
	}
	
	if(!confirm("你确认要清空后重新生成选中的表的数据吗？")){
		return;
	}
	
	var ids = [];
	
	for(var i=0;i<_r.length;i++){
		ids.push(_r[i].NAME);
	}
	
	$.post("tasklog/remakeTableInfo",{ids:ids.join(",")},function(data){
		
		//var data = eval('(' + data + ')');  // change the JSON string to javascript object
		var data = eval(data);
        if (data.success){
            alert("操作成功！");
            
            refreshTableInfoGrid();
        }else{
        	alert(data.msg);
        }
        
	},"JSON");
}

function refreshTableInfoGrid(){
	$('#tableinfo_grid').datagrid("reload");
}

function initTableInfoGrid(){
	
	$('#tableinfo_grid').datagrid({
	    url:'tasklog/statTableInfo',
	    toolbar:"#tableinfo_toolbar",
	    columns:[[
{field:'ID',title:'ID',checkbox:true,width:80},
	        {field:'NAME',title:'表名',width:80},
	        {field:'DESCR',title:'注释',width:80},
	        {field:'TABLESPACE_NAME',title:'表空间',width:80},
	        {field:'STATUS',title:'状态',width:80},
	        {field:'NUM_ROWS',title:'记录数',width:80},
	        {field:'LAST_ANALYZED',title:'最近分析时间',width:80,formatter:function(v){
	        	if(v){
	        		var d = new Date(v);
	        		
	        		return dateFormat(d);
	        	}else{
	        		return v;
	        	}
	        }}
	    ]],
	    rownumbers:true,
	    fitColumns : true,
	    singleSelect:false
	});
}