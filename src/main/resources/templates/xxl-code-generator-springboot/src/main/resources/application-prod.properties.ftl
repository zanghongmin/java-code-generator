#数据库配置
spring.datasource.url=jdbc:mysql://localhost:3306/test?serverTimezone=UTC&useUnicode=true&characterEncoding=utf-8&useSSL=true
spring.datasource.username=root
spring.datasource.password=123456
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver


#logback自定义配置
mylogback.pattern = %d{yyyy-MM-dd HH:mm:ss} [%thread] %-5level %logger{36} - %msg%n
mylogback.rootlevel = INFO
mylogback.console.level = INFO
mylogback.file.fileNamePattern = /data/logs/${artifactId}/${artifactId}.%d{yyyy-MM-dd}.log
mylogback.file.MaxFileSize = 100MB
mylogback.file.MaxHistory = 60
mylogback.file.level = INFO