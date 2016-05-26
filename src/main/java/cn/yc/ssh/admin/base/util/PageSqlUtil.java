package cn.yc.ssh.admin.base.util;

/**
 * @author 作者姓名 yc E-mail: ycssh2@163.com
 * @version 创建时间：2014-5-14 下午04:44:58 类说明
 */
public class PageSqlUtil {
	public static String getPageSql(String sql, Pagination pagination) {
		int page = pagination.getPage();
		int rows = pagination.getRows();
		if(page<=1){
			page=1;
		}
		if(rows<=1){
			rows=10;
		}
		return "SELECT * FROM (SELECT tab.*, ROWNUM RN FROM ("+sql+")tab ) WHERE RN >= "+((page - 1) * rows+1)+" and RN<="+page * rows;
	}

	public static String getCountSql(String sql) {
		return "select count(*) from (" + sql + ") count_table";
	}
}
