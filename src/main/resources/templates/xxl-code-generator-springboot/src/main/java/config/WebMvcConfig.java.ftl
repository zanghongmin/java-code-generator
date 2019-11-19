package ${packgage}.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import javax.annotation.Resource;


/**
 * web mvc config
 */
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Resource
    private SignatureInterceptor signatureInterceptor;


    /**
     * 添加自定义拦截器
     *  1.给对外提供api接口，增加签名检验
     * @param registry
     */
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
           registry.addInterceptor(signatureInterceptor).addPathPatterns("/api/**");
    }

    /**
     * swagger-ui 页面可以加载和显示
     * @param registry
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("swagger-ui.html").addResourceLocations("classpath:/META-INF/resources/");
        registry.addResourceHandler("/webjars/**").addResourceLocations("classpath:/META-INF/resources/webjars/");
    }
}