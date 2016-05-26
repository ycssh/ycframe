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

<title>后勤资源监测</title>

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

<!--[if lt IE 9]>
<script src="<%=basePath %>static/new/javascript/html5shiv.js"></script>
<script src="<%=basePath %>static/new/javascript/respond.min.js"></script>
<![endif]-->

<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.11.0.min.js"></script>
<script src="<%=basePath %>static/new/javascript/bootstrap.min.js" type="text/javascript"></script>
<script src="<%=basePath %>static/new/javascript/echarts-all.js" charset="UTF-8" type="text/javascript"></script>
<script src="<%=basePath %>static/new/javascript/chart1JqForOld.js" charset="UTF-8" type="text/javascript"></script>
<script src="<%=basePath %>static/new/javascript/placeholderfriend.js" charset="UTF-8" type="text/javascript"></script>
</head>

</head>
<body>
    <div class="content">
        <!-- <div class="wrapNav"></div>  -->
		<div class="contentRight" style ="margin-left:0px;">
			<!-- <div class="queryDiv">
				<label for="">培训地点:</label>
				<select name="" id="">
					<option value="">电网运行培训部</option>
				</select>
				 <div class="selectDiy">
					<span id ="trainPlace" class="selectCont">济南</span>
					<i class="tag icons-selectTra"></i>
					<ul>
						<li>济南</li>
						<li>泰安校区</li>
					</ul>
				</div>

				<button class="search" id="trainPlaceSelect">检索</button>
				<button class="restart">重置</button>
				<button class="report">导出</button>
			</div> -->
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="moduleDiv moduleDivAuto ">
                            <p class="moduleTitle icons-moduleTitleBg">后勤资源监测</p>
                            
                            <div class="row rowMargin15">
                            <div class="col-xs-12">
                            <div class="modulesubTitle">
                                <i class="icons-weizhi"></i>济南
                            </div>
                            </div>
                                <div class="col-xs-2 maginTop15">
                                    <div class="tagImg icons-fangjianzongshu"></div>
                                    <p class="tagName">房间总数</p>
                                    <p class="tagNum" id="roomAllNumForD001"></p>
                                </div>
                                <div class="col-xs-2 maginTop15">
                                    <div class="tagImg icons-yiyongfangjian"></div>
                                    <p class="tagName">已用房间</p>
                                    <p class="tagNum" id="roomUseNumForD001"></p>
                                </div>
                                <div class="col-xs-2 maginTop15">
                                    <div class="tagImg icons-kongxianfangjian"></div>
                                    <p class="tagName">空闲房间</p>
                                    <p class="tagNum" id="roomNoNumForD001"></p>
                                </div>
                                <div class="col-xs-2 maginTop15">
                                    <div class="tagImg icons-yudingfangjian"></div>
                                    <p class="tagName">预定房间</p>
                                    <p class="tagNum" id="roomBookNumForD001"></p>
                                </div>
                                <div class="col-xs-4 maginTop15">
                                    <div class="tagImg icons-jihuawanchenglv"></div>
                                    <div class="tagName">房间使用率
                                        <span class="oriageFont" id="roomRateForD001"></span>
                                    </div>
                                    <div class="tagNum shortNum">
                                        <div class="progressDiv" id = "rateOutForD001">
                                            <div class="progressUp" id = "rateInForD001" style ="width:0px;"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xs-12 chartLongTitle">
								南山公寓客房安排变化曲线
                                </div>
                                <div class="LongChartDiv col-xs-12" id = "chartForD001" style ="height:280px;">

                                </div>
                                <div class="col-xs-12">
                                <div class="modulesubTitle">
                                    <i class="icons-weizhi"></i>泰安
                                </div>
                                </div>
                                    <div class="col-xs-2 maginTop15">
                                        <div class="tagImg icons-fangjianzongshu"></div>
                                        <p class="tagName">房间总数</p>
                                        <p class="tagNum" id="roomAllNumForD002"></p>
                                    </div>
                                    <div class="col-xs-2 maginTop15">
                                        <div class="tagImg icons-yiyongfangjian"></div>
                                        <p class="tagName">已用房间</p>
                                        <p class="tagNum" id="roomUseNumForD002"></p>
                                    </div>
                                    <div class="col-xs-2 maginTop15">
                                        <div class="tagImg icons-kongxianfangjian"></div>
                                        <p class="tagName">空闲房间</p>
                                        <p class="tagNum" id="roomNoNumForD002"></p>
                                    </div>
                                    <div class="col-xs-2 maginTop15">
                                        <div class="tagImg icons-yudingfangjian"></div>
                                        <p class="tagName">预定房间</p>
                                        <p class="tagNum" id="roomBookNumForD002"></p>
                                    </div>
                                    <div class="col-xs-4 maginTop15">
                                        <div class="tagImg icons-jihuawanchenglv"></div>
                                        <div class="tagName">房间使用率
                                            <span class="oriageFont" id="roomRateForD002"></span>
                                        </div>
                                        <div class="tagNum shortNum">
                                            <div class="progressDiv" id = "rateOutForD002">
                                                <div class="progressUp" id = "rateInForD002" style ="width:0px;"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-12 chartLongTitle">
                                        	泰安公寓客房安排变化曲线
                                    </div>
                                    <div class="LongChartDiv col-xs-12" id = "chartForD002" style ="height:280px;">

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</body>

