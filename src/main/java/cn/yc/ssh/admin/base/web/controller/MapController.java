package cn.yc.ssh.admin.base.web.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/indexMap")
public class MapController {
	
	@RequestMapping("/index")
	public String index( ){
		return "indexMap/map";
	}
	@RequiresPermissions("indexMap:index2")
	@RequestMapping("/index2")
	public String index2( ){
		return "indexMap/map2";
	}
	
}
