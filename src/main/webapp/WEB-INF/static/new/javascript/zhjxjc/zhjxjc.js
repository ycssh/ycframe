function initData()
{
	var year = $("#year").text();
	var month = $("#month").text();
	$.post("zhjxjc/pxb.do?year="+year+"&month="+month,{},function(data){
		$("#ljz").html(data.ljz);
		$("#bqz").html(data.bqz);
		$("#tqz").html(data.tqz);
		$("#tbz").html(data.tbz+"%");
		if(parseFloat(data.ljz) < parseFloat(data.tqz))
		{
			$("#css_tbz").removeClass("icons-raise").addClass("icons-down");
		}
		$("#bq_tbz").html(data.bq_tbz+"%");
		if(parseFloat(data.bqz) < parseFloat(data.bq_tqz))
		{
			$("#css_bq_tbz").removeClass("icons-raise").addClass("icons-down");
		}
		$("#bq_hbz").html(data.bq_hbz+"%");
		if(parseFloat(data.bqz) < parseFloat(data.bq_hqz))
		{
			$("#css_bq_hbz").removeClass("icons-raise").addClass("icons-down");
		}
	},"JSON");
	
	$.post("zhjxjc/rs.do?year="+year+"&month="+month,{},function(data){
		$("#rs_ljz").html(data.rs_ljz);
		$("#rs_bqz").html(data.rs_bqz);
		$("#rs_tqz").html(data.rs_tqz);
		
		$("#rs_tbz").html(data.rs_tbz+"%");
		if(parseFloat(data.rs_ljz) < parseFloat(data.rs_tqz))
		{
			$("#css_rs_tbz").removeClass("icons-raise").addClass("icons-down");
		}
		$("#rs_bq_tbz").html(data.rs_bq_tbz+"%");
		if(parseFloat(data.rs_bqz) < parseFloat(data.rs_bq_tqz))
		{
			$("#css_rs_bq_tbz").removeClass("icons-raise").addClass("icons-down");
		}
		$("#rs_bq_hbz").html(data.rs_bq_hbz+"%");
		if(parseFloat(data.rs_bqz) < parseFloat(data.rs_bq_hqz))
		{
			$("#css_rs_bq_hbz").removeClass("icons-raise").addClass("icons-down");
		}
	},"JSON");
	
	$.post("zhjxjc/rts.do?year="+year+"&month="+month,{},function(data){
		$("#rts_ljz").html(data.rts_ljz);
		$("#rts_bqz").html(data.rts_bqz);
		$("#rts_tqz").html(data.rts_tqz);
		
		$("#rts_tbz").html(data.rts_tbz+"%");
		if(parseFloat(data.rts_ljz) < parseFloat(data.rts_tqz))
		{
			$("#css_rts_tbz").removeClass("icons-raise").addClass("icons-down");
		}
		$("#rts_bq_tbz").html(data.rts_bq_tbz+"%");
		if(parseFloat(data.rts_bqz) < parseFloat(data.rts_bq_tqz))
		{
			$("#css_rts_bq_tbz").removeClass("icons-raise").addClass("icons-down");
		}
		$("#rts_bq_hbz").html(data.rts_bq_hbz+"%");
		if(parseFloat(data.rts_bqz) < parseFloat(data.rts_bq_hqz))
		{
			$("#css_rts_bq_hbz").removeClass("icons-raise").addClass("icons-down");
		}
	},"JSON");
	
	$.post("zhjxjc/gzl.do?year="+year+"&month="+month,{},function(data){
		$("#gzl_ljz").html(data.gzl_ljz);
		$("#gzl_bqz").html(data.gzl_bqz);
		$("#gzl_tqz").html(data.gzl_tqz);
		
		$("#gzl_tbz").html(data.gzl_tbz+"%");
		if(parseFloat(data.gzl_ljz) < parseFloat(data.gzl_tqz))
		{
			$("#css_gzl_tbz").removeClass("icons-raise").addClass("icons-down");
		}
		$("#gzl_bq_tbz").html(data.gzl_bq_tbz+"%");
		if(parseFloat(data.gzl_bqz) < parseFloat(data.gzl_bq_tqz))
		{
			$("#css_gzl_bq_tbz").removeClass("icons-raise").addClass("icons-down");
		}
		$("#gzl_bq_hbz").html(data.gzl_bq_hbz+"%");
		if(parseFloat(data.gzl_bqz) < parseFloat(data.gzl_bq_hqz))
		{
			$("#css_gzl_bq_hbz").removeClass("icons-raise").addClass("icons-down");
		}
	},"JSON");	
}

