<#if packgage??>
package ${packgage}.controller;
</#if>
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;
import ${packgage}.core.ReturnT;
import ${packgage}.core.PageList;
import ${packgage}.model.${classInfo.className};
import ${packgage}.service.${classInfo.className}Service;
/**
* ${classInfo.classComment}
*
* Created by zang on '${.now?string('yyyy-MM-dd HH:mm:ss')}'.
*/
@Api(value = "${classInfo.classComment}", description = "${classInfo.classComment}")
@Controller
@RequestMapping("/${classInfo.className}")
public class ${classInfo.className}Controller {

    @Resource
    private ${classInfo.className}Service ${classInfo.className?uncap_first}Service;

    /**
    * 新增
    */
    @ApiOperation(value = "新增${classInfo.classComment}")
    @PostMapping("/insert")
    @ResponseBody
    public ReturnT<String> insert(@ModelAttribute  ${classInfo.className} ${classInfo.className?uncap_first}){
    return ${classInfo.className?uncap_first}Service.insert(${classInfo.className?uncap_first});
    }

    /**
    * 删除
    */
    @ApiOperation(value = "删除${classInfo.classComment}")
    @PostMapping("/delete")
    @ResponseBody
    public ReturnT<String> delete(${classInfo.primaryKeyfieldClass} ${classInfo.primaryKeyfieldName?uncap_first}){
        return ${classInfo.className?uncap_first}Service.delete(${classInfo.primaryKeyfieldName?uncap_first});
        }

        /**
        * 更新
        */
        @ApiOperation(value = "更新${classInfo.classComment}")
        @PostMapping("/update")
        @ResponseBody
        public ReturnT<String> update(@ModelAttribute  ${classInfo.className} ${classInfo.className?uncap_first}){
            return ${classInfo.className?uncap_first}Service.update(${classInfo.className?uncap_first});
            }

            /**
            * Load查询
            */
            @ApiOperation(value = "查询${classInfo.classComment}")
            @PostMapping("/load")
            @ResponseBody
            public ReturnT<${classInfo.className}>  load(${classInfo.primaryKeyfieldClass} ${classInfo.primaryKeyfieldName?uncap_first}){
            return new ReturnT(${classInfo.className?uncap_first}Service.load(${classInfo.primaryKeyfieldName?uncap_first}));
            }

            /**
            * 分页查询
            * pagenum为第几页，1为第一页
            * pagesize为页大小
            */
            @ApiOperation(value = "分页查询${classInfo.classComment}")
            @PostMapping("/pageList")
            @ResponseBody
            public ReturnT<PageList<${classInfo.className}>> pageList(@RequestParam(required = false, defaultValue = "1") int pagenum,
            @RequestParam(required = false, defaultValue = "20") int pagesize) {
            return ${classInfo.className?uncap_first}Service.pageList(pagenum, pagesize);
            }

            }

