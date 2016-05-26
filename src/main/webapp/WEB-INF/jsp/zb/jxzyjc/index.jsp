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

<title>教学资源监测</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" href="<%=basePath %>static/new/stylesheets/screen.css">
<link rel="stylesheet" href="<%=basePath %>static/new/stylesheets/bootstrap.min.css">


<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.11.0.min.js"></script>
<script src="<%=basePath %>static/new/javascript/bootstrap.min.js" type="text/javascript"></script>
<script src="<%=basePath %>static/new/javascript/echarts-all.js" charset="UTF-8" type="text/javascript"></script>
<script src="<%=basePath %>static/new/javascript/chart1JqForOld.js" charset="UTF-8" type="text/javascript"></script>
<script src="<%=basePath %>static/new/javascript/placeholderfriend.js" charset="UTF-8" type="text/javascript"></script>

<style type="text/css">
table td{
	font-size: 12px;
}
.contentRight .moduleDiv .tableDiv .tableBody {
  height: 126px;
}
</style>

</head>
<body>
       <div class="content">
	    <!-- <div class="wrapNav"></div>  -->
		<div class="contentRight" style ="margin-left:0px;">
                <div class="queryDiv">
                    <label for="">培训地点:</label>
                    <!-- <select name="" id="">
                        <option value="">电网运行培训部</option>
                    </select> -->
                    <div class="selectDiy">
                    	<span id ="trainPlace" class="selectCont">济南校区</span>
                    	<i class="tag icons-selectTra"></i>
                    	<ul>
                    		<li>济南校区</li>
                    		<li>泰山校区</li>
                    	</ul>
                    </div>
                    
                    <button id = "trainPlaceSelect" class="search">检索</button>
                   <!--  <button class="restart">重置</button>
                    <button class="report">导出</button> -->
                </div>
            <div class="container-fluid">
            	<div class="row">
            		<div class="col-md-12">
            			<div class="moduleDiv moduleDivAuto ">
            				<p class="moduleTitle icons-moduleTitleBg">教室使用情况监测</p>
            				<div class="row rowNoMargin">
            					<div class="col-xs-2 maginTop15">
            						<div class="tagImg icons-allRoom"></div>
                                    <p class="tagName">教室总数</p>
                                    <p class="tagNum"><a id="allNumForJXL" href="" style ='text-decoration:none;'></a></p>
            					</div>
            					<div class="col-xs-2 maginTop15">
            						<div class="tagImg icons-usingRoom"></div>
                                    <p class="tagName">在用教室</p>
                                    <p class="tagNum"><a id = "useNumForJXL" href="" style ='text-decoration:none;'></a></p>
            					</div>
            					<div class="col-xs-2 maginTop15">
            						<div class="tagImg icons-spareRoom"></div>
                                    <p class="tagName">空余教室</p>
                                    <p class="tagNum"><a id = "noNumForJXL" href="" style ='text-decoration:none;'></a></p>
            					</div>
            					<div class="col-xs-5 maginTop15">
            						<div class="tagImg icons-jihuawanchenglv"></div>
                                    <div class="tagName">教室使用率<span class="oriageFont" id="useRateForJXL"></span></div>
                                    <div class="tagNum shortNum">
                                    	<div class="progressDiv" id = "rateOutForJXL">
                                    		<div class="progressUp" id = "rateInForJXL" style ="width:0px;"></div>
                                    	</div>
                                    </div>
            					</div>
            					<div class="tableTop col-xs-12">
                                		<p class="tableTop-title tableTop-title-inline"><i class="greenDot icons-greenDot"></i>教室基本情况一览</p>
                                        <form action="">
                                            <div class="queryBox">
                                                <input type="text" placeholder="搜索房间号" id = "searchRoomTextForJXL"/>
												<button id ="searchRoomButtonForJXL">检索</button>
                                            </div>
                                        </form>
                                </div>
                                <div class="tableDiv nomarginTableDiv col-xs-12">
                                    <table  class="thTable">
                                        <thead>
                                            <tr>
                                                <th id = "roomUseTableFirstHeadForJXL" class="roomUseTableHeadForJXL">房间号</th>
                                                <th class="roomUseTableHeadForJXL">教室用途</th>
                                                <th class="roomUseTableHeadForJXL">管理部门</th>
                                                <th class="roomUseTableHeadForJXL">最大容纳人数</th>
                                                <th>所属楼宇</th>
                                            </tr>
                                        </thead>
                                        </table>
                                        <div class="tableBody"> 
                                            <table id = "roomUseTableForJXL">
                                             	<thead>
                                                   <tr class="thKong">
                                                       <th></th>
                                                       <th></th>
                                                       <th></th>
                                                       <th></th>
                                                       <th></th>
                                                   </tr>
                                                </thead>
                                            <tbody id = "roomUseInfoForJXL">

                                            </tbody>
                                            </table>
                                        </div>
                                    </table>
                                </div>
                                <div class="tableTop col-xs-12">
                                		<p class="tableTop-title tableTop-title-inline"><i class="greenDot icons-greenDot"></i>教室分布情况监测</p>
                                		<label for="">楼层：</label>
                                		<div class="selectDiy smallSelectDiy" id ="thisSelectForFlooRWithJXL">
					                    	<span class="selectCont" id ="floorThisForJXL"></span>
					                    	<i class="tag icons-selectTra"></i>
					                    	<ul id = "floorSelectForJXL">
					                    	</ul>
					                    </div>
					                    <p class="darkFont">在用：<span class="orageColor" id ="thisFloorUseNumForJXL"></span></p>
					                    <p class="darkFont">空余：<span class="greenColor" id ="thisFloorNoNumForJXL"></span></p>
                                </div>
                                <div class="nomarginTableDiv col-xs-12">
                                    <ul id = "thisFloorRoomForJXL">
                                    	
                                    </ul>
                                </div>
                                <div class="tableTop col-xs-12">
                                        <p class="tableTop-title"><i class="greenDot icons-greenDot"></i>教室课程安排情况监测</p>
                                        
                                </div>
                                <div class="tableDiv nomarginTableDiv col-xs-12">
                                    <table class="thTable">
                                        <thead>
                                            <tr>
                                                <th id = "scheduleTableFirstHeadForJXL" class = "scheduleTableHeadForJXL">房间号</th>
                                                <th class = "scheduleTableHeadForJXL">班级</th>
                                                <th class = "scheduleTableHeadForJXL">日期</th>
                                                <th class = "scheduleTableHeadForJXL">时段</th>
                                                <th class = "scheduleTableHeadForJXL">课程名称</th>
                                                <th>培训师</th>
                                            </tr>
                                        </thead>
                                    </table>
                                    <div class="tableBody"> 
                                            <table id = "scheduleTableForJXL">
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
                                            <tbody id ="scheduleForJXL">
                                                
                                            </tbody>
                                            </table>
                                        </div>
                                    </table>
                                </div>
            				</div> 
            			</div>
            		</div>
					
					
            		<div class="col-md-12">
            			<div class="moduleDiv moduleDivAuto ">
            				<p class="moduleTitle icons-moduleTitleBg">实训室使用情况监测</p>
            				<div class="row rowNoMargin">
            					<div class="col-xs-2 maginTop15">
            						<div class="tagImg icons-allRoom"></div>
                                    <p class="tagName">实训室总数</p>
                                    <p class="tagNum"><a id="allNumForSXL" href="" style ='text-decoration:none;'></a></p>
            					</div>
            					<div class="col-xs-2 maginTop15">
            						<div class="tagImg icons-usingRoom"></div>
                                    <p class="tagName">在用实训室</p>
                                    <p class="tagNum"><a id = "useNumForSXL" href="" style ='text-decoration:none;'></a></p>
            					</div>
            					<div class="col-xs-2 maginTop15">
            						<div class="tagImg icons-spareRoom"></div>
                                    <p class="tagName">空余实训室</p>
                                    <p class="tagNum"><a id = "noNumForSXL" href="" style ='text-decoration:none;'></a></p>
            					</div>
            					<div class="col-xs-5 maginTop15">
            						<div class="tagImg icons-jihuawanchenglv"></div>
                                    <div class="tagName">实训室使用率<span class="oriageFont" id="useRateForSXL"></span></div>
                                    <div class="tagNum shortNum">
                                    	<div class="progressDiv" id = "rateOutForSXL">
                                    		<div class="progressUp" id = "rateInForSXL" style ="width:0px;"></div>
                                    	</div>
                                    </div>
            					</div>
            					<div class="tableTop col-xs-12">
                                		<p class="tableTop-title tableTop-title-inline"><i class="greenDot icons-greenDot"></i>实训室基本情况一览</p>
                                        <form action="">
                                            <div class="queryBox">
                                                <input type="text" placeholder="搜索房间号" id = "searchRoomTextForSXL"/>
												<button id ="searchRoomButtonForSXL">检索</button>
                                            </div>
                                        </form>
                                </div>
                                <div class="tableDiv nomarginTableDiv col-xs-12">
                                    <table  class="thTable">
                                        <thead>
                                            <tr>
                                                <th id = "roomUseTableFirstHeadForSXL" class="roomUseTableHeadForSXL">实训室名称</th>
                                                <th class="roomUseTableHeadForSXL">实训室类型</th>
                                                <th class="roomUseTableHeadForSXL">管理部门</th>
                                                <th class="roomUseTableHeadForSXL">最大容纳人数</th>
                                                <th>所属楼宇</th>
                                            </tr>
                                        </thead>
                                        </table>
                                        <div class="tableBody"> 
                                            <table id= "roomUseTableForSXL">
                                             	<thead>
                                                   <tr class="thKong">
                                                       <th></th>
                                                       <th></th>
                                                       <th></th>
                                                       <th></th>
                                                       <th></th>
                                                   </tr>
                                                </thead>
                                            <tbody id = "roomUseInfoForSXL">
                                                
                                            </tbody>
                                            </table>
                                        </div>
                                    </table>
                                </div>
                               
                                <div class="tableTop col-xs-12">
                                        <p class="tableTop-title"><i class="greenDot icons-greenDot"></i>实训室课程安排情况监测</p>
                                </div>
                                <div class="tableDiv nomarginTableDiv col-xs-12">
                                    <table class="thTable">
                                        <thead>
                                            <tr>
                                                <th id ="scheduleTableFirstHeadForSXL" class = "scheduleTableHeadForSXL">实训室名称</th>
                                                <th class = "scheduleTableHeadForSXL">班级</th>
                                                <th class = "scheduleTableHeadForSXL">日期</th>
                                                <th class = "scheduleTableHeadForSXL">时段</th>
                                                <th class = "scheduleTableHeadForSXL">课程名称</th>
                                                <th>培训师</th>
                                            </tr>
                                        </thead>
                                    </table>
                                    <div class="tableBody"> 
                                            <table id ="scheduleTableForSXL">
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
                                            <tbody id ="scheduleForSXL">
                                                
                                            </tbody>
                                            </table>
                                        </div>
                                    </table>
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

	/**
	 * 绑定下拉框点击事件
	 * @return
	 */
	$('#trainPlaceSelect').unbind('click').click(function(e){
		//获取所选地点的值
		var trainPlaceName = $('#trainPlace').html();
		
		//将汉字值转为字符串ID ,默认为济南校区的DOO1
		var trainPlaceId ='D001';
		if(trainPlaceName == '济南校区'){
			trainPlaceId ='D001';
		}else if(trainPlaceName == '泰山校区'){
			trainPlaceId ='D002';
		}
		
		
		//获取该培训地点下的教学楼和培训楼数据
		$.post('jxzyjc/getClassRoomData?placeId='+trainPlaceId)
			.done(function (data){
				//console.log(data);
				
				//执行教学楼数据渲染函数
				domApplyForJXL(data['JxlAllInfo'],data['JxlIsInfo'],data['JxlNoInfo'],data['JxlSchedule'],data['JxlFloor']);
				
				//执行实训楼数据渲染函数
				domApplyForSXL(data['SxlAllInfo'],data['SxlIsInfo'],data['SxlNoInfo'],data['SxlSchedule']);
			})
       		.fail(function () {});
		
		
		//阻止默认和冒泡事件
		e.preventDefault();
		e.stopPropagation();
	});
	
	
	/**
	 * 初始化触发下拉框点击数据
	 */
	$("#trainPlaceSelect").trigger('click');
 	
 	/*============================================教学楼数据渲染=============================================================*/
	/**
	 * 教学楼数据渲染
	 * @param JxlAllInfo 教学楼所有教师数据
	 * @param JxlIsInfo 教学楼已用教室数据
	 * @param JxlNoInfo 教学楼未用教室数据
	 * @param JxlSchedule 教学楼已用教室课程
	 * @return
	 */
 	var domApplyForJXL = function(JxlAllInfo,JxlIsInfo,JxlNoInfo,JxlSchedule,jxlFloorInfo){
 		//变量赋值
		var allInfo = JxlAllInfo,//所有教室数据
			isInfo = JxlIsInfo,//已用教室数据
			noInfo = JxlNoInfo,//未用教室数据
			schedule = JxlSchedule,//已用教室课程
			nowRoomInfo,//当前所显示的教室
			floorInfo = jxlFloorInfo,//楼层信息
			firstFloor, //定义教室分布情况监测下拉框第一个楼层名称
			roomUseTableHeadWidth = $('#roomUseTableFirstHeadForJXL').width(),//教室使用情况头部原来的宽度
			scheduleTableHeadWidth = $('#scheduleTableFirstHeadForJXL').width() //课程表头部原来的宽度
			;
 		
 		//第一部分教室数量显示渲染
 		var partOneFunction = function(){
			//教室数量
			var allNum = allInfo.length;
			//在用教室数量
			var isNum = isInfo.length;
			//空余教室数量
			var noNum = noInfo.length;
			//教室使用率
			var useRate = ((Number(isNum) / Number(allNum) ) * 100).toFixed(2) +"%";
			
			//渲染页面
			$('#allNumForJXL').html(allNum);
			$('#useNumForJXL').html(isNum);
			$('#noNumForJXL').html(noNum);
			$('#useRateForJXL').html(useRate);
			
			//教室使用率百分轴渲染
			//获取外部div长度
			var outWidth = $('#rateOutForJXL').width();
			//得到内部应该显示的长度
			var inWidth = (Number(outWidth) * ( ((Number(isNum) / Number(allNum)).toFixed(4) ) ) ).toFixed(0);
			//渲染内部长度
			 $('#rateInForJXL').width(inWidth);	
		};
		
		
		//第二部分教室使用情况一览 渲染
		var partTwoFunction = function(roomInfo,isSearch){
			//页面显示内容
			var htmlStringArr =[];
			//数据长度
			var len = roomInfo.length;
			//循环数据，获取页面显示内容
			for(var index =0 ;  index < len ; index++){
				//房间名称
				var roomName = roomInfo[index]['roomName'];
				//房间用途
				var useName = roomInfo[index]['useName'];
				//管理部门
				var deptName = roomInfo[index]['deptName'];
				//最大容纳人数
				var maxNum = roomInfo[index]['maxNum'];
				//所属于楼宇
				var buildName = roomInfo[index]['buildName'];
				//页面显示内容
				var thisHtml = '<tr><td><a class ="roomNamePartTwoForJXL" href="javascript:void(0);" style="text-decoration:none;color:#454545;">'+roomName+'</a></td><td>'+useName+'</td><td>'+deptName+'</td><td>'+maxNum+'</td><td>'+buildName+'</td></tr>';
				//加入到数组中
				htmlStringArr.push(thisHtml);				
			}
			//获取在页面显示的内容
			var allHtmlString = htmlStringArr.join(' ');
			//显示在页面上
			$('#roomUseInfoForJXL').html(allHtmlString);

			
			//因为数据超过四行会出现下拉轴导致上下部分表格宽不对其，故需再次进行调整
			if(htmlStringArr.length>4){
				//获取数据表格宽度
				var dataTableWidth = $('#roomUseTableForJXL').width();
				var everyColWidth = (Number(dataTableWidth) / 5)-1;
				//alert(everyColWidth);
				//将 表头列前4个设置为上面列宽度，注意第五个不可设，否则会出现错乱。
				$('.roomUseTableHeadForJXL').width(everyColWidth);
			}else{				
				$('.roomUseTableHeadForJXL').width(roomUseTableHeadWidth);
			}
			
			//将所用教室赋给当前所有教室,只有不是点击查询的时候才赋值
			if(isSearch == 0){
				nowRoomInfo = roomInfo;
			}
			
			//绑定第二部分教室使用情况一览表格中房间号点击效果
			partTwoRoomNameClickFunction();
		};
		
		//第二部分教室使用情况一览表格中房间号点击效果
		var partTwoRoomNameClickFunction = function(){						
			var $tbody = $('#roomUseInfoForJXL');
			$tbody.each(function(){
				$('.roomNamePartTwoForJXL').unbind('click').click(function(){
					//获取班级名称
					var className =$(this).html();
					//定义数组
					var suitArr =[];
					
					//循环再用班级教室，获取该教室课程
					for(var index =0 ;index < schedule.length ; index++){
					//获取房间号
					var roomName = schedule[index]['roomName'];
					//只有当房间号与所选房间号相同时候塞入数组中
					if(roomName == className){
						suitArr.push(schedule[index]);
						}								
					}
					
					//执行教室使用情况预览函数
					partFourFunction(suitArr);
					
				});
			});			
		}
		
		//第三部分教室资源情况监测  中获取楼层下拉框数据
		var partThreeSelectFunction = function(){
			//渲染默认显示的
			$('#floorThisForJXL').html(floorInfo[0]['htmlName']);
			firstFloor = floorInfo[0]['htmlName'];
			//渲染下拉框显示数据
			var selectHtml = '';
			for(var index = 0 ;index < floorInfo.length ;index++){
				selectHtml = selectHtml + ' <li>'+floorInfo[index]['htmlName']+'</li> ';
			}
			$('#floorSelectForJXL').html(selectHtml);
			
			//初始化执行第三部分教室分布使用情况 下拉框实现函数
			floorSelectFunction();
		};
		
		//第三部分教室分布使用情况 下拉框实现函数
		var floorSelectFunction = function(){
		//自定义select事件
		var $selectDiy=$('#thisSelectForFlooRWithJXL');
		$selectDiy.each(function(){
			var $selectCont=$(this).children('.selectCont');
			var $selectUl=$(this).children('ul');
			var $selectLi=$selectUl.children('li');
			$(this).unbind('click').click(function(){
				$selectUl.toggle();
				
				});
			$selectLi.unbind('click').click(function(){
				var showCon=$(this).html();
				$selectCont.html(showCon);
				
				//执行第三部分楼层表格函数
				partThreeTableFunction(showCon);
				
				});
			});
		}
		
		//第三部分教室分布情况监测 中表格显示(满足筛选框楼层名称的)
		var partThreeTableFunction = function(nowFloorName){
			//定义页面显示html数组
			var htmlArr = [];
			//定义该楼层在用教室数量
			var useNum=0;
			//定义该楼层已用教室数量
			var noNum=0;
			
			//循环所有教室信息，获取该楼层教室
			for(var index = 0 ; index < allInfo.length ; index++){
				//获取楼层名称
				var floorName = allInfo[index]['roomFloor'];
				//获取教室是否使用标号
				var isUse = allInfo[index]['isUse'];
				//获取教室名称
				var thisRoomName = allInfo[index]['roomName'];
				
				//判断楼层是否和当前选中的楼层一样,若一样塞入数组中
				if(floorName == nowFloorName ){
					//定义页面显示html
					var thisFloorHtml = '';
					//根据是否已经使用显示不同的html
					if(isUse == 1){//已经使用
						thisFloorHtml = '<li><dl><dt class = "floorRoomNameForJXL">'+thisRoomName+'</dt><dd style ="padding-top: 10px;"><span  class="used floorPicForJXL"><div style="display:none">'+thisRoomName+'</div></span></dd></dl></li>';
						useNum = useNum+1;
					}else{//未使用
						thisFloorHtml = '<li><dl><dt class = "floorRoomNameForJXL">'+thisRoomName+'</dt><dd style ="padding-top: 10px;"><span  class="spare floorPicForJXL"><div style="display:none">'+thisRoomName+'</div></span></dd></dl></li>';
						noNum = noNum+1;
					}
					//加入到页面显示数组中
					htmlArr.push(thisFloorHtml);
				}
			}
			
			//渲染表格
			$('#thisFloorRoomForJXL').html(htmlArr.join(' '));
			//渲染已用教室数量
			$('#thisFloorUseNumForJXL').html(useNum);
			//渲染未用教室数量
			$('#thisFloorNoNumForJXL').html(noNum);
			
			//绑定 第三部分教室分布情况监测 点击教室对应的小圆圈效果
			partThreeRoomNameClickFunction();
		};
		
		//第三部分教室分布情况监测 点击教室对应的小圆圈效果
		var partThreeRoomNameClickFunction = function(){						
			var $tbody = $('#thisFloorRoomForJXL');
			$tbody.each(function(){
				$('.floorPicForJXL').unbind('click').click(function(){
					//获取班级名称
					var className =$(this).children('div').html();
					//定义数组
					var suitArr =[];
					
					//循环再用班级教室，获取该教室课程
					for(var index =0 ;index < schedule.length ; index++){
					//获取房间号
					var roomName = schedule[index]['roomName'];
					//只有当房间号与所选房间号相同时候塞入数组中
					if(roomName == className){
						suitArr.push(schedule[index]);
						}								
					}
					
					//执行教室使用情况预览函数
					partFourFunction(suitArr);
					
				});
			});			
		}
			
		
		//第四部分 教室课程安排情况监测 渲染
		var partFourFunction = function(scheduleInfo){
			//定义页面显示数组
			var htmlArr = [];
			//循环函数获取页面显示内容
			for(var index =0 ;index < scheduleInfo.length ; index++){
				//获取房间号
				var roomName = scheduleInfo[index]['roomName'];
				//教室人数
				var  stuNum = scheduleInfo[index]['stuNum'];
				//班级名称
				var className = scheduleInfo[index]['className'];
				//课程名称
				var courseName = scheduleInfo[index]['courseName'];
				//日期
				var data = scheduleInfo[index]['nowDay'];
				//时段
				var period = scheduleInfo[index]['period'];
				//教师
				var teacherName = scheduleInfo[index]['teacherName'];
													
				//获取该行显示内容插入页面显示数组					
				var thisRowHtml = '<tr><td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" title="'+roomName+'">'+roomName+'</td><td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" title="'+className+'">'+className+'</td><td>'+data+'</td><td>'+period+'</td><td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" title="'+courseName+'">'+courseName+'</td><td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" title="'+teacherName+'">'+teacherName+'</td></tr>';	
				htmlArr.push(thisRowHtml);
			}
			
			//渲染到页面
			$('#scheduleForJXL').html(htmlArr.join(' '));
			
			//因为数据超过四行会出现下拉轴导致上下部分表格宽不对其，故需再次进行调整
			if(htmlArr.length>4){
				//获取数据表格宽度
				var dataTableWidth = $('#scheduleTableForJXL').width();
				var everyColWidth = (Number(dataTableWidth) / 6)-1;
				//alert(everyColWidth);
				$('.scheduleTableHeadForJXL').width(everyColWidth);
			}else{				
				$('.scheduleTableHeadForJXL').width(scheduleTableHeadWidth);
			}
		};
		
		
		
		//绑定事件
		var bindFunction = function(){
			//绑定点击教室总数 数字 事件。
			$('#allNumForJXL').unbind('click').click(function(e){
				//执行教室使用情况预览函数  参数为 所有教室信息
				partTwoFunction(allInfo,0);
				
				//执行教室使用情况预览函数
				partFourFunction(schedule);
				
				//阻止默认和冒泡事件
				e.preventDefault();
				e.stopPropagation();
			});
			
			//绑定点击在用教室 数字 事件。
			$('#useNumForJXL').unbind('click').click(function(e){
				//执行教室使用情况预览函数  参数为 已用教室信息
				partTwoFunction(isInfo,0);
				
				//执行教室使用情况预览函数
				partFourFunction(schedule);
			
				//阻止默认和冒泡事件
				e.preventDefault();
				e.stopPropagation();
			});
			
			//绑定点击空余教室 数字 事件。
			$('#noNumForJXL').unbind('click').click(function(e){
				//执行教室使用情况预览函数  参数为 未用教室信息
				partTwoFunction(noInfo,0);
				
				//执行教室使用情况预览函数
				var sche = [];
				partFourFunction(sche);
			
				//阻止默认和冒泡事件
				e.preventDefault();
				e.stopPropagation();
			});
			
			//绑定点击搜索房间号 检索按钮 事件。
			$('#searchRoomButtonForJXL').unbind('click').click(function(e){
				//获取搜索房间号输入框的内容
				var searchRoomName = $('#searchRoomTextForJXL').val();
				//去除首尾空格
				searchRoomName =$.trim((searchRoomName || "")); 
				
				//定义满足筛选框内容的房间信息
				var suitRoomInfo = [];
				
				//当输入框为空则直接显示当前所以房间，若不是，则根据条件进行筛选显示
				if(searchRoomName == ""){
					suitRoomInfo = nowRoomInfo;
				}else{
					//长度
					var len = nowRoomInfo.length;
					//循环当前房间信息数组
					for(var index =0 ; index < len ; index++){
						//获取房间名
						var roomName = nowRoomInfo[index]['roomName'];
						//判断该房间名是否包含筛选框字符串
						if((roomName.indexOf(searchRoomName))>=0){
							//若包含塞入满足的房间信息中
							suitRoomInfo.push(nowRoomInfo[index]);
						}
					}
				}
			
				//执行教室使用情况预览函数  参数为 筛选后的教室信息
				partTwoFunction(suitRoomInfo,1);
			
				//阻止默认和冒泡事件
				e.preventDefault();
				e.stopPropagation();
			});

		};
		
		
		//初始化执行函数
		partOneFunction();
		bindFunction();
		$("#allNumForJXL").trigger('click');
		partThreeSelectFunction();
		partThreeTableFunction(firstFloor);
		partFourFunction(schedule);
 	};
 	
	
	
 	/*============================================实训楼数据渲染=============================================================*/
	/**
	 * 实训楼数据渲染
	 * @param SxlAllInfo 实训楼所有教师数据
	 * @param SxlIsInfo 实训楼已用教室数据
	 * @param SxlNoInfo 实训楼未用教室数据
	 * @param SxlSchedule 实训楼课程数据
	 * @return
	 */
 	var domApplyForSXL = function(SxlAllInfo,SxlIsInfo,SxlNoInfo,SxlSchedule){
	 	//变量赋值
		var allInfo = SxlAllInfo,//所有教室数据
			isInfo = SxlIsInfo,//已用教室数据
			noInfo = SxlNoInfo,//未用教室数据
			schedule = SxlSchedule,//已用教室课程
			nowRoomInfo,//当前所显示的教室
			roomUseTableHeadWidth = $('#roomUseTableFirstHeadForSXL').width(),//教室使用情况头部原来的宽度
			scheduleTableHeadWidth = $('#scheduleTableFirstHeadForSXL').width() //课程表头部原来的宽度
			;
 		
 		//第一部分教室数量显示渲染
 		var partOneFunction = function(){
			//教室数量
			var allNum = allInfo.length;
			//在用教室数量
			var isNum = isInfo.length;
			//空余教室数量
			var noNum = noInfo.length;
			//教室使用率
			var useRate = ((Number(isNum) / Number(allNum) ) * 100).toFixed(2) +"%";
			
			//渲染页面
			$('#allNumForSXL').html(allNum);
			$('#useNumForSXL').html(isNum);
			$('#noNumForSXL').html(noNum);
			$('#useRateForSXL').html(useRate);
			
			//教室使用率百分轴渲染
			//获取外部div长度
			var outWidth = $('#rateOutForSXL').width();
			//得到内部应该显示的长度
			var inWidth = (Number(outWidth) * ( ((Number(isNum) / Number(allNum)).toFixed(4) ) ) ).toFixed(0);
			//渲染内部长度
			 $('#rateInForSXL').width(inWidth);	
		};
		
		
		
		//第二部分教室使用情况一览 渲染
		var partTwoFunction = function(roomInfo,isSearch){
			//页面显示内容
			var htmlStringArr =[];
			//数据长度
			var len = roomInfo.length;
			//循环数据，获取页面显示内容
			for(var index =0 ;  index < len ; index++){
				//房间名称
				var roomName = roomInfo[index]['roomName'];
				//房间用途
				var useName = roomInfo[index]['useName'];
				//管理部门
				var deptName = roomInfo[index]['deptName'];
				//最大容纳人数
				var maxNum = roomInfo[index]['maxNum'];
				//所属于楼宇
				var buildName = roomInfo[index]['buildName'];
				//页面显示内容
				var thisHtml = '<tr><td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" title="'+roomName+'"><a class ="roomNamePartTwoForSXL" href="javascript:void(0);" style="text-decoration:none;color:#454545;">'+roomName+'</a></td><td>'+useName+'</td><td>'+deptName+'</td><td>'+maxNum+'</td><td>'+buildName+'</td></tr>';
				//加入到数组中
				htmlStringArr.push(thisHtml);				
			}
			//获取在页面显示的内容
			var allHtmlString = htmlStringArr.join(' ');
			//显示在页面上
			$('#roomUseInfoForSXL').html(allHtmlString);
			
			
			//因为数据超过四行会出现下拉轴导致上下部分表格宽不对其，故需再次进行调整
			if(htmlStringArr.length>4){
				//获取数据表格宽度
				var dataTableWidth = $('#roomUseTableForSXL').width();
				var everyColWidth = (Number(dataTableWidth) / 5)-1;
				//alert(everyColWidth);
				//将 表头列前4个设置为上面列宽度，注意第五个不可设，否则会出现错乱。
				$('.roomUseTableHeadForSXL').width(everyColWidth);
			}else{
				$('.roomUseTableHeadForSXL').width(roomUseTableHeadWidth );
			}

			//将所用教室赋给当前所有教室,只有不是点击查询的时候才赋值
			if(isSearch == 0){
				nowRoomInfo = roomInfo;
			}
			
			//绑定第二部分教室使用情况一览表格中房间号点击效果
			partTwoRoomNameClickFunction();
		};
		
		//第二部分教室使用情况一览表格中房间号点击效果
		var partTwoRoomNameClickFunction = function(){						
			var $tbody = $('#roomUseInfoForSXL');
			$tbody.each(function(){
				$('.roomNamePartTwoForSXL').unbind('click').click(function(){
					//获取班级名称
					var className =$(this).html();
					//定义数组
					var suitArr =[];
					
					//循环再用班级教室，获取该教室课程
					for(var index =0 ;index < schedule.length ; index++){
					//获取房间号
					var roomName = schedule[index]['roomName'];
					//只有当房间号与所选房间号相同时候塞入数组中
					if(roomName == className){
						suitArr.push(schedule[index]);
						}								
					}
					
					//执行教室使用情况预览函数
					partFourFunction(suitArr);
					
				});
			});			
		}
		
		//第二部分 教室课程安排情况监测 渲染
		var partFourFunction = function(scheduleInfo){
			//定义页面显示数组
			var htmlArr = [];
			//循环函数获取页面显示内容
			for(var index =0 ;index < scheduleInfo.length ; index++){
				//获取房间号
				var roomName = scheduleInfo[index]['roomName'];
				//教室人数
				var  stuNum = scheduleInfo[index]['stuNum'];
				//班级名称
				var className = scheduleInfo[index]['className'];
				//课程名称
				var courseName = scheduleInfo[index]['courseName'];
				//日期
				var data = scheduleInfo[index]['nowDay'];
				//时段
				var period = scheduleInfo[index]['period'];
				//教师
				var teacherName = scheduleInfo[index]['teacherName'];
									
				//获取该行显示内容插入页面显示数组					
				var thisRowHtml = '<tr><td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" title="'+roomName+'">'+roomName+'</td><td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" title="'+className+'">'+className+'</td><td>'+data+'</td><td>'+period+'</td><td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" title="'+courseName+'">'+courseName+'</td><td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" title="'+teacherName+'">'+teacherName+'</td></tr>';	
				htmlArr.push(thisRowHtml);
			}
			
			//渲染到页面
			$('#scheduleForSXL').html(htmlArr.join(' '));
			
			//因为数据超过四行会出现下拉轴导致上下部分表格宽不对其，故需再次进行调整
			if(htmlArr.length>4){
				//获取数据表格宽度
				var dataTableWidth = $('#scheduleTableForSXL').width();
				var everyColWidth = (Number(dataTableWidth) / 6)-1;
				//alert(everyColWidth);
				$('.scheduleTableHeadForSXL').width(everyColWidth);
			}else{
				$('.scheduleTableHeadForSXL').width(scheduleTableHeadWidth );
			}
		};
		
		
		
		//绑定事件
		var bindFunction = function(){
			//绑定点击教室总数 数字 事件。
			$('#allNumForSXL').unbind('click').click(function(e){
				//执行教室使用情况预览函数  参数为 所有教室信息
				partTwoFunction(allInfo,0);
				
				//执行教室使用情况预览函数
				partFourFunction(schedule);
				
				//阻止默认和冒泡事件
				e.preventDefault();
				e.stopPropagation();
			});
			
			//绑定点击在用教室 数字 事件。
			$('#useNumForSXL').unbind('click').click(function(e){
				//执行教室使用情况预览函数  参数为 已用教室信息
				partTwoFunction(isInfo,0);
				
				//执行教室使用情况预览函数
				partFourFunction(schedule);
			
				//阻止默认和冒泡事件
				e.preventDefault();
				e.stopPropagation();
			});
			
			//绑定点击空余教室 数字 事件。
			$('#noNumForSXL').unbind('click').click(function(e){
				//执行教室使用情况预览函数  参数为 未用教室信息
				partTwoFunction(noInfo,0);
				
				//执行教室使用情况预览函数
				var sche = [];
				partFourFunction(sche);
			
				//阻止默认和冒泡事件
				e.preventDefault();
				e.stopPropagation();
			});
			
			//绑定点击搜索房间号 检索按钮 事件。
			$('#searchRoomButtonForSXL').unbind('click').click(function(e){
				//获取搜索房间号输入框的内容
				var searchRoomName = $('#searchRoomTextForSXL').val();
				//去除首尾空格
				searchRoomName =$.trim((searchRoomName || "")); 
				
				//定义满足筛选框内容的房间信息
				var suitRoomInfo = [];
				
				//当输入框为空则直接显示当前所以房间，若不是，则根据条件进行筛选显示
				if(searchRoomName == ""){
					suitRoomInfo = nowRoomInfo;
				}else{
					//长度
					var len = nowRoomInfo.length;
					//循环当前房间信息数组
					for(var index =0 ; index < len ; index++){
						//获取房间名
						var roomName = nowRoomInfo[index]['roomName'];
						//判断该房间名是否包含筛选框字符串
						if((roomName.indexOf(searchRoomName))>=0){
							//若包含塞入满足的房间信息中
							suitRoomInfo.push(nowRoomInfo[index]);
						}
					}
				}
			
				//执行教室使用情况预览函数  参数为 筛选后的教室信息
				partTwoFunction(suitRoomInfo,1);
			
				//阻止默认和冒泡事件
				e.preventDefault();
				e.stopPropagation();
			});

		};
		
		
		
		
		//初始化执行函数
		partOneFunction();
		bindFunction();
		$("#allNumForSXL").trigger('click');
		partFourFunction(schedule);
		
	}
	
	
	
	
});
</script>

</html>
