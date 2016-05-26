package cn.yc.ssh.admin.base.web.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.eis.SessionDAO;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.support.DefaultSubjectContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import cn.yc.ssh.admin.Constants;
import cn.yc.ssh.admin.base.mybatis.model.OnlineUser;
import cn.yc.ssh.admin.base.mybatis.model.User;
import cn.yc.ssh.admin.base.util.PageResult;
import cn.yc.ssh.admin.base.util.Pagination;

@Controller
@RequestMapping("/sessions")
public class SessionController {
	@Autowired
	private SessionDAO sessionDAO;

	@RequestMapping()
	@RequiresPermissions("admin:session")
	public String list(Model model) {
		return "sessions/list";
	}

	@RequestMapping("/list")
	@RequiresPermissions("admin:session")
	public @ResponseBody PageResult<OnlineUser> list(User user, Pagination page) {
		Collection<Session> sessions = sessionDAO.getActiveSessions();
		int p = page.getPage();
		int row = page.getRows();
		List<Session> list = new ArrayList<Session>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for (Session s : sessions) {
			if (s.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY) != null) {
				list.add(s);
			}
		}
		
		List<OnlineUser> lists = new ArrayList<OnlineUser>();
		int total = list.size();
		for(int i=(p-1)*row;i<p*row&&i<total;i++){
			Session s = list.get(i);
	        PrincipalCollection principalCollection =
	                (PrincipalCollection) s.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY);
	        String userName = (String) principalCollection.getPrimaryPrincipal();
			lists.add(new OnlineUser(s.getId().toString(),userName,s.getHost(),sdf.format(s.getLastAccessTime())));
		}
		return new PageResult<OnlineUser>(lists, total);
	}

	@RequestMapping("/{sessionId}/forceLogout")
	@RequiresPermissions("admin:session")
	public String forceLogout(@PathVariable("sessionId") String sessionId,
			RedirectAttributes redirectAttributes) {
		try {
			Session session = sessionDAO.readSession(sessionId);
			if (session != null) {
				session.setAttribute(Constants.SESSION_FORCE_LOGOUT_KEY,
						Boolean.TRUE);
			}
		} catch (Exception e) {/* ignore */
			e.printStackTrace();
		}
		redirectAttributes.addFlashAttribute("msg", "强制退出成功！");
		return "redirect:/sessions";
	}

}
