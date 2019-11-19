package ${packgage}.config;

//import ${packgage}.dao.SourceDODao;
//import ${packgage}.model.SourceDO;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.util.*;

@Component
public class SignatureInterceptor implements HandlerInterceptor {
	private static final Logger logger = LoggerFactory.getLogger(SignatureInterceptor.class);
	private final static String PARAM_SIG = "signature";
    //@Resource
    //private SourceDODao sourceDODao;
    @Resource
    ObjectMapper objectMapper;

    @Value("${r"${"}spring.profiles.active${r"}"}")
    String profiles;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String requestUri = request.getRequestURI();
        String requestMethod = request.getMethod();
        String source = request.getParameter("source");
        String transeq = request.getParameter("transeq");
        //SourceDO sourceDO = sourceDODao.loadBySource(source);
        //if(sourceDO==null ){
        //    sendJsonMessage(response, new ReturnT(ReturnT.FAIL_CODE,"source来源系统不对").setCommonHeader(source,transeq));
        //    return false;
        //}
        String ip = getIpAddr(request);
        //if(ip==null || sourceDO.getIps()==null || !Arrays.asList(sourceDO.getIps().split(",")).contains(ip)){
        //    sendJsonMessage(response, new ReturnT(ReturnT.FAIL_CODE,"请求ip不在白名单 ip："+ip).setCommonHeader(source,transeq));
        //    return false;
        //}
        //if(!checkSign(getParams(request), sourceDO.getSecretkey())){
        //    if(!profiles.equals("prod") && request.getParameter("signature").equals("123456")) {
        //        logger.info("测试环境签名校验,来源系统:{},请求流水号:{},请求URI:{},请求方式:{},请求参数:{},ip:{}",source,transeq, requestUri, requestMethod,getAllRequestParam(request),ip);
        //    }else{
        //        logger.info("签名校验失败,来源系统:{},请求流水号:{},请求URI:{},请求方式:{},请求参数:{},ip:{}",source,transeq, requestUri, requestMethod,getAllRequestParam(request),ip);
        //        sendJsonMessage(response, new ReturnT(ReturnT.FAIL_CODE,"签名校验失败").setCommonHeader(source,transeq));
        //        return false;
        //    }
        //}
        logger.info("请求成功,来源系统:{},请求流水号:{},请求URI:{},请求方式:{},请求参数:{},ip:{}",source,transeq, requestUri, requestMethod,getAllRequestParam(request),ip);
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

    private String getIpAddr(HttpServletRequest request) {
        String ip = request.getRemoteAddr();
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("x-forwarded-for");
        }
        return ip;
    }
    //验签
    private Boolean checkSign(Map<String, Object> requestMap, String signKey) {
        String sign = (String)requestMap.get(PARAM_SIG);
        requestMap.remove(PARAM_SIG);
        String signContext = getSignContent(requestMap);
        if (!sign.toUpperCase().equals(sign)) {
            logger.error("签名大小写不匹配");
            return false;
        } else {
            logger.info("平台签名字符串：" + signContext);
            String md5 = md5(signContext+signKey, "utf-8");
            String upperCase = md5.toUpperCase();
            if (!sign.equals(upperCase)) {
                logger.error("签名不匹配");
                return false;
            }
        }
        return true;
    }
    //签名内容
    public static String getSignContent(Map<String, Object> sortedParams) {
        StringBuffer content = new StringBuffer();
        List<String> keys = new ArrayList<String>(sortedParams.keySet());
        Collections.sort(keys);
        int index = 0;
        for (int i = 0; i < keys.size(); i++) {
            String key = keys.get(i);
            if(sortedParams.get(key)==null||sortedParams.get(key).equals("")) continue;
            String value = sortedParams.get(key) + "";
            content.append((index++ == 0 ? "" : "&") + key + "=" + value);
        }
        return content.toString();
    }
    //md5
    public static String md5(String encryString, String Charset)
    {
        try
        {
            MessageDigest digest = MessageDigest.getInstance("MD5");
            digest.update(encryString.getBytes(Charset));
            byte b[] = digest.digest();
            int i;
            StringBuffer buf = new StringBuffer("");
            for (int offset = 0; offset < b.length; offset++)
            {
                i = b[offset];
                if (i < 0)
                    i += 256;
                if (i < 16)
                    buf.append("0");
                buf.append(Integer.toHexString(i));
            }
            digest = null;
            b = null;
            return buf.toString();
        }
        catch (Exception e)
        {
            e.printStackTrace();
            return null;
        }
    }

    //获取请求参数
    private   Map<String,Object> getParams(HttpServletRequest request) {
        Map<String,Object> map = new HashMap<String,Object>();
        Enumeration paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String paramName = (String) paramNames.nextElement();
            String[] paramValues = request.getParameterValues(paramName);
            if (paramValues.length >0) {
                String paramValue = paramValues[0];
                if (paramValue.length() != 0) {
                    map.put(paramName, paramValue);
                }
            }
        }
        return map;
    }

}
