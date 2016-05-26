function chart() {

	var year = $("#year").text();
	var month = $('#month').text();
	chartPxb(year, month);
	chartRs(year, month);
	chartRts(year, month);
	chartGzl(year, month);
}
function chartPxb(year, month) {

	$.post("zhjxjc/chartPxb.do?year=" + year + "&month=" + month, {}, function(
			data) {
		var monthList = new Array();
		var monthValueList = new Array();
		var monthTotalValueList = new Array();
		var yearList = new Array();
		var yearValueList = new Array();
		var yearValueList1 = new Array();
		for ( var i = 0; i < data.monthList.length; i++) {
			monthList[i] = data.monthList[i];
			monthValueList[i] = parseFloat(data.monthValueList[i]);
			monthTotalValueList[i] = parseFloat(data.monthTotalValueList[i]);
		}
		for ( var i = 0; i < data.yearList.length; i++) {
			yearList[i] = data.yearList[i];
			yearValueList[i] = parseFloat(data.yearValueList[i]);
			yearValueList1[i] = data.yearValueList1[i];
		}
		if (monthList.length > 0) {
			var myChart = echarts
					.init(document.getElementById('chartPxbMonth'));
			var option = {
				title : {
					text : '',
					subtext : ''
				},
				tooltip : {
					trigger : 'axis'
				},
				legend : {
					data : [ '本期值', '累计值' ]
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
					data : monthList
				} ],
				yAxis : [ {
					type : 'value'
				} ],
				series : [ {
					name : '本期值',
					type : 'bar',
					data : monthValueList,
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
					name : '累计值',
					type : 'bar',
					data : monthTotalValueList,
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
			myChart.setOption(option);
		}
		if (yearList.length > 0) {
			var myChart = echarts
					.init(document.getElementById('chartPxbTotal'));
			var option = {
				tooltip : {
					trigger : 'axis'
				},
				calculable : true,
				legend : {
					data : [ '培训班数量', '增长率' ]
				},
				xAxis : [ {
					type : 'category',
					data : yearList
				} ],
				yAxis : [ {
					type : 'value',
					name : '培训班数量'
				}, {
					type : 'value',
					name : '增长率',
					axisLabel : {
						formatter : '{value} %'
					}
				} ],
				series : [

				{
					name : '培训班数量',
					type : 'bar',
					data : yearValueList
				}, {
					name : '增长率',
					type : 'line',
					yAxisIndex : 1,
					data : yearValueList1
				} ]
			};
			myChart.setOption(option);
		}
	}, "JSON");

}

function chartRs(year, month) {

	$
			.post(
					"zhjxjc/chartRs.do?year=" + year + "&month=" + month,
					{},
					function(data) {
						var monthList = new Array();
						var monthValueList = new Array();
						var monthTotalValueList = new Array();
						var yearList = new Array();
						var yearValueList = new Array();
						var yearValueList1 = new Array();
						for ( var i = 0; i < data.monthList.length; i++) {
							monthList[i] = data.monthList[i];
							monthValueList[i] = parseFloat(data.monthValueList[i]);
							monthTotalValueList[i] = parseFloat(data.monthTotalValueList[i]);
						}
						for ( var i = 0; i < data.yearList.length; i++) {
							yearList[i] = data.yearList[i];
							yearValueList[i] = parseFloat(data.yearValueList[i]);
							yearValueList1[i] = data.yearValueList1[i];
						}
						if (monthList.length > 0) {
							var myChart = echarts.init(document
									.getElementById('chartRsMonth'));
							var option = {
								title : {
									text : '',
									subtext : ''
								},
								tooltip : {
									trigger : 'axis'
								},
								legend : {
									data : [ '本期值', '累计值' ]
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
									data : monthList
								} ],
								yAxis : [ {
									type : 'value'
								} ],
								series : [ {
									name : '本期值',
									type : 'bar',
									data : monthValueList,
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
									name : '累计值',
									type : 'bar',
									data : monthTotalValueList,
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
							myChart.setOption(option);
						}
						if (yearList.length > 0) {
							var myChart = echarts.init(document
									.getElementById('chartRsTotal'));
							var option = {
								tooltip : {
									trigger : 'axis'
								},
								calculable : true,
								legend : {
									data : [ '培训人数', '增长率' ]
								},
								xAxis : [ {
									type : 'category',
									data : yearList
								} ],
								yAxis : [ {
									type : 'value',
									name : '培训人数'
								}, {
									type : 'value',
									name : '增长率',
									axisLabel : {
										formatter : '{value} %'
									}
								} ],
								series : [

								{
									name : '培训人数',
									type : 'bar',
									data : yearValueList
								}, {
									name : '增长率',
									type : 'line',
									yAxisIndex : 1,
									data : yearValueList1
								} ]
							};
							myChart.setOption(option);
						}
					}, "JSON");
}

function chartRts(year, month) {

	$.post("zhjxjc/chartRts.do?year=" + year + "&month=" + month, {}, function(
			data) {
		var monthList = new Array();
		var monthValueList = new Array();
		var monthTotalValueList = new Array();
		var yearList = new Array();
		var yearValueList = new Array();
		var yearValueList1 = new Array();
		for ( var i = 0; i < data.monthList.length; i++) {
			monthList[i] = data.monthList[i];
			monthValueList[i] = parseFloat(data.monthValueList[i]);
			monthTotalValueList[i] = parseFloat(data.monthTotalValueList[i]);
		}
		for ( var i = 0; i < data.yearList.length; i++) {
			yearList[i] = data.yearList[i];
			yearValueList[i] = parseFloat(data.yearValueList[i]);
			yearValueList1[i] = data.yearValueList1[i];
		}
		if (monthList.length > 0) {
			var myChart = echarts
					.init(document.getElementById('chartRtsMonth'));
			var option = {
				title : {
					text : '',
					subtext : ''
				},
				tooltip : {
					trigger : 'axis'
				},
				legend : {
					data : [ '本期值', '累计值' ]
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
					data : monthList
				} ],
				yAxis : [ {
					type : 'value'
				} ],
				series : [ {
					name : '本期值',
					type : 'bar',
					data : monthValueList,
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
					name : '累计值',
					type : 'bar',
					data : monthTotalValueList,
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
			myChart.setOption(option);
		}
		if (yearList.length > 0) {
			var myChart = echarts
					.init(document.getElementById('chartRtsTotal'));
			var option = {
				tooltip : {
					trigger : 'axis'
				},
				calculable : true,
				legend : {
					data : [ '培训人天数', '增长率' ]
				},
				xAxis : [ {
					type : 'category',
					data : yearList
				} ],
				yAxis : [ {
					type : 'value',
					name : '培训人天数'
				}, {
					type : 'value',
					name : '增长率',
					axisLabel : {
						formatter : '{value} %'
					}
				} ],
				series : [

				{
					name : '培训人天数',
					type : 'bar',
					data : yearValueList
				}, {
					name : '增长率',
					type : 'line',
					yAxisIndex : 1,
					data : yearValueList1
				} ]
			};
			myChart.setOption(option);
		}
	}, "JSON");
}

function chartGzl(year, month) {

	$.post("zhjxjc/chartGzl.do?year=" + year + "&month=" + month, {}, function(
			data) {
		var monthList = new Array();
		var monthValueList = new Array();
		var monthTotalValueList = new Array();
		var yearList = new Array();
		var yearValueList = new Array();
		var yearValueList1 = new Array();
		for ( var i = 0; i < data.monthList.length; i++) {
			monthList[i] = data.monthList[i];
			monthValueList[i] = parseFloat(data.monthValueList[i]);
			monthTotalValueList[i] = parseFloat(data.monthTotalValueList[i]);
		}
		for ( var i = 0; i < data.yearList.length; i++) {
			yearList[i] = data.yearList[i];
			yearValueList[i] = parseFloat(data.yearValueList[i]);
			yearValueList1[i] = data.yearValueList1[i];
		}
		if (monthList.length > 0) {
			var myChart = echarts
					.init(document.getElementById('chartGzlMonth'));
			var option = {
				title : {
					text : '',
					subtext : ''
				},
				tooltip : {
					trigger : 'axis'
				},
				legend : {
					data : [ '本期值', '累计值' ]
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
					data : monthList
				} ],
				yAxis : [ {
					type : 'value'
				} ],
				series : [ {
					name : '本期值',
					type : 'bar',
					data : monthValueList,
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
					name : '累计值',
					type : 'bar',
					data : monthTotalValueList,
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
			myChart.setOption(option);
		}
		if (yearList.length > 0) {
			var myChart = echarts
					.init(document.getElementById('chartGzlTotal'));
			var option = {
				tooltip : {
					trigger : 'axis'
				},
				calculable : true,
				legend : {
					data : [ '工作量', '增长率' ]
				},
				xAxis : [ {
					type : 'category',
					data : yearList
				} ],
				yAxis : [ {
					type : 'value',
					name : '工作量'
				}, {
					type : 'value',
					name : '增长率',
					axisLabel : {
						formatter : '{value} %'
					}
				} ],
				series : [

				{
					name : '工作量',
					type : 'bar',
					data : yearValueList
				}, {
					name : '增长率',
					type : 'line',
					yAxisIndex : 1,
					data : yearValueList1
				} ]
			};
			myChart.setOption(option);
		}
	}, "JSON");
}