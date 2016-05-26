<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /> 
<title>培训管理信息系统</title>
		<link rel="stylesheet" href="../artdialog/skins/blue.css"></link>
		<script type="text/javascript" src="../artdialog/artdialog.js"></script>
		<script type="text/javascript" src="../artdialog/iframetools.js"></script>
</head>
<body>
<input type="hidden" id="type" value="1"></input>
<input type="hidden" id="username" value="<%=request.getParameter("username")%>"></input>
<input type="hidden" id="password" value="<%=request.getParameter("password")%>"></input>
<mx:WebletContainer id="loginContainer" webletID="login"  bundleName="main"></mx:WebletContainer>

</body>
</html>