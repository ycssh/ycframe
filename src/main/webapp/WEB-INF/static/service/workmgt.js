$(function(){
	
	initComponent();
	
	$("#searchDB").bind("click",doSearchDB);
	$("#resetDB").bind("click",resetSearchBoxDB);
	
	$("#searchYB").bind("click",doSearchYB);
	$("#resetYB").bind("click",resetSearchBoxYB);
	
	$("#dealWork").bind("click",dealWork);
	$("#WorkInfo").bind("click",WorkInfo);
	$("#doDeal").bind("click",doDeal);
});

function doDeal(){
	
	$.post("workmgt/dowork",{id:$("#id").val()},function(data){
		
		if(data.success){
			alert("处理完成！");
			
			$("#dealWin").window("close");
			refreshGrid()
		}else{
			
			alert("处理发生错误，"+data.msg);
		}
	},"JSON")
}

function dealWork(){
	$("#dealFormTable").show();
	
	var r = $("#dbGrid").datagrid('getChecked');
	if(!r||r.length==0){
		alert('请选择待操作的信息！');
		return;
	}
	if(r.length!=1){
		alert('请选择一条待操作的信息！');
		return;
	}
	
	$("#targetMsgShowFrame").attr("src","workmgt/targetshow/"+r[0].targetType+"/"+r[0].targetId);
	
	$("#dealWin").window({
		title : "处理待办任务",
		width : 655,
		height : 425,
		modal : true
	}).show();
	
	$("#id").val(r[0].id);
}


function WorkInfo(){
	
	$("#dealFormTable").hide();
	
	var r = $("#ybGrid").datagrid('getChecked');
	if(!r||r.length==0){
		alert('请选择待操作的信息！');
		return;
	}
	if(r.length!=1){
		alert('请选择一条待操作的信息！');
		return;
	}
	
	$("#targetMsgShowFrame").attr("src","workmgt/targetshow/"+r[0].targetType+"/"+r[0].targetId);
	
	$("#dealWin").window({
		title : "查看已办任务",
		width : 655,
		height : 425,
		modal : true
	}).show();
	
	$("#id").val(r[0].id);
	
	
}




function resetSearchBoxDB(){
	
	$("#s_flowName").val('');
	$("#s_targetName").val('');
	$("#s_startTime").datebox("setValue",null);
	$("#s_endTime").datebox("setValue",null);
}

function doSearchDB(){
	
	var flowName = $.trim($("#s_flowName").val());
	var targetName = $.trim($("#s_targetName").val());
	var startTime = $("#s_startTime").datebox("getValue");
	var endTime = $("#s_endTime").datebox("getValue");
		if(top.specialCharacter(flowName))
	{
		alert("工作流名称中包含特殊字符，请重新输入.");
		return;
	}
		if(top.specialCharacter(targetName))
	{
		alert("创建人中包含特殊字符，请重新输入.");
		return;
	}		
	if(startTime>endTime){
		alert("开始时间不能大于结束时间");
		return ;
	}
	$("#dbGrid").datagrid("load",{
		filter:"flowName="+flowName+"&targetName="+targetName+"&startTime="+startTime+"&endTime="+endTime
	});
}

function resetSearchBoxYB(){
	
	$("#s_flowName_yb").val('');
	$("#s_targetName_yb").val('');
	$("#s_startTime_yb").datebox("setValue",null);
	$("#s_endTime_yb").datebox("setValue",null);
}

function doSearchYB(){
	
	var flowName = $.trim($("#s_flowName_yb").val());
	var targetName = $.trim($("#s_targetName_yb").val());
	var startTime = $("#s_startTime_yb").datebox("getValue");
	var endTime = $("#s_endTime_yb").datebox("getValue");
		if(top.specialCharacter(flowName))
	{
		alert("工作流名称中包含特殊字符，请重新输入.");
		return;
	}
		if(top.specialCharacter(targetName))
	{
		alert("任务对象中包含特殊字符，请重新输入.");
		return;
	}
	$("#ybGrid").datagrid("load",{
		filter:"flowName="+flowName+"&targetName="+targetName+"&startTime="+startTime+"&endTime="+endTime
	});
}


function refreshGrid(){
	
	$("#dbGrid").datagrid('reload');
	$("#ybGrid").datagrid('reload');
}

function initComponent(){
	
	initGrid();
	//initForm();
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
	
	$('#dbGrid').datagrid({
	    url:'workmgt/findDB.do',
	    toolbar:"#toolbar_db",
	    queryParams:{
	    },
	    columns:[[
	        {field:'id',title:'编号',checkbox:true,width:40},
	        {field:'flowName',title:'工作流名称',width:40},
	        {field:'targetId',title:'任务对象',width:120,formatter:function(val,row,index){
	        	var tt = row.targetType;
	        	if(tt=="ErrorInfo"){
	        		tt = "异常事件"
	        	}
	        	return tt+'信息【编号：'+row.targetId+'】数据等待您处理!';
	        }},
	        {field:'nodeName',title:'流程节点',width:40,formatter:function(val,row,index){
	        	return row.nodeName+"【"+(row.oprUserType=="1"?"用户":"角色")+"-"+row.oprUser+"】";
	        }},
	        {field:'nextNodeName',title:'下一流程节点',width:40,formatter:function(val,row,index){
	        	
	        	if(!row.nextNodeName){
	        		return "结束";
	        	}
	        	return row.nextNodeName+"【"+(row.nextOprUserType=="1"?"用户":"角色")+"-"+row.nextOprUser+"】";
	        }},
	        {field:'crtime',title:'提交时间',width:80}
	    ]],
	    rownumbers:true,
	    singleSelect:false,
	    pageSize:20,
	    autoRowHeight:true,
		fitColumns : true,
	    pagination:true
	});
	
	$('#ybGrid').datagrid({
	    url:'workmgt/findYB.do',
	    toolbar:"#toolbar_yb",
	    queryParams:{
	    },
	    columns:[[
	        {field:'id',title:'编号',checkbox:true,width:40},
	        {field:'flowName',title:'工作流名称',width:40},
	        {field:'targetId',title:'任务对象',width:120,formatter:function(val,row,index){
	        	var tt = row.targetType;
	        	if(tt=="ErrorInfo"){
	        		tt = "异常事件"
	        	}
	        	return tt+'信息【编号：'+row.targetId+'】';
	        }},
	        {field:'nodeName',title:'处理流程节点',width:40,formatter:function(val,row,index){
	        	return row.nodeName+"【"+(row.oprUserType=="1"?"用户":"角色")+"-"+row.oprUser+"】";
	        }},        
	        {field:'dealUser',title:'处理人',width:80},
	        {field:'dealTime',title:'处理时间',width:80}
	    ]],
	    rownumbers:true,
	    singleSelect:false,
	    pageSize:20,
	    autoRowHeight:true,
		fitColumns : true,
	    pagination:true
	});
}