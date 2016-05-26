/**
 * 初始执行函数
 */
$(function(){	 	
	/*================================初始化点击触发事件==============================================*/
	 	//绑定年份点击事件
	 	$('#indexYearSearch').unbind('click').click(function(e){
	 		//获取年份
	 		var selectYear = $('#indexSelectYear').html();
	 		
	 		//获取各个地点点击数据
	 		$.post('../indexPage/chinaMapData?year='+selectYear)
	 			.done(function(data){
	 				//console.log(data);
	 				
	 				//拼接地图需要的数据
	 				var cityDetails =[];
	 				//地图点击数据
	 				var placeData = data['PlaceData'];
	 				//循环数据
	 				for(var index = 0 ; index < placeData.length ;index++){
	 					//出发点
	 					var name = '济南';
	 					//终点
	 					var mudidi =  placeData[index]['placeName'];
	 					//培训类型
	 					var typeP = ['新员工','短期班'];
	 					//培训期数
	 					var timeP = [placeData[index]['newProNum'].toString(),placeData[index]['shortProNum'].toString()];
	 					//班级数
	 					var grade = [placeData[index]['newProClassNum'].toString(),placeData[index]['shortProClassNum'].toString()];
	 					//培训人数
	 					var peopleNum = [placeData[index]['newProSignNum'].toString(),placeData[index]['shortProSignNum'].toString()];
	 					//人天数
	 					var peopleDate =[placeData[index]['newProDayNum'].toString(),placeData[index]['shortProDayNum'].toString()];
	 					//开班数
	 					var openClass = placeData[index]['nowClassNum'].toString();
	 					//在陪人数
	 					var peopleNow = placeData[index]['nowSignNum'].toString();
	 					//年度累计人天数
	 					var peopleTotalYear = ( Number(placeData[index]['newProDayNum']) + Number(placeData[index]['shortProDayNum']) ).toString();
	 					
	 					//塞入到数组中
	 					var dataArr =new Object();
 						dataArr['name'] = name;//出发点
 						dataArr['mudidi'] =mudidi;//终点
 						dataArr['typeP'] = typeP;//培训类型
 						dataArr['timeP'] = timeP;//培训期数
 						dataArr['grade'] = grade;//班级数
 						dataArr['peopleNum'] = peopleNum;//培训人数	 						
 						dataArr['peopleDate'] = peopleDate;//人天数
 						dataArr['openClass'] = openClass;//开班数
 						dataArr['peopleNow'] = peopleNow;//在陪人数
 						dataArr['peopleTotalYear'] = peopleTotalYear;//年度累计人天数
 						cityDetails.push(dataArr);
	 				}
	 				
	 				//显示初次提示框
	                var res='';
	                for (var i = 0; i<cityDetails.length; i++) {
                        if (cityDetails[i].mudidi == '济南') {
                        	res='<dl class="mapDl hasBoderBottom"><dt>'+ cityDetails[i].mudidi+'<br/>年度完成情况</dt>';
                            res+='<dd><p class="mapTdTitle">培训类型：</p><span class="mapTdCont">'+cityDetails[i].typeP[0]+'</span><span class="mapTdCont">'+cityDetails[i].typeP[1]+'</span></dd><dd><p class="mapTdTitle">培训期数：</p><span class="mapTdCont">'+cityDetails[i].timeP[0]+'</span><span class="mapTdCont">'+cityDetails[i].timeP[1]+'</span></dd><dd><p class="mapTdTitle">班级数：</p><span class="mapTdCont">'+cityDetails[i].grade[0]+'</span><span class="mapTdCont">'+cityDetails[i].grade[1]+'</span></dd><dd><p class="mapTdTitle">培训人数：</p><span class="mapTdCont">'+cityDetails[i].peopleNum[0]+'</span><span class="mapTdCont">'+cityDetails[i].peopleNum[1]+'</span></dd><dd class="noBorderBottom"><p class="mapTdTitle">人天数：</p><span class="mapTdCont">'+cityDetails[i].peopleDate[0]+'</span><span class="mapTdCont">'+cityDetails[i].peopleDate[1]+'</span></dd></dl>';
                            res+='<dl class="mapDl"><dt>实时情况</dt><dd><p class="mapTdTitleLong">开班数：</p><span class="mapTdContLong">'+cityDetails[i].openClass+'</span></dd><dd><p class="mapTdTitleLong">在培人数：</p><span class="mapTdContLong">'+cityDetails[i].peopleNow+'</span></dd><dd class="noBorderBottom"><p class="mapTdTitleLong">年度累计人天数：</p><span class="mapTdContLong">'+cityDetails[i].peopleTotalYear+'</span></dd></dl>';
                        }
	                }
	                $('#fistAlterBox').html(res);
	            	$('#fistAlterBox').show();
	 				
	 				
	 			    //执行 地图绘制函数，包括地点点击效果 函数
	 			    echartFunction(cityDetails);
	 			})
	 			.fail(function(){});
	 		
	 		//阻止默认事件
	 	    e.preventDefault();
	 	    e.stopPropagation();
	 	});
	 	
	 	
	 	//下拉框年份函数
	 	yearDropFunction();
	    //初始默认执行点击查询时间
	 	$('#indexYearSearch').trigger('click');
	    //执行 指标导航 点击 显示隐藏切换 函数
	    showHidenMenu();  
	    //执行 绑定 右上角 菜单链接 函数
	    bindMenuClick();
});
/*================================下拉框年份==============================================*/
var yearDropFunction = function(){
	//获取当前年份
	var myDate = new Date();
	var nowYear = myDate.getFullYear();
	
	//获取年份数组
	var yearStringHtml = '';
	for(var year = nowYear;year>=2013;year--){
		yearStringHtml = yearStringHtml + '<li>'+year+'</li>';
	}
	
	//下拉框初始值设置
	$('#indexSelectYear').html(nowYear);
	//下拉框选项
	$('#yearSelect').html(yearStringHtml);
	
	//下拉框实现函数
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
		});
	});
};


