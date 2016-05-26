package cn.yc.ssh.admin.base.web.shiro.filter;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.eis.SessionDAO;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.subject.support.DefaultSubjectContext;
import org.apache.shiro.web.filter.AccessControlFilter;
import org.apache.shiro.web.util.WebUtils;

import cn.yc.ssh.admin.Constants;

public class MaxOnlineUserFilter extends AccessControlFilter {

	private String maxonlineUrl; // 踢出后到的地址

	private SessionDAO sessionDAO;

	
	protected boolean isAccessAllowed(ServletRequest request,
			ServletResponse response, Object mappedValue) throws Exception {
		return false;
	}

	
	protected boolean onAccessDenied(ServletRequest request,
			ServletResponse response) throws Exception {
		Collection<Session> sessions = sessionDAO.getActiveSessions();
		List<Session> list = new ArrayList<Session>();
		for (Session s : sessions) {
			if (s.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY) != null) {
				list.add(s);
			}
		}
		//系统最大在线用户数量
        Map<String,String> inits = (Map<String, String>) Constants.cache.get("sys_init");
        String maxOnlineCount = inits.get("maxOnlineCount");
		if (list.size() > Integer.parseInt(maxOnlineCount)) {
			Subject subject = getSubject(request, response);
			subject.logout();
			WebUtils.issueRedirect(request, response, maxonlineUrl);
			return false;
		}

		return true;
	}

	public String getMaxonlineUrl() {
		return maxonlineUrl;
	}

	public void setMaxonlineUrl(String maxonlineUrl) {
		this.maxonlineUrl = maxonlineUrl;
	}

	public SessionDAO getSessionDAO() {
		return sessionDAO;
	}

	public void setSessionDAO(SessionDAO sessionDAO) {
		this.sessionDAO = sessionDAO;
	}

}