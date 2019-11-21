#数据库配置
spring.datasource.url=jdbc:mysql://localhost:3306/test?serverTimezone=UTC&useUnicode=true&characterEncoding=utf-8&useSSL=true
spring.datasource.username=root
spring.datasource.password=123456
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver


#logback配置
logback.axlife.pattern = %d{yyyy-MM-dd HH:mm:ss} [%thread] %-5level %logger{36} - %msg%n
logback.axlife.rootlevel = info
logback.axlife.console.level = info
logback.axlife.file.fileNamePattern = /data/logs/${artifactId}/${artifactId}.%d{yyyy-MM-dd}.log
logback.axlife.file.MaxFileSize = 100MB
logback.axlife.file.MaxHistory = 60
logback.axlife.file.level = info