/*================================右上角菜单相关函数==============================================*/
/**
 * 绑定 右上角 菜单链接
 */
var bindMenuClick = function(){
	
	//运营状况
	$('#yunyingzhuangkuang').unbind('click').click(function(){	
		//点击全面监测 
		 $(parent.document).find(".firstNode").first().click();
		 
		//关闭相关标签栏
		close();
		//展开    培训运营状况监测
		 $(parent.document).find('#left_menu_t_469').trigger('click');
		//短期班运营状况监测
		 $(parent.document).find('#thirdNode485').trigger('click');
	});	
	//指标大盘
	$('#zhibiaodapan').unbind('click').click(function(){	
		//点击全面监测 
		 $(parent.document).find(".firstNode").first().click();
		//关闭相关标签栏
		close();
		//展开    指标大盘监测
		 $(parent.document).find('#left_menu_t_430').trigger('click');
		//指标大盘监测
		 $(parent.document).find('#thirdNode431').trigger('click');
	});	
	//培训动态
	$('#peixundongtai').unbind('click').click(function(){
		//点击全面监测 
		 $(parent.document).find(".firstNode").first().click();
		//关闭相关标签栏
		close();
		//展开    培训动态监测
		 $(parent.document).find('#left_menu_t_440').trigger('click');
		//培训动态监测
		 $(parent.document).find('#thirdNode441').trigger('click');
	});	
	//业务发展
	$('#yewufazhang').unbind('click').click(function(){
		//点击全面监测 
		 $(parent.document).find(".firstNode").first().click();
		//关闭相关标签栏
		close();
		//展开    综合绩效监测
		 $(parent.document).find('#left_menu_t_450').trigger('click');
		//综合绩效监测
		 $(parent.document).find('#thirdNode451').trigger('click');
	});	
	//培训质量
	$('#peiyunzhiliang').unbind('click').click(function(){	
		//点击全面监测 
		 $(parent.document).find(".firstNode").first().click();
		//关闭相关标签栏
		close();
		//展开    短期班测评结果监测
		 $(parent.document).find('#left_menu_t_475').trigger('click');
		//短期班测评结果监测
		 $(parent.document).find('#thirdNode500').trigger('click');
	});
	//教学实时
	$('#jiaoxueshishi').unbind('click').click(function(){	
		//点击全面监测 
		 $(parent.document).find(".firstNode").first().click();
		//关闭相关标签栏
		close();
		//展开    教学实时监测
		 $(parent.document).find('#left_menu_t_442').trigger('click');
		//教学实时监测
		 $(parent.document).find('#thirdNode443').trigger('click');
	});
	//资源协调
	$('#ziyuanxietiao').unbind('click').click(function(){
		//点击全面监测 
		 $(parent.document).find(".firstNode").first().click();
		//关闭相关标签栏
		close();
		//展开    资源协调控制
		 $(parent.document).find('#left_menu_t_445').trigger('click');
		//资源协调控制
		 $(parent.document).find('#thirdNode446').trigger('click');
	});
	//流程监测
	$('#liuchengjiance').unbind('click').click(function(){
		//点击全面监测 
		 $(parent.document).find(".firstNode").first().click();
		//关闭相关标签栏
		close();
		//展开    计划编制流程监测
		 $(parent.document).find('#left_menu_t_766').trigger('click');
		//计划编制流程监测
		 $(parent.document).find('#thirdNode767').trigger('click');
	});
	
	//关闭展开的标签
	var close = function(){
		//关闭 培训运营状况监测
	     if(!$(parent.document).find('#thirdNode485').is(':hidden')){
	    	 $(parent.document).find('#left_menu_t_469').trigger('click');
	     }
	   //关闭  指标大盘监测
	     if(!$(parent.document).find('#thirdNode431').is(':hidden')){
	    	 $(parent.document).find('#left_menu_t_430').trigger('click');
	     }
	   //关闭 培训动态监测
	     if(!$(parent.document).find('#thirdNode441').is(':hidden')){
	    	 $(parent.document).find('#left_menu_t_440').trigger('click');
	     }
	   //关闭 综合绩效监测
	     if(!$(parent.document).find('#thirdNode451').is(':hidden')){
	    	 $(parent.document).find('#left_menu_t_450').trigger('click');
	     }
	   //关闭 测评结果监测
	     if(!$(parent.document).find('#thirdNode500').is(':hidden')){
	    	 $(parent.document).find('#left_menu_t_475').trigger('click');
	     }
	   //关闭 教学实时监测
	     if(!$(parent.document).find('#thirdNode443').is(':hidden')){
	    	 $(parent.document).find('#left_menu_t_442').trigger('click');
	     }
	   //关闭 培资源协调控制
	     if(!$(parent.document).find('#thirdNode446').is(':hidden')){
	    	 $(parent.document).find('#left_menu_t_445').trigger('click');
	     }
	   //关闭 计划编制流程监测
	     if(!$(parent.document).find('#thirdNode767').is(':hidden')){
	    	 $(parent.document).find('#left_menu_t_766').trigger('click');
	     }
	};

};

