function chartXyg() {
	var majorList = new Array();
	var majorValueList1 = new Array();
	var majorValueList2 = new Array();
	var depName = $("#depSelectedName").text();
	var projectName = $('#projectSelectedName').text();
	var myChart = echarts.init(document.getElementById('chartstudy'));
	var option = {
		title : {
			text : '',
			subtext : ''
		},
		tooltip : {
			trigger : 'axis'
		},
		legend : {
			data : [ '院本部', '泰山校区' ]
		},
		toolbox : {
			show : false,
			feature : {
				mark : {
					show : true
				},
				dataView : {
					show : true,
					readOnly : false
				},
				magicType : {
					show : true,
					type : [ 'line', 'bar' ]
				},
				restore : {
					show : true
				},
				saveAsImage : {
					show : true
				}
			}
		},
		calculable : true,
		xAxis : [ {
			type : 'category',
			data : majorList
		} ],
		yAxis : [ {
			type : 'value'
		} ],
		series : [ {
			name : '院本部',
			type : 'bar',
			data : majorValueList1,
			markPoint : {
				data : [ {
					type : 'max',
					name : '最大值'
				}, {
					type : 'min',
					name : '最小值'
				} ]
			}
		}, {
			name : '泰山校区',
			type : 'bar',
			data : majorValueList2,
			markPoint : {
				data : [ {
					type : 'max',
					name : '最大值'
				}, {
					type : 'min',
					name : '最小值'
				} ]
			}
		} ]
	};	
	$.post('pxdtjc/chartXyg.do', {depName:depName,projectName:projectName}, function(data) {
		for ( var i = 0; i < data.majorList.length; i++) {
			majorList[i] = data.majorList[i].majorName;
			majorValueList1[i] = parseFloat(data.majorValueList1[i].majorValue);
			majorValueList2[i] = parseFloat(data.majorValueList2[i].majorValue);
		}
		if (majorList.length > 0) {
			myChart.setOption(option);
		}
	}, "JSON");

}

function chartGzl() {

	var gzlList = new Array();
	var gzlList1 = new Array();
	var gzlList2 = new Array();
	var courseGzlList = new Array();
	var courseGzlList1 = new Array();
	var courseGzlList2 = new Array();
	var depName = $("#depSelectedName").text();
	// 培训师类型统计图
	var teacherTypeChart = echarts.init(document
			.getElementById('teacherTypeChart'));
	var optionTea = {
		tooltip : {
			trigger : 'axis',
			axisPointer : { // 坐标轴指示器，坐标轴触发有效
				type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
			}
		},
		legend : {
			data : [ '兼职培训师', '专职培训师', '合计' ]
		},
		toolbox : {
			show : false,
			orient : 'vertical',
			x : 'right',
			y : 'center',
			feature : {
				mark : {
					show : true
				},
				dataView : {
					show : true,
					readOnly : false
				},
				magicType : {
					show : true,
					type : [ 'line', 'bar', 'stack', 'tiled' ]
				},
				restore : {
					show : true
				},
				saveAsImage : {
					show : true
				}
			}
		},
		calculable : true,
		xAxis : [ {
			type : 'category',
			data : [ '新员工', '短期班', '合计' ]
		} ],
		yAxis : [ {
			type : 'value'
		} ],
		series : [ {
			name : '兼职培训师',
			type : 'bar',
			data : gzlList1
		}, {
			name : '专职培训师',
			type : 'bar',
			data : gzlList2
		}, {
			name : '合计',
			type : 'bar',
			data : gzlList
		} ]
	};
	
	// 课程类型统计图
	var courseTypeChart = echarts.init(document
			.getElementById('courseTypeChart'));
	var optionCou = {
		tooltip : {
			trigger : 'axis',
			axisPointer : { // 坐标轴指示器，坐标轴触发有效
				type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
			}
		},
		legend : {
			data : [ '理论教学', '实训教学', '合计' ]
		},
		toolbox : {
			show : false,
			orient : 'vertical',
			x : 'right',
			y : 'center',
			feature : {
				mark : {
					show : true
				},
				dataView : {
					show : true,
					readOnly : false
				},
				magicType : {
					show : true,
					type : [ 'line', 'bar', 'stack', 'tiled' ]
				},
				restore : {
					show : true
				},
				saveAsImage : {
					show : true
				}
			}
		},
		calculable : true,
		xAxis : [ {
			type : 'category',
			data : [ '新员工', '短期班', '合计' ]
		} ],
		yAxis : [ {
			type : 'value'
		} ],
		series : [ {
			name : '理论教学',
			type : 'bar',
			data : courseGzlList1
		}, {
			name : '实训教学',
			type : 'bar',
			data : courseGzlList2
		}, {
			name : '合计',
			type : 'bar',
			data : courseGzlList
		} ]
	};
		
	$.post('pxdtjc/chartGzl.do', {depName:depName}, function(data) {
		for ( var i = 0; i < data.gzlList1.length; i++) {
			gzlList1[i] = data.gzlList1[i].value;
			gzlList2[i] = data.gzlList2[i].value;
			gzlList[i] = (parseFloat(gzlList1[i]) + parseFloat(gzlList2[i])).toFixed(2);
		}
		for ( var i = 0; i < data.courseGzlList.length; i++) {
			courseGzlList[i] = data.courseGzlList[i].hj;
			courseGzlList1[i] = data.courseGzlList[i].llnum;
			courseGzlList2[i] = data.courseGzlList[i].sxnum;
		}
		if (gzlList1.length > 0) {
			teacherTypeChart.setOption(optionTea);
		}		
		if (courseGzlList.length > 0) {
			courseTypeChart.setOption(optionCou);
		}	
	}, "JSON");


}

