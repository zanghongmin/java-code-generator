package ${packgage};

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.mybatis.spring.annotation.MapperScan;

@SpringBootApplication
@MapperScan("${packgage}.dao")
public class ${artifactId?cap_first}Application {

    public static void main(String[] args) {
        SpringApplication.run(${artifactId?cap_first}Application.class, args);
    }

}
