<%@page import="cn.yc.ssh.admin.base.mybatis.model.User"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

User u = (User)request.getAttribute("user");
%>
<html>
<head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /> 
    <title>新增</title>
</head>
<body>
<div class="easyui-panel">
		<div id="dlg-toolbar" class="easyui-linkbutton-backcolor" style="padding:2px 0;">
		<table cellpadding="0" cellspacing="0" style="width:100%">
			<tr><td style="padding-left:2px"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="submitForm()">保存</a></td></tr></table>
		</div>
		<div style="padding:0px 0px 0px 0px;">
	    <form id="ff" method="post">
	    	<table>
	    		<tr><td>
		    		<input type="hidden" name="id" id="id" value="${user.id }"/>
			        <input type="hidden" name="organizationId" id="organizationId" value="${user.organizationId}"/>
			    </td></tr>
			    
	    		<tr>
		    		<td>姓名:</td>
		    		<td><input maxlength="50" class="easyui-validatebox" type="text" id="name" name="name"  value="${user.name}" data-options="required:true"/></td>
	    		</tr>
	    		<tr>
		    		<td>登录帐号:</td>
		    		<td><input maxlength="50" class="easyui-validatebox" type="text" id="username" value="${user.username}" name="username" data-options="required:true"/></td>
		    	</tr>
		    	<%if(u.getId()==null){ %>
		    	<tr>
		    		<td>登录密码:</td>
		    		<td><input maxlength="50" class="easyui-validatebox" type="password" id="password" value="${user.password}" name="password" data-options="required:true"/></td>
		    	</tr>
		    	<tr>
		    		<td>重复登录密码:</td>
		    		<td><input maxlength="50" class="easyui-validatebox" type="password" id="passworda" value="${user.password}" name="passworda" data-options="required:true"/></td>
		    	</tr>
		    	<%} %>
	    	</table>
	    </form>
	    </div>
	</div>
	
	
	<script>
		var isAdd = "<%=u.getId()==null%>";
		
		function submitForm(){
			$('#ff').form('submit', {
			    url:'<%=basePath %>user/create',
			    onSubmit: function(){
			    	if(isAdd=="true"){
			    		if($("#password").val()!=$("#passworda").val()){
			    			$.messager.alert('错误','密码与重复密码不一致！');
			    			return false;
			    		}
			    	}
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