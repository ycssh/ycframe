$(function(){
	
	initComponent();
	
	
	$("#addAuto").unbind('click').click(function(){addAtuoFunction();});//自动添加
	
	$("#add").bind("click",addItem);
	$("#edit").bind("click",editItem);
	$("#delete").bind("click",deleteItem);
	
	$("#save").bind("click",saveItem);
	$("#reset").bind("click",resetForm);
	
	$("#search").bind("click",doSearch);
	$("#s_reset").bind("click",resetSearchBox);
	
	
	
});

/**
 * 自动添加异常事件
 */
var addAtuoFunction = function(){
	
	 //注销操作
	if(confirm("确认自动添加?")){
		$.post('errorinfo/addAuto')
		.done(function(data){
			//alert('自动添加'+data+'条');
			alert('添加成功');
			$("#mainGrid").datagrid('reload');
		})
		.fail(function(){alert('操作失败!');});
	} 
	
	

};

function resetSearchBox(){
	
	$("#s_dept").combobox('setValue',null);
	$("#s_startTime").datebox('setValue',null);
	$("#s_endTime").datebox('setValue',null);
	$("#s_status").combobox('setValue',null);
	$("#s_ycfl").combobox('setValue',null);
	$("#s_descr").val('');
	$("#s_ycfl").combobox('setValue',null);
	$("#s_status").combobox('setValue',null);
}

function doSearch(){
	
	var dept = $.trim($("#s_dept").combobox('getValue'));
	var descr = $("#s_descr").val();
	var startTime = $.trim($("#s_startTime").datebox('getValue'));
	var endTime = $.trim($("#s_endTime").datebox('getValue'));
	var ycfl =$.trim($("#s_ycfl").combobox('getValue'));
	var status=$.trim($("#s_status").combobox('getValue'));
	if(startTime>endTime){
		alert("开始时间不能大于结束时间");
		return ;
	}
		if(top.specialCharacter(descr))
	{
		alert("异常描述中包含特殊字符，请重新输入.");
		return;
	}	
	$("#mainGrid").datagrid("load",{
		filter:"dept="+dept+"&descr="+descr+"&startTime="+startTime+"&endTime="+endTime+"&ycfl="+ycfl+"&status="+status
	});
}

function saveItem(){
	var descr = $("#s_descr").val();
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
	
	var idsInStr = ids.join(",");
	
	$.post('errorinfo/delete.do',{ids:idsInStr},function(data){
		
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
		url : "errorinfo/save.do",
		onSubmit : function(param) {
			var isValid = $(this).form('validate');
			if (!isValid) {
				$.messager.progress('close'); // hide progress bar while the
												// form is invalid
			}
			
			if($.trim($("textarea[name='descr']").val()).length==0){
				alert('请输入异常情况描述！');
				isValid = false;
			}
			if($("textarea[name='descr']").val().length>250){
				alert('异常情况描述字数不能超过250！');
				isValid = false;
			}
			/*if($("textarea[name='descr']").val().indexOf('\'')!=-1 || $("textarea[name='descr']").val().indexOf('%')!=-1)
			{
					alert("异常情况描述中包含特殊字符，请重新输入.");
			}*/
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
	    url:'errorinfo/findAll.do',
	    toolbar:"#toolbar",
	    queryParams:{
	    	filter:""
	    },
	    columns:[[
	        {field:'id',title:'编号',checkbox:true,width:40},
	        {field:'descr',title:'异常描述',width:120},
	        {field:'errorTimeDesc',title:'异常发生时间',width:40,formatter:function (value, row, index) {

	            var date = new Date(value);

	            var year = date.getFullYear().toString();

	            var month = (date.getMonth() + 1);

	            var day = date.getDate().toString();

	            var hour = date.getHours().toString();

	            var minutes = date.getMinutes().toString();

	            //var seconds = date.getSeconds().toString();

	            if (month < 10) {

	                month = "0" + month;
	            }

	            if (day < 10) {
	                day = "0" + day;
	            }
	            if (hour < 10) {
	                hour = "0" + hour;
	            }
	            if (minutes < 10) {
	                minutes = "0" + minutes;
	            }
	            //if (seconds < 10) {
	              //  seconds = "0" + seconds;
	            //}
	            return year + "/" + month + "/" + day + " " + hour + ":" + minutes;

	        }},
	        {field:'dept',title:'责任部门',width:40},
	        {field:'ycfl',title:'异常分类',width:40},
	        {field:'cruser',title:'异常事件录入人',width:40},
	        {field:'crtime',title:'异常事件录入时间',width:40,formatter:function (value, row, index) {

	            var date = new Date(value);

	            var year = date.getFullYear().toString();

	            var month = (date.getMonth() + 1);

	            var day = date.getDate().toString();

	            var hour = date.getHours().toString();

	            var minutes = date.getMinutes().toString();

	            //var seconds = date.getSeconds().toString();

	            if (month < 10) {

	                month = "0" + month;
	            }

	            if (day < 10) {
	                day = "0" + day;
	            }
	            if (hour < 10) {
	                hour = "0" + hour;
	            }
	            if (minutes < 10) {
	                minutes = "0" + minutes;
	            }
	            //if (seconds < 10) {
	              //  seconds = "0" + seconds;
	            //}
	            return year + "/" + month + "/" + day + " " + hour + ":" + minutes;

	        }},
	        {field:'status',title:'异常处理状态',width:40},
	        
	    ]],
	    rownumbers:true,
	    singleSelect:false,
	    pageSize:20,
	    autoRowHeight:true,
		fitColumns : true,
	    pagination:true
	});
}