package ${packgage}.config;

import ${packgage}.core.ReturnT;
import ${packgage}.core.ReturnTEnum;
import ${packgage}.util.JacksonUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@ControllerAdvice
@Component
public class MyExceptionHandler extends ResponseEntityExceptionHandler implements HandlerExceptionResolver {
    private Logger logger = LoggerFactory.getLogger(getClass());


    /**
     * 参数检验 全局统一处理
     */
    @Override
    protected ResponseEntity<Object> handleBindException(BindException ex, HttpHeaders headers, HttpStatus status, WebRequest request) {
        BindingResult result = ex.getBindingResult();
        String source = request.getParameter("source");
        String timestamp = request.getParameter("timestamp");
        if (result.hasErrors()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new ReturnT(ReturnTEnum.BAD_REQUEST.getCode(), result.getAllErrors().get(0).getDefaultMessage()).setCommonHeader(source, timestamp));
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new ReturnT(ReturnTEnum.BAD_REQUEST, null).setCommonHeader(source, timestamp));
    }

    /**
     * 统一异常处理
     */
    @Override
    public ModelAndView resolveException(HttpServletRequest request,
                                         HttpServletResponse response, Object handler, Exception ex) {
        boolean isJson = false;
        HandlerMethod method = (HandlerMethod) handler;
        String source = request.getParameter("source");
        String timestamp = request.getParameter("timestamp");
        ReturnT errorResult = new ReturnT(ReturnT.FAIL_CODE, ex.getMessage()).setCommonHeader(source, timestamp);
        logger.error("统一异常处理,来源系统:{},时间戳:{},请求URI:{},请求方式:{},是否json:{},异常内容:{}", source, timestamp, request.getRequestURI(), request.getMethod(), isJson, JacksonUtil.writeValueAsString(errorResult));
        try {
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().print(JacksonUtil.writeValueAsString(errorResult));
        } catch (IOException e) {
            logger.error(e.getMessage(), e);
        }
        return null;
    }
}
