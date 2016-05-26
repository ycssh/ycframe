$(function(){
	
	initRTSdata();
});

function initRTSdata(){
	
	$.post("index/findRTS",{},function(data){
		
		$('#allNumImage').highcharts({
			
		    chart: {
		        type: 'gauge',
		        plotBackgroundColor: null,
		        plotBackgroundImage: null,
		        plotBorderWidth: 0,
		        plotShadow: false
		    },
		    
		    title: {
		        text: '总人天数'
		    },
		    
		    pane: {
		        startAngle: -100,
		        endAngle: 100,
		        background: [{
		            backgroundColor: {
		                linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 },
		                stops: [
		                    [0, '#FFF'],
		                    [1, '#333']
		                ]
		            },
		            borderWidth: 0,
		            outerRadius: '109%'
		        }, {
		            backgroundColor: {
		                linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 },
		                stops: [
		                    [0, '#333'],
		                    [1, '#FFF']
		                ]
		            },
		            borderWidth: 1,
		            outerRadius: '107%'
		        }, {
		            // default background
		        }, {
		            backgroundColor: '#DDD',
		            borderWidth: 0,
		            outerRadius: '105%',
		            innerRadius: '103%'
		        }]
		    },
		       
		    // the value axis
		    yAxis: {
		        min: 0,
		        max: 1800000,
		        
		        minorTickInterval: 'auto',
		        minorTickWidth: 1,
		        minorTickLength: 10,
		        minorTickPosition: 'inside',
		        minorTickColor: '#666',
		
		        tickPixelInterval: 30,
		        tickWidth: 2,
		        tickPosition: 'inside',
		        tickLength: 10,
		        tickColor: '#666',
		        labels: {
		            step: 2,
		            rotation: 'auto'
		        },
		        title: {
		            text: '总人天数'
		        },
		        plotBands: [{
		            from: 0,
		            to: 1200000,
		            color: '#55BF3B' // green
		        }, {
		            from: 1200000,
		            to: 1600000,
		            color: '#DDDF0D' // yellow
		        }, {
		            from: 1600000,
		            to: 1800000,
		            color: '#DF5353' // red
		        }]        
		    },
		
		    series: [{
		        name: '人天数',
		        data: [data.allNum],
		        tooltip: {
		            valueSuffix: ' '
		        }
		    }]
		
		});
		
		$('#detailNumImage').highcharts({
	        title: {
	            text: '人天数月度累计值',
	            x: -10 //center
	        },
	        xAxis: {
	            categories: data.monthList
	        },
	        yAxis: {
	            title: {
	                text: ' '
	            },
	            plotLines: [{
	                value: 0,
	                width: 1,
	                color: '#808080'
	            }]
	        },
	        tooltip: {
	            valueSuffix: ''
	        },
	        legend: {
//	            layout: 'vertical',
	            align: 'bottom',
	            verticalAlign: 'bottom',
	            borderWidth: 0
	        },
	        series: [{
	            name: '新员工',
	            data: data.rtsMap.t1
	        }, {
	            name: '短训班',
	            data: data.rtsMap.t2
	        }, {
	            name: '团青',
	            data: data.rtsMap.t3
	        }]
	    });
		
	},"JSON")
}