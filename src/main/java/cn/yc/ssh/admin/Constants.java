package cn.yc.ssh.admin;

import java.util.HashMap;
import java.util.Map;

/**
 * @author 作者姓名 yc E-mail: ycssh2@163.com
 * @version 创建时间：2014-5-5 下午01:52:08 
 * 类说明 系统常量
 */
public class Constants {
	public static final String CURRENT_USER = "user";
	public static final String SESSION_FORCE_LOGOUT_KEY = "session.force.logout";
	public static final String TREE_OPEN = "open";
	public static final String TREE_CLOSE = "closed";
	public static final String LOG_RECORD = "log";
	
	public static final Integer SYSLOG_ADD = 1;
	public static final Integer SYSLOG_EDIT = 2;
	public static final Integer SYSLOG_DELETE = 3;
	public static final Integer SYSLOG_SEARCH = 4;
	public static final Integer SYSLOG_SYS = 1;
	public static final Integer SYSLOG_BUSINESS = 2;
	
	public static final Integer SYSLOG_RESULT_SUCCESS= 1; //日志操作结果 成功
	public static final Integer SYSLOG_RESULT_FAIL = 0;//日志操作结果 失败
	
	
	public static Map<String,Object> cache = new HashMap<String, Object>();
}
