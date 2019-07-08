package ${packgage}.config;

import ${packgage}.core.ReturnT;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.Enumeration;

@Component
public class SignatureInterceptor implements HandlerInterceptor {
	private static final Logger logger = LoggerFactory.getLogger(SignatureInterceptor.class);
	private final static String PARAM_SIG = "signature";

    @Resource
    ObjectMapper objectMapper;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String requestUri = request.getRequestURI();
        String requestMethod = request.getMethod();
        String source = request.getParameter("source");
        String timestamp = request.getParameter("timestamp");
        logger.info("签名校验成功,来源系统:{},时间戳:{},请求URI:{},请求方式:{},请求参数:{}",source,timestamp, requestUri, requestMethod,getAllRequestParam(request));
        String signature = request.getParameter("signature");
		return true;
	}


    /**
     *  返回请求的内容，Json格式
     * @param response
     * @param obj
     * @throws Exception
     */
    public  void sendJsonMessage(HttpServletResponse response, Object obj) throws Exception {

        response.setContentType("application/json; charset=utf-8");
        PrintWriter writer = response.getWriter();
//        ObjectMapper objectMapper = new ObjectMapper();
//        objectMapper.getSerializerProvider().setNullValueSerializer(new JsonSerializer<Object>() {
//            @Override
//            public void serialize(Object o, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException, JsonProcessingException {
//                jsonGenerator.writeString("");
//            }
//        });
        writer.print(objectMapper.writeValueAsString(obj));
        writer.close();
        response.flushBuffer();
    }

    /**
     * 把request内容转化成字符串
     * @param request
     * @return
     */
    private String getAllRequestParam(final HttpServletRequest request) {
        StringBuilder sb = new StringBuilder();
        Enumeration<?> temp = request.getParameterNames();
        if (null != temp) {
            while (temp.hasMoreElements()) {
                String key = (String) temp.nextElement();
                String value = request.getParameter(key);
                sb.append(key+"="+value+"&");
            }
            if(sb.length()>0){
                return sb.substring(0,sb.length()-1);
            }
        }
        return sb.toString();
    }
}
