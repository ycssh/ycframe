<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<base href="<%=basePath%>">
<title>综合绩效监测</title>
<link rel="stylesheet" href="<%=basePath %>static/new/stylesheets/screen.css">
<link href="<%=basePath %>static/new/stylesheets/bootstrap.min.css" rel="stylesheet">

    <!--[if lt IE 9]>
<script src="javascript/html5shiv.js"></script>
<script src="javascript/respond.min.js"></script>
<![endif]-->
</head>
<body>
	<div class="content">
		<div class="wrapNav"></div>
		<div class="contentRight">
                <div class="queryDiv">
                    <label for="">年份：</label>
                     <div class="selectDiy smallSelectDiy">
                        <span id="year" class="selectCont"></span>
                        <i class="tag icons-selectTra"></i>
                        <ul id="yearCombo">
                        </ul>
                    </div>
                    <label for="">月份：</label>
                     <div class="selectDiy smallSelectDiy">
                        <span id="month" class="selectCont"></span>
                        <i class="tag icons-selectTra"></i>
                        <ul>
                              <li>01</li>
                              <li>02</li>
                              <li>03</li>
                              <li>04</li>
                              <li>05</li>
                              <li>06</li>
                              <li>07</li>
                              <li>08</li>
                              <li>09</li>
                              <li>10</li>
                              <li>11</li>
                              <li>12</li>                                                            
                        </ul>
                    </div>                    
                    <button id="search" class="search">检索</button>
                </div> 
			 <div class="container-fluid">
			 	<div class="row">
			 		<div class="col-md-6">
            			<div class="moduleDiv qushiModule">
            			<p class="moduleTitle icons-moduleTitleBg">培训班情况监测</p>
            			<div class="row rowNoMargin">
            				<div class="col-xs-12 maginTop15">
            						<div class="tagImg icons-leijizhi"></div>
                                    <p class="tagName">累计值（个）</p>
                                    <p class="tagNum" id="ljz"></p>
                                    <div class="compareDiv col-xs-8">
                                    	<icon class="trag"></icon>
                                    	<p class="option">
                                    		<span class="dark">同期值：</span>
                                    		<span class="orageColor" id="tqz" ></span>

                                    	</p>
                                    	<p class="option">
                                    		<span class="dark">同比：</span>
                                    		<span class="orageColor" id="tbz"></span>
                                    		<i id="css_tbz" class="addOrcount icons-raise"></i>
                                    	</p>
                                    </div>
            					</div>
            					<div class="col-xs-12 maginTop15">
            						<div class="tagImg icons-benqizhi"></div>
                                    <p class="tagName">本期值（个）</p>
                                    <p class="tagNum" id="bqz"></p>
                                    <div class="compareDiv col-xs-8">
                                    	<icon class="trag"></icon>
                                    	<p class="option">
                                    		<span class="dark">同比：</span>
                                    		<span class="orageColor" id="bq_tbz"></span>
                                    		<i id = "css_bq_tbz" class="addOrcount icons-raise"></i>

                                    	</p>
                                    	<p class="option">
                                    		<span class="dark">环比：</span>
                                    		<span class="orageColor" id="bq_hbz"></span>
                                    		<i id="css_bq_hbz" class="addOrcount icons-raise"></i>
                                    	</p>
                                    </div>
            					</div>
            				<div class="chartDiv col-xs-12">
                                    <div class="chartTopTab">
                                       <ul>
	                                       	<li class="active">培训班数量月趋势</li>
	                                       	<li>培训班数量年趋势</li>
                                       </ul>
                                    </div>
                                    <div class="chartBody TypeChart" id="chartPxbMonth" style="display:block;">
										
                                    </div>
                                    <div class="chartBody TypeChart" id="chartPxbTotal" style="display:block;">
                                    </div>

                                </div>
            			</div>
            			</div>
            		</div>
            		<div class="col-md-6">
            			<div class="moduleDiv qushiModule">
            			<p class="moduleTitle icons-moduleTitleBg">培训人数监测</p>
            			<div class="row rowNoMargin">
            				<div class="col-xs-12 maginTop15">
            						<div class="tagImg icons-leijizhi"></div>
                                    <p class="tagName">累计值（个）</p>
                                    <p class="tagNum" id="rs_ljz"></p>
                                    <div class="compareDiv col-xs-8">
                                    	<icon class="trag"></icon>
                                    	<p class="option">
                                    		<span class="dark">同期值：</span>
                                    		<span class="orageColor" id="rs_tqz"></span>

                                    	</p>
                                    	<p class="option">
                                    		<span class="dark">同比：</span>
                                    		<span class="orageColor" id="rs_tbz"></span>
                                    		<i id="css_rs_tbz" class="addOrcount icons-raise"></i>
                                    	</p>
                                    </div>
            					</div>
            					<div class="col-xs-12 maginTop15">
            						<div class="tagImg icons-benqizhi"></div>
                                    <p class="tagName">本期值（个）</p>
                                    <p class="tagNum" id="rs_bqz"></p>
                                    <div class="compareDiv col-xs-8">
                                    	<icon class="trag"></icon>
                                    	<p class="option">
                                    		<span class="dark">同比：</span>
                                    		<span class="orageColor" id="rs_bq_tbz"></span>
                                    		<i id="css_rs_bq_tbz" class="addOrcount icons-raise"></i>

                                    	</p>
                                    	<p class="option">
                                    		<span class="dark">环比：</span>
                                    		<span class="orageColor" id="rs_bq_hbz"></span>
                                    		<i id="css_rs_bq_hbz" class="addOrcount icons-raise"></i>
                                    	</p>
                                    </div>
            					</div>
            				<div class="chartDiv col-xs-12">
                                    <div class="chartTopTab">
                                       <ul>
	                                       	<li class="active">培训人数月趋势</li>
	                                       	<li>培训人数年趋势</li>
                                       </ul>
                                    </div>
                                    <div class="chartBody TypeChart" id="chartRsMonth" style="display:block;">
										
                                    </div>
                                    <div class="chartBody TypeChart" id="chartRsTotal" style="display:block;">
                                    </div>
                                </div>
                                
            			</div>
            			</div>
            		</div>
            		<div class="col-md-6">
            			<div class="moduleDiv qushiModule">
            			<p class="moduleTitle icons-moduleTitleBg">培训人天数监测</p>
            			<div class="row rowNoMargin">
            				<div class="col-xs-12 maginTop15">
            						<div class="tagImg icons-leijizhi"></div>
                                    <p class="tagName">累计值（个）</p>
                                    <p class="tagNum" id="rts_ljz"></p>
                                    <div class="compareDiv col-xs-8">
                                    	<icon class="trag"></icon>
                                    	<p class="option">
                                    		<span class="dark">同期值：</span>
                                    		<span class="orageColor" id="rts_tqz"></span>

                                    	</p>
                                    	<p class="option">
                                    		<span class="dark">同比：</span>
                                    		<span class="orageColor" id="rts_tbz"></span>
                                    		<i id="css_rts_tbz" class="addOrcount icons-raise"></i>
                                    	</p>
                                    </div>
            					</div>
            					<div class="col-xs-12 maginTop15">
            						<div class="tagImg icons-benqizhi"></div>
                                    <p class="tagName">本期值（个）</p>
                                    <p class="tagNum" id="rts_bqz"></p>
                                    <div class="compareDiv  col-xs-8">
                                    	<icon class="trag"></icon>
                                    	<p class="option">
                                    		<span class="dark">同比：</span>
                                    		<span class="orageColor" id="rts_bq_tbz"></span>
                                    		<i id="css_rts_bq_tbz"class="addOrcount icons-raise"></i>

                                    	</p>
                                    	<p class="option">
                                    		<span class="dark">环比：</span>
                                    		<span class="orageColor" id="rts_bq_hbz"></span>
                                    		<i id="css_rts_bq_hbz" class="addOrcount icons-raise"></i>
                                    	</p>
                                    </div>
            					</div>
            				<div class="chartDiv col-xs-12">
                                    <div class="chartTopTab">
                                       <ul>
	                                       	<li class="active">培训人天数月趋势</li>
	                                       	<li>培训人天数年趋势</li>
                                       </ul>
                                    </div>
                                    <div class="chartBody TypeChart" id="chartRtsMonth" style="display:block;">
										
                                    </div>
                                    <div class="chartBody TypeChart" id="chartRtsTotal" style="display:block;">
                                    </div>

                                </div>
                              
            			</div>
            			</div>
            		</div>
            		<div class="col-md-6">
            			<div class="moduleDiv qushiModule">
            			<p class="moduleTitle icons-moduleTitleBg">培训工作量监测</p>
            			<div class="row rowNoMargin">
            				<div class="col-xs-12 maginTop15">
            						<div class="tagImg icons-leijizhi"></div>
                                    <p class="tagName">累计值（个）</p>
                                    <p class="tagNum" id="gzl_ljz"></p>
                                    <div class="compareDiv col-xs-8">
                                    	<icon class="trag"></icon>
                                    	<p class="option">
                                    		<span class="dark">同期值：</span>
                                    		<span class="orageColor" id="gzl_tqz"></span>

                                    	</p>
                                    	<p class="option">
                                    		<span class="dark">同比：</span>
                                    		<span class="orageColor" id="gzl_tbz"></span>
                                    		<i id="css_gzl_tbz" class="addOrcount icons-raise"></i>
                                    	</p>
                                    </div>
            					</div>
            					<div class="col-xs-12 maginTop15">
            						<div class="tagImg icons-benqizhi"></div>
                                    <p class="tagName">本期值（个）</p>
                                    <p class="tagNum" id="gzl_bqz"></p>
                                    <div class="compareDiv  col-xs-8">
                                    	<icon class="trag"></icon>
                                    	<p class="option">
                                    		<span class="dark">同比：</span>
                                    		<span class="orageColor" id="gzl_bq_tbz"></span>
                                    		<i id="css_gzl_bq_tbz" class="addOrcount icons-raise"></i>

                                    	</p>
                                    	<p class="option">
                                    		<span class="dark">环比：</span>
                                    		<span class="orageColor" id="gzl_bq_hbz"></span>
                                    		<i id="css_gzl_bq_hbz" class="addOrcount icons-raise"></i>
                                    	</p>
                                    </div>
            					</div>
            				<div class="chartDiv col-xs-12">
                                    <div class="chartTopTab">
                                       <ul>
	                                       	<li class="active">培训工作量月趋势</li>
	                                       	<li>培训班工作量年趋势</li>
                                       </ul>
                                    </div>
                                    <div class="chartBody TypeChart" id="chartGzlMonth" style="display:block;">
										
                                    </div>
                                    <div class="chartBody TypeChart" id="chartGzlTotal" style="display:block;">
                                    </div>

                                </div>
                               
            			</div>
            			</div>
            		</div>
			 	</div>
			 </div>
		</div>
	</div>
