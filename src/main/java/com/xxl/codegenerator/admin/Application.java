package com.xxl.codegenerator.admin;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

import java.io.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * @author xuxueli 2018-03-22 23:41:47
 */
@SpringBootApplication
public class Application extends SpringBootServletInitializer {

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(Application.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    static class ZipOutputStreamDemo {
        private File file;
        private File zipFile;
        private InputStream input;
        private ZipOutputStream zipOut;

        //构造函数
        public ZipOutputStreamDemo(File file) throws FileNotFoundException {
            this.file = file;
            this.zipFile = new File (file.getAbsolutePath()+".zip");
            InputStream input = null;
            this.zipOut = new ZipOutputStream(new FileOutputStream(zipFile));
        }

        //实现对文件（夹）的压缩
        public  void compressFile (File directory) throws IOException {
            if (directory != null) {
                if (directory.isDirectory()) {
                    File [] f = directory.listFiles();
                    if (f!=null) {
                        //目录里面文件数为0，即空目录，此时在压缩包中相对路径下创建一个空目录
                        if (f.length==0) {
                            this.zipOut.putNextEntry(new ZipEntry (this.getPath(directory)+File.separator));
                        }
                        //递归调用compressFile函数，找出所有的文件
                        else {
                            for (int i=0;i<f.length;i++) {
                                compressFile (f[i]);
                            }
                        }
                    }
                }
                //对找出的文件进行压缩处理
                else {
                    System.out.println(directory);
                    this.input = new FileInputStream (directory);
                    this.zipOut.putNextEntry(new ZipEntry(this.getPath(directory)));
                    int temp = 0;
                    while ((temp=input.read())!=-1) {
                        this.zipOut.write(temp);
                    }
                    this.input.close();

                }
            }
        }

        //获得该文件在压缩包中的相对路径
        public String getPath (File f) {
            String str1 = this.file.getAbsolutePath();
            int n1= str1.length();
            String str2 = f.getAbsolutePath();
            int n2= str2.length();
            String str3 = this.file.getName();
            int n3= str3.length();
            String str = str2.substring(n1-n3, n2);
            return str;
        }
    }


}