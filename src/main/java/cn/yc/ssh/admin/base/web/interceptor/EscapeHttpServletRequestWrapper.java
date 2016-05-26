package cn.yc.ssh.admin.base.web.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.apache.commons.lang.StringEscapeUtils;
import org.springframework.web.util.HtmlUtils;

public class EscapeHttpServletRequestWrapper extends HttpServletRequestWrapper {

	public EscapeHttpServletRequestWrapper(HttpServletRequest servletRequest) {
		super(servletRequest);
	}

	public String[] getParameterValues(String parameter) {
		String[] values = super.getParameterValues(parameter);
		if (values == null) {
			return null;
		}
		int count = values.length;
		String[] encodedValues = new String[count];
		for (int i = 0; i < count; i++) {
			encodedValues[i] = escape(values[i]);;
		}
		return encodedValues;

	}

	public String getParameter(String parameter) {
		String value = super.getParameter(parameter);
		if (value == null) {
			return null;
		}
		return escape(value);

	}

	public String getHeader(String name) {
		String value = super.getHeader(name);
		if (value == null)
			return null;
		return escape(value);
	}
	
	public String escape(String value){
		value = StringEscapeUtils.escapeSql(value);
		value =  HtmlUtils.htmlEscapeHex(value).replaceAll("&#x26;", "&");
		return value;
	}
}