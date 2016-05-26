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

<title>培训动态监测</title>

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
</head>
<body>
<body>
        <div class="contentRight">
            <div class="queryDiv">
                <label for="">专业培训部:</label>
                <!-- <select name="" id="">
                    <option value="">电网运行培训部</option>
                </select> -->
                <div class="selectDiy">
                	<span id="depSelectedName"class="selectCont"></span>
                	<input type="text" id="deptValue" style="display:none"/>
                	<i class="tag icons-selectTra"></i>
                	<ul id="depCombo">
                	</ul>
                </div>
                <button id="search" class="search">检索</button>
            </div>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-6">
                        <div class="moduleDiv">
                            <p class="moduleTitle icons-moduleTitleBg">新员工培训教学</p>
                            <div class="row rowDiy">
                                <div class="col-xs-3 maginTop15">
                                    <div class="tagImg icons-zhuanyeshu"></div>
                                    <p class="tagName">举办专业数</p>
                                    <p id="zys" class="tagNum"></p>
                                </div>
                                <div class="col-xs-3 maginTop15">
                                    <div class="tagImg icons-guanlibanjishu"></div>
                                    <p class="tagName">管理班级数</p>
                                    <p id="bjs" class="tagNum"></p>
                                </div>
                                <div class="col-xs-3 maginTop15">
                                    <div class="tagImg icons-zaixianrenshu"></div>
                                    <p class="tagName">在培人数</p>
                                    <p id="zprs"class="tagNum"></p>
                                </div>
                                <div class="col-xs-3 maginTop15">
                                    <div class="tagImg icons-leijirentianshu"></div>
                                    <p class="tagName">累计人天数</p>
                                    <p id="ljrts" class="tagNum"></p>
                                </div>

                                <div class="tableDiv col-xs-12">
                                	<table>
                                		<thead>
                                			<tr>
                                				<th>年度期数 </th>
                                                <th>培训地点</th>
                                                <th>开班数</th>
                                                <th>培训人数</th>
                                                <th>培训人天数</th>
                                			</tr>
                                		</thead>
                                	</table>
                                	<div class="tableBody">
						                     <table id="proInfo">
	                                    </table>
                                    </div>
                                </div>
                                <div class="chartDiv col-xs-12">
                                    <div class="chartTop">
                                        <p class="chartTitle">各期学员专业分布情况:</p>
                                        <div class="selectDiy1">
					                    	<span id="projectSelectedName" class="selectCont"></span>
					                    	<i class="tag icons-selectTra"></i>
					                    	<ul id="projectCombo">
					                    		
					                    	</ul>
					                    </div>
                                    </div>
                                    <div class="chartBody" id="chartstudy">

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="moduleDiv">
                            <p class="moduleTitle icons-moduleTitleBg">短期班举办情况</p>
                            <div class="row rowDiy">
                                <div class="col-xs-4 maginTop15">
                                    <div class="tagImg icons-jihuaqishu"></div>
                                    <p class="tagName">计划期数</p>
                                    <p id="jhqs" class="tagNum"></p>
                                </div>
                                <div class="col-xs-4 maginTop15">
                                    <div class="tagImg icons-wanchengqishu"></div>
                                    <p class="tagName">完成期数</p>
                                    <p id="wcqs" class="tagNum"></p>
                                </div>
                                
                                
                               <div class="col-xs-4 maginTop15">
                                    <div class="tagImg icons-zaixianrenshu"></div>
                                    <p class="tagName">在培人数</p>
                                    <p id="zprs_yangjian" class="tagNum"></p>
                                </div>
                                
                                
                                
                                <div class="col-xs-4 maginTop15">
                                    <div class="tagImg icons-leijirentianshu"></div>
                                    <p class="tagName">累计人天数</p>
                                    <p id="rts" class="tagNum"></p>
                                </div>
                                <div class="col-xs-4 maginTop15">
                                    <div class="tagImg icons-jihuawanchenglv"></div>
                                    <div class="tagName" style ="width:100%;">计划完成率<span class="oriageFont" id="wcl" ></span></div>
                                    <div class="tagNum shortNum">
                                    	<div class="progressDiv">
                                    		<div id="wclPic" class="progressUp"></div>
                                    	</div>
                                    </div>
                                </div>
								<div class="tableTop col-xs-12">
                                		<p class="tableTop-title">本月情况统计</p>
                                		<div  class="tableTopIntro">
                                			<div class="col-xs-4 col-delete-rightP">
                                				本月举办期数：<span id="jbqs"></span>
                                			</div>
                                			<div class="col-xs-4 col-delete-rightP">
                                				本月培训学员：<span id="pxxy"></span>
                                			</div>
                                			<div class="col-xs-4 col-delete-rightP">
                                				本月培训人天数：<span id="ydrts"></span>
                                			</div>
                                		</div>
                                		
                                	</div>
                                <div class="tableDiv col-xs-12">
                                	<p class="tableDiv-title">年度短期班分类统计</p>
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>计划来源</th>
                                                <th>公司标志</th>
                                                <th>培训期数</th>
                                                <th>培训人数</th>
                                                <th>培训人天数</th>
                                            </tr>
                                        </thead>
                                     </table>
                                     <div class="tableBody">
	                                     <table>
	                                        <tbody>
	                                            <tr>
	                                                <td rowspan="2" style="width:20%">国网公司培训班</td>
	                                                <td style="width:20%">计划内</td>
	                                                <td style="width:20%"><span id="jhn_pxqs">0</span></td>
	                                                <td style="width:20%"><span id="jhn_pxrs">0</span></td>
	                                                <td style="width:20%"><span id="jhn_rts">0</span></td>
	                                            </tr>
	                                            <tr>
	                                                <td>临增</td>
	                                                <td><span id="lz_pxqs">0</span></td>
	                                                <td><span id="lz_pxrs">0</span></td>
	                                                <td><span id="lz_rts">0</span></td>
	                                            </tr>
	                                            <tr>
	                                                <td rowspan="3">委托培训班</td>
	                                                <td>系统内</td>
	                                                <td><span id="xtn_pxqs">0</span></td>
	                                                <td><span id="xtn_pxrs">0</span></td>
	                                                <td><span id="xtn_rts">0</span></td>
	                                            </tr>
	                                            <tr>
	                                                <td>系统外</td>
	                                                <td><span id="xtw_pxqs">0</span></td>
	                                                <td><span id="xtw_pxrs">0</span></td>
	                                                <td><span id="xtw_rts">0</span></td>
	                                            </tr>
	                                            <tr>
	                                                <td>山东公司</td>
	                                                <td><span id="sd_pxqs">0</span></td>
	                                                <td><span id="sd_pxrs">0</span></td>
	                                                <td><span id="sd_rts">0</span></td>
	                                            </tr>	                                            
	                                        </tbody>
	                                    </table>
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="moduleDiv">
                        <p class="moduleTitle icons-moduleTitleBg">工作量统计</p>
                            <div class="row rowDiy">
                                <div class="col-xs-4 maginTop15">
                                    <div class="tagImg icons-nianduleijigongzuoliang"></div>
                                    <p class="tagName">年度累计工作量</p>
                                    <p class="tagNum"><span id="ljgzlNum"></span></p>
                                </div>
                                <div class="col-xs-4 maginTop15">
                                    <div class="tagImg icons-guanlibanjishu"></div>
                                    <p class="tagName">本月完成工作量</p>
                                    <p class="tagNum"><span id="curMonthNum"></span></p>
                                </div>
                                <div class="col-xs-4 maginTop15">
                                    <div class="tagImg icons-zaixianrenshu"></div>
                                    <p class="tagName">上月完成工作量</p>
                                    <p class="tagNum"><span id="preMonthNum"></span></p>
                                </div>
                                <div class="chartDiv col-xs-12">
                                    <div class="chartTopTab">
                                       <ul>
	                                       	<li class="active">培训师类型</li>
	                                       	<li>课程类型</li>
                                       </ul>
                                    </div>
                                    <div class="chartBody TypeChart" id="teacherTypeChart" style="display:block;height:230px;"></div>
                                    <div class="chartBody TypeChart" id="courseTypeChart" style="display:block;height:230px;"></div>
                                </div>
                            </div>
						</div>
                    </div>
                    <div class="col-md-6">
                        <div class="moduleDiv">
                        	 <p class="moduleTitle icons-moduleTitleBg">培训教学评价</p>
                            <div class="row rowDiy">
                                <div class="col-xs-6">
                                	<div class="btnTitle">短期班</div>
                                    <div class="gaugeDiv" id="shortqulityGauge"></div>
                                    <div class="gaugeDiv" id="shortserviceGauge"></div>
                                </div>
                                <div class="col-xs-6">
                                    <div class="btnTitle">新员工</div>
                                    <div class="gaugeDiv" id="newqulityGauge"></div>
                                    <div class="gaugeDiv" id="newserviceGauge"></div>
                                </div>
                                <div class="col-xs-6 pieRoseDiv">
                                	<p class="moduletopTitle">年度评测情况统计<span class="dark">(班级数：<span class="oriage" id="cpbjs"></span>)</span></p>
                                	<div class="pieRose" id="yearPieRose"></div>
                                </div>
                                <div class="col-xs-6 pieRoseDiv">
                                	
                                	<p class="moduletopTitle">总评价满意率<span class="oriage" id="cpztmyl"></span></p>
                                	<div class="pieRose" id="totalPieRose"></div>
  
