package cn.yc.ssh.admin.credentials;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;

import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authc.credential.SimpleCredentialsMatcher;

/** 
 * 自定义 密码验证类 
 * @author q 
 * 
 */  
public class CustomCredentialsMatcher extends SimpleCredentialsMatcher {  
       
        public boolean doCredentialsMatch(AuthenticationToken authcToken, AuthenticationInfo info) {  
            UsernamePasswordToken token = (UsernamePasswordToken) authcToken;  
            Object accountCredentials = getCredentials(info);  
            //将密码加密与系统加密后的密码校验，内容一致就返回true,不一致就返回false 
            boolean matches = false;
            try {
            	matches = Md5encyptUtil.validPassword(String.valueOf(token.getPassword()), accountCredentials.toString());
			} catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
            return matches;  
        }  
}