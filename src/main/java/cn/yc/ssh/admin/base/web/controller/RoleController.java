package cn.yc.ssh.admin.base.web.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
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
import cn.yc.ssh.admin.base.service.ResourceService;
import cn.yc.ssh.admin.base.service.RoleService;
import cn.yc.ssh.admin.base.util.Message;
import cn.yc.ssh.admin.base.util.PageResult;
import cn.yc.ssh.admin.base.util.Pagination;
import cn.yc.ssh.admin.log.SysOperLog;
import cn.yc.ssh.common.CommonUtils;

@Controller
@RequestMapping("/role")
public class RoleController {

	@Autowired
	private RoleService roleService;

	@Autowired
	private ResourceService resourceService;

	@RequestMapping(value="index", method = RequestMethod.GET)
	@RequiresPermissions("role:index")
	public String index(Model model) {
		return "role/index";
	}
	
	@RequestMapping(value="list")
	@RequiresPermissions("role:index")
	public @ResponseBody PageResult<Role> list(Model model, Pagination page,Role role) {
		return PageResult.toPage(roleService.find(page,role));
	}
	
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	@RequiresPermissions("role:index")
	public String showCreateForm(Model model) {
		setCommonData(model);
		model.addAttribute("role", new Role());
		model.addAttribute("op", "新增");
		return "role/edit";
	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	@RequiresPermissions("role:index")
	public void create(Role role, HttpServletResponse response ,HttpServletRequest request) throws IOException {
		if(role.getId()!=null){
			roleService.updateRole(role);
		}else{
			roleService.createRole(role);
		}
	}

	@RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
	@RequiresPermissions("role:index")
	public String showUpdateForm(@PathVariable("id") Long id, Model model) {
		model.addAttribute("role", roleService.findOne(id));
		return "role/edit";
	}

	@RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
	@RequiresPermissions("role:index")
	public @ResponseBody Message delete(@PathVariable("id") Long id,HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
		roleService.deleteRole(id);
		SysOperLog log = new SysOperLog();
		log.setContent("删除角色:"+id);
		log.setOperType(Constants.SYSLOG_DELETE);
		log.setTitle("删除角色");
		log.setLogType(Constants.SYSLOG_SYS);
		log.setResult(Constants.SYSLOG_RESULT_SUCCESS);
		request.setAttribute(Constants.LOG_RECORD, log);
		return new Message();
	}
	
	@RequestMapping(value = "/resources/{roleId}")
	@RequiresPermissions("role:index")
	public @ResponseBody List<Resource> getResources(@PathVariable("roleId")Long roleId) {
		return roleService.findResByRole(roleId);
	}
	
	@RequestMapping("/listall")
	//@RequiresPermissions("role:index")
	@RequiresPermissions(value={"role:index","admin:workflowmgt:index"},logical=Logical.OR)
	public @ResponseBody List<Role> listAll(){
//		return roleService.listAll();
		return null;
	}

	private void setCommonData(Model model) {
		model.addAttribute("resourceList", resourceService.findAll());
	}

	@RequiresPermissions("admin:role:resourceTo")
	@RequestMapping(value = "/editresources/{roleId}")
	public String resources(@PathVariable("roleId")Long roleId, Model model) {	
		model.addAttribute("resources",roleService.findResByRole(roleId));
		model.addAttribute("roleId",roleId);
		return "role/resources";
	}
	
	//通过session获取当前登录用户对应角色的角色编码（即 sys_role中的role）
	@RequestMapping(value = "/nowUserRoleCode")
	@RequiresPermissions("role:index")
	public @ResponseBody String nowUserRoleCode(){
		//获取用户
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute(Constants.CURRENT_USER);
		//获取用户ID
		Long userId = user.getId();
		//获取用户访问sys_resource权限 "no" 代表无访问权限  ， "XTZY"代表系统资源, "YWZY"代办业务资源,"all"代表全部资源
		String power = roleService.resTypeForNowUser(userId);
		
		return power;
	}
	
	
	
	@RequestMapping(value = "/saveresources/{roleId}")
	@RequiresPermissions("role:index")
	public @ResponseBody Map saveResources(@PathVariable("roleId")Long roleId,String resources, HttpServletRequest request) {
		roleService.saveResources(roleId,resources);
		SysOperLog log = new SysOperLog();
		log.setContent("角色分配资源:"+roleId);
		log.setOperType(1);
		log.setTitle("角色分配资源");
		log.setLogType(Constants.SYSLOG_SYS);
		log.setResult(Constants.SYSLOG_RESULT_SUCCESS);
		request.setAttribute(Constants.LOG_RECORD, log);
		return CommonUtils.wrapObject("");
	}
	
	@RequiresPermissions("admin:role:pass")
	@RequestMapping(value = "/rolePass/{roleId}")
	public String rolePass(@PathVariable("roleId")Long roleId, Model model) {	
		
		//获取用户
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute(Constants.CURRENT_USER);
		//获取用户ID
		Long userId = user.getId();
		//获取用户访问sys_resource权限 "no" 代表无访问权限  ， "XTZY"代表系统资源, "YWZY"代办业务资源,"all"代表全部资源
		String power = roleService.resTypeForNowUser(userId);
		//资源
		model.addAttribute("resources",roleService.findResByRole(roleId));
		//角色ID
		model.addAttribute("roleId",roleId);
		
		return "role/rolePass";
	}
	
	@RequestMapping(value = "/roleStateUpate/{roleId}")
	@RequiresPermissions("role:index")
	public @ResponseBody Map roleStateUpate(@PathVariable("roleId")Long roleId,String resources, HttpServletRequest request) {
//		//日志
//		SysOperLog log = new SysOperLog();
//		
//		//获取该角色的状态，获取状态id
//		Role role = roleService.getRoleByroleId(roleId);
//		//角色状态 0：有效  1：无效  2待删除
//		String stateId = role.getState() == null ? "0":role.getState();
//		
//		//审核操作
//		int result = roleService.rolePass(roleId, stateId);
//		
//		//根据用户状态进行不同操作
//		if(result > 0 && stateId.equals("1")){//角色审核
//			log.setContent("角色审核，角色ID:"+roleId);
//			log.setOperType(Constants.SYSLOG_EDIT);
//			log.setTitle("角色审核");
//		}else if(result > 0 && stateId.equals("2")){//角色删除	
//			log.setContent("角色删除，角色ID:"+roleId);
//			log.setOperType(Constants.SYSLOG_DELETE);
//			log.setTitle("角色删除");
//		}
//		log.setLogType(Constants.SYSLOG_SYS);
//		log.setResult(Constants.SYSLOG_RESULT_SUCCESS);
//		request.setAttribute(Constants.LOG_RECORD, log);
//		return CommonUtils.wrapObject("");
		return null;
	}
	
	
}
