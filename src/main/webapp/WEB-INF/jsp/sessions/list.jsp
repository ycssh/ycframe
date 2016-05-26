<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="ycfn" uri="/madmin-functions" %>
<html>
<head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /> 
<jsp:include page="../inc.jsp"></jsp:include>
<script type="text/javascript">
$(function(){

	$('#dg').datagrid({
		url : '<%=basePath%>sessions/list',
		method:'post',
		columns:[[ 
           {title:'姓名',field:'userName',width:180}, 
           {title:'登录IP',field:'host',width:180}, 
           {title:'登录时间',field:'loginTime',width:180}, 
           {field:'sessionId',title:'选择',formatter: function(value,row,index){
        	   return "<a href='${pageContext.request.contextPath}/sessions/"+value+"/forceLogout'>强制退出</a>";
           }}
            
           ]] 
	});
})
</script>
</head>
<body class="easyui-layout">
	<!-- 显示的表格 -->
	<div data-options="region:'center',href:'',title:'在线用户列表'" style="overflow: hidden;" id="center">
		<table id="dg">
					<thead>  
							<tr>  
								<th field="ck" checkbox="true"></th>
								<th field="sessionId" >会话id</th>  
								<th field="userName" >用户名</th> 
								<th field="host" >登录IP</th>  
								<th field="loginTime" >登录时间</th>  
								<th>
                       			 <a href="${pageContext.request.contextPath}/sessions/sessionId/forceLogout">强制退出</a>
                       			</th>
							</tr>  
					 </thead>  
		</table>
	</div>
</body>
</html>