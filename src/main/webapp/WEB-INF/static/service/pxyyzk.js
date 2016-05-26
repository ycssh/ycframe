$(function(){
	
	initComponent();
	
	$("#add").bind("click",addItem);
	$("#edit").bind("click",editItem);
	$("#delete").bind("click",deleteItem);
	
	$("#save").bind("click",saveItem);
	$("#reset").bind("click",resetForm);
	
	$("#search").bind("click",doSearch);
	$("#s_reset").bind("click",resetSearchBox);
});

function resetSearchBox(){
	
	$("#s_deptId").combobox('setValue',null);
	$("#s_projectId").combobox('setValue',null);
	$("#s_majorId").combobox('setValue',null);
}

function doSearch(){
	
	var deptId = $.trim($("#s_deptId").combobox('getValue'));
	var projectId = $.trim($("#s_projectId").combobox('getValue'));
	var majorId = $.trim($("#s_majorId").combobox('getValue'));
	
	$("#mainGrid").datagrid("load",{
		filter:"type=1&deptId="+deptId+"&projectId="+projectId+"&majorId="+majorId
	});
}

function saveItem(){
	$('#form').submit();
}

function resetForm(){
	
	var id = $("#id").val();
	$('#form').form('reset');
	
	if(id&&id.length>0){
		var r = $("#mainGrid").datagrid('getChecked');
		
		if(r&&r.length==1){
			$("#form").form('load',r[0]);
			
			//$("#cpsjDesc").datebox('setValue',formatDate(new Date(r[0].cpsj)));
		}
	}
}

function formatDate(date){
	
	var y = date.getFullYear();
	var m = date.getMonth()+1;
	m = m<10?'0'+m:m;
	var d = date.getDate();
	d = d<10?'0'+d:d;
	return y+'-'+m+'-'+d;
}

function addItem(){
	
	showWindow("新增");
}

function editItem(){
	
	var r = $("#mainGrid").datagrid('getChecked');
	if(!r||r.length==0){
		alert('请选择待修改的信息！');
		return;
	}
	if(r.length!=1){
		alert('请选择一条待修改的信息！');
		return;
	}
	/*if(r[0].isBL!="1"){
		alert("非补录数据不允许编辑！");
		return;
	}*/
	
	showWindow("修改信息");
	$("#form").form('load',r[0]);
	//$("#cpsjDesc").datebox('setValue',formatDate(new Date(r[0].cpsj)));
}

function deleteItem(){
	
	
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
		/*if(r[i].isBL!="1"){
			alert("非补录数据不允许删除，请取消选择非补录数据！");
			return;
		}*/
		ids.push(r[i].id);
	}
	
	$.post('pxyyzk/deleteXyg.do',{ids:ids.join(',')},function(data){
		
		//var data = eval('(' + data + ')'); // change the JSON string to
		// javascript object
		if (data.success) {
			alert('删除成功！');

			refreshItem();
		} else {
			alert(data.msg);
		}
	},"JSON");
}

function refreshItem(){
	
	$("#mainGrid").datagrid('reload');
}
function initComponent(){
	
	initGrid();
	initForm();
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

function initForm(){
	
	$('#form').form({
		url : "pxyyzk/saveXyg.do",
		onSubmit : function(param) {
			var isValid = $(this).form('validate');
			if (!isValid) {
				$.messager.progress('close'); // hide progress bar while the
												// form is invalid
			}
			return isValid; // return false will stop the form submission
		},
		success : function(data) {
			// alert(data)

			var data = eval('(' + data + ')'); // change the JSON string to
												// javascript object
			if (data.success) {
				alert('保存成功！');

				$("#window").window('close');
				refreshItem();
			} else {
				alert(data.msg);
			}
		}
	});
}

function initGrid(){
	
	$('#mainGrid').datagrid({
	    url:'pxyyzk/findAllXyg.do',
	    toolbar:"#toolbar",
	    queryParams:{
	    	filter:"type=1"
	    },
	    columns:[[
	        {field:'id',title:'编号',checkbox:true,width:40},
	        {field:'deptName',title:'专业培训部',width:80},
	        {field:'majorName',title:'专业',width:80},
	        {field:'className',title:'班级',width:120},
	        {field:'solution',title:'培训方案编制',width:40,formatter:zkFormatter,align:'center'},
	        {field:'kcb',title:'课程表编制',width:40,formatter:zkFormatter,align:'center'},
	        {field:'wzx',title:'晚自习教室安排',width:40,formatter:zkFormatter,align:'center'},
	        {field:'bzr',title:'班主任/辅导员安排',width:40,formatter:zkFormatter,align:'center'},
	        {field:'bd',title:'学员报到',width:40,formatter:zkFormatter,align:'center'},
	        {field:'qywh',title:'企业文化和主营业务成绩报送',width:40,formatter:zkFormatter,align:'center'},
	        {field:'jsbs',title:'技能竞赛笔试成绩报送',width:40,formatter:zkFormatter,align:'center'},
	        {field:'jscz',title:'技能竞赛操作成绩报送',width:40,formatter:zkFormatter,align:'center'},
	        {field:'jx',title:'军训成绩报送',width:40,formatter:zkFormatter,align:'center'},
	        {field:'yd',title:'月度成绩报送',width:40,formatter:zkFormatter,align:'center'},
	        {field:'jy',title:'结业成绩报送',width:40,formatter:zkFormatter,align:'center'},
	        {field:'yxxy',title:'优秀学员评选',width:40,formatter:zkFormatter,align:'center'},
	        {field:'yxgb',title:'优秀学员干部评选',width:40,formatter:zkFormatter,align:'center'},
	        {field:'isBL',title:'是否补录',width:20}
	    ]],
	    rownumbers:true,
	    singleSelect:false,
	    autoRowHeight:false,
		fitColumns : true,
		pageSize:10,
	    pagination:true
	});
}

function zkFormatter(val,row,index){
	
	return '<img src="static/images/yyzk'+val+'.png" width="20" />';
}