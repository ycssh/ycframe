package cn.yc.ssh.admin.base.web.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.yc.ssh.admin.Constants;
import cn.yc.ssh.admin.base.mybatis.model.SysInit;
import cn.yc.ssh.admin.base.service.SysInitService;
import cn.yc.ssh.admin.log.SysOperLog;

@Controller
@RequestMapping("/sysinit")
public class SysInitController {

	@Resource
	private SysInitService sysInitService;

	@RequestMapping("/list")
	@RequiresPermissions("sysinit")
	public String list(Model model, HttpServletRequest request) {
		model.addAttribute("inits", Constants.cache.get("sys_initlist"));
		return "sys/sysinit";
	}

	@RequestMapping("/update/{id}/{value}")
	@ResponseBody
	@RequiresPermissions("sysinit")
	public String update(@PathVariable int id, @PathVariable String value, HttpServletRequest request) {
		List<SysInit> list = (List<SysInit>) Constants.cache.get("sys_initlist");
        Map<String,String> inits = (Map<String, String>) Constants.cache.get("sys_init");
		for (SysInit init : list) {
			if (init.getId() == id) {
				init.setValue(value);
				inits.put(init.getType(), value);
			}
		}

		SysOperLog log = new SysOperLog();
		log.setContent("编辑系统初始化参数:");
		log.setOperType(Constants.SYSLOG_EDIT);
		log.setTitle("编辑系统初始化参数");
		log.setLogType(Constants.SYSLOG_SYS);
		log.setResult(Constants.SYSLOG_RESULT_SUCCESS);
		request.setAttribute(Constants.LOG_RECORD, log);
		sysInitService.update(id, value);
		return "1";
	}
}
