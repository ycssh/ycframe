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

<title>教学实时监测</title>

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
<link rel="stylesheet" type="text/css"
	href="<%=basePath %>static/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath %>static/easyui/themes/icon.css">
<script type="text/javascript">
 function exportSched(){
	 var date = $("#wantTime").val();
	 if(date==null||date==""){
		 alert("请选择日期");
	 }
	 var uri="<%= basePath%>";
	 var path="jxssjc/export?date="+date;
	 window.open(uri+path);
}
</script>

</head>

<body>
   
   <div class="content">
       <!--  <div class="wrapNav"></div>--> 
        <div class="contentRight">
                <div class="queryDiv">
                    <label for="">日期:</label>
                    <div class="selectDiy largeSelectDiy">
                         <input class="Wdate" type="text" onClick="WdatePicker()" id="wantTime" name="wantTime"></input>
                    </div>
                    <div class="queryDiv">
                        <button id="searchAll" class="search">检索</button>
                        <button id="export" class="report">导出</button>
                    </div>
                </div>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-6">
                        <div class="moduleDiv moduleDivAuto">
                            <p class="moduleTitle icons-moduleTitleBg">新员工教学实时监测</p>
                            <div class="row rowDiy">
                                <div class="col-xs-4 maginTop15">
                                    <div class="tagImg icons-zhuanyeshu"></div>
                                    <p class="tagName">今日办班（个）</p>
                                    <p id="cnclass" class="tagNum"></p>
                                </div>
                                <div class="col-xs-4 maginTop15">
                                    <div class="tagImg icons-zaixianrenshu"></div>
                                    <p class="tagName">在培人数（个）</p>
                                    <p id="cnperson" class="tagNum"></p>
                                </div>
                                <div class="tableTop col-xs-12">
                                    <p class="tableTop-title tableTop-title-inline"><i class="greenDot icons-greenDot"></i>今日办班一览</p>
                                   
                                        <div class="queryBox">
                                            <input id="nbanji" type="text" placeholder="" />
                                            <button id="nsearch" >检索</button>
                                        </div>
                                   
                                </div>
                                <div class="tableDiv table6row ellipsisTabelDiv col-xs-12">
                                    <table id="table1_head" class="thTable">
                                        <thead>
                                            <tr>
                                                <th>项目名称</th>
                                                <th>培训地点</th>
                                                <th>班级名称</th>
                                                <th>班级人数</th>
                                            </tr>
                                        </thead>
                                    </table>
                                    <div class="tableBody">
                                        <table id="table1_body">
                                            <thead>
                                                <tr class="thKong">
                                                    <th></th>
                                                    <th></th>
                                                    <th></th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody id="tbody_nclass"> 
                                                <tr>
                                                    <td><a style="text-decoration:none;"  title=""></a> </td>
                                                    <td><a style="text-decoration:none;" title=""></a></td>
	                                                <td><a class="newcl" href="javascript:;" style="text-decoration:underline;" title=""></a> </td>
                                                    <td></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="tableTop col-xs-12">
                                    <p class="tableTop-title tableTop-title-inline"><i class="greenDot icons-greenDot"></i>课程安排一览</p>
                                </div>
                                <div class="tableDiv nomarginTableDiv ellipsisTabelDiv col-xs-12">
                                    <table id="table2_head" class="thTable">
                                        <thead>
                                            <tr>
                                                <th>课程名称</th>
                                                <th>时段</th>
                                                <th>组名</th>
                                                <th>培训师</th>
                                                <th>教室名称</th>
                                                <th>授课方式</th>
                                            </tr>
                                        </thead>
                                    </table>
                                    <div class="tableBody">
                                        <table id="table2_body">
                                            <thead>
                                                <tr class="thKong">
                                                    <th></th>
                                                    <th></th>
                                                    <th></th>
                                                    <th></th>
                                                    <th></th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody id="tbody_nsched">
                                                <tr>
                                                    <td><a style="text-decoration:none;" title=""></a>
                                                    </td>
                                                    <td><a style="text-decoration:none;" title=""></a></td>
	                                                <td><a style="text-decoration:none;" title=""></a>
                                                    </td>
                                                    <td><a style="text-decoration:none;" title=""></a>
                                                    </td>
                                                    <td><a style="text-decoration:none;" title=""></a>
                                                    </td>
                                                    <td> </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="moduleDiv moduleDivAuto">
                            <p class="moduleTitle icons-moduleTitleBg">短期班教学实时监测</p>
                            <div class="row rowDiy">
                                <div class="col-xs-4 maginTop15">
                                    <div class="tagImg icons-zhuanyeshu"></div>
                                    <p class="tagName">今日办班（个）</p>
                                    <p id="csclass" class="tagNum"></p>
                                </div>
                                <div class="col-xs-4 maginTop15">
                                    <div class="tagImg icons-zaixianrenshu"></div>
                                    <p class="tagName">在培人数（个）</p>
                                    <p id="csperson" class="tagNum"></p>
                                </div>
                                <div class="tableTop col-xs-12">
                                    <p class="tableTop-title tableTop-title-inline"><i class="greenDot icons-greenDot"></i>今日办班一览</p>
                                   
                                        <div class="queryBox">
                                            <input id="sbanji" type="text" placeholder="" />
                                            <button id="ssearch" >检索</button>
                                        </div>
                                   
                                </div>
                                <div class="tableDiv table6row ellipsisTabelDiv col-xs-12">
                                    <table id="table3_head" class="thTable">
                                        <thead>
                                            <tr>
                                                <th>项目名称</th>
                                                <th>培训地点</th>
                                                <th>承办部门</th>
                                                <th>班级人数</th>
                                            </tr>
                                        </thead>
                                    </table>
                                    <div class="tableBody">
                                        <table id="table3_body">
                                            <thead>
                                                <tr class="thKong">
                                                    <th></th>
                                                    <th></th>
                                                    <th></th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody id="tbody_sclass">
                                                <tr>
                                                    <td><a class="shtcl" href="javascript:;" style="text-decoration:underline;" title=""></a></td>
                                                    <td><a style="text-decoration:none;" title=""></a></td>
	                                                <td><a  title=""></a></td>
                                                    <td></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="tableTop col-xs-12">
                                    <p class="tableTop-title tableTop-title-inline"><i class="greenDot icons-greenDot"></i>课程安排一览</p>
                                </div>
                                <div class="tableDiv nomarginTableDiv ellipsisTabelDiv col-xs-12">
                                    <table id="table4_head" class="thTable">
                                        <thead>
                                            <tr>
                                                <th>课程名称</th>
                                                <th>时段</th>
                                                <th>组名</th>
                                                <th>培训师</th>
                                                <th>教室名称</th>
                                                <th>授课方式</th>
                                            </tr>
                                        </thead>
                                    </table>
                                    <div class="tableBody">
                                        <table id="table4_body">
                                            <thead>
                                                <tr class="thKong">
                                                    <th></th>
                                                    <th></th>
                                                    <th></th>
                                                    <th></th>
                                                    <th></th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody id="tbody_ssched">
                                                <tr>
                                                    <td><a style="text-decoration:none;" title=""></a>
                                                    </td>
                                                    <td><a style="text-decoration:none;" title=""></a></td>
	                                                <td><a style="text-decoration:none;" title=""></a>
                                                    </td>
                                                    <td><a style="text-decoration:none;" title=""></a>
                                                    </td>
                                                    <td><a style="text-decoration:none;" title=""></a>
                                                    </td>
                                                    <td></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
  
</body>
<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<script src="<%=basePath %>static/new/javascript/bootstrap.min.js" type="text/javascript"></script>
<script src="<%=basePath %>static/new/javascript/echarts-all.js" charset="UTF-8" type="text/javascript"></script>
<script src="<%=basePath %>static/new/javascript/chart1Jq.js" charset="UTF-8" type="text/javascript"></script>
<script src="<%=basePath %>static/new/javascript/WdatePicker/WdatePicker.js" charset="UTF-8" type="text/javascript"></script>
<script src="<%=basePath %>static/service/jxssjc.js" charset="UTF-8" type="text/javascript"></script>
</html>
