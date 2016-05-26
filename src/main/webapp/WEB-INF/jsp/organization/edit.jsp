<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /> 
    <title>新增</title>
</head>
<body>
<div>
		<div id="dlg-toolbar" class="easyui-linkbutton-backcolor" style="padding:2px 0;">
		<table cellpadding="0" cellspacing="0" style="width:100%">
			<tr><td style="padding-left:2px"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="submitForm()">保存</a></td></tr></table>
		</div>
		<div style="padding:0px 0px 0px 0px;">
	    <form id="ff" method="post">
	    	<table>
	    		<tr><td>
		    		<input type="hidden" name="id" id="id" value="${organization.id }"/>
			        <input type="hidden" name="parentId" id="parentId" value="${organization.parentId }"/>
			    </td></tr>
			    
	    		<tr>
		    		<td>部门名称:</td>
		    		<td><input class="easyui-validatebox" type="text" id="name"  value="${organization.name }" name="name" data-options="required:true"/></td>
	    		</tr>
	    	</table>
	    </form>
	    </div>
	</div>
	
	
	<script>
		function submitForm(){
			$('#ff').form('submit', {
			    url:'<%=basePath %>organization/save',
			    onSubmit: function(){
			    	return $("#ff").form('validate');
			    },
			    success:function(d){
			    	$.messager.alert('提示','操作成功');
					$("#appendChild").dialog('close');
			    	$('#dg').datagrid('reload');
			    }
			});
		}
	</script>
</body>
</html>