<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<script src="<%=basePath %>static/new/javascript/echarts-all.js" charset="UTF-8" type="text/javascript"></script>
<script src="<%=basePath %>static/new/javascript/chart1Jq_1103.js" charset="UTF-8" type="text/javascript"></script>
<script src="<%=basePath %>static/new/javascript/zhjxjc/zhjxjc.js" charset="UTF-8" type="text/javascript"></script>
<script src="<%=basePath %>static/new/javascript/zhjxjc/chart.js" charset="UTF-8" type="text/javascript"></script>
<script src="<%=basePath %>static/new/javascript/esl.js" charset="UTF-8" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	$(".chartBody").css("width",($("body").width()-123)/2+"px");
	initSearchBox();
	$("#search").bind("click",doSearch);
	initData();
	chart();
	initChart1Jq(); 
	$(".chartTopTab").find("li").css("cursor","pointer")
});

function initSearchBox()
{
	var date = new Date();
	var year = date.getFullYear();
	var month = date.getMonth()+1;
	var html1= [];
	for(var y=date.getFullYear();y>=2014;y--){
		html1.push('<li value="'+y+'">'+y+'</li>');
	}
	$("#year").html(year);
	$("#yearCombo").html(html1.join(''));		
	if(month < 10)
	{
		month = "0"+month;
	}
	$("#year").html(year);
	$("#month").html(month);
}
function doSearch()
{
	initData();
	chart();
}
</script>
</body>
</html>