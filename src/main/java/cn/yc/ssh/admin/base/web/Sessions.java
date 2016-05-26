package cn.yc.ssh.admin.base.web;

import org.apache.shiro.SecurityUtils;

import cn.yc.ssh.admin.Constants;
import cn.yc.ssh.admin.base.mybatis.model.User;

public class Sessions {
	public User getUser() {
		return (User) SecurityUtils.getSubject().getSession().getAttribute(Constants.CURRENT_USER);
	}
	public String getIP(){
		return SecurityUtils.getSubject().getSession().getHost();
	}
}
