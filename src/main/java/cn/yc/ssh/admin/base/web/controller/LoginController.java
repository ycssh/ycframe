package cn.yc.ssh.admin.base.web.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.yc.ssh.admin.Constants;
import cn.yc.ssh.admin.base.web.exception.MaliciousLoginException;
import cn.yc.ssh.admin.log.SysOperLog;

@Controller
public class LoginController {

	@RequestMapping("/logout22")
	public String logout(HttpServletRequest req, Model model,HttpServletResponse response){
		
		Subject subject = SecurityUtils.getSubject();
		try {
			subject.logout();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		try {
			WebUtils.issueRedirect(req, response, "/index");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "login";
	}
    @RequestMapping(value = "/login")
    public String showLoginForm(HttpServletRequest req, Model model,HttpServletResponse response) throws IOException {
    	//判断已经登录，跳转到index
		Subject subject = SecurityUtils.getSubject();
		if(subject.getPrincipal()!=null){
			WebUtils.issueRedirect(req, response, "/index");
		}
        String exceptionClassName = (String)req.getAttribute("shiroLoginFailure");
        String error = null;
        if(ExcessiveAttemptsException.class.getName().equals(exceptionClassName)){
            @SuppressWarnings("unchecked")
			Map<String,String> inits = (Map<String, String>) Constants.cache.get("sys_init");
            SysOperLog log = new SysOperLog();
			log.setContent("用户连续输入密码错误");
			log.setOperType(Constants.SYSLOG_ADD);
			log.setTitle("用户连续输入密码错误");
			log.setUserid(req.getParameter("username"));
			log.setLogType(Constants.SYSLOG_SYS);
			log.setResult(Constants.SYSLOG_RESULT_FAIL);
			req.setAttribute(Constants.LOG_RECORD, log);
        	error="连续输入"+inits.get("pwdCount")+"次密码错误，帐号锁定"+inits.get("pwdTime")+"分钟";
        }else if(UnknownAccountException.class.getName().equals(exceptionClassName)) {
            SysOperLog log = new SysOperLog();
			log.setContent("用户名/密码错误");
			log.setOperType(Constants.SYSLOG_SEARCH);
			log.setTitle("用户名/密码错误");
			log.setUserid(req.getParameter("username"));
			log.setLogType(Constants.SYSLOG_SYS);
			log.setResult(Constants.SYSLOG_RESULT_FAIL);
			req.setAttribute(Constants.LOG_RECORD, log);
        	
            error = "用户名/密码错误";
        }else if(MaliciousLoginException.class.getName().equals(exceptionClassName)) {
            SysOperLog log = new SysOperLog();
			log.setContent("系统检测到你可能恶意登录,请联系系统管理员");
			log.setOperType(Constants.SYSLOG_SEARCH);
			log.setTitle("系统检测到你可能恶意登录,请联系系统管理员");
			log.setUserid(req.getParameter("username"));
			log.setLogType(Constants.SYSLOG_SYS);
			log.setResult(Constants.SYSLOG_RESULT_FAIL);
			req.setAttribute(Constants.LOG_RECORD, log);
        	
            error = "系统检测到你可能恶意登录,请联系系统管理员";
        } else if(IncorrectCredentialsException.class.getName().equals(exceptionClassName)) {
            SysOperLog log = new SysOperLog();
			log.setContent("用户名/密码错误");
			log.setOperType(Constants.SYSLOG_SEARCH);
			log.setTitle("用户名/密码错误");
			log.setUserid(req.getParameter("username"));
			log.setLogType(Constants.SYSLOG_SYS);
			log.setResult(Constants.SYSLOG_RESULT_FAIL);
			req.setAttribute(Constants.LOG_RECORD, log);
        	
            error = "用户名/密码错误";
        } else if("jCaptcha.error".equalsIgnoreCase(exceptionClassName)){
            SysOperLog log = new SysOperLog();
			log.setContent("验证码错误");
			log.setOperType(Constants.SYSLOG_SEARCH);
			log.setTitle("验证码错误");
			log.setUserid(req.getParameter("username"));
			log.setLogType(Constants.SYSLOG_SYS);
			log.setResult(Constants.SYSLOG_RESULT_FAIL);
			req.setAttribute(Constants.LOG_RECORD, log);
        	
        	error="请输入正确的验证码";
        }else if(LockedAccountException.class.getName().equals(exceptionClassName)){
            SysOperLog log = new SysOperLog();
			log.setContent("账号状态异常，登陆失败");
			log.setOperType(Constants.SYSLOG_SEARCH);
			log.setTitle("账号状态异常，登陆失败");
			log.setUserid(req.getParameter("username"));
			log.setLogType(Constants.SYSLOG_SYS);
			log.setResult(Constants.SYSLOG_RESULT_FAIL);
			req.setAttribute(Constants.LOG_RECORD, log);
        	
        	error = "账号状态异常，请联系系统管理员";
        }
        else if(exceptionClassName != null) {
        	error = "登录错误";
        }
        model.addAttribute("error", error);
        if(req.getParameter("forceLogout") != null) {
            model.addAttribute("error", "您已经被管理员强制退出，请重新登录");
        }
        return "login"+(StringUtils.hasLength(req.getParameter("id"))?req.getParameter("id"):"");
    }

    @RequestMapping("/login/aes")
    public @ResponseBody String getAESKey(){
    	Session session = SecurityUtils.getSubject().getSession();
    	String key = null;
    	key = new SecureRandomNumberGenerator().nextBytes().toHex().substring(0,16);
    	session.setAttribute("aesKey", key);
    	return key;
    	
    }

}
