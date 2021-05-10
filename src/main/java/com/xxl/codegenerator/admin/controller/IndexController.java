package com.xxl.codegenerator.admin.controller;

import com.xxl.codegenerator.admin.core.CodeGeneratorTool;
import com.xxl.codegenerator.admin.core.model.ClassInfo;
import com.xxl.codegenerator.admin.core.util.FileUtil;
import com.xxl.codegenerator.admin.model.ReturnT;
import com.xxl.codegenerator.admin.util.FreemarkerTool;
import freemarker.template.TemplateException;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * sso server (for web)
 *
 * @author xuxueli 2017-08-01 21:39:47
 */
@Controller
public class IndexController {
    private static final Logger logger = LoggerFactory.getLogger(IndexController.class);

    public static String folder = System.getProperty("java.io.tmpdir") + File.separator;

    @Resource
    private FreemarkerTool freemarkerTool;

    @RequestMapping("/")
    public String index() {
        return "index";
    }

    @RequestMapping("/zip")
    public String indexzip() {
        return "index_zip";
    }

    @RequestMapping("/codeGenerate")
    @ResponseBody
    public ReturnT<Map<String, String>> codeGenerate(String tableSql,String ppname) {

        try {

            if (StringUtils.isBlank(tableSql)) {
                return new ReturnT<Map<String, String>>(ReturnT.FAIL_CODE, "表结构信息不可为空");
            }

            // parse table
            ClassInfo classInfo = CodeGeneratorTool.processTableIntoClassInfo(tableSql);

            // code genarete
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("classInfo", classInfo);
            params.put("ppname", ppname);
            // result
            Map<String, String> result = new HashMap<String, String>();


            result.put("controller_code", freemarkerTool.processString("xxl-code-generator/controller.ftl", params));
            result.put("service_code", freemarkerTool.processString("xxl-code-generator/service_new.ftl", params));
            result.put("vo_code", freemarkerTool.processString("xxl-code-generator/vo.ftl", params));

            result.put("dao_code", freemarkerTool.processString("xxl-code-generator/dao.ftl", params));
            result.put("mybatis_code", freemarkerTool.processString("xxl-code-generator/mybatis.ftl", params));
            result.put("model_code", freemarkerTool.processString("xxl-code-generator/model.ftl", params));





            // 计算,生成代码行数
            int lineNum = 0;
            for (Map.Entry<String, String> item: result.entrySet()) {
                if (item.getValue() != null) {
                    lineNum += StringUtils.countMatches(item.getValue(), "\n");
                }
            }
            logger.info("生成代码行数：{}", lineNum);

            return new ReturnT<Map<String, String>>(result);
        } catch (IOException | TemplateException e) {
            logger.error(e.getMessage(), e);
            return new ReturnT<Map<String, String>>(ReturnT.FAIL_CODE, "表结构解析失败");
        }

    }
    @RequestMapping("/codeGenerate-swagger")
    @ResponseBody
    public ReturnT<Map<String, String>> codeGenerateswagger(String tableSql,String ppname) {

        try {

            if (StringUtils.isBlank(tableSql)) {
                return new ReturnT<Map<String, String>>(ReturnT.FAIL_CODE, "表结构信息不可为空");
            }

            // parse table
            ClassInfo classInfo = CodeGeneratorTool.processTableIntoClassInfo(tableSql);

            // code genarete
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("classInfo", classInfo);
            params.put("ppname", ppname);
            // result
            Map<String, String> result = new HashMap<String, String>();


//            result.put("controller_code", freemarkerTool.processString("xxl-code-generator-springboot/controller.ftl", params));
//            result.put("service_code", freemarkerTool.processString("xxl-code-generator-springboot/service.ftl", params));
//            result.put("vo_code", freemarkerTool.processString("xxl-code-generator-springboot/vo.ftl", params));
//
//            result.put("dao_code", freemarkerTool.processString("xxl-code-generator-springboot/dao.ftl", params));
//            result.put("mybatis_code", freemarkerTool.processString("xxl-code-generator-springboot/mybatis.ftl", params));
//            result.put("model_code", freemarkerTool.processString("xxl-code-generator-springboot/model.ftl", params));

            result.put("controller_code", freemarkerTool.processString("xxl-code-generator-swagger/controller.ftl", params));
            result.put("service_code", freemarkerTool.processString("xxl-code-generator/service_new.ftl", params));
            result.put("vo_code", freemarkerTool.processString("xxl-code-generator/vo.ftl", params));
            result.put("dto_code", freemarkerTool.processString("xxl-code-generator/dto.ftl", params));
            result.put("dao_code", freemarkerTool.processString("xxl-code-generator/dao.ftl", params));
            result.put("mybatis_code", freemarkerTool.processString("xxl-code-generator/mybatis.ftl", params));
            result.put("model_code", freemarkerTool.processString("xxl-code-generator-swagger/model.ftl", params));



            // 计算,生成代码行数
            int lineNum = 0;
            for (Map.Entry<String, String> item: result.entrySet()) {
                if (item.getValue() != null) {
                    lineNum += StringUtils.countMatches(item.getValue(), "\n");
                }
            }
            logger.info("生成代码行数：{}", lineNum);

            return new ReturnT<Map<String, String>>(result);
        } catch (IOException | TemplateException e) {
            logger.error(e.getMessage(), e);
            return new ReturnT<Map<String, String>>(ReturnT.FAIL_CODE, "表结构解析失败");
        }

    }


