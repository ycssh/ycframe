package cn.yc.ssh.admin.base.mybatis.model;

public class OnlineUser {
	private String sessionId;
	private String userName;
	private String host;
	private String loginTime;

	public String getSessionId() {
		return sessionId;
	}

	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getHost() {
		return host;
	}

	public void setHost(String host) {
		this.host = host;
	}

	public String getLoginTime() {
		return loginTime;
	}

	public void setLoginTime(String loginTime) {
		this.loginTime = loginTime;
	}

	public OnlineUser(String sessionId, String userName, String host,
			String loginTime) {
		super();
		this.sessionId = sessionId;
		this.userName = userName;
		this.host = host;
		this.loginTime = loginTime;
	}

	public OnlineUser() {
		super();
	}

	
}
