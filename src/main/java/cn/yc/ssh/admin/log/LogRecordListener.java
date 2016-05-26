package cn.yc.ssh.admin.log;

import org.springframework.context.ApplicationListener;

public class LogRecordListener implements ApplicationListener<LogRecordEvent> {

	
	public void onApplicationEvent(final LogRecordEvent event) {
//		new Thread(new Runnable() {
//			
//			public void run() {
//				final SysOperLog log = event.getSysOperLog();			
//				if(log.getResult() == null){//若没有添加事件结果，默认为成功 ，即为 1
//					log.setResult(1);
//				}
//				String sql = "INSERT INTO SYSOPER_LOG(DBID,IP,OPERTYPE,OPERTIME,CONTENT,TITLE,USERID,UNAME,logtype,RESULT) "
//						+ "VALUES(SEQ_SYS_OPER_LOG.NEXTVAL,:ip,:operType,:opertime,:content,:title,:userid,:uname,:logType,:result)";
//				//===================end
//				
//				npjt.update(sql, new BeanPropertySqlParameterSource(log));
//			}
//		}).start();
	}
	
	
}