function chartPj() {
	var depName = $("#depSelectedName").text();
	$.post('pxdtjc/chartPj.do', {depName:depName}, function(data) {
		var zlmyl = data.zlmyl;
		var jxfwmyl = data.jxfwmyl;
		var s_zlmyl = data.s_zlmyl;
		var s_jxfwmyl = data.s_jxfwmyl;
		var xygBjs = data.xygBjs;
		var dxbBjs = data.dxbBjs;
		var ztmyl = data.ztmyl;
		// 短期班培训质量满意度
		var shortqulityGauge = echarts.init(document
				.getElementById('shortqulityGauge'));
		var shortqulityGaugeOption = {
			tooltip : {
				formatter : "{a} <br/>{b} : {c}%"
			},
			toolbox : {
				show : false,
				feature : {
					mark : {
						show : true
					},
					restore : {
						show : true
					},
					saveAsImage : {
						show : true
					}
				}
			},
			series : [ {
				name : '',
				type : 'gauge',
				splitNumber : 1, // 分割段数，默认为5
				center : [ '50%', '70%' ],
				radius : 50,
				startAngle : 180,
				endAngle : 0,
				axisLine : { // 坐标轴线
					lineStyle : { // 属性lineStyle控制线条样式
						color : [ [ 0.2, '#228b22' ], [ 0.8, '#2ba196' ],
								[ 1, '#2ba196' ] ],
						width : 5
					}
				},
				axisTick : { // 坐标轴小标记
					splitNumber : 2, // 每份split细分多少段
					length : 12, // 属性length控制线长
					lineStyle : { // 属性lineStyle控制线条样式
						color : 'auto'
					}
				},
				axisLabel : { // 坐标轴文本标签，详见axis.axisLabel
					textStyle : { // 其余属性默认使用全局文本样式，详见TEXTSTYLE
						color : 'auto'
					}
				},
				splitLine : { // 分隔线
					show : true, // 默认显示，属性show控制显示与否
					length : 10, // 属性length控制线长
					lineStyle : { // 属性lineStyle（详见lineStyle）控制线条样式
						color : 'auto'
					}
				},
				pointer : {
					width : 2
				},
				title : {
					show : true,
					offsetCenter : [ 0, '25%' ], // x, y，单位px
					textStyle : { // 其余属性默认使用全局文本样式，详见TEXTSTYLE
						// fontWeight: 'bolder'
						fontSize : 12
					}
				},
				detail : {
					offsetCenter : [ 0, -40 ],
					formatter : '{value}%',
					textStyle : { // 其余属性默认使用全局文本样式，详见TEXTSTYLE
						color : 'auto',
						fontWeight : 'bolder',
						fontSize : 16
					}
				},
				data : [ {
					value : s_zlmyl,
					name : '培训质量满意率'
				} ]
			} ]
		};


		// 短期班教学服务满意度
		var shortserviceGauge = echarts.init(document
				.getElementById('shortserviceGauge'));
		var shortserviceGaugeOption = {
			tooltip : {
				formatter : "{a} <br/>{b} : {c}%"
			},
			toolbox : {
				show : false,
				feature : {
					mark : {
						show : true
					},
					restore : {
						show : true
					},
					saveAsImage : {
						show : true
					}
				}
			},
			series : [ {
				name : '',
				type : 'gauge',
				splitNumber : 1, // 分割段数，默认为5
				center : [ '50%', '70%' ],
				radius : 50,
				startAngle : 180,
				endAngle : 0,
				axisLine : { // 坐标轴线
					lineStyle : { // 属性lineStyle控制线条样式
						color : [ [ 0.2, '#228b22' ], [ 0.8, '#2ba196' ],
								[ 1, '#2ba196' ] ],
						width : 5
					}
				},
				axisTick : { // 坐标轴小标记
					splitNumber : 2, // 每份split细分多少段
					length : 12, // 属性length控制线长
					lineStyle : { // 属性lineStyle控制线条样式
						color : 'auto'
					}
				},
				axisLabel : { // 坐标轴文本标签，详见axis.axisLabel
					textStyle : { // 其余属性默认使用全局文本样式，详见TEXTSTYLE
						color : 'auto'
					}
				},
				splitLine : { // 分隔线
					show : true, // 默认显示，属性show控制显示与否
					length : 10, // 属性length控制线长
					lineStyle : { // 属性lineStyle（详见lineStyle）控制线条样式
						color : 'auto'
					}
				},
				pointer : {
					width : 2
				},
				title : {
					show : true,
					offsetCenter : [ 0, '25%' ], // x, y，单位px
					textStyle : { // 其余属性默认使用全局文本样式，详见TEXTSTYLE
						// fontWeight: 'bolder'
						fontSize : 12
					}
				},
				detail : {
					offsetCenter : [ 0, -40 ],
					formatter : '{value}%',
					textStyle : { // 其余属性默认使用全局文本样式，详见TEXTSTYLE
						color : 'auto',
						fontWeight : 'bolder',
						fontSize : 16
					}
				},
				data : [ {
					value : s_jxfwmyl,
					name : '教学服务满意率'
				} ]
			} ]
		};
		
		// 新员工培训质量满意度
		var newqulityGauge = echarts
				.init(document.getElementById('newqulityGauge'));
		var newqulityGaugeOption = {
			tooltip : {
				formatter : "{a} <br/>{b} : {c}%"
			},
			toolbox : {
				show : false,
				feature : {
					mark : {
						show : true
					},
					restore : {
						show : true
					},
					saveAsImage : {
						show : true
					}
				}
			},
			series : [ {
				name : '',
				type : 'gauge',
				splitNumber : 1, // 分割段数，默认为5
				center : [ '50%', '70%' ],
				radius : 50,
				startAngle : 180,
				endAngle : 0,
				axisLine : { // 坐标轴线
					lineStyle : { // 属性lineStyle控制线条样式
						color : [ [ 0.2, '#228b22' ], [ 0.8, '#2ba196' ],
								[ 1, '#2ba196' ] ],
						width : 5
					}
				},
				axisTick : { // 坐标轴小标记
					splitNumber : 2, // 每份split细分多少段
					length : 12, // 属性length控制线长
					lineStyle : { // 属性lineStyle控制线条样式
						color : 'auto'
					}
				},
				axisLabel : { // 坐标轴文本标签，详见axis.axisLabel
					textStyle : { // 其余属性默认使用全局文本样式，详见TEXTSTYLE
						color : 'auto'
					}
				},
				splitLine : { // 分隔线
					show : true, // 默认显示，属性show控制显示与否
					length : 10, // 属性length控制线长
					lineStyle : { // 属性lineStyle（详见lineStyle）控制线条样式
						color : 'auto'
					}
				},
				pointer : {
					width : 2
				},
				title : {
					show : true,
					offsetCenter : [ 0, '25%' ], // x, y，单位px
					textStyle : { // 其余属性默认使用全局文本样式，详见TEXTSTYLE
						// fontWeight: 'bolder'
						fontSize : 12
					}
				},
				detail : {
					offsetCenter : [ 0, -40 ],
					formatter : '{value}%',
					textStyle : { // 其余属性默认使用全局文本样式，详见TEXTSTYLE
						color : 'auto',
						fontWeight : 'bolder',
						fontSize : 16
					}
				},
				data : [ {
					value : zlmyl,
					name : '培训质量满意率'
				} ]
			} ]
		};

		// 新员工服务满意度
		var newserviceGauge = echarts.init(document
				.getElementById('newserviceGauge'));
		var newserviceGaugeOption = {
			tooltip : {
				formatter : "{a} <br/>{b} : {c}%"
			},
			toolbox : {
				show : false,
				feature : {
					mark : {
						show : true
					},
					restore : {
						show : true
					},
					saveAsImage : {
						show : true
					}
				}
			},
			series : [ {
				name : '',
				type : 'gauge',
				splitNumber : 1, // 分割段数，默认为5
				center : [ '50%', '70%' ],
				radius : 50,
				startAngle : 180,
				endAngle : 0,
				axisLine : { // 坐标轴线
					lineStyle : { // 属性lineStyle控制线条样式
						color : [ [ 0.2, '#228b22' ], [ 0.8, '#2ba196' ],
								[ 1, '#2ba196' ] ],
						width : 5
					}
				},
				axisTick : { // 坐标轴小标记
					splitNumber : 2, // 每份split细分多少段
					length : 12, // 属性length控制线长
					lineStyle : { // 属性lineStyle控制线条样式
						color : 'auto'
					}
				},
				axisLabel : { // 坐标轴文本标签，详见axis.axisLabel
					textStyle : { // 其余属性默认使用全局文本样式，详见TEXTSTYLE
						color : 'auto'
					}
				},
				splitLine : { // 分隔线
					show : true, // 默认显示，属性show控制显示与否
					length : 10, // 属性length控制线长
					lineStyle : { // 属性lineStyle（详见lineStyle）控制线条样式
						color : 'auto'
					}
				},
				pointer : {
					width : 2
				},
				title : {
					show : true,
					offsetCenter : [ 0, '25%' ], // x, y，单位px
					textStyle : { // 其余属性默认使用全局文本样式，详见TEXTSTYLE
						// fontWeight: 'bolder'
						fontSize : 12
					}
				},
				detail : {
					offsetCenter : [ 0, -40 ],
					formatter : '{value}%',
					textStyle : { // 其余属性默认使用全局文本样式，详见TEXTSTYLE
						color : 'auto',
						fontWeight : 'bolder',
						fontSize : 16
					}
				},
				data : [ {
					value : jxfwmyl,
					name : '教学服务满意率'
				} ]
			} ]
		};


		// 年度评测情况：班级数
		var yearPieRose = echarts.init(document.getElementById('yearPieRose'));
		var yearPieRoseOption = {
			title : {
				text : '',
				subtext : '',
				x : 'center'
			},
			tooltip : {
				trigger : 'item',
				formatter : "{a} <br/>{b} : {c} ({d}%)"
			},
			legend : {
				x : 'left',
				y : 'bottom',
				data : [ '', '' ]
			},
			toolbox : {
				show : false,
				feature : {
					mark : {
						show : true
					},
					dataView : {
						show : true,
						readOnly : false
					},
					magicType : {
						show : true,
						type : [ 'pie', 'funnel' ]
					},
					restore : {
						show : true
					},
					saveAsImage : {
						show : true
					}
				}
			},
			calculable : true,
			series : [ {
				name : '年度测评班级情况',
				type : 'pie',
				radius : [ 20, 75 ],
				center : [ '50%', 105 ],
				roseType : 'radius',
				width : '20%', // for funnel
				max : 40, // for funnel
				itemStyle : {
					normal : {
						label : {
							show : false
						},
						labelLine : {
							show : false
						}
					},
					emphasis : {
						label : {
							show : true
						},
						labelLine : {
							show : true
						}
					}
				},
				data : [ {
					value : xygBjs,
					name : '新员工'
				}, {
					value : dxbBjs,
					name : '短训班'
				} ]
			} ]
		};

		
		// 总评价满意率
		var totalPieRose = echarts.init(document.getElementById('totalPieRose'));
		var totalPieRoseOption = {
			tooltip : {
				formatter : "{a} <br/>{b} : {c}%"
			},
			series : [ {
				name : '总体评价满意率',
				type : 'gauge',
				center : [ '50%', 105 ],
				splitNumber : 10, // 分割段数，默认为5
				axisLine : { // 坐标轴线
					lineStyle : { // 属性lineStyle控制线条样式
						color : [ [ 0.2, '#228b22' ], [ 0.8, '#48b' ],
								[ 1, '#ff4500' ] ],
						width : 8
					}
				},
				axisTick : { // 坐标轴小标记
					splitNumber : 10, // 每份split细分多少段
					length : 12, // 属性length控制线长
					lineStyle : { // 属性lineStyle控制线条样式
						color : 'auto'
					}
				},
				axisLabel : { // 坐标轴文本标签，详见axis.axisLabel
					textStyle : { // 其余属性默认使用全局文本样式，详见TEXTSTYLE
						color : 'auto'
					}
				},
				splitLine : { // 分隔线
					show : true, // 默认显示，属性show控制显示与否
					length : 30, // 属性length控制线长
					lineStyle : { // 属性lineStyle（详见lineStyle）控制线条样式
						color : 'auto'
					}
				},
				pointer : {
					width : 5
				},
				title : {
					show : true,
					offsetCenter : [ 0, '-40%' ], // x, y，单位px
					textStyle : { // 其余属性默认使用全局文本样式，详见TEXTSTYLE
						fontWeight : 'bolder'
					}
				},
				detail : {
					formatter : '{value}%',
					textStyle : { // 其余属性默认使用全局文本样式，详见TEXTSTYLE
						color : 'auto',
						fontWeight : 'bolder',
						fontSize : 20
					}
				},
				data : [ {
					value : ztmyl,
					name : ''
				} ]
			} ]
		};		
		shortqulityGauge.setOption(shortqulityGaugeOption);
		shortserviceGauge.setOption(shortserviceGaugeOption);
		newqulityGauge.setOption(newqulityGaugeOption);
		newserviceGauge.setOption(newserviceGaugeOption);
		yearPieRose.setOption(yearPieRoseOption);
		totalPieRose.setOption(totalPieRoseOption);
	}, "JSON");
}