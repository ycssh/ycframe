package cn.yc.ssh.common;

import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

public class PropsUtil {
	private static Properties prop = new Properties();
	static {
		InputStream propIS = PropsUtil.class.getClassLoader()
				.getResourceAsStream("enums.properties");
		try {
			prop.load(propIS);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static String getProperty(String key) {
		try {
			return prop.getProperty(key);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 以[KGSB=17,23]样式,返回数据列表
	 * 
	 * @param key
	 * @return
	 */
	public static List<String> getProperty2List(String key) {
		return Arrays.asList(PropsUtil.getProperty(key).split(","));
	}

	/**
	 * GDLX=1:ZG,2:DS样式，将数据以map方式返回
	 * 
	 * @param key
	 * @param flag
	 *            0:[key:value],1:[value:key]
	 * @return
	 */
	public static Map<String, String> getProperty2Map(String key, String flag) {
		List<String> list = PropsUtil.getProperty2List(key);
		Map<String, String> map = new HashMap<String, String>();
		if ("0".equals(flag)) {
			for (String str : list) {
				String[] kv = str.split(":");
				map.put(kv[0], kv[1]);
			}
		} else if ("1".equals(flag)) {
			for (String str : list) {
				String[] kv = str.split(":");
				map.put(kv[1], kv[0]);
			}
		}
		return map;
	}
}
