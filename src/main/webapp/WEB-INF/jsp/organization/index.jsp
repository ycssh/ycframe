<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /> 
<jsp:include page="../inc.jsp"></jsp:include>
<link rel="stylesheet" href="<%=basePath%>static/zTree3.5/css/zTreeStyle/zTreeStyle.css"></link>
<script src="<%=basePath%>static/zTree3.5/js/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript">

var organizationId;

var setting = {
	async : {
		enable : true,
		url : "<%=basePath%>organization/ajaxtree",
		dataType : "json",
		type : 'get',
		autoParam : [ "id" ]
	},
	callback : {
		onClick : zTreeOnClick,
		onAsyncSuccess: zTreeOnAsyncSuccess
	},
	data : {
		key:{
			name:"name"
		},
		simpleData : {
			enable : true,
			idKey : "id",
			pIdKey : "parentId",
			rootPId : 0
		}
	},
	edit:{
		enable:true,
		showRemoveBtn:false,
		showRenameBtn:false
	}
};

/**Tree单击事件*/
function zTreeOnClick(event, treeId, treeNode) {
	organizationId = treeNode.id;
	$('#dg').datagrid(
	{
		queryParams:{
			"pId":treeNode.id
		}
	});
}

/**
 * 加载树的根节点的时候展开，并查询
 */
function zTreeOnAsyncSuccess(event, treeId, treeNode){
	if(treeNode==null){
		var treeObj = $.fn.zTree.getZTreeObj("tree");
		var node = treeObj.getNodeByParam("id", 0, null);
		if(organizationId ==null)
		{
			organizationId = node.id;
		}
		treeObj.expandAll(true);
		$('#dg').datagrid(
		{
			queryParams:{
				"pId":organizationId
			}
		});
	}
}

function saveItem(){
	$('#form').submit();
}
function resetForm(){
	
	var id = $("#id").val();
	$('#form').form('reset');
	
	if(id&&id.length>0){
		var r = $("#dg").datagrid('getChecked');
		
		if(r&&r.length==1){
			$("#form").form('load',r[0]);
		}
	}
}

$(function() {
	initForm();
	
	$("#save").bind("click",saveItem);
	$("#reset").bind("click",resetForm);
	$.fn.zTree.init($("#tree"), setting);
	
	
	$('#dg').datagrid({
		url : '<%=basePath%>organization/list',
		toolbar: [
					{  
			            text: '添加',  
			            iconCls: 'icon-add',  
			            handler: function() {  
			            	deptAdd();
			            }  
			        }, '-', 
			                  {  
			            text: '修改',  
			            iconCls: 'icon-edit',  
			            handler: function() {  
			            	deptEdit();
			            }  
			        }, '-',{  
			            text: '删除',  
			            iconCls: 'icon-remove',  
			            handler: function(){  
			            	deptDelete();
			            }  
			        }
		],onRowContextMenu:onRowContextMenu
	});
	
	$("#dg").datagrid('hideColumn', "id");
});
function onRowContextMenu(e,row){
	var rm = $('#rm_organization');
	e.preventDefault();
	rm.menu({
		onClick:function(item){
		     if(item.text=='刷新'){
		        datagrid.datagrid('reload');
		     }
		 }
	});
	rm.menu('show',{
		left: (e.pageX+20),
		top: (e.pageY-20)
	});
};

function reload(){
	$.fn.zTree.init($("#tree"), setting);
}

function deptAdd(){
	 if(organizationId==null){
    	$.messager.alert('提示','请选择左侧选择部门');
    	return;
	 } 
	
	$("#window").window({
		title : "新增",
		width : 600,
		height : 320,
		modal : true
	}).show();
	
	$('#form').form('reset');
	$("#parentId").val(organizationId);
}

function initForm(){
	
	$('#form').form({
		url : "save.do",
		onSubmit : function(param) {
			var isValid = $(this).form('validate');
			if (!isValid) {
				$.messager.progress('close'); // hide progress bar while the
												// form is invalid
			}
			
			var orgName = $("#name").val();
			if(orgName.length>100){
				$.messager.alert("错误","组织名称长度不能超过100个字符！");
				return false;
			}
			return isValid; // return false will stop the form submission
		},
		success : function(data) {
			// alert(data)

			var data = eval('(' + data + ')'); // change the JSON string to
												// javascript object
			if (data.success) {

				$.messager.alert("提示","保存组织成功！");
				$("#window").window('close');
				refreshItem();
			} else {
				alert(data.msg);
			}
		}
	});
}

function refreshItem(){
	
	$("#dg").datagrid('reload');
	reload();
}

function deptEdit(){
	var row = $('#dg').datagrid('getSelected');
	if(!row){
    	$.messager.alert('提示','请选择要编辑的记录');
    	return ;
	}
	
	$("#window").window({
		title : "修改",
		width : 600,
		height : 320,
		modal : true
	}).show();
	
	$('#form').form('reset');
	$("#form").form('load',row);
}

function deptDelete(){
	var row = $('#dg').datagrid('getSelected');
	if(!row){
    	$.messager.alert('提示','请选择要上删除的记录');
    	return ;
	}
	if(confirm("确定删除?")){
		$.post("<%=basePath%>organization/delete/"+row.id,{},function(data){
			if(data.success){
				$.messager.alert('提示','删除成功！');
			}else{
				$.messager.alert('提示','删除失败！');
			}
	    	
	    	$('#dg').datagrid('reload');
	    	reload();
		},"JSON");
	}
}
</script>

</head>
<body class="easyui-layout">
<div data-options="region:'west',split:true,title:'部门树',tools : [ {
						iconCls : 'icon-reload',
						handler : reload
					}]" style="width:200px;padding:10px;">
	<ul id="tree"  class="ztree" style="margin-top: 5px;"></ul>
</div>
<div data-options="region:'center',href:'',title:'列表'" style="overflow: hidden;" id="center">
	<table id="dg" >
		<thead>  
			<tr> 
				<th data-options="field:'ck',checkbox:true"></th>
	        	<th data-options="field:'id'" >部门编号</th>  
				<th data-options="field:'name'">部门名称</th>
				<th data-options="field:'power'">部门权限</th>
	        </tr>
	    </thead>
	</table>
</div>
	<div id="appendChild"></div>
	
	
	<!-- Window -->
	<div id="window" style="display: none;">

		<form id="form" method="post">

			<input class="easyui-validatebox" type="text" id="id" name="id"
				style="width:350;display: none;" />
			<input class="easyui-validatebox" type="text" id="parentId" name="parentId"
				style="width:350;display: none;" />

			<fieldset style="margin-top: 10px">
				<legend>组织信息</legend>
				<table width="100%">
				
					<tr>
						<td><label for="name">名称:</label>
						</td>
						<td><input id="name" name="name" class="easyui-validatebox" style="width: 330px" data-options="required:true">
						</td>
					</tr>
					
					
					<tr>
						<td><label for="power">部门权限:</label>
						</td>
						<td><input id="power" name="power" class="easyui-validatebox" style="width: 330px" data-options="required:true">
						</td>
					</tr>
					

				</table>
			</fieldset>

			<table width="100%">
				<tr>
					<td align="center"><a id="save" href="#"
						class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
						<a id="reset" href="#" class="easyui-linkbutton"
						data-options="iconCls:'icon-reset'">重置</a></td>
				</tr>
			</table>

		</form>

	</div>
</body>
</html>