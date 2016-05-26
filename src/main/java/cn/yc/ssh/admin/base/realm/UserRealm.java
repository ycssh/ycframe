package cn.yc.ssh.admin.base.realm;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.concurrent.atomic.AtomicInteger;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheManager;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import cn.yc.ssh.admin.Constants;
import cn.yc.ssh.admin.base.mybatis.model.Resource;
import cn.yc.ssh.admin.base.mybatis.model.Role;
import cn.yc.ssh.admin.base.mybatis.model.User;
import cn.yc.ssh.admin.base.service.UserService;
import cn.yc.ssh.admin.base.web.exception.MaliciousLoginException;

public class UserRealm extends AuthorizingRealm {

    @Autowired
    private UserService userService;
    private Cache<String, AtomicInteger> ipRetryCache;
    
    public UserRealm(CacheManager cacheManager) {
    	ipRetryCache = cacheManager.getCache("ipRetryCache");
    }

    /**
     * 获取用户权限和角色，配置了权限的地方自动检测，来查询用户角色
     */
    @SuppressWarnings("unchecked")
	
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        Subject subject = SecurityUtils.getSubject();
        Session session = subject.getSession();
        User user = (User) session.getAttribute(Constants.CURRENT_USER);
        Set<String> sroles = new HashSet<String>();
        Set<String> permissions = new HashSet<String>();
        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
        if(session.getAttribute("stringRoles")==null){
            List<Role> roles = userService.findRolesByUse(user.getId());
            for(Role role:roles){
            	sroles.add(String.valueOf(role.getRole()));
            }
            session.setAttribute("stringRoles", sroles);
        }else{
        	sroles = (Set<String>) session.getAttribute("stringRoles");
        }
        if(session.getAttribute("stringPermissions")==null){
            List<Resource> resources = userService.findResByUse(user.getId());
            for(Resource resource:resources){
            	permissions.add(String.valueOf(resource.getPermission()));
            }
            session.setAttribute("stringPermissions", permissions);
        }else{
        	permissions = (Set<String>) session.getAttribute("stringPermissions");
        }
        authorizationInfo.setRoles(sroles);
        authorizationInfo.setStringPermissions(permissions);
        return authorizationInfo;
    }

    
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
    	String ip = SecurityUtils.getSubject().getSession().getHost();
        String username = (String)token.getPrincipal();

        AtomicInteger ipRetryCount = ipRetryCache.get(ip);
        if(ipRetryCount == null) {
        	ipRetryCount = new AtomicInteger(0);
    		ipRetryCache.put(ip, ipRetryCount);
        }
        if(ipRetryCount.incrementAndGet() > 10){
			throw new MaliciousLoginException();
        }
        User user = userService.findByUsername(username);
        if(user == null) {
            ipRetryCount.incrementAndGet();
            ipRetryCache.put(ip, ipRetryCount);
            throw new UnknownAccountException();//没找到帐号
        }
        if(user.getLocked()!=0) {
            throw new LockedAccountException(); //帐号锁定
        }
        //交给AuthenticatingRealm使用CredentialsMatcher进行密码匹配,也可以自定义实现
        SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(
                user.getUsername(), //用户名
                user.getPassword(), //密码
                ByteSource.Util.bytes(user.getCredentialsSalt()),//salt=username+salt
                getName()  //realm name
        );
        return authenticationInfo;
    }

    
    public void clearCachedAuthorizationInfo(PrincipalCollection principals) {
        super.clearCachedAuthorizationInfo(principals);
    }

    
    public void clearCachedAuthenticationInfo(PrincipalCollection principals) {
        super.clearCachedAuthenticationInfo(principals);
    }

    
    public void clearCache(PrincipalCollection principals) {
        super.clearCache(principals);
    }

    public void clearAllCachedAuthorizationInfo() {
        getAuthorizationCache().clear();
    }

    public void clearAllCachedAuthenticationInfo() {
        getAuthenticationCache().clear();
    }

    public void clearAllCache() {
        clearAllCachedAuthenticationInfo();
        clearAllCachedAuthorizationInfo();
    }

}