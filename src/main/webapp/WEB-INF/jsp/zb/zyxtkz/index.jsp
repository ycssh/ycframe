<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String version="1.3.5";
String contextPath = request.getContextPath();
%>
<html>
<head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" /> 
	
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="easyui">
<meta http-equiv="description" content="easyui">

<link rel="stylesheet" type="text/css" href="<%=basePath%>static/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>static/easyui/themes/icon.css">

<script type="text/javascript" src="<%=basePath%>static/js/jquery-1.11.0.min.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=basePath%>static/easyui/jquery.easyui.min.js" charset="utf-8"></script>

<script type="text/javascript" src="<%=basePath%>static/js/system.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=basePath%>static/easyui/easyui-lang-zh_CN.js" charset="utf-8"></script>

<script src="<%=basePath %>static/new/javascript/echarts-all.js" charset="UTF-8" type="text/javascript"></script>
		
		
	<script type="text/javascript">
	/*====================初始化执行函数=============================*/
	$(function(){
		var height = document.documentElement.clientHeight;
		$("#chart").css("height",height*0.4-20);
		$("#zyxtkz_top").css("height",height*0.6);
		//执行表格和图表函数
		tableFunction();
	});
	
	
	/*=======================表格及图标执行函数=============================*/
	/**
	 * 表格及图标执行函数
	 * @return
	 */
	var tableFunction = function(){
	
		//初始化表格筛选框数据
		var partHead = function(){
			//获取当前年月
			var nowDate = new Date();
			//年
			var nowYear = nowDate.getFullYear();
			//月
			var nowMonth = nowDate.getMonth()+1;
			
			//赋值到年 输入框
			/* $('#year').val(nowYear);
			$('#month').val(nowMonth); */
			$('#year').numberspinner("setValue",nowYear);
			$('#month').numberspinner("setValue",nowMonth);
		};
		
		
		//表格查询函数（带筛选条件的）
		var tableLoad = function(){
			//判断年份和月份输入是否正确
			var a = yearAndMonthIsRight();
			if(!a){
				alert("请输入年份、月份和培训地点")
				return;
			}
			//获取年份
			//var year = Number($('#year').val());
			//获取月份
			//var month = Number($('#month').val());
			

			var year = $('#year').numberspinner("getValue");
			var month = $('#month').numberspinner("getValue");
			//获取培训地点
			var place = $('#place').combobox('getValue');
			
			//获取该年月天数
			var monthString = month<10 ? '0'+month : month;
			var d = new Date(year, monthString, 0);  
			var daysCount = Number(d.getDate());  
			
			//查询该条件下的数据
			 /* $('#dg').datagrid('load',{
				year: year,
				month: month,
				daysCount: daysCount,
				place: place
			});  */
			$("#dg").datagrid({
				pagination:false,
				singleSelect:true,
				url:'<%=basePath%>zyxtkz/getPageData',
				method:'post',
				toolbar:'#tb',
				height:(document.documentElement.clientHeight-68)*0.6,
			    queryParams:{
					year: year,
					month: month,
					daysCount: daysCount,
					place: place
			    },
			    fitColumns : false,
			    columns:[[
			  	        {field:'projectName',width:300,formatter: function(value,row,index){return '<span title='+value+'>'+value+'</span>'},title:'专业培训部'},
			  	        {field:'getToTime',width:150,align:'center',title:'报到时间'},
			  	        {field:'dayNum',width:30,align:'center',title:'天数'},
					  	   {field:'data_01',align:'center',title:'1  日 ',width:30 } ,
					  	   {field:'data_02',align:'center',title:'2  日 ',width:30 } ,
					  	   {field:'data_03',align:'center',title:'3  日 ',width:30 } ,
					  	   {field:'data_04',align:'center',title:'4  日 ',width:30 } ,
					  	   {field:'data_05',align:'center',title:'5  日 ',width:30 } ,
					  	   {field:'data_06',align:'center',title:'6  日 ',width:30 } ,
					  	   {field:'data_07',align:'center',title:'7  日 ',width:30 } ,
					  	   {field:'data_08',align:'center',title:'8  日 ',width:30 } ,
					  	   {field:'data_09',align:'center',title:'9  日 ',width:30 } ,
					  	   {field:'data_10',align:'center',title:'10日 ',width:30 } ,
					  	   {field:'data_11',align:'center',title:'11日 ',width:30 } ,
					  	   {field:'data_12',align:'center',title:'12日 ',width:30 } ,
					  	   {field:'data_13',align:'center',title:'13日 ',width:30 } ,
					  	   {field:'data_14',align:'center',title:'14日 ',width:30 } ,
					  	   {field:'data_15',align:'center',title:'15日 ',width:30 } ,
					  	   {field:'data_16',align:'center',title:'16日 ',width:30 } ,
					  	   {field:'data_17',align:'center',title:'17日 ',width:30 } ,
					  	   {field:'data_18',align:'center',title:'18日 ',width:30 } ,
					  	   {field:'data_19',align:'center',title:'19日 ',width:30 } ,
					  	   {field:'data_20',align:'center',title:'20日 ',width:30 } ,
					  	   {field:'data_21',align:'center',title:'21日 ',width:30 } ,
					  	   {field:'data_22',align:'center',title:'22日 ',width:30 } ,
					  	   {field:'data_23',align:'center',title:'23日 ',width:30 } ,
					  	   {field:'data_24',align:'center',title:'24日 ',width:30 } ,
					  	   {field:'data_25',align:'center',title:'25日 ',width:30 } ,
					  	   {field:'data_26',align:'center',title:'26日 ',width:30 } ,
					  	   {field:'data_27',align:'center',title:'27日 ',width:30 } ,
					  	   {field:'data_28',align:'center',title:'28日 ',width:30 } ,
					  	   {field:'data_29',align:'center',title:'29日 ',width:30 } ,
					  	   {field:'data_30',align:'center',title:'30日 ',width:30 } ,
					  	   {field:'data_31',align:'center',title:'31日 ' ,width:30 } ,
			  	    ]],
			})
			
			
			//初始化都显示			
			$('#dg').datagrid('showColumn','data_29');
			$('#dg').datagrid('showColumn','data_30');
			$('#dg').datagrid('showColumn','data_31');
			
			//根据天数隐藏列
			if(daysCount==28){
				$('#dg').datagrid('hideColumn','data_29');
				$('#dg').datagrid('hideColumn','data_30');
				$('#dg').datagrid('hideColumn','data_31');
			}else if(daysCount==29){
				$('#dg').datagrid('hideColumn','data_30');
				$('#dg').datagrid('hideColumn','data_31');
			}else if(daysCount==30){
				$('#dg').datagrid('hideColumn','data_31');
			}  
			
		};
		
		//图表执行函数
		var chartFunction = function(){
			//判断年份和月份输入是否正确
			//yearAndMonthIsRight();
			var a = yearAndMonthIsRight();
			if(!a)
				return;
			//获取年份
			/* var year = Number($('#year').val());
			//获取月份
			var month = Number($('#month').val()); */

			var year = $('#year').numberspinner("getValue");
			var month = $('#month').numberspinner("getValue");
			//获取培训地点
			var place = $('#place').combobox('getValue');
			
			//获取该年月天数
			var monthString = month<10 ? '0'+month : month;
			var d = new Date(year, monthString, 0);  
			var daysCount = Number(d.getDate()); 
			
			//获取数据（easyUI,回调函数不好用故重复执行函数）
			$.get('getPageData',{ year: year, month: month,daysCount: daysCount,place: place })
				.done(function(data){					
					//获取最后一条合计数据
					var lastData = data[data.length-1];
					
					//筛选数据，满足echart需要
					//定义横坐标数据数组
					var Xname = [];
					//定义预警线数据
					var YJXvalue = [];
					//定义高警线数据
					var GJXvalue = [];
					//定义合计数据数组
					var HJvalue = [];
					
					for(var index = 1; index <= daysCount ; index++){
						//横坐标数据名称
						Xname.push(index + '日');
						//预警线数据
						YJXvalue.push('400');
						//高警线数据
						GJXvalue.push('450');
						//合计
						var indexString = index<10? '0'+index : index;
						HJvalue.push(lastData['data_'+indexString]);
					}
					
					//执行echart绘制函数
					echartFunction(Xname,YJXvalue,GJXvalue,HJvalue);
					
				})
				.fail(function(){alert('获取图表数据失败');});
			
		};
		
		//绘制图表的echart，折线面积图
		var echartFunction = function(Xname,YJXvalue,GJXvalue,HJvalue){
			var chart=echarts.init(document.getElementById('chart'));
			chart.setOption({
				tooltip : {trigger: 'axis'},
				color:['blue','yellow','red'],
				legend: {data:['合计'],y: 'bottom',show:false},
				yAxis : [{type : 'value'}],
				xAxis : [
					{
						type : 'category',
						boundaryGap : false,
						data : Xname
					}
				],
				series : [
					{
						name:'合计',
						type:'line',
						smooth:true,
						itemStyle: {normal: {areaStyle: {type: 'default'}}},
						data:HJvalue
					},
					{
						name:'预警',
						type:'line',
						data:YJXvalue
					},
					{
						name:'告警',
						type:'line',
						data:GJXvalue
					}
				]
			});
			
			
		};
		
		//判断输入年份和月份是否正确
		var yearAndMonthIsRight = function(){

			var year = $('#year').numberspinner("getValue");
			var month = $('#month').numberspinner("getValue");
			//获取培训地点
			var place = $('#place').combobox('getValue');
			if(year==""||month==""||place==""){
				return false;
			}
			return true;
		}; 
		
		//绑定点击事件
		var bindFunction = function(){
			//查询按钮
			$('#searchButton').unbind('click').click(function(){
				//表格函数
				tableLoad();
				//图表函数
				chartFunction();
			});
		};
		
		
		//初始化执行函数
		partHead();
		bindFunction();
	    $('#searchButton').trigger("click");
	};
		
	
	
	
</script>

</head>
<body>
<div id="zyxtkz_top">
	
	<div id="tb" style="padding:5px;">
		<div>
			<span>年份:</span>
			<input id="year" class="easyui-numberspinner" 
         data-options="min:2009,max:2100" style="line-height:17px;width:100px;border:1px solid #ccc">
			<span>月份:</span>
			<input id="month" class="easyui-numberspinner" 
         data-options="min:1,max:12" style="line-height:17px;width:100px;border:1px solid #ccc">
			培训地点: 
			<select id ="place" class="easyui-combobox" panelHeight="auto" style="width:100px">
				<option value="D001">济南校区</option>
				<option value="D002,D003">泰山校区</option>
			</select>
			
			<a id ="searchButton" href="javaScript:void(0);" class="easyui-linkbutton" iconCls="icon-search">查询</a>
			<!--<a href="javaScript:void(0);" class="easyui-linkbutton" iconCls="icon-reload">重置</a>-->
			
		</div>
	</div>

	<table id="dg">
	</table>
	
	
</div>

<div id = "chart">
</div>

</body>
</html>