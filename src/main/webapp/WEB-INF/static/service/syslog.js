$(function(){
	
	initComponent();
	
	
	$("#search").bind("click",doSearch);
	$("#s_reset").bind("click",resetSearchBox);
	
	$("#scan").bind("click",scanInfo);
	$("#delete").bind("click",deleteInfo);
});

function scanInfo(){
	
	var r = $("#mainGrid").datagrid('getChecked');
	if(!r||r.length==0){
		alert('请选择待查看的信息！');
		return;
	}
	if(r.length!=1){
		alert('请选择一条待查看的信息！');
		return;
	}
	
	showWindow("查看信息");
	
	if(r[0].operType){
		
		var val = r[0].operType;
		if(val==1){
    		val = "新增";
    	}else if(val==2){
    		
    		val = "修改";
    	}else if(val==3){
    		
    		val = "删除";
    	}else if(val==4){
    		
    		val = "查询";
    	}
		r[0].operType = val;
	}
	if(r[0].opertime){
		
		r[0].opertime = dateFormat(new Date(r[0].opertime));
	}
	$("#form").form('load',r[0]);
}

function deleteInfo(){
	
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
		ids.push(r[i].dbId);
	}
	
	$.post('syslog/delete.do',{ids:ids.join(',')},function(data){
		
		//var data = eval('(' + data + ')'); // change the JSON string to
		// javascript object
		if (data.success) {
			alert('删除成功！');

			refreshGrid();
		} else {
			alert(data.msg);
		}
	},"JSON");
}

function resetSearchBox(){
	
	$("#s_title").val('');
	$("#s_userid").val('');
	$("#logType").combobox('setValue',"0");
	$("#orderType").combobox('setValue',"1");
	$("#s_startTime").datebox("setValue",null);
	$("#s_endTime").datebox("setValue",null);
}

function doSearch(){
	
	var title = $.trim($("#s_title").val());
	var userid = $.trim($("#s_userid").val());
	var startTime = $("#s_startTime").datebox("getValue");
	var endTime = $("#s_endTime").datebox("getValue");
	var logType = $("#logType").combobox("getValue");
	var orderType = $("#orderType").combobox("getValue");
	if(startTime>endTime){
		alert("开始时间不能大于结束时间");
		return ;
	}
		if(top.specialCharacter(userid))
	{
		alert("操作人中包含特殊字符，请重新输入.");
		return;
	}
		if(top.specialCharacter(title))
	{
		alert("标题中包含特殊字符，请重新输入.");
		return;
	}	
	$("#mainGrid").datagrid("load",{
		filter:"title="+title+"&userid="+userid+"&startTime="+startTime+"&endTime="+endTime+"&logType="+logType+"&orderType="+orderType
	});
}


function refreshGrid(){
	
	$("#mainGrid").datagrid('reload');
}

function initComponent(){
	
	initGrid();
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


function initGrid(){
	
	$('#mainGrid').datagrid({
	    url:'syslog/findAll.do',
	    toolbar:"#toolbar",
	    queryParams:{
	    },
	    columns:[[
	        {field:'dbId',title:'编号',checkbox:true,width:40},
	        {field:'title',title:'日志标题',width:120},
	    /*    {field:'operType',title:'操作类型',width:40,formatter:function(val,row,index){
	        	if(val==1){
	        		return "新增";
	        	}else if(val==2){
	        		
	        		return "修改";
	        	}else if(val==3){
	        		
	        		return "删除";
	        	}else if(val==4){
	        		
	        		return "查询";
	        	}
	        	return val;
	        }},*/
	        {field:'logType',title:'日志类型',width:40,formatter:function(val,row,index){
	        	if(val==1){
	        		return "系统日志";
	        	}else if(val==2){
	        		return "业务日志";
	        	}
	        	return val;
	        }},
	        {field:'userid',title:'操作人',width:40},
	        {field:'opertime',title:'操作时间',width:80,formatter:dateFormater},
	        {field:'ip',title:'操作人IP地址',width:80},
	        {field:'result',title:'事件结果',width:40,formatter:function(val,row,index){
	        	if(val==0){
	        		return "失败";
	        	}else if(val==1){
	        		return "成功";
	        	}else{
	        		return "其他";
	        	}
	        }}
	    ]],
	    rownumbers:true,
	    singleSelect:false,
	    pageSize:20,
	    autoRowHeight:true,
		fitColumns : true,
	    pagination:true
	});
}