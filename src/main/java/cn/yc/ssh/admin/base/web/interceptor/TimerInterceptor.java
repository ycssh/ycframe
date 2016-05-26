package cn.yc.ssh.admin.base.web.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.util.StopWatch;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * @author 作者姓名 yc E-mail: ycssh2@163.com
 * @version 创建时间：2014-5-13 上午10:49:14 类说明
 */
public class TimerInterceptor extends HandlerInterceptorAdapter {
	private static final Log log = LogFactory.getLog(TimerInterceptor.class);

	private static ThreadLocal<StopWatch> stopWatchLocal = null;

	
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		request.setCharacterEncoding("UTF-8");
		if (stopWatchLocal == null) {
			stopWatchLocal = new ThreadLocal<StopWatch>();
		}
		StopWatch stopWatch = new StopWatch(handler.toString());
		stopWatchLocal.set(stopWatch);
		stopWatch.start(handler.toString());
		boolean a = super.preHandle(request, response, handler);
		return a;
	}

	
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		StopWatch stopWatch = stopWatchLocal.get();
		stopWatch.stop();
		String currentPath = request.getRequestURI();
		String queryString = request.getQueryString();
		queryString = queryString == null ? "" : "?" + queryString;
//		log.info("time:" + stopWatch.getTotalTimeMillis()
//				+ "-----access url path:" + currentPath + queryString);
		stopWatchLocal.set(null);
		super.afterCompletion(request, response, handler, ex);
	}
}
