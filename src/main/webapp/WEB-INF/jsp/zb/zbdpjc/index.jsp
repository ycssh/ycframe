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
<base href="<%=basePath%>">

<title>指标大盘监测</title>

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
<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<script src="<%=basePath %>static/new/javascript/bootstrap.min.js" type="text/javascript"></script>
<script src="<%=basePath %>static/new/javascript/chart1Jq_1103.js" charset="UTF-8" type="text/javascript"></script>
<script src="<%=basePath %>static/new/javascript/zbdpjc/zbdpjc.js" charset="UTF-8" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	
	
	
	var date=new Date();
	var month = date.getMonth()+1;
	if(parseInt(month)<10){
		month = '0'+month;
	}
	$("#month").html(month);
	$.ajax({
		url:"zbDict/findByType.do?type=dept",
		method: "POST",
		success:function(data){
			var html = [];
			for(var i=0;i<data.length;i++){
				html.push('<li value="'+data[i].value+'">'+data[i].name+'</li>');
			}
			$("#depSelectedName").html(data[0].name);
			$("#depCombo").html(html.join(''));
			var html1= [];
			for(var y=date.getFullYear();y>=2014;y--){
				html1.push('<li value="'+y+'">'+y+'</li>');
			}
			$("#year").html(date.getFullYear());
			$("#yearCombo").html(html1.join(''));			
		},
		async:false,
		dataType:"json"
	});
	$("#search").bind("click",doSearch);
	initData();
	initChart1Jq(); 
});

