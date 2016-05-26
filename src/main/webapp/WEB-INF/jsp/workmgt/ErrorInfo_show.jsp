<%@page import="com.sgcc.yyjk.de.po.stat.ErrorInfo"%>
<%@page import="cn.yc.ssh.stat.util.BeanFactory"%>
<%@page import="cn.yc.ssh.stat.dao.IErrorInfoDAO"%>
<%@page import="org.springframework.util.StringUtils"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
			
	String objId = (String)request.getAttribute("objId");
	if(!StringUtils.hasLength(objId)){
		
		out.print("<font color=red>发生错误，未获取到ID！</font>");
		return;
	}
	
	
	IErrorInfoDAO errorInfoDAO = (IErrorInfoDAO)BeanFactory.getBean("errorInfoDAO");
	ErrorInfo ei = errorInfoDAO.findById(objId); 
	
	if(ei==null){
		out.print("<font color=red>对不起，未获取到异常事件对象，可能该异常信息已经被删除！</font>");
		return;
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /> 
<base href="<%=basePath%>">

<title>异常事件展示-工作流</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style type="text/css">
table td{
	font-size: 12px;
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

<body >

		<form id="form" method="post">

			<input class="easyui-validatebox" type="text" id="id" name="id"
				style="width:350;display: none;" value="<%=objId %>" />

				<table width="100%">
					
					<tr>
						<td><label for="name">异常事件描述:</label>
						</td>
						<td colspan="3"><textarea readonly="readonly" rows="8" cols="60" name="descr"><%=ei.getDescr() %></textarea>
						</td>
					</tr>
					
					<tr>
						<td><label for="name">责任部门:</label>
						</td>
						<td><input id="dept" readonly="readonly" name="dept" value="<%=ei.getDept() %>"  style="width: 170px" class="easyui-textbox" >
						</td>
						<td><label for="name">异常发生时间:</label>
						</td>
						<td><input class="easyui-textbox" readonly="readonly" id="errorTimeDesc" name="errorTimeDesc" 
        value="<%=ei.getErrorTime() %>">
						</td>
					</tr>
					<tr>
						<td><label for="name">信息录入人:</label>
						</td>
						<td><input id="dept" name="dept" readonly="readonly" value="<%=ei.getCruser() %>"  style="width: 170px" class="easyui-textbox" >
						</td>
						<td><label for="name">信息录入时间:</label>
						</td>
						<td><input class="easyui-textbox" readonly="readonly" id="errorTimeDesc" name="errorTimeDesc" 
        value="<%=ei.getCrtime()%>">
						</td>
					</tr>

				</table>

		</form>
	
	
</body>
</html>
