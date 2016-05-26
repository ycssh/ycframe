function initGzl()
{
	var depName = $("#depSelectedName").text();
	$.post('pxdtjc/gzl.do',{depName:depName},function(data){
		$("#ljgzlNum").html(data.ljgzlNum);
		$("#curMonthNum").html(data.curMonthNum);
		$("#preMonthNum").html(data.preMonthNum);
	},"JSON");
}

