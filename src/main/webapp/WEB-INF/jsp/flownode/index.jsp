<%@page import="org.springframework.util.StringUtils"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
			

	String flowId = request.getParameter("flowId");
	if(!StringUtils.hasLength(flowId)){
		out.print("<font color=red>打开页面错误！</font>");
		return;
	}
	
%>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /> 
<base href="<%=basePath%>">

<title>配置工作流-<%=flowId %></title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

<style type="text/css">
.sfn{
	border: 1px solid rgb(200,200,200);
	padding: 5px 30px;
	margin: 1px auto;
	width: 400px;
	text-align: center;
}
.sfn_pic{
	padding: 5px 30px;
	margin: 1px auto;
	width: 400px;
	text-align: center;
}
.sfn1{
	border: 1px solid rgb(200,200,200);
	padding: 5px 30px;
	margin: 1px auto;
	width: 400px;
	text-align: center;
	font-size: 12px;
	font-weight: bold;
}
.sfn:hover,.cur{
	border-color:red;
	color: red; 
}


</style>
<link rel="stylesheet" type="text/css"
	href="<%=basePath %>static/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath %>static/easyui/themes/icon.css">
<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/easyui/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>

</head>
<body>
<script type="text/javascript" src="<%=basePath %>static/service/flownode.js"></script>

	<div>
			<div id="addNode" class="easyui-linkbutton"
			data-options="iconCls:'icon-add',plain:true">新增节点</div>
			 <div id="editNode" class="easyui-linkbutton"
				data-options="iconCls:'icon-edit',plain:true">修改节点</div>
			<div id="deleteNode" class="easyui-linkbutton"
				data-options="iconCls:'icon-remove',plain:true">删除节点</div>
	</div>
	
	<div id="liucheng" class="easyui-panel" style="width:680px;height: 320px" title="流程" data-options="iconCls:'icon-ok',tools:[
				{
					iconCls:'icon-reload',
					handler:function(){refreshWorkFlow()}
				}]">
    </div>
    
    <!-- Window -->
	<div id="nodeWin" style="display: none;">
	
		<form id="nodeForm" method="post">
			<input id="flowId" name="flowId" type="hidden" value="<%=flowId%>">
			<input id="oprUser" name="oprUser" type="hidden" >
			<input id="id" name="id" type="hidden" >
		
			<fieldset style="margin-top: 10px">
				<legend>信息</legend>
				<table width="100%">
					
					<tr>
						<td><label for="name">节点名称:</label>
						</td>
						<td><input  validType="length[0,50]" invalidMessage="不能超过50个字符！" id="name" name="name" style="width: 400px" class="easyui-validatebox" data-options="required:true">
						</td>
					</tr>
					<tr>
						<td><label for="name">指派用户方式:</label>
						</td>
						<td><input id="oprUserType" name="oprUserType"  style="width: 400px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        required:true,
        editable:false,
        data:[{name:'用户',value:1},{name:'角色',value:2}],
        onSelect:function(rec){
        	if(rec.value==1){
        		$('#user_mode').show();
        		$('#role_mode').hide();
        	}else{
        		$('#user_mode').hide();
        		$('#role_mode').show();
        	}
        }">
						</td>
					</tr>
					<tr>
						<td><label for="name">指派处理人:</label>
						</td>
						<td><div id="user_mode" style="display: none;"><input id="user_mode_input" name="user_mode"  style="width: 400px" class="easyui-combobox" data-options="
        valueField: 'username',
        textField: 'username',
        url:'user/listall.do',
        editable:false,
        onSelect:function(rec){
        	$('#oprUser').val(rec.username);
        }"></div>
        					<div id="role_mode" style="display: none;"><input id="role_mode_input" name="role_mode"  style="width: 400px" class="easyui-combobox" data-options="
        valueField: 'role',
        textField: 'name',
        editable:false,
        url:'role/listall.do',
        onSelect:function(rec){
        	$('#oprUser').val(rec.role);
        }"></div>
						</td>
					</tr>
					
				</table>
			</fieldset>
			
			<table width="100%">
				<tr>
					<td align="center"><a id="saveNode" href="javascript:void()"
						class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
						<a id="resetNode" href="javascript:void()" class="easyui-linkbutton"
						data-options="iconCls:'icon-reset'">重置</a></td>
				</tr>
			</table>
		</form>
	</div>
	
</body>
</html>
