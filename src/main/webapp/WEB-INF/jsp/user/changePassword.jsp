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
		    		<td><input class="easyui-validatebox" type="text" id="name" name="name" disabled="disabled" value="${user.name}" data-options="required:true"/></td>
	    		</tr>
	    		<tr>
		    		<td>登录帐号:</td>
		    		<td><input class="easyui-validatebox" type="text" id="username" disabled="disabled"  value="${user.username}" name="username" data-options="required:true"/></td>
		    	</tr>
		    	<tr>
		    		<td>原始密码:</td>
		    		<td><input class="easyui-validatebox" type="password" id="password" value="" name="password" data-options="required:true"/></td>
		    	</tr>
		    	<tr>
		    		<td>新密码:</td>
		    		<td><input class="easyui-validatebox" type="password" id="passworda" name="passworda" data-options="required:true" validType="length[8,20]"/></td>
		    	</tr>
		    	<tr>
		    		<td>重复登录密码:</td>
		    		<td><input class="easyui-validatebox" type="password" id="passwordab" name="passwordab" data-options="required:true"/></td>
		    	</tr>
	    	</table>
	    	<input type="hidden" name="md5" id="md5">
	    </form>
	    </div>
	</div>
	
	
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/CryptoJS/components/core.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/CryptoJS/rollups/aes.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/CryptoJS/rollups/md5.js"></script>
	<script>

	 function Encrypt(word){
		 var key = CryptoJS.enc.Utf8.parse(aesKey);	
		 var iv  = CryptoJS.enc.Utf8.parse(aesKey);	
		 var srcs = CryptoJS.enc.Utf8.parse(word);
		 var encrypted = CryptoJS.AES.encrypt(srcs, key, { iv: iv,mode:CryptoJS.mode.CBC});
	     return encrypted.toString();
	}
		var aesKey = "<%=session.getAttribute("aesKey")%>";
		function submitForm(){
			$('#ff').form('submit', {
			    url:'<%=basePath %>user/changePassword',
			    onSubmit: function(){
	    		    var now=$("#passworda").val();
		    		if($("#passwordab").val()!=$("#passworda").val()){
		    			$.messager.alert('错误','新密码与重复密码不一致！');
		    			return false;
		    		}
	    		    if(now==$("#username").val()){
			    		alert("用户名不能和密码一致");
			    		return false;
	    		    }
	    		    var reg = /^(?=.*\d.*)(?=.*[a-zA-Z].*).{8,20}$/;
			    	if(reg.test(now)){
			    		if($("#ff").form('validate')){
				            $("#password").val(Encrypt($("#password").val()));
				            $("#passworda").val(Encrypt($("#passworda").val()));
							var hash = CryptoJS.MD5($("#passworda").val());
							$("#md5").val(hash);
				            $("#passwordab").val(Encrypt($("#passwordab").val()));
				            return true;
			    		}
			    	}else{
			    		alert("新密码必须包含数字和字母");
			    		return false;
			    	};
			    	return $("#ff").form('validate');
			    },
			    success:function(d){
			    	if(d!=""){
				    	$.messager.alert('提示',d);
				    	$("#password").val("");
				    	$("#passworda").val("");
				    	$("#passwordab").val("");
			    	}else{
				    	$.messager.alert('提示','操作成功');
						$("#resetpwds").dialog('destroy');
			    	}
			    }
			});
		}
	</script>
</body>
</html>