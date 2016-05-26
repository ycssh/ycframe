package cn.yc.ssh.admin.base.util;

import java.lang.reflect.Field;
import java.util.List;

import cn.yc.ssh.admin.Constants;


public class DictUtils{
    public static String getDictName(String type, String value) {
    	return (String) Constants.cache.get(type+value);
    }
    public static <T>  PageResult<T> batchTran(PageResult<T> pageResult, String field,String type){
    	List<T> list = pageResult.getRows();
    	try {
			for(T obj:list){
				Class<? extends Object> clazz = obj.getClass();
				Field f = clazz.getDeclaredField(field);
				f.setAccessible(true);
				Object objValue = f.get(obj);
				if(objValue!=null){
					String value = objValue.toString();
					Object result = Constants.cache.get(type+value);
					String name = result==null?"":result.toString();
					f.set(obj, name);
				}
			}
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (NoSuchFieldException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		}
    	return pageResult;
    }
}
