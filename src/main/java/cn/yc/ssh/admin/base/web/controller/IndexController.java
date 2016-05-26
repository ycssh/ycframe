package cn.yc.ssh.admin.base.web.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.yc.ssh.admin.Constants;
import cn.yc.ssh.admin.base.mybatis.model.Resource;
import cn.yc.ssh.admin.base.mybatis.model.Resource.ResourceType;
import cn.yc.ssh.admin.base.mybatis.model.User;
import cn.yc.ssh.admin.base.service.UserService;
import cn.yc.ssh.admin.base.web.bind.annotation.CurrentUser;

@Controller
public class IndexController {

    @Autowired
    private UserService userService;
    
    @RequestMapping("/console")
    public String index(@CurrentUser User loginUser, Model model) {
        return "admin/index";
    }
    
    @RequestMapping(value={"/index","/"})
    public String index2(Model model) {
    	@SuppressWarnings("unchecked")
		Map<String,String> inits = (Map<String, String>) Constants.cache.get("sys_init");
    	Session session = SecurityUtils.getSubject().getSession();
    	User user = (User) session.getAttribute(Constants.CURRENT_USER);
    	session.setAttribute("isFirstLogin", "0");
    	session.setAttribute("pwdValidTime", "0");
    	if(user.getCreateTime().getTime() != user.getUpdateTime().getTime())
    	{
    		session.setAttribute("isFirstLogin", "1");
    	}
    	long day = Long.parseLong(inits.get("pwdValidTime"));
    	if((new Date().getTime()-user.getUpdateTime().getTime())/1000 / 60 / 60 / 24 < day)
    	{
    		session.setAttribute("pwdValidTime", "1");
    	}
    	
    	//用于主页显示用户名称
    	session.setAttribute("userRealNameForIndexPage", user.getName());
    	
        return "admin/index2";
    }
    
    @RequestMapping("layout/menus")
    public @ResponseBody List<Resource> resources(@CurrentUser User loginUser) {
    	List<Resource> resources = userService.findResByUse(loginUser.getId());
    	for(int i=resources.size()-1;i>=0;i--){
    		if(ResourceType.button.equals(resources.get(i).getType())){
    			resources.remove(i);
    		}
    	}
    	return resources;
    }
    

    @RequestMapping("/welcome")
    public String welcome() {
       // return "project";
    	return "project/welcome";
    }


    @SuppressWarnings("rawtypes")
	@RequestMapping("/index/findRTS")
    public @ResponseBody Map findRTS(){
    	
    	return null;
    }
    
    @SuppressWarnings("rawtypes")
	@RequestMapping("/index/findGZL")
    public @ResponseBody Map findGZL(){
    	
    	return null;
    }
}