/**
 * 指标导航 点击 显示隐藏切换
 */
 var showHidenMenu = function(){
	//导航栏点击显示隐藏切换
	   var cricleDds = $('#circleNav').find('dd');
	   $('#menuIsShow').click(function() {
		   
		 //判断是否隐藏，改变div大小方便点击 
	     if(cricleDds.is(':hidden')){//隐藏
	    	 $('#circleNav').css({'width':'360px','height':'360px'});    	 
	     }else{//显示
	    	 $('#circleNav').css({'width':'100px','height':'100px'});
	     }
		 
	     //隐藏线索切换
		 cricleDds.toggle();
	   });
 };


 /*================================地图绘制及点击效果函数==============================================*/
/**
 * 地图绘制函数，包括地点点击效果
 */
var echartFunction = function(cityDetails){
	
 	//绘制地图函数
    var myChart2 = echarts.init(document.getElementById('mainMap'));
    myChart2.setOption({
        backgroundColor: '#fff',
        color: ['gold', 'aqua', 'lime'],
        tooltip: {
            trigger: 'item',
            position: [100, 50],
            backgroundColor: 'rgba(255,255,255,1)',
            borderColor: '#2ba196',
            borderRadius: 14,
            borderWidth: 2,
            z:20,
            padding: [10, 28, 10, 28],
            textStyle: {color: '#2ba196', fontSize: 12,fontStyle: 'normal',fontFamily: 'Arial, Verdana, sans-serif'},
            formatter: function(v) {
            	//隐藏初次显示提示框
            	$('#fistAlterBox').hide();
            	
                // var res = v.seriesName;
                var res;
                for (var i = 0, l = cityDetails.length; i < l; i++) {
                    if (cityDetails[i].name == v.seriesName) {
                        if (cityDetails[i].mudidi == v.data.name) {
                           /* res = cityDetails[i].mudidi + '<br/>';
                            res += "培训类型：" + cityDetails[i].typeP + '<br/> 培训期数：' + cityDetails[i].timeP + '<br/> 班级数：' + cityDetails[i].grade + '<br/>培训人数：' + cityDetails[i].peopleNum + '<br/>人天数：' + cityDetails[i].peopleDate;*/
                            

                        	res='<dl class="mapDl hasBoderBottom"><dt>'+ cityDetails[i].mudidi+'<br/>年度完成情况</dt>';
                            
                        	
                        	res+='<dd><p class="mapTdTitle">培训类型：</p><span class="mapTdCont">'+cityDetails[i].typeP[0]+'</span><span class="mapTdCont">'+cityDetails[i].typeP[1]+'</span></dd><dd><p class="mapTdTitle">培训期数：</p><span class="mapTdCont">'+cityDetails[i].timeP[0]+'</span><span class="mapTdCont">'+cityDetails[i].timeP[1]+'</span></dd><dd><p class="mapTdTitle">班级数：</p><span class="mapTdCont">'+cityDetails[i].grade[0]+'</span><span class="mapTdCont">'+cityDetails[i].grade[1]+'</span></dd><dd><p class="mapTdTitle">培训人数：</p><span class="mapTdCont">'+cityDetails[i].peopleNum[0]+'</span><span class="mapTdCont">'+cityDetails[i].peopleNum[1]+'</span></dd><dd class="noBorderBottom"><p class="mapTdTitle">人天数：</p><span class="mapTdCont">'+cityDetails[i].peopleDate[0]+'</span><span class="mapTdCont">'+cityDetails[i].peopleDate[1]+'</span></dd></dl>';
                            res+='<dl class="mapDl"><dt>实时情况</dt><dd><p class="mapTdTitleLong">开班数：</p><span class="mapTdContLong">'+cityDetails[i].openClass+'</span></dd><dd><p class="mapTdTitleLong">在培人数：</p><span class="mapTdContLong">'+cityDetails[i].peopleNow+'</span></dd><dd class="noBorderBottom"><p class="mapTdTitleLong">年度累计人天数：</p><span class="mapTdContLong">'+cityDetails[i].peopleTotalYear+'</span></dd></dl>';
                        }

                    }
                }
                return res;
            }
        },
        /*legend: { orient: 'vertical',x: 'left', data: ['济南'],selectedMode: 'single',selected: {},textStyle: { color: '#2ba196'}},*/
        dataRange: { min: 0, max: 100,show:false,calculable: true,color: ['#ff3333', 'orange', 'yellow', 'lime', 'aqua'],textStyle: { color: '#fff'}},
        series: [{
            name: '全国',
            type: 'map',
            roam: false,
            hoverable: false,
            mapType: 'china',
            itemStyle: {normal: {borderColor: 'rgba(100,149,237,1)',borderWidth: 0.8,areaStyle: {color: '#f6f4f0'}}},
            tooltip : {trigger: 'axis',backgroundColor: 'black', position : [0, 0],formatter: "Series formatter: <br/>{a}<br/>{b}:{c}"},
            data: [],
            markLine: { smooth: true,symbol: ['none', 'circle'],symbolSize: 1,itemStyle: {normal: {color: '#fff',borderWidth: 1, borderColor: 'rgba(30,144,255,0.5)'}},data: [],},
            geoCoord: {
                '上海': [121.4648, 31.2891],
                '东莞': [113.8953, 22.901],
                '东营': [118.7073, 37.5513],
                '中山': [113.4229, 22.478],
                '临汾': [111.4783, 36.1615],
                '临沂': [118.3118, 35.2936],
                '丹东': [124.541, 40.4242],
                '丽水': [119.5642, 28.1854],
                '乌鲁木齐': [87.9236, 43.5883],
                '佛山': [112.8955, 23.1097],
                '保定': [115.0488, 39.0948],
                '兰州': [103.5901, 36.3043],
                '包头': [110.3467, 41.4899],
                '北京': [116.4551, 40.2539],
                '北海': [109.314, 21.6211],
                '南京': [118.8062, 31.9208],
                '南宁': [108.479, 23.1152],
                '南昌': [116.0046, 28.6633],
                '南通': [121.1023, 32.1625],
                '厦门': [118.1689, 24.6478],
                '台州': [121.1353, 28.6688],
                '合肥': [117.29, 32.0581],
                '呼和浩特': [111.4124, 40.4901],
                '咸阳': [108.4131, 34.8706],
                '哈尔滨': [127.9688, 45.368],
                '唐山': [118.4766, 39.6826],
                '嘉兴': [120.9155, 30.6354],
                '大同': [113.7854, 39.8035],
                '大连': [122.2229, 39.4409],
                '天津': [117.4219, 39.4189],
                '太原': [112.3352, 37.9413],
                '威海': [121.9482, 37.1393],
                '宁波': [121.5967, 29.6466],
                '宝鸡': [107.1826, 34.3433],
                '宿迁': [118.5535, 33.7775],
                '常州': [119.4543, 31.5582],
                '广州': [113.5107, 23.2196],
                '廊坊': [116.521, 39.0509],
                '延安': [109.1052, 36.4252],
                '张家口': [115.1477, 40.8527],
                '徐州': [117.5208, 34.3268],
                '德州': [116.6858, 37.2107],
                '惠州': [114.6204, 23.1647],
                '成都': [103.9526, 30.7617],
                '扬州': [119.4653, 32.8162],
                '承德': [117.5757, 41.4075],
                '拉萨': [91.1865, 30.1465],
                '无锡': [120.3442, 31.5527],
                '日照': [119.2786, 35.5023],
                '昆明': [102.9199, 25.4663],
                '杭州': [119.5313, 29.8773],
                '枣庄': [117.323, 34.8926],
                '柳州': [109.3799, 24.9774],
                '株洲': [113.5327, 27.0319],
                '武汉': [114.3896, 30.6628],
                '汕头': [117.1692, 23.3405],
                '江门': [112.6318, 22.1484],
                '沈阳': [123.1238, 42.1216],
                '沧州': [116.8286, 38.2104],
                '河源': [114.917, 23.9722],
                '泉州': [118.3228, 25.1147],
                '泰山': [117.0264, 36.0516],
                '泰州': [120.0586, 32.5525],
                '济南': [117.1582, 36.8701],
                //'济南': [50.1582, 36.8701],
                '济宁': [116.8286, 35.3375],
                '海口': [110.3893, 19.8516],
                '淄博': [118.0371, 36.6064],
                '淮安': [118.927, 33.4039],
                '深圳': [114.5435, 22.5439],
                '清远': [112.9175, 24.3292],
                '温州': [120.498, 27.8119],
                '渭南': [109.7864, 35.0299],
                '湖州': [119.8608, 30.7782],
                '湘潭': [112.5439, 27.7075],
                '滨州': [117.8174, 37.4963],
                '潍坊': [119.0918, 36.524],
                '烟台': [120.7397, 37.5128],
                '玉溪': [101.9312, 23.8898],
                '珠海': [113.7305, 22.1155],
                '盐城': [120.2234, 33.5577],
                '盘锦': [121.9482, 41.0449],
                '石家庄': [114.4995, 38.1006],
                '福州': [119.4543, 25.9222],
                '秦皇岛': [119.2126, 40.0232],
                '绍兴': [120.564, 29.7565],
                '聊城': [115.9167, 36.4032],
                '肇庆': [112.1265, 23.5822],
                '舟山': [122.2559, 30.2234],
                '苏州': [120.6519, 31.3989],
                '莱芜': [117.6526, 36.2714],
                '菏泽': [115.6201, 35.2057],
                '营口': [122.4316, 40.4297],
                '葫芦岛': [120.1575, 40.578],
                '衡水': [115.8838, 37.7161],
                '衢州': [118.6853, 28.8666],
                '西宁': [101.4038, 36.8207],
                '西安': [109.1162, 34.2004],
                '贵阳': [106.6992, 26.7682],
                '连云港': [119.1248, 34.552],
                '邢台': [114.8071, 37.2821],
                '邯郸': [114.4775, 36.535],
                '郑州': [113.4668, 34.6234],
                '鄂尔多斯': [108.9734, 39.2487],
                '重庆': [107.7539, 30.1904],
                '金华': [120.0037, 29.1028],
                '铜川': [109.0393, 35.1947],
                '银川': [106.3586, 38.1775],
                '镇江': [119.4763, 31.9702],
                '长春': [125.8154, 44.2584],
                '长沙': [113.0823, 28.2568],
                '长治': [112.8625, 36.4746],
                '阳泉': [113.4778, 38.0951],
                '青岛': [120.4651, 36.3373],
                '韶关': [113.7964, 24.7028]
            }
        }, {
            name: '济南',
            type: 'map',
            mapType: 'china',
            selectedMode : '',//把selectedMode的值multiple设为空就去掉了点击省份选中的情况
            data: [],
            markLine: {
                smooth: true,
                effect: {show: true,scaleSize: 1,period: 3,color: '#fff',shadowBlur: 10},
                itemStyle: {normal: { borderWidth:1,lineStyle: {type: 'solid', shadowBlur: 2} } },
                data: [ [{name: '济南'}, {name: '济南'}],
	                    [{ name: '济南'}, {name: '泰山'}],
	                    [{ name: '济南'}, {name: '成都'}],
	                    [{ name: '济南'}, {name: '长春'}],
	                    [{name: '济南'}, {name: '西安'}],
	                    [{ name: '济南'}, {name: '苏州'}] ]
            },
            markPoint: {
                symbol: 'emptyCircle',
                symbolSize: function(v) {return 10 + v / 10},
                effect: {show: true,shadowBlur: 0},
                itemStyle: {normal: {label: {show: false}},
                emphasis: {label: {position: 'top'}}},
                data: [{name:'济南'},{name:'泰山'},{ name:'长春'},{name:'西安'},
                       {name:'苏州'},{name:'成都'}]
            }
        }]
    });
    
};



