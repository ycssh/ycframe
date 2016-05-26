package cn.yc.ssh.common;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.util.StringUtils;

public class CommonUtils {

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static Map wrapObject(Object obj) {

		Map m = new HashMap();

		if (obj == null) {
			m.put("success", false);
		} else {
			m.put("success", true);
			m.put("obj", obj);
		}

		return m;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static Map wrapError(String valMsg) {
		
		Map m = new HashMap();

		m.put("success", false);
		m.put("msg", valMsg);

		return m;
	}

	public static String getKeyValue(String s, String k) {

		if (!StringUtils.hasLength(s)) {
			return null;
		}

		if (s.indexOf("&") >= 0) {
			String[] ss = s.split("&");

			for (String se : ss) {
				if (StringUtils.hasLength(se) && se.indexOf("=") >= 0) {

					String[] ses = se.split("=");

					if (ses[0].equals(k)&&ses.length==2) {
						return ses[1];
//						return StringEscapeUtils.escapeSql(ses[1]);
					}
				}
			}
		} else {
			if (s.indexOf("=") >= 0) {
				String[] ss = s.split("=");

				if (ss[0].equals(k)&&ss.length==2) {
					return ss[1];
//					return StringEscapeUtils.escapeSql(ss[1]);
				}
			}
		}

		return null;
	}

	@Deprecated
	public static Object[] string2Objects(String taskIdsStr) {
		

		return null;
	}

	/***
	 * 
	 * 将以逗号分隔的string类型的字符串转换成List
	 * @param taskIdsStr 以半角逗号分隔的字符串，形如"2,3,4,5";
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static List string2List(String taskIdsStr) {
		
		if (!StringUtils.hasLength(taskIdsStr)) {
			return null;
		}

		List list = new ArrayList();
		if (taskIdsStr.indexOf(",") >= 0) {

			String[] tes = taskIdsStr.split(",");

			for (String te : tes) {

				list.add(Integer.parseInt(te));
				
			}
		} else {
			list.add(Integer.parseInt(taskIdsStr));
		}
		return list;
	}
	
	/***
	 * 
	 * 将以逗号分隔的string类型的字符串转换成<List<Integer>>
	 * @param taskIdsStr 以半角逗号分隔的字符串，形如"2,3,4,5";
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static List string2List(String taskIdsStr,Class class1) {
		
		if (!StringUtils.hasLength(taskIdsStr)) {
			return null;
		}
		
		if(class1==null||class1.equals(Integer.class)){
			return string2List(taskIdsStr);
		}

		List list = new ArrayList();
		if (taskIdsStr.indexOf(",") >= 0) {

			String[] tes = taskIdsStr.split(",");

			for (String te : tes) {

				list.add(class1.cast(te));
				
			}
		} else {
			list.add(class1.cast(taskIdsStr));
		}
		return list;
	}

	/**
	 * 生成分页SQL
	 * @param sql
	 * @param start
	 * @param limit
	 * @return
	 */
	public static String getPavSql(String sql, int start, int limit) {
		
		if(!StringUtils.hasLength(sql)){
			return sql;
		}
		
		sql  =  "select * from (select t.*,rownum r from ("+sql+") t) where r>"+start+" and r<="+(start+limit)+" ";
		return sql;
	}

	public static String array2string(Object[] fields, String sep) {
		
		if(fields==null||fields.length==0){
			return null;
		}
		String s = "";
		for(Object o:fields){
			s += sep+o.toString();
		}
		if(!"".equals(s)){
			s = s.substring(sep.length());
		}
		return s;
	}

	public static String getDescFromList(String valueField, String value,
			String nameField, List<Map<String, Object>> list) {
		
		if(list==null||list.size()==0){
			return null;
		}
		if(value==null){
			return null;
		}
		for(Map<String, Object> m:list){
			
			if(value.equals(m.get(valueField))){
				return (String) m.get(nameField);
			}
		}
		return null;
	}

	/**
	 * 获取一月的最大天数
	 * @param year
	 * @param month
	 * @return
	 */
	public static int getMaxDayOfMonth(int year, int month) {
		
		
        Calendar calendar = Calendar.getInstance();  
        calendar.clear();    //在使用set方法之前，必须先clear一下，否则很多信息会继承自系统当前时间
        calendar.set(Calendar.YEAR,year);   
        calendar.set(Calendar.MONTH,month-1);  //Calendar对象默认一月为0          
        int endday = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
        
		return endday;
	}
	
}
