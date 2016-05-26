<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf" %> 
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /> 
<base href="<%=basePath%>">

<title>全景展示</title>

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
<link rel="stylesheet" href="<%=basePath %>static/new/stylesheets/screen.css">
<link rel="stylesheet" href="<%=basePath %>static/new/stylesheets/bootstrap.min.css">
<script type="text/javascript" src="<%=basePath %>static/new/javascript/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/new/javascript/bootstrap.min.js"></script>
<script src="<%=basePath %>static/new/javascript/chart1Jq.js" charset="UTF-8" type="text/javascript"></script>
<script src="<%=basePath %>static/service/jxqjzs.js" charset="UTF-8" type="text/javascript"></script>

</head>

<body>
   
  <div class="content">
	
		<div class="contentRight">
			<div class="boxWrap" id="slides">
				<ul class="clearfix tab-content tabContent">
				   <c:forEach items="${imgNameList}" var="nameList">
					<li class="tab-pannel tabPannel li1"><img src="<%=basePath %>static/images/jxqjzsImg/fyjdzs/${nameList.imgName}" alt=""></li>
					<!--  <li class="tab-pannel tabPannel li2"><img src="<%=basePath %>static/images/jxqjzsImg/view1/slide-2.jpg" alt=""></li>
					<li class="tab-pannel tabPannel li3"><img src="<%=basePath %>static/images/jxqjzsImg/view1/slide-3.jpg" alt=""></li>
					<li class="tab-pannel tabPannel li4"><img src="<%=basePath %>static/images/jxqjzsImg/view1/slide-4.jpg" alt=""></li>
					<li class="tab-pannel tabPannel li5"><img src="<%=basePath %>static/images/jxqjzsImg/view1/slide-5.jpg" alt=""></li>
					<li class="tab-pannel tabPannel li6"><img src="<%=basePath %>static/images/jxqjzsImg/view1/slide-6.jpg" alt=""></li>-->
					</c:forEach>
				</ul>
				<div class="leftOpacityBox">
					<div class="leftTip icons-left" id="J_pre"></div>
				</div>
				<div class="rightOpacityBox">
					<div class="rightTip icons-right" id="J_next"></div>
				</div>
			</div>
		</div>
     <!--  <form name="upload" action="<%=basePath %>/jxqjzs/upload2" enctype="multipart/form-data" method="post">
  <input type="file" name="thefile" value="选择图片"/> <input type="submit" value="上传图片" />
 </form>-->
</div>
  
</body>
</html>
