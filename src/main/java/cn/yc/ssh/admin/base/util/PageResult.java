package cn.yc.ssh.admin.base.util;

import java.util.List;

import com.github.pagehelper.Page;

/**
 * @author 作者姓名 yc E-mail: ycssh2@163.com
 * @version 创建时间：2014-5-14 下午02:24:35 类说明 分页工具类
 */
public class PageResult<T> {
	private List<T> rows;

	private int total;

	public List<T> getRows() {
		return rows;
	}

	public void setRows(List<T> rows) {
		this.rows = rows;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public PageResult(List<T> rows, int total) {
		super();
		this.rows = rows;
		this.total = total;
	}
	
	public static PageResult toPage(Page page){
		return new PageResult(page, (int)page.getTotal());
	}

}
