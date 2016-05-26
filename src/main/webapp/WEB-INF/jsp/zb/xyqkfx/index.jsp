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

<title>学员情况分析</title>

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


</head>
<body>
    <div class="content">
        <!-- <div class="wrapNav"></div>  -->
		<div class="contentRight" style ="margin-left:0px;">
                <div class="queryDiv">
                    <label for="">项目名称：</label>
                    <div class="selectDiy longestSelectDiv" id="selectDom">
                        <span class="selectCont" id="nowProject"></span>
                        <i class="tag icons-selectTra"></i>
                        <ul id ="projectAll">
                          
                        </ul>
                    </div>
                    <button class="search" id='projectClikc'>检索</button>
                </div>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="moduleDiv moduleDivAuto ">
                            <div class="row rowNoMargin">
                                <div class="col-xs-2 maginTop15">
                                    <div class="tagImg icons-zhuanyeshu"></div>
                                    <p class="tagName">专业数</p>
                                    <p class="tagNum" id = "specNum"></p>
                                </div>
                                <div class="col-xs-2 maginTop15">
                                    <div class="tagImg icons-guanlibanjishu"></div>
                                    <p class="tagName">班级数</p>
                                    <p class="tagNum" id="classNum"></p>
                                </div>
                                <div class="col-xs-2 maginTop15">
                                    <div class="tagImg icons-zaixianrenshu"></div>
                                    <p class="tagName">培训人数</p>
                                    <p class="tagNum" id="signNum"></p>
                                </div>

                                <div class="ChartDivHeight col-xs-12" Id ="chartPart" style="height:450px;">
                                    <p class="line1"></p>
                                    <p class="line2"></p>
                                    <div class="col-xs-4 proportionDiv" id="sexProportion"></div>
                                    <div class="col-xs-4 proportionDiv" id="communistsProportion"></div>
                                    <div class="col-xs-4 proportionDiv" id="deucationalProportion"></div>

                                    <div class="col-xs-6 proportionDiv" id="nationProportion" style="height:250px;"></div>
                                    <div class="col-xs-6 proportionDiv" id="provinceProportion" style="height:250px;"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="moduleDiv moduleDivAuto ">
                            <p class="moduleTitle icons-moduleTitleBg">专业分班情况</p>
                            <div class="row rowNoMargin">
                                <div class="tableDiv nomarginTableDiv col-xs-12">
                                    <table class="thTable">
                                        <thead>
                                            <tr>
                                                <th>专业培训部</th>
                                                <th>专业方向</th>
                                                <th>班级数</th>
                                                <th>总人数</th>
                                            </tr>
                                        </thead>
                                    </table>
                                    <div class="tableBody">
                                        <table>
                                            <thead>
                                                <tr class="thKong">
                                                    <th></th>
                                                    <th></th>
                                                    <th></th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody id = "classInfo">


											
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


