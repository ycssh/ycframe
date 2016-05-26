package cn.yc.ssh.test.fdfs;

import org.csource.common.NameValuePair;
import org.csource.fastdfs.ClientGlobal;
import org.csource.fastdfs.StorageClient1;
import org.csource.fastdfs.StorageServer;
import org.csource.fastdfs.TrackerClient;
import org.csource.fastdfs.TrackerServer;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/fdfs")
public class UploadController {

	@RequestMapping(value = "/index")
	public String goupload(){
		return "fdfs/index";
	}
	
	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	@ResponseBody
	public void upload(@RequestParam MultipartFile file) {
		try {
			String tempFileName = file.getOriginalFilename();
			// fastDFS方式
			ClassPathResource cpr = new ClassPathResource("fdfs_client.conf");
			ClientGlobal.init(cpr.getClassLoader().getResource("fdfs_client.conf").getPath());
			byte[] fileBuff = file.getBytes();
			String fileId = "";
			String fileExtName = tempFileName.substring(tempFileName.lastIndexOf("."));
			// 建立连接
			TrackerClient tracker = new TrackerClient();
			TrackerServer trackerServer = tracker.getConnection();
			StorageServer storageServer = null;
			StorageClient1 client = new StorageClient1(trackerServer,storageServer);
			// 设置元信息
			NameValuePair[] metaList = new NameValuePair[3];
			metaList[0] = new NameValuePair("fileName", tempFileName);
			metaList[1] = new NameValuePair("fileExtName", fileExtName);
			metaList[2] = new NameValuePair("fileLength", String.valueOf(file.getSize()));
			// 上传文件
			fileId = client.upload_file1(fileBuff, fileExtName, metaList);
			System.out.println(fileId);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