<script type="text/javascript">
$(function(){
	//解决IE8 不支持 indexof 属性======
	if (!Array.prototype.indexOf)
	{
	  Array.prototype.indexOf = function(elt /*, from*/)
	  {
	    var len = this.length >>> 0;
	    var from = Number(arguments[1]) || 0;
	    from = (from < 0)
	         ? Math.ceil(from)
	         : Math.floor(from);
	    if (from < 0)
	      from += len;
	    for (; from < len; from++)
	    {
	      if (from in this &&
	          this[from] === elt)
	        return from;
	    }
	    return -1;
	  };
	}

	//获取济南和泰安校区房间使用情况数据
	 $.post('hqzyjc/getPageData')
		.done(function (data){
			//console.log(data);
			
			//济南数据渲染
			getD001Html(data['D001befMothUseInfo'],data['D001nowMothUseInfo'],data['D001todayAllNum'],data['D001todayBookNum'],data['D001todayNoNum'],data['D001todayUseNum']);
			//泰安校区数据渲染
			getD002Html(data['D002befMothUseInfo'],data['D002nowMothUseInfo'],data['D002todayAllNum'],data['D002todayBookNum'],data['D002todayNoNum'],data['D002todayUseNum']);

		})
   		.fail(function () {alert('获取数据失败');});
		
	
	/*============================================济南据渲染=============================================================*/
	/**
	 * 济南据渲染
	 * @param befMothUseInfo 上个月宿舍使用情况数据
	 * @param nowMothUseInfo 本月宿舍使用情况数据
	 * @param todayAllNum 今天房间总数
	 * @param todayBookNum 今天房间预订数
	 * @param todayNoNum  今天房间未使用数
	 * @param todayUseNum 今天放假已使用数
	 * @return
	 */
	var getD001Html = function(befMothUseInfo,nowMothUseInfo,todayAllNum,todayBookNum,todayNoNum,todayUseNum){
	
		//第一部分头部今天房间使用情况渲染
		var partOneFunction =function(){		 
			 //房间总数
			 var allNum = todayAllNum;
			 //已用房间
			 var useNum = todayUseNum;
			 //空闲房间
			 var noNum = todayNoNum;
			 //预定房间
			 var bookNum = todayBookNum;
			 //房间使用率
			 var useRate =Number(allNum)==0? "0%" :  ((Number(useNum) / Number(allNum) ) * 100).toFixed(2) +"%";
			 
			 //渲染页面
			 $('#roomAllNumForD001').html(allNum);
			 $('#roomUseNumForD001').html(useNum);
			 $('#roomNoNumForD001').html(noNum);
			 $('#roomBookNumForD001').html(bookNum);
			 $('#roomRateForD001').html(useRate);
			 
			 
			 //教室使用率百分轴渲染
			//获取外部div长度
			var outWidth = $('#rateOutForD001').width();
			//得到内部应该显示的长度
			var inWidth =Number(allNum)==0? "0" :  (Number(outWidth) * ( ((Number(useNum) / Number(allNum)).toFixed(4) ) ) ).toFixed(0);
			//渲染内部长度
			 $('#rateInForD001').width(inWidth);			 
		};
		
		
		
		//绘制第二部分表格
		var partTwoFunction = function(){
			//获取本月和上月天数
			var nowMonthDays = nowMothUseInfo.length;
			var befMonthDays = befMothUseInfo.length;
			//获取最大的月份天数
			var maxDays = Math.max(Number(nowMonthDays),Number(befMonthDays));
			
			//循环获取X轴显示的每天数据
			var XdatesArr = [];
			for(var index = 1; index<=maxDays ;index++){
				XdatesArr.push(index.toString() + '日');
			}
			
			//获取本月数据和上月数据
			var nowMonthDataArr = [];
			var befMonthDataArr = [];
			for(var index = 0; index <maxDays ;index++){
				if(nowMothUseInfo[index]!=null){
					nowMonthDataArr.push(nowMothUseInfo[index]['counts']);
				}
				
				if(befMothUseInfo[index]!=null){
					befMonthDataArr.push(befMothUseInfo[index]['counts']);
				}

			}
			
			//绘制
			tableFunction(XdatesArr,nowMonthDataArr,befMonthDataArr,'chartForD001');		
		};
		
		
		//初始化执行函数
		partOneFunction();	
		partTwoFunction();
	};
	
	
	/*============================================泰安校区数据渲染=============================================================*/
	/**
	 * 泰安校区数据渲染
	 * @param befMothUseInfo 上个月宿舍使用情况数据
	 * @param nowMothUseInfo 本月宿舍使用情况数据
	 * @param todayAllNum 今天房间总数
	 * @param todayBookNum 今天房间预订数
	 * @param todayNoNum  今天房间未使用数
	 * @param todayUseNum 今天放假已使用数
	 * @return
	 */
	var getD002Html = function(befMothUseInfo,nowMothUseInfo,todayAllNum,todayBookNum,todayNoNum,todayUseNum){
		//第一部分头部今天房间使用情况渲染
		var partOneFunction =function(){		 
			 //房间总数
			 var allNum = todayAllNum;
			 //已用房间
			 var useNum = todayUseNum;
			 //空闲房间
			 var noNum = todayNoNum;
			 //预定房间
			 var bookNum = todayBookNum;
			 //房间使用率
			 var useRate =Number(allNum)==0? "0%" : ((Number(useNum) / Number(allNum) ) * 100).toFixed(2)+'%';
			 
			 //渲染页面
			 $('#roomAllNumForD002').html(allNum);
			 $('#roomUseNumForD002').html(useNum);
			 $('#roomNoNumForD002').html(noNum);
			 $('#roomBookNumForD002').html(bookNum);
			 $('#roomRateForD002').html(useRate);
			 
			 
			 //教室使用率百分轴渲染
			//获取外部div长度
			var outWidth = $('#rateOutForD002').width();
			//得到内部应该显示的长度
			var inWidth =Number(allNum)==0? "0" : (Number(outWidth) * ( ((Number(useNum) / Number(allNum)).toFixed(4) ) ) ).toFixed(0);
			//渲染内部长度
			 $('#rateInForD002').width(inWidth);			 
		};
		
		
		
		//绘制第二部分表格
		var partTwoFunction = function(){
			//获取本月和上月天数
			var nowMonthDays = nowMothUseInfo.length;
			var befMonthDays = befMothUseInfo.length;
			//获取最大的月份天数
			var maxDays = Math.max(Number(nowMonthDays),Number(befMonthDays));
			
			//循环获取X轴显示的每天数据
			var XdatesArr = [];
			for(var index = 1; index<=maxDays ;index++){
				XdatesArr.push(index.toString() + '日');
			}
			
			//获取本月数据和上月数据
			var nowMonthDataArr = [];
			var befMonthDataArr = [];
			for(var index = 0; index <maxDays ;index++){
				if(nowMothUseInfo[index]!=null){
					nowMonthDataArr.push(nowMothUseInfo[index]['counts']);
				}
				
				if(befMothUseInfo[index]!=null){
					befMonthDataArr.push(befMothUseInfo[index]['counts']);
				}

			}
			
			//绘制
			tableFunction(XdatesArr,nowMonthDataArr,befMonthDataArr,'chartForD002');		
		};
		
		
		//初始化执行函数
		partOneFunction();	
		partTwoFunction();
	};
	
	
	/*============================================公用函数=============================================================*/
	//绘制echart折线图表格
	var tableFunction = function(XdatesArr,nowMonthDataArr,befMonthDataArr,dom){
	//设置表格显示
	var option = {
			tooltip : {
		        trigger: 'axis'
		    },
			backgroundColor:['#f7f7f7'],
		    legend: {
		        data:['本月客房使用情况','上月客房使用情况'],
				y: 'bottom',
		    },
		    xAxis : [
		        {
		            type : 'category',
		            boundaryGap : false,
		            data : XdatesArr,
					axisLabel : {show:true,interval: 'auto',rotate: 45}
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value'
		        }
		    ],
		    series : [
		        {
		            name:'本月客房使用情况',
		            type:'line',
		            data:nowMonthDataArr
		        },
		        {
		            name:'上月客房使用情况',
		            type:'line',
		            data:befMonthDataArr
		        }
		    ]
		};
               
		//执行echarts
		echarts.init(document.getElementById(dom)).setOption(option);
	}
	
	
	
});
</script>

</html>