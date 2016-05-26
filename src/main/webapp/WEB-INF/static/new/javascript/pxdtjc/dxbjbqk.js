function initDxbjbqk()
{
	var depName = $("#depSelectedName").text();
	$.post('pxdtjc/dxb.do',{depName:depName},function(data){
		$("#jhqs").html(data.jhqsNum);
		$("#wcqs").html(data.wcqsNum);
		$("#rts").html(data.rts);
		$("#wcl").html(data.wcl);
		if(data.jhqsNum ==0)
		{
			$("#wclPic").width(0);
		}else
		{
			$("#wclPic").width((data.wcqsNum/data.jhqsNum)*175);
		}
		$("#jbqs").html(data.byqsNum);
		$("#pxxy").html(data.bypxxyNum);
		$("#ydrts").html(data.ydrts);
		
		$("#xtn_pxqs").html(0);
		$("#xtn_pxrs").html(0);
		$("#xtn_rts").html(0);
		$("#xtw_pxqs").html(0);
		$("#xtw_pxrs").html(0);
		$("#xtw_rts").html(0);
		$("#jhn_pxqs").html(0);
		$("#jhn_pxrs").html(0);
		$("#jhn_rts").html(0);
		$("#lz_pxqs").html(0);
		$("#lz_pxrs").html(0);
		$("#lz_rts").html(0);
		$("#sd_pxqs").html(0);
		$("#sd_pxrs").html(0);
		$("#sd_rts").html(0);
		
		
		for(var i=0;i<data.proInfo.length;i++)
		{
			if(data.proInfo[i].tag == 'A001' && data.proInfo[i].planSource == 'C002'){
				$("#xtn_pxqs").html(data.proInfo[i].pxqs);
				$("#xtn_pxrs").html(data.proInfo[i].pxrs);
				$("#xtn_rts").html(data.proInfo[i].pxrts);
			}else if(data.proInfo[i].tag == 'A009' && data.proInfo[i].planSource == 'C002')
			{
				$("#xtw_pxqs").html(data.proInfo[i].pxqs);
				$("#xtw_pxrs").html(data.proInfo[i].pxrs);
				$("#xtw_rts").html(data.proInfo[i].pxrts);
			}else if(data.proInfo[i].tag == 'A003' && data.proInfo[i].planSource == 'C001')
			{
				$("#jhn_pxqs").html(data.proInfo[i].pxqs);
				$("#jhn_pxrs").html(data.proInfo[i].pxrs);
				$("#jhn_rts").html(data.proInfo[i].pxrts);
			}else if(data.proInfo[i].tag == 'A004' && data.proInfo[i].planSource == 'C001')
			{
				$("#lz_pxqs").html(data.proInfo[i].pxqs);
				$("#lz_pxrs").html(data.proInfo[i].pxrs);
				$("#lz_rts").html(data.proInfo[i].pxrts);
			}else if(data.proInfo[i].tag == 'A002' && data.proInfo[i].planSource == 'C002')
			{
				$("#sd_pxqs").html(data.proInfo[i].pxqs);
				$("#sd_pxrs").html(data.proInfo[i].pxrs);
				$("#sd_rts").html(data.proInfo[i].pxrts);
			}

		}
	},"JSON");
}

