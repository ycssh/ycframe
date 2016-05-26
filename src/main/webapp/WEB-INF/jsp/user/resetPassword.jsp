<%@page import="cn.yc.ssh.admin.base.mybatis.model.User"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /> 
    <title>重置密码</title>
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
		    		<input type="hidden" name="userId" id="userId" value="${user.id}"/>
		    		<input type="hidden" name="usernamepwd" id="usernamepwd" value="${user.username}"/>
			        <input type="hidden" name="organizationId" id="organizationId" value="${user.organizationId}"/>
			    </td></tr>
			    
	    		<tr>
		    		<td>姓名:</td>
		    		<td><input class="easyui-validatebox"  style="width:100%" type="text" id="name" name="name" disabled="disabled" value="${user.name}" data-options="required:true"/></td>
	    		</tr>
	    		<tr>
		    		<td>登录帐号:</td>
		    		<td><input class="easyui-validatebox" type="text"  disabled="disabled"  value="${user.username}" data-options="required:true"/></td>
		    	</tr>
		    	<tr>
		    		<td>新密码:</td>
		    		<td><input class="easyui-validatebox" type="password" id="passwordaa" name="passwordaa" data-options="required:true" validType="length[8,20]"/></td>
		    	</tr>
		    	<tr>
		    		<td>重复登录密码:</td>
		    		<td><input class="easyui-validatebox" type="password" id="passwordab" name="passwordab" data-options="required:true"/></td>
		    	</tr>
	    	</table>
	    	<input type="hidden" id="md55" name="md55"/>
	    </form>
	    </div>
	</div>
	
	
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/CryptoJS/components/core.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/CryptoJS/rollups/aes.js"></script>
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
		var url = '<%=basePath %>user/resetPassword/'+$("#userId").val();
		$('#ff').form('submit', {
		    url:url,
		    onSubmit: function(){
	    		if($("#passwordab").val()!=$("#passwordaa").val()){
	    			$.messager.alert('错误','新密码与重复密码不一致！');
	    			return false;
	    		}
	    		if($("#usernamepwd").val()==$("#passwordaa").val()){
	    			$.messager.alert('错误','密码不能与账号名一致！');
	    			return false;
	    		}			    		
    		    var now=$("#passwordaa").val();
    		    var reg = /^(?=.*\d.*)(?=.*[a-zA-Z].*).{8,20}$/;
		    	if(reg.test(now)){
		    		if($("#ff").form('validate')){
			            $("#passwordaa").val(Encrypt($("#passwordaa").val()));
			            $("#passwordab").val(Encrypt($("#passwordab").val()));
						var hash = CryptoJS.MD5($("#passwordaa").val()).toString();
						$("#md55").val(hash);
			            return true;
		    		}
		    	}else{
		    		alert("密码必须包含数字和字母的8-20位字符");
		    		return false;
		    	};
		    	return $("#ff").form('validate');
		    },
		    success:function(d){
		    	if(d!=""){
			    	$.messager.alert('提示',d);
			    	$("#passwordaa").val("");
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