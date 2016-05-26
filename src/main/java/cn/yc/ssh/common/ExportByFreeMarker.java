package cn.yc.ssh.common;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import freemarker.template.Configuration;
import freemarker.template.Template;

public class ExportByFreeMarker {
	private static Log log = LogFactory.getLog(ExportByFreeMarker.class);
	//模板名称
	private String ftlName;
	//输出文件名称
	private String outFileName;
	//文件生成时使用
	private String filePath;
	//输入数据[存放的数据Key值要与模板中的参数相对应]
	private Map<String,?> data;
	
	private String suffix = ".doc";
	private String ftlPath = "/ftl/word";
	/**
	 * 导出word
	 * @param request
	 * @param response
	 */
	public  void exportToWord(HttpServletRequest request, HttpServletResponse response){
		this.suffix = ".doc";
		this.ftlPath = "/ftl/word";
		this.exportToPage(request, response);
	}
	/**
	 * 导出excel
	 * @param request
	 * @param response
	 */
	public  void exportToExcel(HttpServletRequest request, HttpServletResponse response){
		this.suffix = ".xls";
		this.ftlPath = "/ftl/excel";
		this.exportToPage(request, response);
	}
	/**
	 * 导出到页面中
	 * @param request
	 * @param response
	 */
	private void exportToPage(HttpServletRequest request, HttpServletResponse response){
		try {
			Template t = getCfg();
			response.setContentType("text/html;charset=UTF-8");
			request.setCharacterEncoding("UTF-8");
			String contentType = "application/octet-stream";
			response.setContentType(contentType);
			response.setHeader("Content-disposition", "attachment; filename="+new String(this.getOutFileName().getBytes("gbk"),"iso8859-1"));
			Writer writer = response.getWriter();	
			t.process(this.getData(), writer);
			writer.flush();
			writer.close();
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
	}
	public void exportToPageWithZip(HttpServletRequest request, HttpServletResponse response){
		this.suffix = ".zip";
		try {
			response.setContentType("text/html;charset=UTF-8");
			request.setCharacterEncoding("UTF-8");
			String contentType = "application/octet-stream";
			response.setContentType(contentType);
			response.setHeader("Content-disposition", "attachment; filename="+new String(this.getOutFileName().getBytes("gbk"),"iso8859-1"));
			OutputStream writer = response.getOutputStream();	
			ZipUtil zu = new ZipUtil();
			zu.compress(writer, this.getFilePath(),true);
			writer.flush();
			writer.close();
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);		
		}
	}
	/**
	 * 导出到文件中
	 * @param path
	 */
	public void exportToFile(String path,String suffix){
		if("doc".equalsIgnoreCase(suffix)){
			this.suffix = ".doc";
			this.ftlPath = "/ftl/word";
		}else if("xls".equalsIgnoreCase(suffix)){
			this.suffix = ".xls";
			this.ftlPath = "/ftl/excel";
		}
		try {
			this.filePath = PropsUtil.getProperty("MX_XLS_DOC_FILEPATH")+File.separator+suffix+File.separator+path;
			Template template = this.getCfg();
			File dir = new File(this.filePath);
			if(!dir.exists()){
				dir.mkdirs();
			}
			File outFile = new File(this.filePath,this.getOutFileName());
			Writer out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(outFile),"utf-8"));
			template.process(this.getData(), out);
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
	}
	public static void main(String[] args) {
		//导出word
		ExportByFreeMarker ebf = new ExportByFreeMarker();
		ebf.setFtlName("test.ftl");
		ebf.setOutFileName("学员结业登记表.xl");
		Map<String,String> dataMap = new HashMap<String,String>();
		dataMap.put("name", "张三");
		dataMap.put("sex", "男");
		dataMap.put("company", "微软公司");
		dataMap.put("idcard", "340589198009089987");
		dataMap.put("no", "2013103001");
		dataMap.put("birthday", "20131030");
		dataMap.put("nation", "汉族");
		dataMap.put("edu", "山东大学");
		dataMap.put("degree", "本科");
		dataMap.put("zzmm", "中共党员");
		dataMap.put("college", "北京大学");
		dataMap.put("graduation","2010-06");
		ebf.setData(dataMap);
		ebf.exportToFile("D:/","doc");
		
		//导出Excel
		ExportByFreeMarker ebf2 = new ExportByFreeMarker();
		ebf2.setFtlName("unelectricity.ftl");
		ebf2.setOutFileName("非电专业.xl");
		Map<String,String> dataMap2 = new HashMap<String,String>();
		dataMap2.put("no", "1");
		dataMap2.put("company", "微软公司");
		dataMap2.put("major", "非电专业");
		dataMap2.put("place", "泰山");
		dataMap2.put("gendor", "男");
		dataMap2.put("name", "");
		dataMap2.put("age", "26");
		dataMap2.put("nation", "汉族");
		dataMap2.put("political", "共青团员");
		dataMap2.put("education", "本科");
		dataMap2.put("degree", "本科");
		dataMap2.put("graduateCollege", "北京大学");
		ebf2.setData(dataMap2);
		ebf2.exportToFile("D:/","xls");
		
	}
	private Template getCfg() throws IOException {
		this.setOutFileName(this.getOutFileName());
		Configuration cfg = new Configuration();
		cfg.setClassForTemplateLoading(this.getClass(),this.ftlPath);
		cfg.setClassicCompatible(true);
		Template t = cfg.getTemplate(this.getFtlName(), "utf-8");
		return t;
	}
	private String addSuffixToFile(String fileName){
		int index = fileName.lastIndexOf(".");
		return fileName.substring(0,index>0?index:fileName.length())+this.suffix;
	}
	public String getFtlName() {
		return ftlName;
	}

	public void setFtlName(String ftlName) {
		this.ftlName = ftlName;
	}

	

	

	public String getOutFileName() {
		return this.addSuffixToFile(outFileName);
	}

	public void setOutFileName(String outFileName) {
		this.outFileName = outFileName;
	}

	public Map<String, ?> getData() {
		return data;
	}

	public void setData(Map<String, ?> data) {
		this.data = data;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
}
