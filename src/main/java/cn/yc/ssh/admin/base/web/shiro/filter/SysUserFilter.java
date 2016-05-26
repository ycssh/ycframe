package cn.yc.ssh.admin.base.web.shiro.filter;

import java.util.Date;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.PathMatchingFilter;
import org.springframework.beans.factory.annotation.Autowired;

import cn.yc.ssh.admin.Constants;
import cn.yc.ssh.admin.base.mybatis.model.User;
import cn.yc.ssh.admin.base.service.UserService;
import cn.yc.ssh.admin.log.SysOperLog;

public class SysUserFilter extends PathMatchingFilter {

    @Autowired
    private UserService userService;

    
    protected boolean onPreHandle(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception {

        String username = (String)SecurityUtils.getSubject().getPrincipal();
        Subject subject = SecurityUtils.getSubject(); 
        Session session = subject.getSession();

        Map<String,String> inits = (Map<String, String>) Constants.cache.get("sys_init");
        String sessionTimeout = inits.get("sessionTimeout");
        session.setTimeout(Integer.parseInt(sessionTimeout)*60*1000);
        if(session.getAttribute(Constants.CURRENT_USER)==null){
        	String currentIP = request.getRemoteHost();
        	if("0:0:0:0:0:0:0:1".equals(currentIP)){
        		currentIP = "127.0.0.1";
        	}
        	User user = userService.findByUsername(username);
        	session.setAttribute(Constants.CURRENT_USER, user);

			SysOperLog _log = new SysOperLog();
			_log.setTitle("登录");
			_log.setOperType(1);
			
			_log.setIp(currentIP);
			_log.setUname(user.getName());
			_log.setUserid(user.getUsername());
			_log.setContent("登录");
			_log.setOpertime(new Date());
			_log.setLogType(Constants.SYSLOG_SYS);
			_log.setResult(Constants.SYSLOG_RESULT_SUCCESS);
//			syslogDAO.add(_log);
        }else{
        	User user = (User) session.getAttribute(Constants.CURRENT_USER);
        	request.setAttribute(Constants.CURRENT_USER, user);
        }
        return true;
    }
}
