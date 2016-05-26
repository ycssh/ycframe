$(function(){
	
	$("#kjcz_opr_startAllIncre").click(startAllIncreTask);
	
	$("#kjcz_opr_clearAllEntities").click(clearAllEntities);
	
	$("#kjcz_opr_remakeAllEntities").click(remakeAllEntities);
});

function startAllIncreTask(){
	
	if(!confirm("你确认要立即执行所有的增量任务吗？")){
		return;
	}
	
	$.post("tasklog/startAllIncre",{},function(data){
		
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

function clearAllEntities(){
	if(!confirm("你确认要清除所有的实体表数据吗？")){
		return;
	}
	
	$.post("tasklog/clearAllEntities",{},function(data){
		
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

function remakeAllEntities(){
	if(!confirm("你确认要重新生成实体表数据吗？")){
		return;
	}
	
	$.post("tasklog/remakeAllEntities",{},function(data){
		
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