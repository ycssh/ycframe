package cn.yc.ssh.admin.base.util;

/**
 * @author 作者姓名 yc E-mail: ycssh2@163.com
 * @version 创建时间：2014-5-14 下午03:04:25 类说明
 */
public class Pagination {
	private int page = 1;
	private int rows = 10;

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

}
