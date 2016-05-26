package cn.yc.ssh.admin.base.web.interceptor;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class CsrfFilter implements Filter {
		
		public void init(FilterConfig filterConfig) throws ServletException {
		
		}
		
		public void doFilter(ServletRequest request, ServletResponse response,
				FilterChain chain) throws IOException, ServletException{
			// 强制类型转换 HttpServletRequest
			HttpServletRequest httpReq = (HttpServletRequest)request;
			// 构造HttpRequestWrapper对象处理XSS
		     boolean flag =  validateRequest(httpReq);
		     if(flag==false){
		    	 try {
					throw new Exception();
				} catch (Exception e) {
					response.getOutputStream().println("<h1>Request Error!</h1>");
				}
		     }
		     chain.doFilter(httpReq, response);
			

		}

		public void destroy() {
			
		}
		 /**
	     * 验证请求的合法性，防止跨域攻击
	     * 
	     * @param request
	     * @return
	     */
	    public static boolean validateRequest(HttpServletRequest request) {
	        String referer = "";
	        boolean referer_sign = true; // true 站内提交，验证通过 //false 站外提交，验证失败
	        referer = request.getHeader("Referer"); 
	        // 判断是否存在请求页面
	        if ((null!=referer)&&(!"".equals(referer))){//如果是手动输入的url,则不做拦截
	        
	            // 判断请求页面和getRequestURI是否相同
	            String servername_str = request.getServerName();
	            
	            //当通过pxgl管理 跳转到运行监控时 不进行过滤
	            if(servername_str.indexOf("sgcc")>0 || servername_str.indexOf("10")>=0){
	            	return true;
	            }
	            
	            
	            if ((null!=servername_str)&&(!"".equals(servername_str))) {
	                int index = 0;
	                if (referer.indexOf("https://") == 0) {
	                    index = 8;
	                }
	                else if (referer.indexOf( "http://") == 0) {
	                    index = 7;
	                }
	                if (referer.length() - index < servername_str.length()) {// 长度不够
	                    referer_sign = false;
	                }
	                else { // 比较字符串（主机名称）是否相同
	                    String referer_str = referer.substring(index, index + servername_str.length());
	                    if (!servername_str.equalsIgnoreCase(referer_str)) referer_sign = false;
	                }
	            }
	            else referer_sign = false;
	        
	    }
	    
	        return referer_sign;
	    }

}