</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>    
<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.11.0.min.js"></script>
<!-- 注意，此段JS需要优先加载需要放在JQ下面，且优先其他JS加载  -->
<script type="text/javascript">
	//解决工作量统计切换出现大小错误的情况
	$(function(){
		//获取专业分布情况柱状图宽度
		var IdChartstudyWidth = $('#chartstudy').width();
		//设置工作量统计柱状图宽度
		$('#teacherTypeChart').width(IdChartstudyWidth);
		$('#courseTypeChart').width(IdChartstudyWidth);
	});
</script>


<script type="text/javascript" src="<%=basePath %>static/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<script src="<%=basePath %>static/new/javascript/bootstrap.min.js" type="text/javascript"></script>
<script src="<%=basePath %>static/new/javascript/echarts-all.js" charset="UTF-8" type="text/javascript"></script>
<script src="<%=basePath %>static/new/javascript/chart1Jq_1103.js" charset="UTF-8" type="text/javascript"></script>
<script src="<%=basePath %>static/new/javascript/pxdtjc/chart1.js" charset="UTF-8" type="text/javascript"></script>
<script src="<%=basePath %>static/new/javascript/pxdtjc/xygpxjx.js" charset="UTF-8" type="text/javascript"></script>
<script src="<%=basePath %>static/new/javascript/pxdtjc/dxbjbqk.js" charset="UTF-8" type="text/javascript"></script>
<script src="<%=basePath %>static/new/javascript/pxdtjc/gzl.js" charset="UTF-8" type="text/javascript"></script>
<script src="<%=basePath %>static/new/javascript/pxdtjc/pj.js" charset="UTF-8" type="text/javascript"></script>
<script type="text/javascript">
$(function(){

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
		},
		async:false,
		dataType:"json"
	});
	$.ajax({
		url:"monthplan/findByYear.do",
		method: "POST",
		success:function(data){
			var html = [];
			for(var i=0;i<data.length;i++){
				html.push('<li id="'+data[i].id+'"value="'+data[i].id+'">'+data[i].trainName+'</li>');
			}
			$("#projectSelectedName").html(data[0].trainName);
			$("#projectCombo").html(html.join(''));
		},
		async:false,
		dataType:"json"
	});
	/* initSearchBox(); */
	$("#search").bind("click",doSearch);
	initData();
	
	
	getZprtsForShort();
});

//获取短期班举办情况中的在培人数
var getZprtsForShort = function(){
	var depName = $("#depSelectedName").text();
	$.post('pxdtjc/getZprsForShort',{depName:depName})
	.done(function(data){
		//console.log(data);
		$('#zprs_yangjian').html(data['num']);
	})
	.fail(function(){alert('获取数据失败')});
};


function initData()
{
 	initXygPxJx();
 	initDxbjbqk();
	initGzl();
	initPj();	
	chartXyg();
	chartGzl();	
	chartPj();	
	initChart1Jq(); 
}
function initSearchBox()
{
	$.post("monthplan/findByYear.do",{},function(data){
		var html = [];
		for(var i=0;i<data.length;i++){
			html.push('<li id="'+data[i].id+'"value="'+data[i].id+'">'+data[i].trainName+'</li>');
		}
		$("#projectSelectedName").html(data[0].trainName);
		$("#projectCombo").html(html.join(''));
	},"JSON");	
}

function doSearch()
{
	initXygPxJx();
	initDxbjbqk();
	initGzl();
	initPj();
	chartXyg();
	chartGzl();	
	chartPj();	
	getZprtsForShort();
}

</script>
</body>
	
</body>
</html>