/*================================地图假数据格式==============================================*/

//地图坐标点 点击显示数据示例
/*var cityDetails = [{
       name: '济南',
       mudidi: '济南',
       typeP: ['新员工','短期班'],
       timeP: ['2','94'],
       grade: ['75','94'],
       peopleNum: ['3638','7604'],
       peopleDate: ['392220','37927'],
       openClass:'0',
       peopleNow:'0',
       peopleTotalYear:'17680'
   },{
       name: '济南',
       mudidi: '泰山',
       typeP: ['新员工','短期班'],
       timeP: ['2','63'],
       grade: ['40','63'],
       peopleNum: ['1984','3481'],
       peopleDate: ['144712','23518'],
       openClass:'0',
       peopleNow:'0',
       peopleTotalYear:'17680'
   }, {
       name: '济南',
       mudidi: '成都',
       typeP: ['新员工','短期班'],
       timeP: ['1','10'],
       grade: ['8','10'],
       peopleNum: ['422','725'],
       peopleDate: ['48108','3945'],
       openClass:'0',
       peopleNow:'0',
       peopleTotalYear:'17680'
   }, {
       name: '济南',
       mudidi: '长春',
       typeP: ['新员工','短期班'],
       timeP: ['1','10'],
       grade: ['9','10'],
       peopleNum: ['499','471'],
       peopleDate: ['51186','2355'],
       openClass:'0',
       peopleNow:'0',
       peopleTotalYear:'17680'
   }, {
       name: '济南',
       mudidi: '西安',
       typeP: ['新员工','短期班'],
       timeP: ['1','6'],
       grade: ['12','6'],
       peopleNum: ['622','461'],
       peopleDate: ['70908','2305'],
       openClass:'0',
       peopleNow:'0',
       peopleTotalYear:'17680'
   }, {
       name: '济南',
       mudidi: '苏州',
       typeP: ['新员工','短期班'],
       timeP: ['1','10'],
       grade: ['4','10'],
       peopleNum: ['132','502'],
       peopleDate: ['15048','2632'],
       openClass:'0',
       peopleNow:'0',
       peopleTotalYear:'17680'
   }];*/


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            