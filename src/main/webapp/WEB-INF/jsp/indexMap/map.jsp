<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String version="1.3.5";
String contextPath = request.getContextPath();
%>
<html>
<title>首页地图</title>

<head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /> 	
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="easyui">
<meta http-equiv="description" content="easyui">

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/new/stylesheets/screen.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-1.11.0.min.js"></script>
<script src="${pageContext.request.contextPath}/static/new/javascript/echarts-allForIndex.js" charset="UTF-8" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/static/new/javascript/chart1JqForOld.js" charset="UTF-8" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/static/new/javascript/mapIndex.js" charset="UTF-8" type="text/javascript"></script> 
<script src="${pageContext.request.contextPath}/static/new/javascript/WdatePicker/WdatePicker.js" charset="UTF-8" type="text/javascript"></script>
		
</head>
<body>

  <div class="contentRight"  style ="margin-left:0px;">
       <div class="queryDiv">
           <label for="">年份:</label>
           <div class="selectDiy" style="width:110px;" id="selectDom">
               <span class="selectCont" id = "indexSelectYear"  style="width:110px;"></span>
               <i class="tag icons-selectTra"></i>
               <ul id = "yearSelect">
               
               </ul>
           </div>
           <button class="search" id ="indexYearSearch" style="margin-left: 25px;">检索</button>
       </div>
       
   <div class="contentBody">
   		<!-- 地图 -->
   		<div id="mainMap" class="mainMapc" style="overflow: hidden;"></div>
       
       
       <!-- 初次进入提示框 -->
	   <div id="fistAlterBox" class="echarts-tooltip" style="display:none;position: absolute;  border: 2px solid rgb(43, 161, 150); white-space: nowrap; transition: left 0.4s, top 0.4s; border-radius: 14px; color: rgb(43, 161, 150); font-family: Arial, Verdana, sans-serif; font-size: 12px; line-height: 18px; font-style: normal; padding: 10px 28px; left: 100px; top: 50px; background-color: rgb(255, 255, 255);"></div> 		


	   <!-- 右上角导航栏 -->		                
       <div class="circleNavc" id="circleNav">
           <dl>
				<dt class="show"> 
				   <span><a id="menuIsShow" href="javaScript:void(0);" style="color:white;">指标导航</a></span> 
				</dt> 											  
				<dd class="secondLevel">
				 <a id="yunyingzhuangkuang" href="javascript:void(0);" class="firstLink" >运营状况</a>
				 <a id="zhibiaodapan" href="javascript:void(0);" class="secondLink">指标大盘</a>
				 <a id="peixundongtai" href="javascript:void(0);" class="thirdLink">培训动态</a> 
				</dd> 
				<dd class="thirdLevel">
				 <a id="yewufazhang" href="javascript:void(0);" class="firstLink">业务发展</a>
				 <a id="peiyunzhiliang" href="javascript:void(0);" class="secondLink">培训质量</a>
				 <a id="jiaoxueshishi" href="javascript:void(0);" class="thirdLink">教学实时</a>
				 <a id="ziyuanxietiao" href="javascript:void(0);" class="fourthLink">资源协调</a>
				 <a id="liuchengjiance" href="javascript:void(0);" class="fiveLink">流程监测</a> 
				</dd>
			</dl>
        </div>
        
    </div>
    
</div>

</body>
</html>