    //生产swagger类型的代码文件
    @RequestMapping("/codeGenerate_swagger_zip")
    @ResponseBody
    public ReturnT<String> codeGenerate_swagger_zip(String tableSql,String ppname) {

        try {
            if (StringUtils.isBlank(tableSql)) {
                return new ReturnT<String>(ReturnT.FAIL_CODE, "表结构信息不可为空");
            }
            List<ClassInfo>  classInfos = new ArrayList<>();
            // parse table
            for(String sql:tableSql.split("\\;")){
                if(sql.trim().length()==0){
                    continue;
                }
                ClassInfo classInfo = CodeGeneratorTool.processTableIntoClassInfo(sql);
                classInfos.add(classInfo);
            }
            Long time = System.currentTimeMillis();
            String filename =  time + "-springboot2.zip";
            String filepath = folder + time;
            File fileparent = new File(filepath);
            logger.info("文件路径：" + filepath);
            if(fileparent.exists()){
                FileUtil.deleteRecursively(fileparent);
            }
            fileparent.mkdirs();

            Map<String, Object> params = new HashMap<String, Object>();
            params.put("ppname", ppname);
            final  String  javapath =filepath+ File.separator ;
            File javapathfile = new File(javapath);
            javapathfile.mkdirs();

            for(ClassInfo  classInfo:classInfos){
                params.put("classInfo", classInfo);

                File controllerfile = new File(javapath+File.separator+"controller"+File.separator+classInfo.getClassName()+"Controller.java");
                if(!controllerfile.getParentFile().exists()){
                    controllerfile.getParentFile().mkdirs();
                }
                FileUtil.writeFileContent(controllerfile, freemarkerTool.processString("xxl-code-generator-swagger/controller.ftl", params).getBytes());

                File servicefile = new File(javapath+File.separator+"service"+File.separator+"DBService"+File.separator+classInfo.getClassName()+"Service.java");
                if(!servicefile.getParentFile().exists()){
                    servicefile.getParentFile().mkdirs();
                }
                FileUtil.writeFileContent(servicefile, freemarkerTool.processString("xxl-code-generator/service_new.ftl", params).getBytes());

                File vofile = new File(javapath+File.separator+"dto"+File.separator+"DBVo"+File.separator+classInfo.getOldclassName()+"Vo.java");
                if(!vofile.getParentFile().exists()){
                    vofile.getParentFile().mkdirs();
                }
                FileUtil.writeFileContent(vofile, freemarkerTool.processString("xxl-code-generator/vo.ftl", params).getBytes());

//                File dtofile = new File(javapath+File.separator+"dto"+File.separator+"DBDto"+File.separator+classInfo.getOldclassName()+"Dto.java");
//                if(!dtofile.getParentFile().exists()){
//                    dtofile.getParentFile().mkdirs();
//                }
//                FileUtil.writeFileContent(dtofile, freemarkerTool.processString("xxl-code-generator/dto.ftl", params).getBytes());

                File dtoCreatefile = new File(javapath+File.separator+"dto"+File.separator+"DBDto"+File.separator+classInfo.getOldclassName()+"CreateDto.java");
                if(!dtoCreatefile.getParentFile().exists()){
                    dtoCreatefile.getParentFile().mkdirs();
                }
                FileUtil.writeFileContent(dtoCreatefile, freemarkerTool.processString("xxl-code-generator/dtoCreate.ftl", params).getBytes());

                File dtoUpdatefile = new File(javapath+File.separator+"dto"+File.separator+"DBDto"+File.separator+classInfo.getOldclassName()+"UpdateDto.java");
                if(!dtoUpdatefile.getParentFile().exists()){
                    dtoUpdatefile.getParentFile().mkdirs();
                }
                FileUtil.writeFileContent(dtoUpdatefile, freemarkerTool.processString("xxl-code-generator/dtoUpdate.ftl", params).getBytes());


                File daofile = new File(javapath+File.separator+"dao"+File.separator+classInfo.getClassName()+"Dao.java");
                if(!daofile.getParentFile().exists()){
                    daofile.getParentFile().mkdirs();
                }
                FileUtil.writeFileContent(daofile, freemarkerTool.processString("xxl-code-generator/dao.ftl", params).getBytes());


                File modelfile = new File(javapath+File.separator+"model"+File.separator+classInfo.getClassName()+".java");
                if(!modelfile.getParentFile().exists()){
                    modelfile.getParentFile().mkdirs();
                }
                FileUtil.writeFileContent(modelfile, freemarkerTool.processString("xxl-code-generator-swagger/model.ftl", params).getBytes());

                File mybatisfile = new File(javapath+File.separator+"mybatis"+File.separator+classInfo.getClassName()+".xml");
                if(!mybatisfile.getParentFile().exists()){
                    mybatisfile.getParentFile().mkdirs();
                }
                FileUtil.writeFileContent(mybatisfile, freemarkerTool.processString("xxl-code-generator/mybatis.ftl", params).getBytes());

            }
            FileUtil.compress(filepath,folder+filename);
            return new ReturnT<String>(filename);
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            return new ReturnT<String>(ReturnT.FAIL_CODE, "表结构解析失败");
        }

    }




