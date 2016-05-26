package cn.yc.ssh.common;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class FileUtils {

	public static String saveFile(CommonsMultipartFile impFile) throws Exception {
		
		
		if(impFile!=null&&!impFile.isEmpty()){
			
			String fileName = impFile.getOriginalFilename();
			
			InputStream is = impFile.getInputStream();
			String filePath = PropsUtil.getProperty("UPLOAD_DIR");
			File distFilePath = new File( filePath,String.valueOf(new Date().getTime()));

			if (!distFilePath.exists()) {
				distFilePath.mkdirs();
			}
			File saveFile = new File(distFilePath,
					fileName);
			OutputStream os = new FileOutputStream(saveFile);

			byte[] buff = new byte[1024];

			int len = 0;

			while ((len = is.read(buff)) != -1) {
				os.write(buff, 0, len);
			}

			os.close();
			is.close();
			
			return saveFile.getAbsolutePath();
		}
		
		return null;
	}

}
