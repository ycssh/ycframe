package cn.yc.ssh.common;

import java.util.List;

public class MyPape {

	private int total;
	private List<?> rows;
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public List<?> getRows() {
		return rows;
	}
	public void setRows(List<?> rows) {
		this.rows = rows;
	}
	public MyPape(int total2, List<?> rows) {
		super();
		this.total = total2;
		this.rows = rows;
	}
	public MyPape() {
		super();
	}
	
	
}
