package cn.yc.ssh.admin.base.web.shiro.filter;

import java.util.Date;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;

import cn.yc.ssh.admin.Constants;
import cn.yc.ssh.admin.base.mybatis.model.User;
import cn.yc.ssh.admin.log.SysOperLog;

public class LogoutFilter extends
		org.apache.shiro.web.filter.authc.LogoutFilter {

	
	public String getRedirectUrl(ServletRequest request,
			ServletResponse response, Subject subject) {
		SysOperLog _log = new SysOperLog();
		_log.setIp(request.getRemoteHost());
		Session session = subject.getSession();
		User user = (User) session.getAttribute(Constants.CURRENT_USER);
		if (user != null) {
			_log.setUname(user.getName());
			_log.setUserid(user.getUsername());
			_log.setContent("退出登录");
			_log.setTitle("退出登录");
			_log.setOperType(1);
			_log.setOpertime(new Date());
			_log.setResult(Constants.SYSLOG_RESULT_SUCCESS);
//			syslogDAO.add(_log);
		}
		return "login";
	}
}