<script type="text/javascript">
$(function(){
	//获取筛选框内容
	$.post('xyqkfx/getAllProject')
	.done(function(data){
		//console.log(data);
		//显示下拉框内容
		partHeadFunction(data['project']);
	})
	.fail(function(){alert('获取下拉框数据失败');});
	
	/**
	 * 头部显示相关函数
	 * @param project 新员工项目相关数据
	 * @return
	 */
	var partHeadFunction = function(project){
	
		//定义全局变量
		var nowProjectId ;//当前选择的项目ID
	
		//获取下拉框内容
		var SelectDom = function(){		
			//循环显示下拉框数据
			var selectHtmlArr = [];
			var maxHtmlLength = 0;
			for(var index = 0; index<project.length; index++){
				//下拉框展示内容
				selectHtmlArr.push('<li>'+project[index]['projectName']+'<span class ="nowPorjectid" style="display:none;">'+project[index]['projectId']+'</span></li>');
				
				//用于获取最大下来框子内容长度，从而设置下拉框宽度
				if(maxHtmlLength < project[index]['projectName'].length){
					maxHtmlLength = project[index]['projectName'].length;
				};
			}
			//初次显示在下拉框上的数据
			$('#nowProject').html(selectHtmlArr[0]);
			//记录下当前的项目id
			nowProjectId = project[0]['projectId'];
			//下拉框可选择的数据
			$('#projectAll').html(selectHtmlArr.join('  '));
			
			//根据项目名称，定义下拉框宽带  基数100，没增加5个字，提升38px
			var intLen = (Number(maxHtmlLength)/5).toFixed(0);
			var flLen = (Number(maxHtmlLength)/5).toFixed(1);
			var widthPx = Number(flLen)>Number(intLen ) ? ((Number(intLen)+1)*38)+100 : (Number(intLen)*38)+100 ;
			$('#selectDom').width(widthPx);	
			$('#nowProject').width(widthPx);			
			
			//下拉框效果函数
			selectFunction();
		};
		
		//下拉框实现函数
		var selectFunction = function(){
		//自定义select事件
		var $selectDiy=$('#selectDom');
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
				
				//记录下当前的项目id
				$(this).each(function(){
					nowProjectId = $('.nowPorjectid').html();
					})
				});
			});
		};
		
		var clickFunction = function(){
			$('#projectClikc').unbind('click').click(function(e){
				//获取项目id
				//alert(nowProjectId);
				
				//获取该项目下的页面显示数据
				$.post('xyqkfx/getDataByProjectId',{projectId:nowProjectId})
				.done(function(data){
					//console.log(data);
					bodyFunction(data);
				})
				.fail(function(){alert('获取该项目数据失败');});
			
				//阻止默认和冒泡事件
				e.preventDefault();
				e.stopPropagation();
			});
		};
		
		//初始化执行函数
		SelectDom();
		clickFunction();
		$("#projectClikc").trigger('click');
	}
	
	
	/**
	 * 页面显示函数
	 * @param data 页面相关数据
	 * @return
	 */
	var bodyFunction = function(data){
		//定义全局变量
		var specNum = data['specNum'],//专业数
		    classNum = data['classNum'],//班级数
			signNum =data['signNum'],//培训人数			
			manNum =data['manNum'],//男人数
			womanNum =data['womanNum'],//女人数
			DYnum =data['DYnum'],//中共党员 人数
			YBDYnum =data['YBDYnum'],//中共预备党员 人数
			GQTYnum =data['GQTYnum'],//共青团员 人数
			QZnum =data['QZnum'],//群众 人数
			QTnum =data['QTnum'],//其他 人数
			eduBSnum =data['eduBSnum'],//博士研究生毕业 人数
			eduSSnum =data['eduSSnum'],//硕士研究生毕业 人数
			eduBKnum =data['eduBKnum'],//大学本科毕业 人数
			eduQTnum =data['eduQTnum'],//其他
			nationList =data['nationList'],//民族情况信息
			companyList =data['companyList'],//所属公司情况信息
			signNumList =data['signNumList']//专业班级人数信息
			;
			
		//第一部分数量信息渲染
		var partOneDom = function(){
			//专业数量
			$('#specNum').html(specNum);
			//班级数
			$('#classNum').html(classNum);
			//培训人数
			$('#signNum').html(signNum);			
		};
		
		
		//男女比例
		var chart1Function = function(){		
			var sexProportion = echarts.init(document.getElementById('sexProportion'));
			sexProportion.setOption({
	        title : {text: '男女比例分布',textStyle : {fontSize : '12',fontWeight : 'bold',color:'#2ba196'}},
		  	tooltip : {trigger: 'item',formatter: "{a} <br/>{b} : {c} ({d}%)"},
			legend: {orient : 'vertical',x : 'right',data:['男','女']},
			toolbox: {
					show : false,
					feature : {
						mark : {show: true},
						dataView : {show: true, readOnly: false},
						magicType : {show: true, type: ['pie', 'funnel'],option: {funnel: {x: '25%',width: '50%',funnelAlign: 'center',max: 1548}}},
						restore : {show: true},
						saveAsImage : {show: true}
					}
			},
			calculable : true,
			series : [
				{
					name:'详细：',
					type:'pie',
					radius : ['50%', '70%'],
					itemStyle : {
						normal : {label : {show : false},labelLine : {show : false}},
						emphasis : {label : {show : true,position : 'center',textStyle : {fontSize : '12',fontWeight : 'bold'}}}
					},
					data:[
						{value:manNum, name:'男'},
						{value:womanNum, name:'女'}
					]
				}
			]
			}); 
		};
		
		
		//党团员比例
		var chert2Function = function(){
			var communistsProportion = echarts.init(document.getElementById('communistsProportion'));
			communistsProportion.setOption({
			title : {text: '政治面貌分布',textStyle : {fontSize : '12',fontWeight : 'bold',color:'#2ba196'}},
			tooltip : {trigger: 'item',formatter: "{a} <br/>{b} : {c} ({d}%)"},
			legend: {orient : 'vertical',x : 'right',data:['中共党员','中共预备党员','共青团员','群众','其他']},
			toolbox: {
				show : false,
				feature : {
					mark : {show: true},
					dataView : {show: true, readOnly: false},
					magicType : {show: true, type: ['pie', 'funnel'],option: {funnel: {x: '25%',width: '50%',funnelAlign: 'center',max: 1548}}},
					restore : {show: true},
					saveAsImage : {show: true}
				}
			},
			calculable : true,
			series : [
				{
					name:'详细：',
					type:'pie',
					radius : ['50%', '70%'],
					itemStyle : {
						normal : {label : {show : false},labelLine : {show : false}},
						emphasis : {label : {show : true,position : 'center',textStyle : {fontSize : '12',fontWeight : 'bold'}}}
					},
					data:[
						{value:DYnum, name:'中共党员'},
						{value:YBDYnum, name:'中共预备党员'},
						{value:GQTYnum, name:'共青团员'},
						{value:QZnum, name:'群众'},
						{value:QTnum, name:'其他'}
					]
				}
			]
			});
		};

		
		//学历情况比例
		var chart3Function = function(){
			var deucationalProportion = echarts.init(document.getElementById('deucationalProportion'));
			deucationalProportion.setOption({
				title : {text: '学历水平分布',textStyle : {fontSize : '12',fontWeight : 'bold',color:'#2ba196'}},
				tooltip : {trigger: 'item',formatter: "{a} <br/>{b} : {c} ({d}%)"},
				legend: {orient : 'vertical',x : 'right',data:['博士研究生毕业','硕士研究生毕业','大学本科毕业','其他']},
				toolbox: {
					show : false,
					feature : {
						mark : {show: true},
						dataView : {show: true, readOnly: false},
						magicType : {show: true, type: ['pie', 'funnel'],option: {funnel: {x: '25%',width: '50%',funnelAlign: 'center',max: 1548}}},
						restore : {show: true},
						saveAsImage : {show: true}
					}
				},
				calculable : true,
				series : [
					{
						name:'详细：',
						type:'pie',
						radius : ['50%', '70%'],
						itemStyle : {
							normal : {label : {show : false},labelLine : {show : false}},
							emphasis : {label : {show : true,position : 'center',textStyle : {fontSize : '12',fontWeight : 'bold'}}}
						},
						data:[
							{value:eduBSnum, name:'博士研究生毕业'},
							{value:eduSSnum, name:'硕士研究生毕业'},
							{value:eduBKnum, name:'大学本科毕业'},
							{value:eduQTnum, name:'其他'}
						]
					}
				]
			});
		};
		
		
		//名族分布情况
		var chart4Function = function(){
			//数据筛选
			var nameArr = [];
			var valueArr = [];
			if(nationList.length>0){
				for(var index =0 ;index < nationList.length ; index++){
					nameArr.push(nationList[index]['name']);
					var thisValue = Number(nationList[index]['countNum']);
					valueArr.push(thisValue);
				}
			}else{
				nameArr.push(0);
				valueArr.push(0);
			}
		
			//绘制图表
			var nationProportion=echarts.init(document.getElementById('nationProportion'));
			nationProportion.setOption({
				title : {text: '学员名族分布',textStyle : {fontSize : '12',fontWeight : 'bold',color:'#2ba196'}},
				tooltip : {trigger: 'axis'},
				toolbox: {
					show : false,
					feature : {
					mark : {show: true},
					dataView : {show: true, readOnly: false},
					magicType : {show: true, type: ['line', 'bar']},
					restore : {show: true},
					saveAsImage : {show: true}}
				},
				calculable : true,
				xAxis : [
						{
							type : 'category',
							data : nameArr,
							axisLabel : {show:true,interval: 'auto',rotate: -45}
						}
					],
				yAxis : [{type : 'value'}],
				series : [
							{
								name:'人数',
								type:'bar',
								data:valueArr
							}
						]
			});
		};
		
		
		
		//学员网省分布
		var chart5Function = function(){
			//数据筛选
			var nameArr = [];
			var valueArr = [];
			if(companyList.length>0){
				for(var index =0 ;index < companyList.length ; index++){
					nameArr.push(companyList[index]['name']);
					var thisValue = Number(companyList[index]['countNum']);
					valueArr.push(thisValue);
				}
			}else{
				nameArr.push(0);
				valueArr.push(0);
			}
		
			//绘制图表
			var nationProportion=echarts.init(document.getElementById('provinceProportion'));
			nationProportion.setOption({
				title : {text: '学员网省分布',textStyle : {fontSize : '12',fontWeight : 'bold',color:'#2ba196'}},
				tooltip : {trigger: 'axis'},
				toolbox: {
					show : false,
					feature : {
					mark : {show: true},
					dataView : {show: true, readOnly: false},
					magicType : {show: true, type: ['line', 'bar']},
					restore : {show: true},
					saveAsImage : {show: true}}
				},
				calculable : true,
 			    dataZoom : {
			        show : true,
			        realtime : true,
			        y: 36,
			        height: 15,
			        start : 0,
			        end : 20
			    }, 
				xAxis : [
						{
							type : 'category',
							data : nameArr,
							axisLabel : {show:true,interval: 'auto',rotate: -15}
						}
					],
				yAxis : [{type : 'value'}],
				series : [
							{
								name:'人数',
								type:'bar',
								data:valueArr
							}
						]
			});
		};
		
		
		//专业分班情况 表格 绘制
		var partTwoDom = function(){
			//console.log(signNumList);
			//表格显示内容
			var htmlArr = [];
			
			//用于区别部门是否改变
			var nowDeptId = "yangjian";
			for(var index = 0; index<signNumList.length; index++){
				//部门下专业数量
				var thisDeptSpecNum = signNumList[index]['thisDeptSpecNum'];
				//部门名称
				var thisDeptName = signNumList[index]['deptName'];
				//专业名称
				var thisSpecName = signNumList[index]['specName'];
				//班级数量
				var thisClassNum = signNumList[index]['classNum'];
				//专业总人数
				var thisSignNum = signNumList[index]['signNum'];
			
			
				//判断专业是否改变
				if(nowDeptId!=signNumList[index]['deptId']){
					//用于判断专业是否改变
					nowDeptId = signNumList[index]['deptId'];						
					//该专业的第一个数据					
					htmlArr.push('<tr><td rowspan="'+thisDeptSpecNum+'">'+thisDeptName+'</td><td>'+thisSpecName+'</td><td>'+thisClassNum+'</td><td>'+thisSignNum+'</td></tr>');
				}else{
					htmlArr.push('<tr><td>'+thisSpecName+'</td><td>'+thisClassNum+'</td><td>'+thisSignNum+'</td></tr>');
				}
			}
			
			$('#classInfo').html(htmlArr.join('   '));
		};
				
		
		//初始化执行函数
		partOneDom();
		chart1Function();
		chert2Function();
		chart3Function();
		chart4Function();
		chart5Function();
		partTwoDom();
	}; 
	
});

</script>

</html>
