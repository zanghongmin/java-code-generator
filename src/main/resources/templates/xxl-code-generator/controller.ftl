<#if packgage??>
package ${packgage}.controller;
</#if>
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
* ${classInfo.classComment}
*
* Created by 开发3处 on '${.now?string('yyyy-MM-dd HH:mm:ss')}'.
*/
@Controller
public class ${classInfo.className}Controller {

    @Resource
    private ${classInfo.className}Service ${classInfo.className?uncap_first}Service;

    /**
    * 新增
    */
    @RequestMapping("/insert")
    @ResponseBody
    public ReturnT<String> insert(${classInfo.className} ${classInfo.className?uncap_first}){
        return ${classInfo.className?uncap_first}Service.insert(${classInfo.className?uncap_first});
    }

    /**
    * 删除
    */
    @RequestMapping("/delete")
    @ResponseBody
    public ReturnT<String> delete(${classInfo.primaryKeyfieldClass} ${classInfo.primaryKeyfieldName?uncap_first}){
        return ${classInfo.className?uncap_first}Service.delete(${classInfo.primaryKeyfieldName?uncap_first});
    }

    /**
    * 更新
    */
    @RequestMapping("/update")
    @ResponseBody
    public ReturnT<String> update(${classInfo.className} ${classInfo.className?uncap_first}){
        return ${classInfo.className?uncap_first}Service.update(${classInfo.className?uncap_first});
    }

    /**
    * Load查询
    */
    @RequestMapping("/load")
    @ResponseBody
    public ReturnT<${classInfo.className}>  load(${classInfo.primaryKeyfieldClass} ${classInfo.primaryKeyfieldName?uncap_first}){
        return new ReturnT(${classInfo.className?uncap_first}Service.load(${classInfo.primaryKeyfieldName?uncap_first}));
    }

    /**
    * 分页查询
    */
    @RequestMapping("/pageList")
    @ResponseBody
    public Map<String, Object> pageList(@RequestParam(required = false, defaultValue = "0") int offset,
                                        @RequestParam(required = false, defaultValue = "10") int pagesize) {
        return ${classInfo.className?uncap_first}Service.pageList(offset, pagesize);
    }

}
