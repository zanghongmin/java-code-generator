server.port=8080

mybatis.config-location=classpath:mybatis/mybatis-config.xml
mybatis.mapper-locations=classpath:mybatis/mapper/*.xml
mybatis.type-aliases-package=${packgage}.model


#时间对象Date转JSON时格式化
spring.jackson.date-format=yyyy-MM-dd HH:mm:ss
spring.jackson.time-zone=GMT+8
spring.jackson.serialization.write-dates-as-timestamps=false


spring.profiles.active=local


