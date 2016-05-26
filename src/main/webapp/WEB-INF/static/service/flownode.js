var gData = [];

$(function(){
	
	initNodeForm();
	
	initFlowNodes();
	$("#addNode").bind("click",addFlowNode);
	
	$("#saveNode").bind("click",saveFlowNode);
	$("#resetNode").bind("click",resetFlowNode);
	
	$("#editNode").bind("click",editFlowNode);
	$("#deleteNode").bind("click",deleteFlowNode);
});

function deleteFlowNode(){
	
	var rec = $(".sfn").filter(".cur");
	if(rec.length==0){
		alert("请选择待操作的记录！");
		return;
	}
	
	var r = gData[rec.attr("id").substring("flowNode".length)-1];
	
	if(!confirm("你确认要删除此节点吗？")){
		return;
	}
	
	$.post("flownode/delete.do",{id:r.id},function(data){
		
		if(data.success){
			alert("删除成功！");
			refreshWorkFlow();
		}else{
			alert("发生错误！"+data.msg)
		}
	},"JSON")
}

function editFlowNode(){
	
	var rec = $(".sfn").filter(".cur");
	if(rec.length==0){
		alert("请选择待操作的记录！");
		return;
	}
	
	var r = gData[rec.attr("id").substring("flowNode".length)-1];
	
	addFlowNode('edit');
	$('#nodeForm').form('load',r);
	
	if(r.oprUserType==1){
		$('#user_mode').show();
		$('#role_mode').hide();
		
		$('#user_mode_input').combobox('setValue',r.oprUser);
	}else{
		$('#user_mode').hide();
		$('#role_mode').show();
		
		$('#role_mode_input').combobox('setValue',r.oprUser);
	}
}

function flowNodeSelected(){
	
	$(".sfn").removeClass("cur");
	$(this).addClass("cur");
}

function initFlowNodes(){
	
	$.post("flownode/listByFlow",{flowId:$("#flowId").val()},function(data){
		
		gData = data;
		
		var html = [];
		html.push('<div class="sfn1" style="margin-top:20px;">开&nbsp;&nbsp;&nbsp;始</div>');
		if(!!data){
			
			for(var i=0;i<data.length;i++){
				html.push('<div class="sfn_pic"><img src="static/images/liucheng.png" height="20" /></div>');
				html.push('<div class="sfn" id="flowNode'+(i+1)+'">'+data[i].name+'【处理人员：'+(data[i].oprUserType==1?'用户':'角色')+'-'+(data[i].oprUser)+'】</div>');
			}
		}
		html.push('<div class="sfn_pic"><img src="static/images/liucheng.png" height="20" /></div>');
		html.push('<div class="sfn1">结&nbsp;&nbsp;&nbsp;束</div>');
		$("#liucheng").html(html.join(''));
		
		$(".sfn").bind("click",flowNodeSelected);
	},"JSON");
}

function refreshWorkFlow(){
	
	//alert('refresh');
	initFlowNodes();
}

function resetFlowNode(){
	var rec = $(".sfn").filter(".cur");
	var r = gData[rec.attr("id").substring("flowNode".length)-1];
	
	$('#nodeForm').form('load',r);
	if(r.oprUserType==1){
		$('#user_mode').show();
		$('#role_mode').hide();
		
		$('#user_mode_input').combobox('setValue',r.oprUser);
	}else{
		$('#user_mode').hide();
		$('#role_mode').show();
		
		$('#role_mode_input').combobox('setValue',r.oprUser);
	}
	
}

function saveFlowNode(){
	
	$("#nodeForm").submit();
}

function addFlowNode(t){
	
	$("#nodeWin").window({
		title : $(this).attr("id")=='addNode'?'新增':'修改',
		width : 627,
		height : 254,
		resizable:false,
		modal : true
	}).show();
	
	$('#nodeForm').form('reset');
}

function initNodeForm(){
	
	$('#nodeForm').form({
		url : "flownode/save.do",
		onSubmit : function(param) {
			/*var isValid = $(this).form('validate');
			if (!isValid) {
				$.messager.progress('close'); 
												
			}
			return isValid; */
		},
		success : function(data) {

			var data = eval('(' + data + ')'); // change the JSON string to
												// javascript object
			if (data.success) {
				alert('保存成功！');

				$("#nodeWin").window('close');
				refreshWorkFlow();
			} else {
				alert(data.msg);
			}
		}
	});
}