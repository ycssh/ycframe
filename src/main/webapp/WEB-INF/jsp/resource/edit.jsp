<%@page import="org.springframework.util.StringUtils"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
	<head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /> 
	    <title></title>
	    

	</head>
	
<body>
	<div id="dlg-toolbar" class="easyui-linkbutton-backcolor" style="padding:2px 0;">
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" id="saveButton">保存</a>
	</div>
	<form action="<%=basePath%>resource/save" id="saveform" method="post" enctype="multipart/form-data">
    	<input type="hidden" value="${resource.id }" name="id" id="id">
    	<input type="hidden" value="${resource.parentId }" name="parentId" id="parentId">
       <table>
       	<tr><td>名称</td><td><input name="name" value="${resource.name }" id="name" style="width:250px;"> </td></tr>
       	<tr><td>url</td><td><input name="url" value="${resource.url}" id="url" style="width:250px;"></td></tr>
       	<tr><td>权限字符串</td><td><input name="permission" value="${resource.permission}" id="permission" style="width:250px;"></td></tr>
       	<tr><td>类型</td><td>
       		<select name="type" id="type" style="width:250px;">
       			<option value="menu">菜单</option>
       			<option value="button">按钮</option>
       		</select>
       		</td></tr>
       </table>
    </form>
	<script type="text/javascript" src="<%=basePath%>static/js/jquery.form.js"></script>
	<script type="text/javascript">
	$(function(){
		$("#type").val("${resource.type}");
		$("#saveButton").bind("click",function(){
			$("#saveform").ajaxSubmit({
				type : "post",
				success : function(data) {
					alert("保存成功");	
					$("#dlg").dialog("close");
				},
				error:function(data){
					$.messager.alert('提示',data.responseText)
				}
			})
		})
	})
		
	</script>


</body>

</html>