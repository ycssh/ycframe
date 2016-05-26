package cn.yc.ssh.admin.log;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

public class LogRecorder implements ApplicationContextAware {
	private ApplicationContext ctx;

	
	public void setApplicationContext(ApplicationContext ctx)
			throws BeansException {
		this.ctx = ctx;
	}

	public void saveRecord(SysOperLog log) {
		LogRecordEvent event = new LogRecordEvent(this.ctx, log);
		ctx.publishEvent(event);
	}
}
