package cn.yc.ssh.admin.credentials;

import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

import net.sf.ehcache.CacheException;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheManager;
import org.apache.shiro.session.InvalidSessionException;
import org.apache.shiro.session.Session;

import cn.yc.ssh.admin.Constants;
import cn.yc.ssh.admin.base.realm.AES;

/**
 * 连续输入密码错误锁定帐号
 * @author yc
 *
 */
public class RetryLimitHashedCredentialsMatcher extends HashedCredentialsMatcher {

    private Cache<String, AtomicInteger> passwordRetryCache;
    
    private Cache<String, AtomicInteger> ipRetryCache;

    public RetryLimitHashedCredentialsMatcher(CacheManager cacheManager) {
        passwordRetryCache = cacheManager.getCache("passwordRetryCache");
    	ipRetryCache = cacheManager.getCache("ipRetryCache");
    }

    
    public boolean doCredentialsMatch(AuthenticationToken token, AuthenticationInfo info) {
			String ip = SecurityUtils.getSubject().getSession().getHost();
			String username = (String)token.getPrincipal();
			//同一个用户名多次输入密码错误锁定
//			passwordRetryCache.put(username,new AtomicInteger(0));
			AtomicInteger retryCount = passwordRetryCache.get("passwordRetryCount:"+username);
			AtomicInteger ipRetryCount = ipRetryCache.get(ip);
			@SuppressWarnings("unchecked")
			Map<String,String> inits = (Map<String, String>) Constants.cache.get("sys_init");
			String pwdCount = inits.get("pwdCount");
			if(retryCount == null) {
			    retryCount = new AtomicInteger(0);
			    passwordRetryCache.put("passwordRetryCount:"+username, retryCount);
			}
			if(retryCount.incrementAndGet() > Integer.parseInt(pwdCount)) {
				//连续输入密码错误
				throw new ExcessiveAttemptsException();
			}
			if(ipRetryCount == null) {
				ipRetryCount = new AtomicInteger(0);
				ipRetryCache.put(ip, ipRetryCount);
			}
			
			boolean matches = false;
			try {
				Session session = SecurityUtils.getSubject().getSession();
				String password = AES.Decrypt(new String((char[])token.getCredentials()), session.getAttribute("aesKey").toString());
				try {
					SimpleAuthenticationInfo authenticationInfo = (SimpleAuthenticationInfo) info;
					String salt = new String(authenticationInfo.getCredentialsSalt().getBytes());
					password = AES.Encrypt(password,salt.substring(salt.length()-16));
				} catch (Exception e) {
					e.printStackTrace();
				}
				UsernamePasswordToken tokens = new UsernamePasswordToken(token.getPrincipal().toString(), password);
				matches =  super.doCredentialsMatch(tokens, info);
			} catch (InvalidSessionException e) {
				e.printStackTrace();
			} catch (CacheException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
			if(matches) {
			    passwordRetryCache.remove("passwordRetryCount:"+username);
			    ipRetryCache.remove(ip);
			}else{
				ipRetryCount.incrementAndGet();
				ipRetryCache.put(ip, ipRetryCount);
				passwordRetryCache.put("passwordRetryCount:"+username, retryCount);
			}
			return matches;
    }
}