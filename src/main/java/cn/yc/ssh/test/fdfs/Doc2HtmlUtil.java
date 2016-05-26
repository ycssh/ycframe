package cn.yc.ssh.test.fdfs;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.ConnectException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.artofsolving.jodconverter.DocumentConverter;
import com.artofsolving.jodconverter.openoffice.connection.OpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.connection.SocketOpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.converter.OpenOfficeDocumentConverter;

/**
 * 利用jodconverter(基于OpenOffice服务)将word文件(*.doc)转化为html格式，
 * 使用前请检查OpenOffice服务是否已经开启, OpenOffice进程名称：soffice.exe | soffice.bin
 * 
 * @author linshutao
 * */
public class Doc2HtmlUtil {

	/**
	 * 执行前，请启动openoffice服务 进入$OO_HOME\program下 执行soffice -headless
	 * -accept="socket,host=127.0.0.1,port=8100;urp;" -nofirststartwizard
	 * 
	 * @param xlsfile
	 * @param targetfile
	 * @throws Exception
	 */
	public String doc2Html(InputStream fromFileInputStream, File toFileFolder) {
		String soffice_host = "127.0.0.1";
		String soffice_port = "8100";

		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String timesuffix = sdf.format(date);
		String htmFileName = "htmlfile" + timesuffix + ".html";
		String docFileName = "docfile" + timesuffix + ".doc";

		File htmlOutputFile = new File(toFileFolder.toString()
				+ File.separatorChar + htmFileName);
		File docInputFile = new File(toFileFolder.toString()
				+ File.separatorChar + docFileName);
		/**
		 * 由fromFileInputStream构建输入文件
		 * */
		try {
			OutputStream os = new FileOutputStream(docInputFile);
			int bytesRead = 0;
			byte[] buffer = new byte[1024 * 8];
			while ((bytesRead = fromFileInputStream.read(buffer)) != -1) {
				os.write(buffer, 0, bytesRead);
			}

			os.close();
			fromFileInputStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

		OpenOfficeConnection connection = new SocketOpenOfficeConnection(
				soffice_host, Integer.parseInt(soffice_port));
		try {
			connection.connect();
		} catch (ConnectException e) {
			System.err.println("文件转换出错，请检查OpenOffice服务是否启动。");
			e.printStackTrace();
		}
		// convert
		DocumentConverter converter = new OpenOfficeDocumentConverter(
				connection);
		converter.convert(docInputFile, htmlOutputFile);
		connection.disconnect();

		// 转换完之后删除word文件
//		docInputFile.delete();
		return htmFileName;
	}

	public static void main(String[] args) {
		try {
			InputStream is = new FileInputStream(new File(
					"C:/Users/ycssh/Desktop/会议.doc"));
			File toFileFolder = new File("C:/Users/ycssh/Desktop/doc2html");
			Doc2HtmlUtil doc2HtmlUtil = new Doc2HtmlUtil();
			doc2HtmlUtil.doc2Html(is, toFileFolder);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
	}
}