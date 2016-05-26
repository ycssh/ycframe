$(function(){
	
	initComponent();
	$("#search").bind("click",doSearch);
	$("#s_reset").bind("click",resetSearchBox);
});


function resetSearchBox(){
	
	$("#s_startTime").datebox("setValue",null);
	$("#s_endTime").datebox("setValue",null);
	$('#logType').combobox("setValue","");
}

function doSearch(){
	var logType = $.trim($('#logType').combobox('getValue'));
	var startTime = $("#s_startTime").datebox("getValue");
	var endTime = $("#s_endTime").datebox("getValue");
	if(startTime>endTime){
		alert("开始时间不能大于结束时间");
		return ;
	}
	$("#mainGrid").datagrid("load",{
		filter:"&startTime="+startTime+"&endTime="+endTime+"&logType="+logType
	});
}


function refreshGrid(){
	
	$("#mainGrid").datagrid('reload');
}

function initComponent(){
	
	initGrid();
}

function initGrid(){
	
	$('#mainGrid').datagrid({
	    url:'syslog/findAllTotal.do',
	    toolbar:"#toolbar",
	    queryParams:{
	    },
	    columns:[[
	        {field:'dbId',title:'编号',checkbox:true,width:40},
	        {field:'title',title:'日志标题',width:60},
	        {field:'logType',title:'日志类型',width:40,formatter:function(val,row,index){
	        	if(val==1){
	        		return "系统日志";
	        	}else if(val==2){
	        		return "业务日志";
	        	}
	        	return val;
	        }},
	        {field:'operTime',title:'发生次数',width:40},
	    ]],
	    rownumbers:true,
	    singleSelect:false,
	    pageSize:20,
	    autoRowHeight:true,
		fitColumns : true,
	    pagination:true
	});
}