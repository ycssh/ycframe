<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /> 
</head>
<body>
		<div id="dlg-toolbar" class="easyui-linkbutton-backcolor" style="padding:2px 0;">
		<table cellpadding="0" cellspacing="0" style="width:100%">
			<tr><td style="padding-left:2px"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="submitForm()">保存</a></td></tr></table>
		</div>
		
		<div style="padding:10px;">
			<ul id="tree"  class="ztree" style="margin-top: 5px;"></ul>
		</div>
	
<link rel="stylesheet" href="<%=basePath%>static/zTree3.5/css/zTreeStyle/zTreeStyle.css"></link>
<script src="<%=basePath%>static/zTree3.5/js/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript">
var setting = {
	async : {
		enable : true,
		url : "<%=basePath%>resource/tree",
		dataType : "json",
		type : 'get',
		autoParam : [ "id" ]
	},
	callback : {
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
	check:{
		enable: true,
		chkStyle:"checkbox",
		chkbixType:{"Y":"ps","N":"ps"}
	},
	edit:{
		enable:true,
		showRemoveBtn:false,
		showRenameBtn:false
	}
};
/**
 * 加载树的根节点的时候展开，并查询
 */
function zTreeOnAsyncSuccess(event, treeId, treeNode){
	var treeObj = $.fn.zTree.getZTreeObj("tree");
	$.get("<%=basePath%>role/resources/${roleId}",{},function(data){
		$.each(data,function(i,resource){
			var node = treeObj.getNodeByParam("id", resource.id, null);
			treeObj.checkNode(node, true, false);
		})
	},"json");
}


$(function() {
	$.fn.zTree.init($("#tree"), setting);
});

function submitForm(){
	var treeObj = $.fn.zTree.getZTreeObj("tree");
	var nodes = treeObj.getCheckedNodes(true);
	var resources= new Array();
	$.each(nodes,function(i,node){
		resources[resources.length+1]=node.id;
	})
	var resource=resources.join(",");
	$.post("<%=basePath%>role/saveresources/${roleId}",
		{"resources":resource},function(data){
    	
    	if(data.success){
    		$.messager.alert('提示','操作成功！');
			$("#resources").dialog('close');
	    	$('#dg').datagrid('reload');
    	}else{
    		$.messager.alert('错误','操作失败！');
    	}
	},"json");
}
</script>
</body>
</html>