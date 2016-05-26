package cn.yc.ssh.admin.log;


public class SysOperTotalLog {
	// 操作内容标题
	private String title;
	// 操作人ID
	private Integer operType;

	private String operTime;
	
	private Integer logType;

	public String getTitle() {
		return title;
	}

	public Integer getOperType() {
		return operType;
	}

	public Integer getLogType() {
		return logType;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getOperTime() {
		return operTime;
	}

	public void setOperTime(String operTime) {
		this.operTime = operTime;
	}

	public void setOperType(Integer operType) {
		this.operType = operType;
	}

	public void setLogType(Integer logType) {
		this.logType = logType;
	}

}
