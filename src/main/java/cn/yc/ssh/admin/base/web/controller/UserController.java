package cn.yc.ssh.admin.base.web.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authc.credential.CredentialsMatcher;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.session.InvalidSessionException;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import cn.yc.ssh.admin.Constants;
import cn.yc.ssh.admin.base.mybatis.model.Resource;
import cn.yc.ssh.admin.base.mybatis.model.Role;
import cn.yc.ssh.admin.base.mybatis.model.User;
import cn.yc.ssh.admin.base.realm.AES;
import cn.yc.ssh.admin.base.realm.UserRealm;
import cn.yc.ssh.admin.base.service.OrganizationService;
import cn.yc.ssh.admin.base.service.RoleService;
import cn.yc.ssh.admin.base.service.UserService;
import cn.yc.ssh.admin.base.util.Message;
import cn.yc.ssh.admin.base.util.PageResult;
import cn.yc.ssh.admin.base.util.Pagination;
import cn.yc.ssh.admin.log.SysOperLog;

import com.github.pagehelper.Page;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	private OrganizationService organizationService;
	@Autowired
	private RoleService roleService;

	@Autowired
	private UserRealm userRealm;

	@Autowired
	private CredentialsMatcher credentialsMatcher;

	@RequestMapping(value = "index", method = RequestMethod.GET)
	@RequiresPermissions("user:index")
	public String index(Model model) {
		return "user/index";
	}

	@RequestMapping("list")
	@RequiresPermissions("user:index")
	public @ResponseBody
	PageResult<User> list(Model model, User user, Boolean cascade,
			Pagination page) {
		Page<User> users = userService.find(user, cascade, page);
		for(User u:users){
			List<Role> roles = userService.findRolesByUser(u.getId());
			String roleName = "";
			if(roles!=null){
				for(int i=0;i<roles.size();i++){
					roleName+=roles.get(i).getName();
					if(i!=roles.size()-1){
						roleName+=","	;
					}
				}
			}
			u.setRoleName(roleName);
				
		}
		return PageResult.toPage(users);
	}

	@RequestMapping("/resources")
	public @ResponseBody
	List<Resource> frontList() {
		String username = SecurityUtils.getSubject().getPrincipal().toString();
		User user = userService.findByUsername(username);
		List<Resource> resources = userService.findResByUse(user.getId());

		List<Resource> resources2 = new ArrayList<Resource>();
		Set<Long> set = new HashSet<Long>();
		for (Resource resource : resources) {
			while (!set.contains(resource.getId())) {
				set.add(resource.getId());
				List<Resource> children = new ArrayList<Resource>();
				for (Resource resource2 : resources) {
					if (resource2.getParentId().equals(resource.getId())
							&& "menu".equals(resource2.getType())) {
						children.add(resource2);
					}
				}
				resource.setChildren(children);
			}
			System.out.println(resource.getId()+"\t"+resource.getParentId());
			if (resource.getParentId() == 0) {
				resources2.add(resource);
			}
		}
		return resources2;
	}

	@RequestMapping(value = "/add/{organizationId}", method = RequestMethod.GET)
	@RequiresPermissions("user:index")
	public String showCreateForm(Model model,
			@PathVariable("organizationId") Long organizationId) {
		User user = new User();
		user.setOrganizationId(organizationId);
		model.addAttribute("user", user);
		return "user/edit";
	}

	@RequestMapping(value = "/create", method = RequestMethod.POST)
	@RequiresPermissions("user:index")
	public @ResponseBody
	String create(User user, RedirectAttributes redirectAttributes, String md5,
			HttpServletResponse response, HttpServletRequest request)
			throws Exception {
		SysOperLog log = new SysOperLog();
		if (user.getId() == null) {
			User u = userService.findByUsername(user.getUsername());
			if (u != null) {
				return "用户名为" + user.getUsername() + "的用户已经存在，请输入其他用户名！";
			}
			String password = AES.Decrypt(user.getPassword(), SecurityUtils
					.getSubject().getSession().getAttribute("aesKey")
					.toString());
			if (password.length() < 8 || password.length() > 20) {
				response.setContentType("text/html;charset=UTF-8");
				return "密码必须在8-20位.";
			}
			user.setLocked(0L);
			user.setPassword(password);
			userService.createUser(user);
			log.setContent("新增用户:" + user.getUsername());
			log.setOperType(Constants.SYSLOG_ADD);
			log.setTitle("新增用户");
		} else {
			log.setContent("编辑用户:" + user.getUsername());
			log.setOperType(Constants.SYSLOG_EDIT);
			log.setTitle("编辑用户");
			userService.updateUser(user);
		}
		log.setLogType(Constants.SYSLOG_SYS);
		log.setResult(Constants.SYSLOG_RESULT_SUCCESS);
		request.setAttribute(Constants.LOG_RECORD, log);
		return "";
	}

	@RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
	@RequiresPermissions("user:index")
	public String showUpdateForm(@PathVariable("id") Long id, Model model) {
		setCommonData(model);
		model.addAttribute("user", userService.findOne(id));
		return "user/edit";
	}

	@RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
	@RequiresPermissions("user:index")
	public @ResponseBody
	Message delete(@PathVariable("id") Long id,
			RedirectAttributes redirectAttributes, HttpServletRequest request) {
		userService.deleteUser(id);
		SysOperLog log = new SysOperLog();
		log.setContent("删除用户:" + id);
		log.setOperType(Constants.SYSLOG_DELETE);
		log.setTitle("删除用户");
		log.setLogType(Constants.SYSLOG_SYS);
		log.setResult(Constants.SYSLOG_RESULT_SUCCESS);
		request.setAttribute(Constants.LOG_RECORD, log);
		return new Message(true, "");
	}

	@RequestMapping(value = "/{id}/changePassword", method = RequestMethod.GET)
	@RequiresPermissions("user:index")
	public String showChangePasswordForm(@PathVariable("id") Long id,
			Model model) {
		model.addAttribute("user", userService.findOne(id));
		model.addAttribute("op", "修改密码");
		return "user/changePassword";
	}

	@RequestMapping(value = "/resetPassword/{id}", method = RequestMethod.GET)
	@RequiresPermissions("user:index")
	public String resetPasswordForm(@PathVariable("id") Long id, Model model) {
		model.addAttribute("user", userService.findOne(id));
		model.addAttribute("op", "重置密码密码");
		return "user/resetPassword";
	}
	
	@RequestMapping(value = "/resetPassword/{id}", method = RequestMethod.POST)
	@RequiresPermissions("user:index")
	public @ResponseBody String resetPassword(@PathVariable("id") Long id, Model model, String passwordaa) throws InvalidSessionException, Exception {
		User user = userService.findOne(id);
		String password = AES.Decrypt(passwordaa, SecurityUtils.getSubject().getSession().getAttribute("aesKey").toString());
		if (password.length() < 8 || password.length() > 20) {
			return "密码必须在8-20位.";
		}
		user.setPassword(password);
		userService.updateUser(user);
		return "";
	}

	/***
	 * 修改自己密码
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/changePassword", method = RequestMethod.GET)
	public String showChangePasswordForm(Model model) {
		Subject subject = SecurityUtils.getSubject();
		Session session = subject.getSession();
		model.addAttribute("user", session.getAttribute(Constants.CURRENT_USER));
		model.addAttribute("op", "修改密码");
		return "user/changePassword";
	}

	@RequestMapping(value = "/changePassword", method = RequestMethod.POST)
	public void changePassword(Model model, String passworda, String password,
			String md5, HttpServletResponse response, HttpServletRequest request)
			throws Exception {
		Session session = SecurityUtils.getSubject().getSession();
		if (session.getAttribute("aesKey") == null) {
			String key = null;
			key = new SecureRandomNumberGenerator().nextBytes().toHex()
					.substring(0, 16);
			session.setAttribute("aesKey", key);
		}
		passworda = AES.Decrypt(passworda, SecurityUtils.getSubject()
				.getSession().getAttribute("aesKey").toString());
		if (passworda.length() < 8 || passworda.length() > 20) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print("密码必须在8-20位.");
			out.flush();
			return;
		}
		String pwd = AES.Decrypt(password, SecurityUtils.getSubject()
				.getSession().getAttribute("aesKey").toString());
		if (pwd.equals(passworda)) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print("新密码不能和原始密码一致，请重新输入");
			out.flush();
			return;
		}
		User user = (User) SecurityUtils.getSubject().getSession()
				.getAttribute(Constants.CURRENT_USER);

		Subject subject = SecurityUtils.getSubject();
		UsernamePasswordToken token = new UsernamePasswordToken(subject
				.getPrincipal().toString(), password);

		SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(
				user.getUsername(), user.getPassword(),
				ByteSource.Util.bytes(user.getCredentialsSalt()),
				userRealm.getName());
		boolean matchs = credentialsMatcher.doCredentialsMatch(token, info);
		if (matchs) {
			userService.changePassword(user.getId(), passworda);
			SysOperLog log = new SysOperLog();
			log.setContent("用户修改密码:" + user.toString());
			log.setOperType(Constants.SYSLOG_EDIT);
			log.setTitle("修改密码");
			log.setLogType(Constants.SYSLOG_BUSINESS);
			log.setResult(Constants.SYSLOG_RESULT_SUCCESS);
			request.setAttribute(Constants.LOG_RECORD, log);
		} else {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print("原始密码不正确，请重新输入");
			out.flush();
		}
	}

	private void setCommonData(Model model) {
		model.addAttribute("organizationList", organizationService.findAll());
		model.addAttribute("roleList", roleService.findAll());
	}

	/**
	 * 保存分配角色
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping("saverole/{id}")
	@RequiresPermissions("user:index")
	public @ResponseBody
	Message saveRole(@PathVariable("id") Long id, String roles,
			HttpServletRequest request) {
		SysOperLog log = new SysOperLog();
		log.setContent("用户：" + id + "分配角色");
		log.setOperType(1);
		log.setTitle("分配角色");
		log.setLogType(Constants.SYSLOG_SYS);
		log.setResult(Constants.SYSLOG_RESULT_SUCCESS);
		request.setAttribute(Constants.LOG_RECORD, log);
		userService.saveRoles(id, roles);
		return new Message(true, "");
	}

	/**
	 * 跳转到分配角色
	 * 
	 * @param id
	 * @return
	 */
	@RequiresPermissions("admin:user:setRole")
	@RequestMapping("role/{id}")
	public String role(@PathVariable("id") Long id, Model model) {
		List<Role> roles = userService.findRolesByUser(id);
		List<Role> all = roleService.findAll();
		all.removeAll(roles);
		model.addAttribute("roles", roles);
		model.addAttribute("notIn", all);
		model.addAttribute("userId", id);
		return "user/role";
	}

	/**
	 * 跳转到分配角色
	 * 
	 * @param id
	 * @return
	 */
	@RequiresPermissions("admin:user:edit")
	@RequestMapping("state/{state}/{username}")
	public @ResponseBody void updateState(@PathVariable int state,
			@PathVariable String username) {
		userService.updateState(state, username);
	}
}
