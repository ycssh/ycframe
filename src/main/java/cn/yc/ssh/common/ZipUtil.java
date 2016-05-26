package cn.yc.ssh.common;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.zip.CRC32;
import java.util.zip.CheckedOutputStream;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.tools.ant.Project;
import org.apache.tools.ant.taskdefs.Zip;
import org.apache.tools.ant.types.FileSet;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipOutputStream;

public class ZipUtil {
	private static final Log logger = LogFactory.getLog(ZipUtil.class); 
	static final int BUFFER = 8192;  
	  
    private File zipFile;  
  
    public ZipUtil(String pathName) {  
        zipFile = new File(pathName);  
    }  
    public ZipUtil(){
    	
    }
    public static void  mkdirs(String filepath){
    	File file = new File(filepath);  
    	if(!file.exists()){
    		file.mkdirs();
    	}
    }
    public void compress(OutputStream os,String srcPathName,boolean flag) {  
        File file = new File(srcPathName);  
        if (!file.exists())  {
        	logger.error(srcPathName + "不存在！");
        	throw new RuntimeException(srcPathName + "不存在！");  
        }
        	
        try {  
           // FileOutputStream fileOutputStream = new FileOutputStream(zipFile);  
            CheckedOutputStream cos = new CheckedOutputStream(os,  
                    new CRC32());  
            ZipOutputStream out = new ZipOutputStream(cos);  
            String basedir = "";  
            compress(file, out, basedir); 
            out.flush();
            out.close();  
            if(flag){
            	this.delFile(srcPathName);
            }
        } catch (Exception e) {  
            throw new RuntimeException(e);  
        }  
    }  
    public void compress(String srcPathName,boolean flag) {  
        File file = new File(srcPathName);  
        if (!file.exists())  {
        	logger.error(srcPathName + "不存在！");
        	throw new RuntimeException(srcPathName + "不存在！");  
        }
        	
        try {  
            FileOutputStream fileOutputStream = new FileOutputStream(zipFile);  
            CheckedOutputStream cos = new CheckedOutputStream(fileOutputStream,  
                    new CRC32());  
            ZipOutputStream out = new ZipOutputStream(cos);  
            String basedir = "";  
            compress(file, out, basedir); 
            out.flush();
            out.close(); 
            if(flag){
            	this.delFile(srcPathName);
            }
        } catch (Exception e) {  
            throw new RuntimeException(e);  
        }  
    }  
  
    private void compress(File file, ZipOutputStream out, String basedir) {  
        /* 判断是目录还是文件 */  
        if (file.isDirectory()) {  
            this.compressDirectory(file, out, basedir);  
        } else {  
            logger.info("压缩：" + basedir + file.getName());  
            this.compressFile(file, out, basedir);  
        }  
    }  
  
    /** 压缩一个目录 */  
    private void compressDirectory(File dir, ZipOutputStream out, String basedir) {  
        if (!dir.exists()) { 
            return;  
         }
        File[] files = dir.listFiles();  
        for (int i = 0; i < files.length; i++) {  
            /* 递归 */  
            compress(files[i], out, basedir + dir.getName() + "/");  
        }  
    }  
  
    /** 压缩一个文件 */  
    private void compressFile(File file, ZipOutputStream out, String basedir) {  
        if (!file.exists()) {  
            return;  
        }  
        try { 
        	out.setEncoding("GBK");
            BufferedInputStream bis = new BufferedInputStream(  
                    new FileInputStream(file));  
            ZipEntry entry = new ZipEntry(basedir + file.getName());  
            out.putNextEntry(entry);  
            int count;  
            byte data[] = new byte[BUFFER];  
            while ((count = bis.read(data, 0, BUFFER)) != -1) {  
                out.write(data, 0, count);  
            }  
            bis.close();  
        } catch (Exception e) {  
            throw new RuntimeException(e);  
        }  
    }
    public void compressByAnt(String srcPathName) {  
        File srcdir = new File(srcPathName);  
        if (!srcdir.exists())  
            throw new RuntimeException(srcPathName + "不存在！");  
          
        Project prj = new Project();  
        Zip zip = new Zip();  
        zip.setProject(prj);  
        zip.setDestFile(zipFile);  
        FileSet fileSet = new FileSet();  
        fileSet.setProject(prj);  
        fileSet.setDir(srcdir);  
        //fileSet.setIncludes("**/*.java"); 包括哪些文件或文件夹 eg:zip.setIncludes("*.java");  
        //fileSet.setExcludes(...); 排除哪些文件或文件夹  
        zip.addFileset(fileSet);  
          
        zip.execute();  
    }  
    public void delFile(String fpath){
    	File file = new File(fpath);
    	if(file.isDirectory()){
    		File[] files = file.listFiles();
    		if(files.length>0){
    			for(int i=0;i<files.length;i++){
    				delFile(files[i].getPath());
    			}
    		}
    	}
    		file.delete();
    }
    public static void main(String[] args) {  
    	/* ZipUtil zc = new  ZipUtil("d:\\你好.zip");  
        zc.compress("d:\\upload");  
          
        ZipUtil zc1 = new  ZipUtil("d:\\你好2.zip");   
        zc1.compressByAnt("d:\\upload");  */
        ZipUtil zc2 = new ZipUtil();
        zc2.delFile("D:\\pxgl_xls_doc_report\\doc\\结业登记表");
    }  
}
