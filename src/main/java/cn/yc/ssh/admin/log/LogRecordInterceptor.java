package cn.yc.ssh.admin.log;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import cn.yc.ssh.admin.Constants;
import cn.yc.ssh.admin.base.mybatis.model.User;

public class LogRecordInterceptor implements HandlerInterceptor, ApplicationContextAware {
	private ApplicationContext ctx;

	
	public void afterCompletion(HttpServletRequest req, HttpServletResponse resp, Object handler, Exception arg3)
			throws Exception {
	}

	
	public void postHandle(HttpServletRequest req, HttpServletResponse resp, Object handler, ModelAndView view)
			throws Exception {
		Object obj = SecurityUtils.getSubject().getSession().getAttribute(Constants.CURRENT_USER);
		if (null != obj) {
			User user = (User) obj;
			Object _obj = req.getAttribute(Constants.LOG_RECORD);
			if(_obj!=null){
				SysOperLog _log = (SysOperLog) _obj;
				_log.setIp(req.getRemoteHost());
				_log.setUname(user.getName());
				_log.setUserid(user.getUsername());
				LogRecordEvent event = new LogRecordEvent(LogRecordInterceptor.this.ctx, _log);
				ctx.publishEvent(event);
			}
		}else{
			Object _obj = req.getAttribute(Constants.LOG_RECORD);
			if(_obj!=null){
				SysOperLog _log = (SysOperLog) _obj;
				_log.setIp(req.getRemoteHost());
				LogRecordEvent event = new LogRecordEvent(LogRecordInterceptor.this.ctx, _log);
				ctx.publishEvent(event);
			}
		}
	}

	
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler) throws Exception {
		return true;
	}

	
	public void setApplicationContext(ApplicationContext ctx) throws BeansException {
		this.ctx = ctx;
	}
}