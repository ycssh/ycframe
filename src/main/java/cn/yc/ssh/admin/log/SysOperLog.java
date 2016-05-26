package cn.yc.ssh.admin.log;

import java.util.Date;

public class SysOperLog {
	private Long dbId;
	// 登录IP
	private String ip;
	// 操作时间
	private Date opertime = new Date();
	// 操作内容
	private String content;
	// 操作内容标题
	private String title;
	// 操作人ID
	private String userid;
	// 操作人姓名
	private String uname;
	// 操作类型
	private Integer operType;
	
	private Integer logType;
	
	//事件结果 0：失败 1:成功
	private Integer result;

	public Long getDbId() {
		return dbId;
	}

	public void setDbId(Long dbId) {
		this.dbId = dbId;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public Date getOpertime() {
		return opertime;
	}

	public void setOpertime(Date opertime) {
		this.opertime = opertime;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getUname() {
		return uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}

	public Integer getOperType() {
		return operType;
	}

	public void setOperType(Integer operType) {
		this.operType = operType;
	}

	public Integer getLogType() {
		return logType;
	}

	public void setLogType(Integer logType) {
		this.logType = logType;
	}
	

	public Integer getResult() {
		return result;
	}

	public void setResult(Integer result) {
		this.result = result;
	}

	public SysOperLog(String content, String title, Integer operType) {
		super();
		this.content = content;
		this.title = title;
		this.operType = operType;
	}

	public SysOperLog() {

	}
}
