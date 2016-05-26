function initPj()
{
	var depName = $("#depSelectedName").text();
	$.post('pxdtjc/pj.do',{depName:depName},function(data){
		$("#cpbjs").html(data.cpbjs);
		$("#cpztmyl").html(data.cpztmyl);
	},"JSON");
}

