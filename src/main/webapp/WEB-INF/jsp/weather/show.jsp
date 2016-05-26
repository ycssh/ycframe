<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<base href="<%=basePath%>">

<title>气象环境监测</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" href="<%=basePath %>static/new/stylesheets/screen.css">
<link rel="stylesheet" href="<%=basePath %>static/new/stylesheets/bootstrap.min.css">
<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<script src="<%=basePath %>static/new/javascript/bootstrap.min.js" type="text/javascript"></script>
<script src="<%=basePath %>static/new/javascript/echarts-all.js" charset="UTF-8" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	init();
});
function init()
{
	queryData();
	var $selectDiy = $('.selectDiy');

	$selectDiy.each(function() {
		var $selectCont = $(this).children('.selectCont');
		var $selectUl = $(this).children('ul');
		var $selectLi = $selectUl.children('li');
		$(this).click(function() {
			$selectUl.toggle();
		});
		$selectLi.click(function() {
			var showCon = $(this).html();
			$selectCont.html(showCon);
			queryData();
		});
	});
}

function queryData()
{
	var campus = $("#campus").text();
	$.post(encodeURI("weather/weather.do?campus="+campus),{},function(data){
		$("#todayDate").html(data.list[0].week+"("+data.list[0].day+")");
		$("#todayImg").attr("src","static/new/images/weather/"+data.list[0].content1+".png");
		$("#todayTemperature").html(data.list[0].temperature);
		$("#todayWeatherType").html(data.list[0].weatherType);
		$("#todayWind").html(data.list[0].windDirection+data.list[0].windPower);
		$("#todayPm").html(data.list[0].weatherQuality+data.list[0].pm);
		for(var i=1;i<data.list.length;i++)
		{
			$("#week"+i).html(data.list[i].week);
			$("#day"+i).html(data.list[i].day);
			$("#img"+i).attr("src","static/new/images/weather/"+data.list[i].content1+".png");
			$("#temperature"+i).html(data.list[i].temperature);
			$("#weatherType"+i).html(data.list[i].weatherType);
			$("#wind"+i).html(data.list[i].windDirection+data.list[i].windPower);
		}
	},"JSON");	
}
</script>
</head>

<body>

	<div class="content">
        <div class="contentRight">
              <div class="queryDiv">
                  <label for="">培训地点</label>
                  <div class="selectDiy">
                      <span id= "campus" class="selectCont">济南</span>
                      <i class="tag icons-selectTra"></i>
                      <ul>
                          <li>济南</li>
                          <li>泰安</li>
                      </ul>
                  </div>
              </div>
            <div class="weatherWrap">
                <ul id="weather" class="clearfix wrapUl">
                    <li class="wrapLi width3">
                        <dl>
                            <dt class="todayDate" id="todayDate"></dt>
                            <dd>
                                <p class="imgBox">
                                    <img id="todayImg" src="" alt="" class="todayTag">
                                </p>
                            </dd>
                            <dd class="todayTemparature" id="todayTemperature">
                                </dd>
                            <dd class="weatherInfo" id="todayWeatherType"></dd>
                            <dd class="windForce" id="todayWind"></dd>
                            <dd class="environment">空气质量：
                                <span class="environmentIntro" id="todayPm"></span>
                            </dd>
                        </dl>
                    </li>
					<li class="wrapLi">
						<i class="line"></i>
					</li>
					<li class="wrapLi width2">
						<ul class="innerUl">
							<li id="week1"></li>
							<li id="day1"></li>
							<li>
								<p class="imgSmallBox">
									<img id="img1" src="static/new/images/weather/leizhenyu.png" alt="" class="weaTag">
								</p>
							</li>
							<li id="temperature1"></li>
							<li id="weatherType1"></li>
							<li id="wind1"></li>
						</ul>
					</li>
					
					<li class="wrapLi">
						<i class="line"></i>
					</li>
					<li class="wrapLi width2">
						<ul class="innerUl">
							<li id="week2"></li>
							<li id="day2"></li>
							<li>
								<p class="imgSmallBox">
									<img id="img2" src="static/new/images/weather/leizhenyu.png" alt="" class="weaTag">
								</p>
							</li>
							<li id="temperature2"></li>
							<li id="weatherType2"></li>
							<li id="wind2"></li>
						</ul>
					</li>
					<li class="wrapLi">
						<i class="line"></i>
					</li>
					<li class="wrapLi width2">
						<ul class="innerUl">
							<li id="week3"></li>
							<li id="day3"></li>
							<li>
								<p class="imgSmallBox">
									<img id="img3" src="static/new/images/weather/leizhenyu.png" alt="" class="weaTag">
								</p>
							</li>
							<li id="temperature3"></li>
							<li id="weatherType3"></li>
							<li id="wind3"></li>
						</ul>
					</li>
					<li class="wrapLi">
						<i class="line"></i>
					</li>
					<li class="wrapLi width2">
						<ul class="innerUl">
							<li id="week4"></li>
							<li id="day4"></li>
							<li>
								<p class="imgSmallBox">
									<img id="img4" src="static/new/images/weather/leizhenyu.png" alt="" class="weaTag">
								</p>
							</li>
							<li id="temperature4"></li>
							<li id="weatherType4"></li>
							<li id="wind4"></li>
						</ul>
					</li>
                    
                </ul>
            </div>
        </div>
    </div>
</body>
</html>
