function initXygPxJx()
{
	var depName = $("#depSelectedName").text();
	$.post('pxdtjc/xyg.do',{depName:depName},function(data){
		$("#zys").text(data.majorNum);
		$("#bjs").text(data.bjNum);
		$("#zprs").text(data.perNum);
		$("#ljrts").text(data.rts);
		var proInfo =$('#proInfo');
		proInfo.empty();
		for(var i=0;i<data.xygProInfo.length;i++)
		{
			var tr = $('<tr></tr>');
			tr.append($('<td style="width:20%">'+data.xygProInfo[i].batchYear+'</td>'));
			tr.append($('<td style="width:20%">'+data.xygProInfo[i].campusName+'</td>'));
			tr.append($('<td style="width:20%">'+data.xygProInfo[i].bjs+'</td>'));
			tr.append($('<td style="width:20%">'+data.xygProInfo[i].pxrs+'</td>'));
			tr.append($('<td style="width:20%">'+data.xygProInfo[i].pxrts+'</td>'));
			proInfo.append(tr);
		}
	},"JSON");
}

