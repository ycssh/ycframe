package cn.yc.ssh.admin.base.web.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import cn.yc.ssh.admin.Constants;
import cn.yc.ssh.admin.base.mybatis.model.Organization;
import cn.yc.ssh.admin.base.service.OrganizationService;
import cn.yc.ssh.admin.base.util.PageResult;
import cn.yc.ssh.admin.base.util.Pagination;
import cn.yc.ssh.admin.log.SysOperLog;
import cn.yc.ssh.common.CommonUtils;

import com.github.pagehelper.Page;

@Controller
@RequestMapping("/organization")
public class OrganizationController {

	@Autowired
	private OrganizationService organizationService;

	@RequestMapping(value = "index", method = RequestMethod.GET)
	@RequiresPermissions("organization:index")
	public String index(Model model) {
		return "organization/index";
	}

	@RequestMapping(value = "/list")
	@RequiresPermissions("organization:index")
	public @ResponseBody
	PageResult<Organization> list(Organization organization, Pagination page,Long pId) {
		return PageResult.toPage( organizationService.findByPID(pId,page));
	}

	@RequestMapping(value = "/ajaxtree")
	@RequiresPermissions("organization:ajaxtree")
	public @ResponseBody
	List<Organization> showAjaxTree(Model model, HttpServletRequest request) {
		String pid = request.getParameter("id");
		Long parentId = 0L;
		if (StringUtils.hasLength(pid)) {
			parentId = Long.parseLong(pid);
		}
		List<Organization> list = new ArrayList<Organization>();
		list = organizationService.findByParent(parentId);
//		if(parentId==0){
//			list.add(new Organization(0L,"根组织"));
//		}
		if (parentId == 0) {
			if(list==null||list.size()==0){
				return list;
			}
			Organization organization = list.get(0);
			list.addAll(organizationService.findByParent(organization.getId()));
		}
		return list;
	}

	@RequestMapping(value = "/add/{parentId}", method = RequestMethod.GET)
	@RequiresPermissions("organization:index")
	public String showAppendChildForm(@PathVariable("parentId") Long parentId,
			Model model) {
		Organization child = new Organization();
		child.setParentId(parentId);
		model.addAttribute("organization", child);
		return "organization/edit";
	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	@RequiresPermissions("organization:index")
	public 
	void create(Organization organization,HttpServletResponse response,HttpServletRequest request) throws IOException {
		SysOperLog log = new SysOperLog();
		if (organization.getId() != null) {
			log.setContent("编辑部门"+organization.getName());
			log.setOperType(1);
			log.setTitle("编辑部门");
			organizationService.updateOrganization(organization);
		} else {
			log.setContent("新增部门"+organization.getName());
			log.setOperType(Constants.SYSLOG_EDIT);
			log.setTitle("新增部门");
			organizationService.createOrganization(organization);
		}
		log.setLogType(Constants.SYSLOG_SYS);
		log.setResult(Constants.SYSLOG_RESULT_SUCCESS);
		request.setAttribute(Constants.LOG_RECORD, log);
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print("{\"success\":true,\"obj\":\"\"}");
		out.flush();
	}

	@RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
	@RequiresPermissions("organization:index")
	public String showMaintainForm(@PathVariable("id") Long id, Model model) {
		model.addAttribute("organization", organizationService.findOne(id));
		return "organization/edit";
	}

	@RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
	@RequiresPermissions("organization:index")
	public @ResponseBody
	Map<String,Object> delete(@PathVariable("id") Long id,
			RedirectAttributes redirectAttributes,HttpServletRequest request) {
		organizationService.deleteOrganization(id);
		SysOperLog log = new SysOperLog();
		log.setContent("删除部门:"+id);
		log.setOperType(Constants.SYSLOG_DELETE);
		log.setTitle("删除部门");
		log.setLogType(Constants.SYSLOG_SYS);
		log.setResult(Constants.SYSLOG_RESULT_SUCCESS);
		request.setAttribute(Constants.LOG_RECORD, log);
		return CommonUtils.wrapObject("");
	}

}
