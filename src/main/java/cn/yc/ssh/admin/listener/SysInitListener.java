package cn.yc.ssh.admin.listener;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import cn.yc.ssh.admin.Constants;
import cn.yc.ssh.admin.base.entity.Dict;
import cn.yc.ssh.admin.base.mybatis.model.SysInit;
import cn.yc.ssh.admin.spring.SpringUtils;

public class SysInitListener implements ServletContextListener {
	ServletContext ctx;

	
	public void contextDestroyed(ServletContextEvent event) {
		this.ctx = null;
	}

	
	public void contextInitialized(ServletContextEvent event) {
		//读取dict配置
		JdbcTemplate jdbcTemplate = SpringUtils.getBean("jdbcTemplate");
		String sql = "select name,value,type from dict";
		String sql1 = "select id,name,value,unit,type from sys_init";
		List<Dict> dicts = jdbcTemplate.query(sql, new BeanPropertyRowMapper<Dict>(Dict.class));
		List<SysInit> list = jdbcTemplate.query(sql1, new BeanPropertyRowMapper<SysInit>(SysInit.class));
		Map<String,String> inits = new HashMap<String, String>();
		for(SysInit init:list){
			inits.put(init.getType(), init.getValue());
		}
		for(Dict dict:dicts){
			String value = dict.getValue();
			String type = dict.getType();
			String name = dict.getName();
			Constants.cache.put(type+value, name);
		}
		Constants.cache.put("sys_init", inits);
		Constants.cache.put("sys_initlist", list);
	}
}