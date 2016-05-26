package cn.yc.ssh.admin.base.web.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import cn.yc.ssh.admin.Constants;
import cn.yc.ssh.admin.base.mybatis.model.Resource;
import cn.yc.ssh.admin.base.mybatis.model.User;
import cn.yc.ssh.admin.base.service.ResourceService;
import cn.yc.ssh.admin.base.service.RoleService;
import cn.yc.ssh.admin.base.service.UserService;
import cn.yc.ssh.common.CommonUtils;

@Controller
@RequestMapping("/resource")
public class ResourceController {

    @Autowired
    private ResourceService resourceService;
    
	@Autowired
	private RoleService roleService;

    @ModelAttribute("types")
    public Resource.ResourceType[] resourceTypes() {
        return Resource.ResourceType.values();
    }

    @RequestMapping(value="index", method = RequestMethod.GET)
    @RequiresPermissions("admin:resource:view")
    public String index(Model model) {
        return "resource/index";
    }
    
    @RequiresPermissions("admin:resource:view")
    @RequestMapping(value="list", method = RequestMethod.GET)
    public @ResponseBody List<Resource> list(Model model) {
        return resourceService.findAll();
    }
    

    @RequestMapping(value="tree", method = RequestMethod.GET)
    public @ResponseBody List<Resource> tree() {
		return resourceService.findAll();
    }

    @RequiresPermissions("admin:resource:create")
    @RequestMapping(value = "/add/{parentId}", method = RequestMethod.GET)
    public String showAppendChildForm(@PathVariable("parentId") Long parentId, Model model) {
        Resource child = new Resource();
        child.setParentId(parentId);
        model.addAttribute("resource", child);
        return "resource/edit";
    }
    
    @RequiresPermissions("admin:resource:create")
    @RequestMapping(value = "/addRoot", method = RequestMethod.GET)
    public String showAddRoot(Model model) {
    	Resource child = new Resource();
    	child.setParentId((long) 0);
        model.addAttribute("resource", child);
        return "resource/edit";
    }

    @RequiresPermissions("admin:resource:create")
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public @ResponseBody String save(Resource resource, RedirectAttributes redirectAttributes) {
    	
    	if(resource.getId()!=null){
    		resourceService.updateResource(resource);
            return "修改成功";
    	}else{
    		resourceService.createResource(resource);
            return "新增子节点成功";
    	}
    }

    @RequiresPermissions("admin:resource:create")
    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public String showUpdateForm(@PathVariable("id") Long id, Model model) {
        model.addAttribute("resource", resourceService.findOne(id));
        return "resource/edit";
    }

    @RequiresPermissions("admin:resource:delete")
    @RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
    public @ResponseBody String delete(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        resourceService.deleteResource(id);
        return "删除成功";
    }
    
    @RequiresPermissions("admin:resource:delete")
    @RequestMapping(value = "/remove", method = RequestMethod.POST)
    public @ResponseBody Map<String,Object> remove(String ids) {
        resourceService.removeByIds(ids);
        return CommonUtils.wrapObject("");
    }
    
    @RequestMapping(value = "/uploadPic/{id}")
    public String uploadPicPage(@PathVariable("id") Long id, Model model) {
        model.addAttribute("resId", id);
        return "resource/uploadPic";
    }

    @SuppressWarnings("rawtypes")
	@RequestMapping("/uploadPic/upload")
    public @ResponseBody Map uploadPic(@RequestParam CommonsMultipartFile impFile,Long id){
    	return null;
//    	try {
//			String fileName = FileUtils.saveFile(impFile);
//			Resource r = resourceService.findOne(id);
//			r.setPicName(fileName);
//			
//			resourceService.updatePic(r);
//			return CommonUtils.wrapObject("");
//		} catch (Exception e) {
//			
//			e.printStackTrace();
//			return CommonUtils.wrapError("出错了");
//		}
    }
    
    @RequestMapping("/uploadPic/showPic")
	public void readFile(Long resId,HttpServletResponse response){
//		
//		String fileFullName = resourceService.findOne(resId).getPicName();
//		File f = new File(fileFullName);
//		
//		String fileName = fileFullName.substring(fileFullName.lastIndexOf("\\")+1);
//		try {
//			
//			response.reset();
//			// 设置response的Header
//			response.addHeader("Content-Disposition", "attachment;filename="
//					+ new String(fileName.getBytes("utf-8"), "ISO-8859-1"));
//			response.addHeader("Content-Length", "" + f.length());
//			response.setContentType("application/octet-stream");
//			
//			InputStream is = new FileInputStream(f);
//			
//			byte[] buff = new byte[1024];
//			int len = 0;
//			
//			OutputStream os = new BufferedOutputStream(response.getOutputStream());
//			while((len = is.read(buff))!=-1){
//				os.write(buff, 0, len);
//			}
//			os.flush();
//			is.close();
//			os.close();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
	}

}
