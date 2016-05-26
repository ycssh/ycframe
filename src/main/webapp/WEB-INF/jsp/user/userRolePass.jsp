<%@page import="cn.yc.ssh.admin.base.mybatis.model.UserAllInfo"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
	String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

UserAllInfo u = (UserAllInfo)request.getAttribute("user");
%>
<html>
<head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /> 
    <title>角色分配状态审核</title>
</head>
<body>
<div class="easyui-panel">
		<div id="dlg-toolbar" class="easyui-linkbutton-backcolor" style="padding:2px 0;">
			<table cellpadding="0" cellspacing="0" style="width:100%">
				<tr>
				<td style="padding-left:2px">
				<a href="javascript:void(0)" id="okButtom" class="easyui-linkbutton" data-options="iconCls:'icon-ok',plain:true">通过</a>
				<a href="javascript:void(0)" id="cancelButtom" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true">取消</a>
				</td>
				</tr>
			</table>
		</div>
		<div style="padding:0px 0px 0px 0px;">
	    <form id="ff" method="post" style="padding-left: 15.5%;">
	    	<table>
	    		<tr>
		    		<td>用户名:</td>
		    		<td><input maxlength="50" class="easyui-validatebox" type="text" id="loginName"  value="${user.loginName}" name="loginName" data-options="required:true"  readonly="readonly"/></td>
	    		</tr>
	    		<tr>
		    		<td>姓名:</td>
		    		<td><input maxlength="50" class="easyui-validatebox" type="text" id="realName" value="${user.realName}" name="realName" data-options="required:true" readonly="readonly"/></td>
		    	</tr>
		    	<tr>
		    		<td>角色名称:</td>
		    		<td><input maxlength="50" class="easyui-validatebox" type="text" id="roleName" value="${user.roleName}" name="roleName" readonly="readonly"/></td>
		    	</tr>
		    	<tr>
		    		<td>角色分配状态:</td>
		    		<td><input maxlength="50" class="easyui-validatebox" type="text" id="syURoleName" value="${user.syURoleName}" name="syURoleName" data-options="required:true" readonly="readonly"/></td>
		    	</tr>
		    	
		    	<tr><td>
		    		<input type="hidden" name="userId" id="userId" value="${user.userId }"/>
			    </td></tr>
		    		    	
	    	</table>
	    </form>
	    </div>
	</div>
	
	
	<script>
<%-- 		//点击提交后
		function submitForm(){
			$('#ff').form('submit', {
			    url:'<%=basePath %>role/save',
			    onSubmit: function(){
			    	return $("#ff").form('validate');
			    },
			    success:function(d){
			    	$.messager.alert('提示','操作成功');
					$("#appendChild").dialog('close');
			    	$('#dg').datagrid('reload');
			    }
			});
		} --%>
		
		$(function(){
			//点击确认
			$('#okButtom').unbind('click').click(function(){
				//若ID 为3 则，未激活变为激活。  若ID为4 待删除变为删除		
				$.post('<%=basePath %>user/sysRoleUpdate',{userId:${user.userId}})
				.done(function(data){
					$.messager.alert('提示','操作成功');
					$("#appendChild").dialog('close');
			    	$('#dg').datagrid('reload');
				})
				.fail(function(){
					alert('操作失败');
				});
				
							
			});
			
			//点击取消后，消除弹出框
			$('#cancelButtom').unbind('click').click(function(){
				$("#appendChild").dialog('close');
			});
		});
	</script>
</body>
</html>