function doSearch()
{
	initData();
}
</script>
</head>
<body>
 <div class="content">
        <div class="contentRight">
                <div class="queryDiv">
                    <label for="">专业培训部:</label>
                    <div class="selectDiy">
	                	<span id="depSelectedName"class="selectCont"></span>
	                	<input type="text" id="deptValue" style="display:none"/>
	                	<i class="tag icons-selectTra"></i>
	                	<ul id="depCombo">
	                	</ul>
                    </div>
                    <label for="">年份：</label>
                    <!-- <select name="" id="">
                        <option value="">2015</option>
                    </select> -->
                    <div class="selectDiy smallSelectDiy">
                        <span id="year" class="selectCont">2015</span>
                        <i class="tag icons-selectTra"></i>
                        <ul id="yearCombo">
                        </ul>
                    </div>
                    <label for="">月份：</label>
                    <!-- <select name="" id="">
                        <option value="">2015</option>
                    </select> -->
                    <div class="selectDiy smallSelectDiy">
                        <span id="month" class="selectCont">05</span>
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
                    <!--<button id="export" class="report">导出</button>
                     <button class="copyBtn">打印</button> -->
                </div>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="zhibiaoWrap">
                            <dl class="warpDl">
                                <dt>
                                    <ul class="zhibiaoTd clearfix">
                                        <li class="no1 outLi">
											业务指标
                                        </li>
                                        <li class="no2 outLi">
                                                                                                                     单位
                                        </li>
                                        <li class="no3 outLi">
                                            <p>本期</p>
                                            <div class="tableHeadNav">
                                                <ul class="showNumName liCol4 clearfix">
                                                    <li>
                                                        <span>本期值</span>
                                                    </li>
                                                    <li>
                                                        <span>同期值</span>
                                                    </li>
                                                    <li>
                                                        <span>同比</span>
                                                    </li>
                                                    <li>
                                                        <span>环比</span>
                                                    </li>
                                                </ul>
                                            </div>
                                        </li>
                                        <li class="no4 outLi">
                                            <p>累计</p>
                                            <div class="tableHeadNav">
                                                <ul class="showNumName liCol3 clearfix">
                                                    <li>
                                                        <span>本期值</span>
                                                    </li>
                                                    <li>
                                                        <span>同期值</span>
                                                    </li>
                                                    <li>
                                                        <span>同比</span>
                                                    </li>
                                                </ul>
                                            </div>
                                        </li>
                                    </ul>
                                </dt>
                                <dd>
                                    <ul class="zhibiaoDd clearfix">
                                        <li class="level1 innerLi boldFont">
                                            <i class="dotTip">
                                                1
                                            </i>
                                        	    培训项目个数
                                        </li>
                                        <li class="no2 innerLi">
                                     	       个
                                        </li>
                                        <li class="no3 innerLi">
                                            <ul class="compareNum liCol4">
                                                <li id="bqz">789</li>
                                                <li id="tqz">790</li>
                                                <li id="tbz">89%</li>
                                                <li id="hbz">34.6%</li>
                                            </ul>
                                        </li>
                                        <li class="no4 innerLi">
                                            <ul class="compareNum liCol3">
                                                <li id="lj_bqz" >789</li>
                                                <li id="lj_tqz">790</li>
                                                <li id="lj_tbz">89%</li>
                                            </ul>
                                        </li>
                                    </ul>
                                </dd>
                                <dd>
                                    <ul class="zhibiaoDd clearfix">
                                        <li class="level1 innerLi">
                                            <p class="lineP"></p>
                                            国网公司培训班
                                        </li>
                                        <li class="no2 innerLi">
                                            个
                                        </li>
                                        <li class="no3 innerLi">
                                            <ul class="compareNum liCol4">
                                                <li id="gw_bqz">789</li>
                                                <li id="gw_tqz">790</li>
                                                <li id="gw_tbz">89%</li>
                                                <li id="gw_hbz">34.6%</li>
                                            </ul>
                                        </li>
                                        <li class="no4 innerLi">
                                            <ul class="compareNum liCol3">
                                                <li id="gw_lj_bqz">789</li>
                                                <li id="gw_lj_tqz">790</li>
                                                <li id="gw_lj_tbz">89%</li>
                                            </ul>
                                        </li>
                                    </ul>
                                </dd>
                                <dd>
                                    <ul class="zhibiaoDd clearfix">
                                        <li class="level1 innerLi">
                                            <p class="lineP linePLong"></p>
                                            委托培训班
                                        </li>
                                        <li class="no2 innerLi">
                                            个
                                        </li>
                                        <li class="no3 innerLi">
                                            <ul class="compareNum liCol4">
                                                <li id="wt_bqz">789</li>
                                                <li id="wt_tqz">790</li>
                                                <li id="wt_tbz">89%</li>
                                                <li id="wt_hbz">34.6%</li>
                                            </ul>
                                        </li>
                                        <li class="no4 innerLi">
                                            <ul class="compareNum liCol3">
                                                <li id="wt_lj_bqz">789</li>
                                                <li id="wt_lj_tqz">790</li>
                                                <li id="wt_lj_tbz">89%</li>
                                            </ul>
                                        </li>
                                    </ul>
                                </dd>
                                <dd>
                                    <ul class="zhibiaoDd clearfix">
                                        <li class="level2 innerLi">
                                            <p class="lineP"></p>
                                            山东公司
                                        </li>
                                        <li class="no2 innerLi">
                                            个
                                        </li>
										<li class="no3 innerLi">
                                            <ul class="compareNum liCol4">
                                                <li id="sd_bqz">789</li>
                                                <li id="sd_tqz">790</li>
                                                <li id="sd_tbz">89%</li>
                                                <li id="sd_hbz">34.6%</li>
                                            </ul>
                                        </li>
                                        <li class="no4 innerLi">
                                            <ul class="compareNum liCol3">
                                                <li id="sd_lj_bqz">789</li>
                                                <li id="sd_lj_tqz">790</li>
                                                <li id="sd_lj_tbz">89%</li>
                                            </ul>
                                        </li>
                                    </ul>
                                </dd>
                                <dd>
                                    <ul class="zhibiaoDd clearfix">
                                        <li class="level2 innerLi">
                                            <p class="lineP linePLong"></p>
                                            系统内
                                        </li>
                                        <li class="no2 innerLi">
                                            个
                                        </li>
										<li class="no3 innerLi">
                                            <ul class="compareNum liCol4">
                                                <li id="xtn_bqz">789</li>
                                                <li id="xtn_tqz">790</li>
                                                <li id="xtn_tbz">89%</li>
                                                <li id="xtn_hbz">34.6%</li>
                                            </ul>
                                        </li>
                                        <li class="no4 innerLi">
                                            <ul class="compareNum liCol3">
                                                <li id="xtn_lj_bqz">789</li>
                                                <li id="xtn_lj_tqz">790</li>
                                                <li id="xtn_lj_tbz">89%</li>
                                            </ul>
                                        </li>
                                    </ul>
                                </dd>
                                <dd>
                                    <ul class="zhibiaoDd clearfix">
                                        <li class="level2 innerLi">
                                            <p class="lineP linePLong"></p>
                                            系统外
                                        </li>
                                        <li class="no2 innerLi">
                                            个
                                        </li>
										<li class="no3 innerLi">
                                            <ul class="compareNum liCol4">
                                                <li id="xtw_bqz">789</li>
                                                <li id="xtw_tqz">790</li>
                                                <li id="xtw_tbz">89%</li>
                                                <li id="xtw_hbz">34.6%</li>
                                            </ul>
                                        </li>
                                        <li class="no4 innerLi">
                                            <ul class="compareNum liCol3">
                                                <li id="xtw_lj_bqz">789</li>
                                                <li id="xtw_lj_tqz">790</li>
                                                <li id="xtw_lj_tbz">89%</li>
                                            </ul>
                                        </li>
                                    </ul>
                                </dd>
                                <dd>
                                    <ul class="zhibiaoDd clearfix">
                                        <li class="level1 innerLi boldFont">
                                            <i class="dotTip">
                                                2
                                            </i>
                                            培训人天数
                                        </li>
                                        <li class="no2 innerLi">
                                            人天
                                        </li>
                                        <li class="no3 innerLi">
                                            <ul class="compareNum liCol4">
                                                <li id="bqz_rts">789</li>
                                                <li id="tqz_rts">790</li>
                                                <li id="tbz_rts">89%</li>
                                                <li id="hbz_rts">34.6%</li>
                                            </ul>
                                        </li>
                                        <li class="no4 innerLi">
                                            <ul class="compareNum liCol3">
                                                <li id="lj_bqz_rts">789</li>
                                                <li id="lj_tqz_rts">790</li>
                                                <li id="lj_tbz_rts">89%</li>
                                            </ul>
                                        </li>
                                    </ul>
                                </dd>
                                <dd>
                                    <ul class="zhibiaoDd clearfix">
                                        <li class="level1 innerLi">
                                            <p class="lineP"></p>
                                            国网公司培训班
                                        </li>
                                        <li class="no2 innerLi">
                                            人天
                                        </li>
                                        <li class="no3 innerLi">
                                            <ul class="compareNum liCol4">
                                                <li id="gw_bqz_rts">789</li>
                                                <li id="gw_tqz_rts">790</li>
                                                <li id="gw_tbz_rts">89%</li>
                                                <li id="gw_hbz_rts">34.6%</li>
                                            </ul>
                                        </li>
                                        <li class="no4 innerLi">
                                            <ul class="compareNum liCol3">
                                                <li id="gw_lj_bqz_rts">789</li>
                                                <li id="gw_lj_tqz_rts">790</li>
                                                <li id="gw_lj_tbz_rts">89%</li>
                                            </ul>
                                        </li>
                                    </ul>
                                </dd>
                                <dd>
                                    <ul class="zhibiaoDd clearfix">
                                        <li class="level1 innerLi">
                                            <p class="lineP linePLong"></p>
                                            委托培训班
                                        </li>
                                        <li class="no2 innerLi">
                                            人天
                                        </li>
                                        <li class="no3 innerLi">
                                            <ul class="compareNum liCol4">
                                                <li id="wt_bqz_rts">789</li>
                                                <li id="wt_tqz_rts">790</li>
                                                <li id="wt_tbz_rts">89%</li>
                                                <li id="wt_hbz_rts">34.6%</li>
                                            </ul>
                                        </li>
                                        <li class="no4 innerLi">
                                            <ul class="compareNum liCol3">
                                                <li id="wt_lj_bqz_rts">789</li>
                                                <li id="wt_lj_tqz_rts">790</li>
                                                <li id="wt_lj_tbz_rts">89%</li>
                                            </ul>
                                        </li>
                                    </ul>
                                </dd>
                                <dd>
                                    <ul class="zhibiaoDd clearfix">
                                        <li class="level2 innerLi">
                                            <p class="lineP"></p>
                                            山东公司
                                        </li>
                                        <li class="no2 innerLi">
                                            人天
                                        </li>
                                        <li class="no3 innerLi">
                                            <ul class="compareNum liCol4">
                                                <li id="sd_bqz_rts">789</li>
                                                <li id="sd_tqz_rts">790</li>
                                                <li id="sd_tbz_rts">89%</li>
                                                <li id="sd_hbz_rts">34.6%</li>
                                            </ul>
                                        </li>
                                        <li class="no4 innerLi">
                                            <ul class="compareNum liCol3">
                                                <li id="sd_lj_bqz_rts">789</li>
                                                <li id="sd_lj_tqz_rts">790</li>
                                                <li id="sd_lj_tbz_rts">89%</li>
                                            </ul>
                                        </li>
                                    </ul>
                                </dd>
                                <dd>
                                    <ul class="zhibiaoDd clearfix">
                                        <li class="level2 innerLi">
                                            <p class="lineP linePLong"></p>
                                            系统内
                                        </li>
                                        <li class="no2 innerLi">
                                            人天
                                        </li>
                                        <li class="no3 innerLi">
                                            <ul class="compareNum liCol4">
                                                <li id="xtn_bqz_rts">789</li>
                                                <li id="xtn_tqz_rts">790</li>
                                                <li id="xtn_tbz_rts">89%</li>
                                                <li id="xtn_hbz_rts">34.6%</li>
                                            </ul>
                                        </li>
                                        <li class="no4 innerLi">
                                            <ul class="compareNum liCol3">
                                                <li id="xtn_lj_bqz_rts">789</li>
                                                <li id="xtn_lj_tqz_rts">790</li>
                                                <li id="xtn_lj_tbz_rts">89%</li>
                                            </ul>
                                        </li>
                                    </ul>
                                </dd>
                                <dd>
                                    <ul class="zhibiaoDd clearfix">
                                        <li class="level2 innerLi">
                                            <p class="lineP linePLong"></p>
                                            系统外
                                        </li>
                                        <li class="no2 innerLi">
                                           人天
                                        </li>
                                        <li class="no3 innerLi">
                                            <ul class="compareNum liCol4">
                                                <li id="xtw_bqz_rts">789</li>
                                                <li id="xtw_tqz_rts">790</li>
                                                <li id="xtw_tbz_rts">89%</li>
                                                <li id="xtw_hbz_rts">34.6%</li>
                                            </ul>
                                        </li>
                                        <li class="no4 innerLi">
                                            <ul class="compareNum liCol3">
                                                <li id="xtw_lj_bqz_rts">789</li>
                                                <li id="xtw_lj_tqz_rts">790</li>
                                                <li id="xtw_lj_tbz_rts">89%</li>
                                            </ul>
                                        </li>
                                    </ul>
                                </dd>
                                 <dd>
                                    <ul class="zhibiaoDd clearfix">
                                        <li class="level1 innerLi boldFont">
                                            <i class="dotTip">
                                                3
                                            </i>
                                            培训教学评价
                                        </li>
                                        <li class="no2 innerLi">
                                            %
                                        </li>
                                        <li class="no3 innerLi">
                                            <ul class="compareNum liCol4">
                                                <li id="jxpj_bqz">2</li>
                                                <li id="jxpj_tqz">3</li>
                                                <li id="jxpj_tbz">4</li>
                                                <li id="jxpj_hbz">5</li>
                                            </ul>
                                        </li>
                                        <li class="no4 innerLi">
                                            <ul class="compareNum liCol3">
                                                <li id="lj_jxpj_bqz">6</li>
                                                <li id="lj_jxpj_tqz">7</li>
                                                <li id="lj_jxpj_tbz">8</li>
                                            </ul>
                                        </li>
                                    </ul>
                                </dd>
                                <dd>
                                    <ul class="zhibiaoDd clearfix">
                                        <li class="level1 innerLi">
                                            <p class="lineP"></p>
                                            培训质量满意率
                                        </li>
                                        <li class="no2 innerLi">
                                            %
                                        </li>
                                        <li class="no3 innerLi">
                                            <ul class="compareNum liCol4">
                                                <li id="pxzl_bqz">2</li>
                                                <li id="pxzl_tqz">3</li>
                                                <li id="pxzl_tbz">4</li>
                                                <li id="pxzl_hbz">5</li>
                                            </ul>
                                        </li>
                                        <li class="no4 innerLi">
                                            <ul class="compareNum liCol3">
                                                <li id="lj_pxzl_bqz">6</li>
                                                <li id="lj_pxzl_tqz">7</li>
                                                <li id="lj_pxzl_tbz">8</li>
                                            </ul>
                                        </li>
                                    </ul>
                                </dd>
                                <dd>
                                    <ul class="zhibiaoDd clearfix">
                                        <li class="level1 innerLi">
                                            <p class="lineP linePLong"></p>
                                            综合服务满意率
                                        </li>
                                        <li class="no2 innerLi">
                                            %
                                        </li>
                                        <li class="no3 innerLi">
                                            <ul class="compareNum liCol4">
                                                <li id="zhfw_bqz">2</li>
                                                <li id="zhfw_tqz">3</li>
                                                <li id="zhfw_tbz">4</li>
                                                <li id="zhfw_hbz">5</li>
                                            </ul>
                                        </li>
                                        <li class="no4 innerLi">
                                            <ul class="compareNum liCol3">
                                                <li id="lj_zhfw_bqz">6</li>
                                                <li id="lj_zhfw_tqz">7</li>
                                                <li id="lj_zhfw_tbz">8</li>
                                            </ul>
                                        </li>
                                    </ul>
                                </dd>
                            </dl>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
	
</body>
</html>
                                                                                                                                                                                                                                                                                                                                                                                 