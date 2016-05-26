package cn.yc.ssh.test.fdfs;

import java.io.File;

import com.artofsolving.jodconverter.DocumentConverter;
import com.artofsolving.jodconverter.openoffice.connection.OpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.connection.SocketOpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.converter.OpenOfficeDocumentConverter;

public class Pdf2Doc {

	public static void docToPdf() throws Exception {
		OpenOfficeConnection connection = new SocketOpenOfficeConnection(
				"127.0.0.1", 8100);
		try {
			connection.connect();
			DocumentConverter converter = new OpenOfficeDocumentConverter(
					connection);
			File doc = new File("C:/Users/ycssh/Desktop/会议.doc");
			File pdf = new File("C:/Users/ycssh/Desktop/doc2html/会议.pdf");
			converter.convert(doc, pdf);
			connection.disconnect();
			System.out.println("****pdf转换成功，PDF输出：" + pdf.getPath() + "****");
		} catch (java.net.ConnectException e) {
			e.printStackTrace();
			System.out.println("****swf转换器异常，openoffice服务未启动！****");
			throw e;
		} catch (com.artofsolving.jodconverter.openoffice.connection.OpenOfficeException e) {
			e.printStackTrace();
			System.out.println("****swf转换器异常，读取转换文件失败****");
			throw e;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	public static void main(String[] args) {
		try {
			docToPdf();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
