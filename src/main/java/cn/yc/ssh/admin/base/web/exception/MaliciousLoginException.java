package cn.yc.ssh.admin.base.web.exception;

import org.apache.shiro.authc.AccountException;

/**
 * 恶意登录
 * @author ycssh
 *
 */
public class MaliciousLoginException extends AccountException {
	/**
	 * 
	 */
	private static final long serialVersionUID = -5581461930102745684L;

	public MaliciousLoginException(String message){
		super(message);
	}
	public MaliciousLoginException(String message, Throwable cause) {
		super(message, cause);
	}

	public MaliciousLoginException() {
		super();
	}

	public MaliciousLoginException(Throwable cause) {
		super(cause);
	}
}
