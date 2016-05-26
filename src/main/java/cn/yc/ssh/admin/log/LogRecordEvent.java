package cn.yc.ssh.admin.log;

import org.springframework.context.ApplicationContext;
import org.springframework.context.event.ApplicationContextEvent;

public class LogRecordEvent extends ApplicationContextEvent {
	/**
	 * 
	 */
	private static final long serialVersionUID = 5225074810706843782L;
	private SysOperLog sysOperLog;

	public LogRecordEvent(ApplicationContext source, SysOperLog sysOperLog) {
		super(source);
		this.sysOperLog = sysOperLog;
	}

	public SysOperLog getSysOperLog() {
		return sysOperLog;
	}
}
