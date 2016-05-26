function initData()
{
	var year = $("#year").text();
	var month = $("#month").text();
	var deptName = $("#depSelectedName").text();
	$.post(encodeURI("zbdpjc/pxb.do?year="+year+"&month="+month+"&deptName="+deptName),{},function(data){
		$("#bqz").html(data.bqz);
		$("#tqz").html(data.tqz);
		$("#tbz").html(data.tbz+"%");
		$("#hbz").html(data.hbz+"%");
		$("#lj_bqz").html(data.lj_bqz);
		$("#lj_tqz").html(data.lj_tqz);
		$("#lj_tbz").html(data.lj_tbz+"%");
		
		$("#gw_bqz").html(data.gw_bqz);
		$("#gw_tqz").html(data.gw_tqz);
		$("#gw_tbz").html(data.gw_tbz+"%");
		$("#gw_hbz").html(data.gw_hbz+"%");
		$("#gw_lj_bqz").html(data.gw_lj_bqz);
		$("#gw_lj_tqz").html(data.gw_lj_tqz);
		$("#gw_lj_tbz").html(data.gw_lj_tbz+"%");
		
		$("#wt_bqz").html(data.wt_bqz);
		$("#wt_tqz").html(data.wt_tqz);
		$("#wt_tbz").html(data.wt_tbz+"%");
		$("#wt_hbz").html(data.wt_hbz+"%");
		$("#wt_lj_bqz").html(data.wt_lj_bqz);
		$("#wt_lj_tqz").html(data.wt_lj_tqz);
		$("#wt_lj_tbz").html(data.wt_lj_tbz+"%");
		
		$("#xtn_bqz").html(data.xtn_bqz);
		$("#xtn_tqz").html(data.xtn_tqz);
		$("#xtn_tbz").html(data.xtn_tbz+"%");
		$("#xtn_hbz").html(data.xtn_hbz+"%");
		$("#xtn_lj_bqz").html(data.xtn_lj_bqz);
		$("#xtn_lj_tqz").html(data.xtn_lj_tqz);
		$("#xtn_lj_tbz").html(data.xtn_lj_tbz+"%");
		
		$("#sd_bqz").html(data.sd_bqz);
		$("#sd_tqz").html(data.sd_tqz);
		$("#sd_tbz").html(data.sd_tbz+"%");
		$("#sd_hbz").html(data.sd_hbz+"%");
		$("#sd_lj_bqz").html(data.sd_lj_bqz);
		$("#sd_lj_tqz").html(data.sd_lj_tqz);
		$("#sd_lj_tbz").html(data.sd_lj_tbz+"%");
		
		$("#xtw_bqz").html(data.xtw_bqz);
		$("#xtw_tqz").html(data.xtw_tqz);
		$("#xtw_tbz").html(data.xtw_tbz+"%");
		$("#xtw_hbz").html(data.xtw_hbz+"%");
		$("#xtw_lj_bqz").html(data.xtw_lj_bqz);
		$("#xtw_lj_tqz").html(data.xtw_lj_tqz);
		$("#xtw_lj_tbz").html(data.xtw_lj_tbz+"%");
	},"JSON");	
	
	
	$.post(encodeURI("zbdpjc/rts.do?year="+year+"&month="+month+"&deptName="+deptName),{},function(data){
		$("#bqz_rts").html(data.bqz_rts);
		$("#tqz_rts").html(data.tqz_rts);
		$("#tbz_rts").html(data.tbz_rts+"%");
		$("#hbz_rts").html(data.hbz_rts+"%");
		$("#lj_bqz_rts").html(data.lj_bqz_rts);
		$("#lj_tqz_rts").html(data.lj_tqz_rts);
		$("#lj_tbz_rts").html(data.lj_tbz_rts+"%");
		
		$("#gw_bqz_rts").html(data.gw_bqz_rts);
		$("#gw_tqz_rts").html(data.gw_tqz_rts);
		$("#gw_tbz_rts").html(data.gw_tbz_rts+"%");
		$("#gw_hbz_rts").html(data.gw_hbz_rts+"%");
		$("#gw_lj_bqz_rts").html(data.gw_lj_bqz_rts);
		$("#gw_lj_tqz_rts").html(data.gw_lj_tqz_rts);
		$("#gw_lj_tbz_rts").html(data.gw_lj_tbz_rts+"%");
		
		$("#wt_bqz_rts").html(data.wt_bqz_rts);
		$("#wt_tqz_rts").html(data.wt_tqz_rts);
		$("#wt_tbz_rts").html(data.wt_tbz_rts+"%");
		$("#wt_hbz_rts").html(data.wt_hbz_rts+"%");
		$("#wt_lj_bqz_rts").html(data.wt_lj_bqz_rts);
		$("#wt_lj_tqz_rts").html(data.wt_lj_tqz_rts);
		$("#wt_lj_tbz_rts").html(data.wt_lj_tbz_rts+"%");
		
		$("#xtn_bqz_rts").html(data.xtn_bqz_rts);
		$("#xtn_tqz_rts").html(data.xtn_tqz_rts);
		$("#xtn_tbz_rts").html(data.xtn_tbz_rts+"%");
		$("#xtn_hbz_rts").html(data.xtn_hbz_rts+"%");
		$("#xtn_lj_bqz_rts").html(data.xtn_lj_bqz_rts);
		$("#xtn_lj_tqz_rts").html(data.xtn_lj_tqz_rts);
		$("#xtn_lj_tbz_rts").html(data.xtn_lj_tbz_rts+"%");
		
		$("#sd_bqz_rts").html(data.sd_bqz_rts);
		$("#sd_tqz_rts").html(data.sd_tqz_rts);
		$("#sd_tbz_rts").html(data.sd_tbz_rts+"%");
		$("#sd_hbz_rts").html(data.sd_hbz_rts+"%");
		$("#sd_lj_bqz_rts").html(data.sd_lj_bqz_rts);
		$("#sd_lj_tqz_rts").html(data.sd_lj_tqz_rts);
		$("#sd_lj_tbz_rts").html(data.sd_lj_tbz_rts+"%");
		
		$("#xtw_bqz_rts").html(data.xtw_bqz_rts);
		$("#xtw_tqz_rts").html(data.xtw_tqz_rts);
		$("#xtw_tbz_rts").html(data.xtw_tbz_rts+"%");
		$("#xtw_hbz_rts").html(data.xtw_hbz_rts+"%");
		$("#xtw_lj_bqz_rts").html(data.xtw_lj_bqz_rts);
		$("#xtw_lj_tqz_rts").html(data.xtw_lj_tqz_rts);
		$("#xtw_lj_tbz_rts").html(data.xtw_lj_tbz_rts+"%");
	},"JSON");
	
	
	$.post(encodeURI("zbdpjc/pj.do?year="+year+"&month="+month+"&deptName="+deptName),{},function(data){
		$("#jxpj_bqz").html(data.jxpj_bqz+"%");
		$("#jxpj_tqz").html(data.jxpj_tqz+"%");
		$("#jxpj_tbz").html(data.jxpj_tbz+"%");
		$("#jxpj_hbz").html(data.jxpj_hbz+"%");
		$("#lj_jxpj_bqz").html(data.lj_jxpj_bqz+"%");
		$("#lj_jxpj_tqz").html(data.lj_jxpj_tqz+"%");
		$("#lj_jxpj_tbz").html(data.lj_jxpj_tbz+"%");
		
		$("#pxzl_bqz").html(data.pxzl_bqz+"%");
		$("#pxzl_tqz").html(data.pxzl_tqz+"%");
		$("#pxzl_tbz").html(data.pxzl_tbz+"%");
		$("#pxzl_hbz").html(data.pxzl_hbz+"%");
		$("#lj_pxzl_bqz").html(data.lj_pxzl_bqz+"%");
		$("#lj_pxzl_tqz").html(data.lj_pxzl_tqz+"%");
		$("#lj_pxzl_tbz").html(data.lj_pxzl_tbz+"%");
		
		$("#zhfw_bqz").html(data.zhfw_bqz+"%");
		$("#zhfw_tqz").html(data.zhfw_tqz+"%");
		$("#zhfw_tbz").html(data.zhfw_tbz+"%");
		$("#zhfw_hbz").html(data.zhfw_hbz+"%");
		$("#lj_zhfw_bqz").html(data.lj_zhfw_bqz+"%");
		$("#lj_zhfw_tqz").html(data.lj_zhfw_tqz+"%");
		$("#lj_zhfw_tbz").html(data.lj_zhfw_tbz+"%");
		
	},"JSON");	
}