    @RequestMapping("/codeGenerate_zip")
    @ResponseBody
    public ReturnT<String> codeGenerate_zip(String tableSql,String groupId,String artifactId,String description,String springbootversion) {

        try {
            if (StringUtils.isBlank(tableSql)) {
                return new ReturnT<String>(ReturnT.FAIL_CODE, "表结构信息不可为空");
            }

            List<ClassInfo>  classInfos = new ArrayList<>();
            // parse table
            for(String sql:tableSql.split("\\;")){
                if(sql.trim().length()==0){
                    continue;
                }
                ClassInfo classInfo = CodeGeneratorTool.processTableIntoClassInfo(sql);
                classInfos.add(classInfo);
            }
            //ClassInfo classInfo = CodeGeneratorTool.processTableIntoClassInfo(tableSql);

            artifactId = com.xxl.codegenerator.admin.core.util.StringUtils.underlineToCamelCase(artifactId);
            if (artifactId.contains("_")) {
                artifactId = artifactId.replaceAll("_", "");
            }

            String filename =  artifactId + "-springboot2.zip";
            String filepath = folder+artifactId;
            File fileparent = new File(filepath);
            logger.info("文件路径：" + filepath);
            if(fileparent.exists()){
                FileUtil.deleteRecursively(fileparent);
            }
            fileparent.mkdirs();




            Map<String, Object> params = new HashMap<String, Object>();
            params.put("groupId", groupId);
            params.put("artifactId", artifactId);
            params.put("description", description);
            params.put("springbootversion", springbootversion);
            String artifactIdtmp = artifactId;
            if(artifactId.contains("-")){
                artifactIdtmp = artifactId.split("-")[1];
            }
            params.put("packgage", groupId+"."+artifactIdtmp);
            final  String  javapath =filepath+ File.separator + "src"+ File.separator + "main"+ File.separator + "java" +File.separator+ groupId.replaceAll("\\.","/" )+File.separator+artifactIdtmp;
            File javapathfile = new File(javapath);
            javapathfile.mkdirs();
            javapathfile = new File(javapath+ File.separator + "config");
            javapathfile.mkdirs();
            javapathfile = new File(javapath+ File.separator + "core");
            javapathfile.mkdirs();
            final  String  resoutcespath = filepath+ File.separator + "src"+ File.separator + "main"+ File.separator + "resources";
            File resoutcespathfile = new File(resoutcespath);
            resoutcespathfile.mkdirs();
            resoutcespathfile = new File(resoutcespath + File.separator + "static");
            resoutcespathfile.mkdirs();
            resoutcespathfile = new File(resoutcespath + File.separator + "templates");
            resoutcespathfile.mkdirs();

            File pomfile = new File(filepath+ File.separator + "pom.xml");
            FileUtil.writeFileContent(pomfile, freemarkerTool.processString("xxl-code-generator-springboot/pom.ftl", params).getBytes());
            File SwaggerConfigfile = new File(javapath + File.separator + "config"+File.separator +"SwaggerConfig.java");
            FileUtil.writeFileContent(SwaggerConfigfile, freemarkerTool.processString("xxl-code-generator-springboot/src/main/java/config/SwaggerConfig.java.ftl", params).getBytes());
            File MyExceptionHandlerConfigfile = new File(javapath + File.separator + "config"+File.separator +"MyExceptionHandler.java");
            FileUtil.writeFileContent(MyExceptionHandlerConfigfile, freemarkerTool.processString("xxl-code-generator-springboot/src/main/java/config/MyExceptionHandler.java.ftl", params).getBytes());
            File SignatureInterceptorConfigfile = new File(javapath + File.separator + "config"+File.separator +"SignatureInterceptor.java");
            FileUtil.writeFileContent(SignatureInterceptorConfigfile, freemarkerTool.processString("xxl-code-generator-springboot/src/main/java/config/SignatureInterceptor.java.ftl", params).getBytes());
            File WebMvcConfigConfigfile = new File(javapath + File.separator + "config"+File.separator +"WebMvcConfig.java");
            FileUtil.writeFileContent(WebMvcConfigConfigfile, freemarkerTool.processString("xxl-code-generator-springboot/src/main/java/config/WebMvcConfig.java.ftl", params).getBytes());


            File ReturnTfile = new File(javapath + File.separator + "core"+File.separator + "ReturnT.java");
            FileUtil.writeFileContent(ReturnTfile, freemarkerTool.processString("xxl-code-generator-springboot/src/main/java/core/ReturnT.java.ftl", params).getBytes());
            File MyExceptionfile = new File(javapath + File.separator + "core"+File.separator + "MyException.java");
            FileUtil.writeFileContent(MyExceptionfile, freemarkerTool.processString("xxl-code-generator-springboot/src/main/java/core/MyException.java.ftl", params).getBytes());
            File PageListfile = new File(javapath + File.separator + "core"+File.separator + "PageList.java");
            FileUtil.writeFileContent(PageListfile, freemarkerTool.processString("xxl-code-generator-springboot/src/main/java/core/PageList.java.ftl", params).getBytes());
            File PageQueryfile = new File(javapath + File.separator + "core"+File.separator + "PageQuery.java");
            FileUtil.writeFileContent(PageQueryfile, freemarkerTool.processString("xxl-code-generator-springboot/src/main/java/core/PageQuery.java.ftl", params).getBytes());
            File QueryHeadfile = new File(javapath + File.separator + "core"+File.separator + "QueryHead.java");
            FileUtil.writeFileContent(QueryHeadfile, freemarkerTool.processString("xxl-code-generator-springboot/src/main/java/core/QueryHead.java.ftl", params).getBytes());
            File ReturnTEnumfile = new File(javapath + File.separator + "core"+File.separator + "ReturnTEnum.java");
            FileUtil.writeFileContent(ReturnTEnumfile, freemarkerTool.processString("xxl-code-generator-springboot/src/main/java/core/ReturnTEnum.java.ftl", params).getBytes());

            File TestRequestfile = new File(javapath + File.separator + "dto"+File.separator + "TestRequest.java");
            FileUtil.writeFileContent(TestRequestfile, freemarkerTool.processString("xxl-code-generator-springboot/src/main/java/dto/TestRequest.java.ftl", params).getBytes());

            File JacksonUtilfile = new File(javapath + File.separator + "util"+File.separator + "JacksonUtil.java");
            FileUtil.writeFileContent(JacksonUtilfile, freemarkerTool.processString("xxl-code-generator-springboot/src/main/java/util/JacksonUtil.java.ftl", params).getBytes());
            File LocalCacheUtilfile = new File(javapath + File.separator + "util"+File.separator + "LocalCacheUtil.java");
            FileUtil.writeFileContent(LocalCacheUtilfile, freemarkerTool.processString("xxl-code-generator-springboot/src/main/java/util/LocalCacheUtil.java.ftl", params).getBytes());

            File MainApplicationfile = new File(javapath +File.separator + "MainApplication.java");
            FileUtil.writeFileContent(MainApplicationfile, freemarkerTool.processString("xxl-code-generator-springboot/src/main/java/MainApplication.ftl", params).getBytes());

            File mybatisconfigfile = new File(resoutcespath+ File.separator+"mybatis"+ File.separator + "mybatis-config.xml");
            FileUtil.writeFileContent(mybatisconfigfile, freemarkerTool.processString("xxl-code-generator-springboot/src/main/resources/mybatis/mybatis-config.ftl", params).getBytes());
            File applicationfile = new File(resoutcespath+ File.separator+ "application.properties");
            FileUtil.writeFileContent(applicationfile, freemarkerTool.processString("xxl-code-generator-springboot/src/main/resources/application.properties.ftl", params).getBytes());
            File applicationLocalfile = new File(resoutcespath+ File.separator+ "application-local.properties");
            FileUtil.writeFileContent(applicationLocalfile, freemarkerTool.processString("xxl-code-generator-springboot/src/main/resources/application-local.properties.ftl", params).getBytes());
            File applicationProdfile = new File(resoutcespath+ File.separator+ "application-prod.properties");
            FileUtil.writeFileContent(applicationProdfile, freemarkerTool.processString("xxl-code-generator-springboot/src/main/resources/application-prod.properties.ftl", params).getBytes());

            File sqlfile = new File(resoutcespath+ File.separator + artifactId + ".sql");
            FileUtil.writeFileContent(sqlfile, tableSql.getBytes());

            URL url = IndexController.class.getClassLoader().getResource("templates/xxl-code-generator-springboot/src/main/resources/logback.xml");
            File logbackfile = new File(url.getFile());

            FileUtils.copyFile( logbackfile, new File(resoutcespath+ File.separator+ "logback.xml"));

            File APIcontrollerfile = new File(javapath + File.separator +"controller"+File.separator + "APIController.java");
            FileUtil.writeFileContent(APIcontrollerfile, freemarkerTool.processString("xxl-code-generator-springboot/src/main/java/controller/APIController.java.ftl", params).getBytes());

            for(ClassInfo  classInfo:classInfos){
                params.put("classInfo", classInfo);

                File controllerfile = new File(javapath+File.separator+"controller"+File.separator+classInfo.getClassName()+"Controller.java");
                if(!controllerfile.getParentFile().exists()){
                    controllerfile.getParentFile().mkdirs();
                }
                FileUtil.writeFileContent(controllerfile, freemarkerTool.processString("xxl-code-generator-springboot/src/main/java/controller/controller.ftl", params).getBytes());

                File servicefile = new File(javapath+File.separator+"service"+File.separator+"DBService"+File.separator+classInfo.getClassName()+"Service.java");
                if(!servicefile.getParentFile().exists()){
                    servicefile.getParentFile().mkdirs();
                }
                FileUtil.writeFileContent(servicefile, freemarkerTool.processString("xxl-code-generator-springboot/src/main/java/service/service_new.ftl", params).getBytes());

                File vofile = new File(javapath+File.separator+"dto"+File.separator+"DBVo"+File.separator+classInfo.getOldclassName()+"Vo.java");
                if(!vofile.getParentFile().exists()){
                    vofile.getParentFile().mkdirs();
                }
                FileUtil.writeFileContent(vofile, freemarkerTool.processString("xxl-code-generator-springboot/src/main/java/dto/vo.ftl", params).getBytes());

                File dtofile = new File(javapath+File.separator+"dto"+File.separator+"DBDto"+File.separator+classInfo.getOldclassName()+"Dto.java");
                if(!dtofile.getParentFile().exists()){
                    dtofile.getParentFile().mkdirs();
                }
                FileUtil.writeFileContent(dtofile, freemarkerTool.processString("xxl-code-generator-springboot/src/main/java/dto/dto.ftl", params).getBytes());

                File daofile = new File(javapath+File.separator+"dao"+File.separator+classInfo.getClassName()+"Dao.java");
                if(!daofile.getParentFile().exists()){
                    daofile.getParentFile().mkdirs();
                }
                FileUtil.writeFileContent(daofile, freemarkerTool.processString("xxl-code-generator-springboot/src/main/java/dao/dao.ftl", params).getBytes());

                File modelfile = new File(javapath+File.separator+"model"+File.separator+classInfo.getClassName()+".java");
                if(!modelfile.getParentFile().exists()){
                    modelfile.getParentFile().mkdirs();
                }
                FileUtil.writeFileContent(modelfile, freemarkerTool.processString("xxl-code-generator-springboot/src/main/java/model/model.ftl", params).getBytes());

                File mybatisfile = new File(resoutcespath+File.separator+"mybatis"+File.separator+"mapper"+File.separator+classInfo.getClassName()+".xml");
                if(!mybatisfile.getParentFile().exists()){
                    mybatisfile.getParentFile().mkdirs();
                }
                FileUtil.writeFileContent(mybatisfile, freemarkerTool.processString("xxl-code-generator-springboot/src/main/resources/mybatis/mapper/mybatis.ftl", params).getBytes());
            }


            FileUtil.compress(filepath,folder+filename);
            return new ReturnT<String>(filename);
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            return new ReturnT<String>(ReturnT.FAIL_CODE, "表结构解析失败");
        }

    }


    @GetMapping("/downloadzip")
    public void download(String name, HttpServletRequest request, HttpServletResponse response) {

        try (
                //jdk7新特性，可以直接写到try()括号里面，java会自动关闭
                InputStream inputStream = new FileInputStream(new File(folder, name));
                OutputStream outputStream = response.getOutputStream()
        ) {
            //指明为下载
            response.setContentType("application/x-download");
            String fileName = name;
            response.addHeader("Content-Disposition", "attachment;fileName=" + fileName);   // 设置文件名


            //把输入流copy到输出流
            IOUtils.copy(inputStream, outputStream);

            outputStream.flush();

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}