$(function(){
	
	initGZLdata();
});

function initGZLdata(){
	
	$.post("index/findGZL",{},function(data){
		
		 $('#deptgzlImage').highcharts({
		        chart: {
		            type: 'column'
		        },
		        title: {
		            text: '工作量统计'
		        },
		        xAxis: {
		            categories: data.depts
		        },
		        yAxis: {
		            min: 0,
		            title: {
		                text: '工作量'
		            }
		        },
		        tooltip: {
		            shared: true,
		            useHTML: true
		        },
		        plotOptions: {
		            column: {
		                pointPadding: 0.2,
		                borderWidth: 0
		            }
		        },
		        series: [{
		            name: '新员工',
		            data: data.xList

		        }, {
		            name: '短训班',
		            data: data.dList

		        }, {
		            name: '团青',
		            data: data.tList

		        }]
		    });
		 
		 $('#gzlfbImage').highcharts({
		        chart: {
		            plotBackgroundColor: null,
		            plotBorderWidth: null,
		            plotShadow: false
		        },
		        title: {
		            text: '工作量分布'
		        },
		        tooltip: {
		    	    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
		        },
		        plotOptions: {
		            pie: {
		                allowPointSelect: true,
		                cursor: 'pointer',
		                dataLabels: {
		                    enabled: true,
		                    color: 'rgb(192,192,171)',
		                    connectorColor: '#000000',
		                    format: '<b>{point.name}</b>: {point.percentage:.1f} %'
		                }
		            }
		        },
		        series: [{
		            type: 'pie',
		            name: '工作量',
		            data: data.fbList
		        }]
		    });
		
	},"JSON")
}