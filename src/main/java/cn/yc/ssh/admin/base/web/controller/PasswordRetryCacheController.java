package cn.yc.ssh.admin.base.web.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.concurrent.atomic.AtomicInteger;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheManager;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.yc.ssh.admin.Constants;
import cn.yc.ssh.admin.base.mybatis.model.User;
import cn.yc.ssh.admin.base.service.UserService;
import cn.yc.ssh.admin.log.SysOperLog;

@Controller
@RequestMapping("/passwordRetry")
/**
 * 对于登录失败自动锁定的用户，管理员解锁
 * @author ycssh
 *
 */
public class PasswordRetryCacheController {

	@Resource
	private CacheManager cacheManager;

	@Resource
	private UserService userService;

	@RequestMapping("/list")
	@RequiresPermissions("passwordRetry")
	public String list(Model model) {
		Cache<String, AtomicInteger> passwordRetryCache= cacheManager.getCache("passwordRetryCache");
		Set<String> usernames = passwordRetryCache.keys();
		List<User> users = new ArrayList<User>();
		for (String name : usernames) {
			users.add(userService.findByUsername(name.replace("passwordRetryCount:", "")));
		}
		model.addAttribute("users",users);
		return "sys/passwordRetry";
	}
	
	@RequestMapping(value="/unlock/{username}")
	@ResponseBody
	@RequiresPermissions("passwordRetry")
	public String unlock(@PathVariable("username") String username, HttpServletRequest request) {
		Cache<String, AtomicInteger> passwordRetryCache= cacheManager.getCache("passwordRetryCache");
		passwordRetryCache.remove(username);
		SysOperLog log = new SysOperLog();
		log.setContent("解锁输入密码错误用户:"+username);
		log.setOperType(Constants.SYSLOG_ADD);
		log.setTitle("解锁输入密码错误用户");
		log.setLogType(Constants.SYSLOG_SYS);
		log.setResult(Constants.SYSLOG_RESULT_SUCCESS);
		request.setAttribute(Constants.LOG_RECORD, log);
		return "1";
	}

}
