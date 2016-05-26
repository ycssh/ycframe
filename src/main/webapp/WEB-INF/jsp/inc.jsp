<%@ page language="java" pageEncoding="UTF-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String version="1.3.5";
String contextPath = request.getContextPath();
%>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="easyui">
<meta http-equiv="description" content="easyui">


<script type="text/javascript" src="<%=basePath%>static/js/jquery-1.11.0.min.js" charset="utf-8"></script>
<!-- easyui相关库 -->
<script type="text/javascript" src="<%=basePath%>static/easyui/jquery.easyui.min.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=basePath%>static/js/system.js" charset="utf-8"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>static/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>static/easyui/themes/icon.css">

<script type="text/javascript" src="<%=basePath%>static/easyui/easyui-lang-zh_CN.js" charset="utf-8"></script>
