package cn.yc.ssh.common;

import org.springframework.util.StringUtils;

public class Condition {

	private Integer page;
	private Integer rows;
	private String sort;
	private String dir;
	private String filter;
	
	public Integer getRows() {
		return rows;
	}
	public void setRows(Integer rows) {
		this.rows = rows;
	}

	public Integer getPage() {
		return page;
	}
	public void setPage(Integer page) {
		this.page = page;
	}
	public Integer getStart() {
		
		if(this.page==null){
			return 0;
		}
		return (page-1)*rows;
	}
	public void setStart(Integer start) {
	}
	public Integer getLimit() {
		
		return rows;
//		return limit;
	}
	public void setLimit(Integer limit) {
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getDir() {
		return dir;
	}
	public void setDir(String dir) {
		this.dir = dir;
	}
	public String getFilter() {
		return filter;
	}
	public void setFilter(String filter) {
		this.filter = filter;
	}
	
	
	
	
	public void updateFilter(String k,String nV){
		
		if(!StringUtils.hasLength(filter)){
			filter = k+"="+nV;
			return ;
		}
		
		String tmp = "";
		if(filter.indexOf("&")>=0){
			String[] fs = filter.split("&");
			
			for(String fe:fs){
				
				if(!StringUtils.hasLength(fe)||fe.indexOf("=")<0){
					continue;
				}
				
				String[] fes = fe.split("=");
				
				if(fes[0].equals(k)){
					tmp += "&"+fes[0]+"="+nV;
				}else{
					tmp += "&"+fe;
				}
			}
		}else{
			
			if(filter.indexOf("=")>=0){
				String[] fs = filter.split("=");
				
				if(fs[0].equals(k)){
					tmp += "&"+fs[0]+"="+nV;
				}else{
					tmp += "&"+filter;
				}
			}
		}
		
		tmp = tmp.equals("")?"":tmp.substring(1);
		
		filter = tmp;
	}
	
	
}
