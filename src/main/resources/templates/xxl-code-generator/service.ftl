<#if ppname??>
package ${ppname}.service;
</#if>
import java.util.Map;

/**
* ${classInfo.classComment}
*
* Created by zang on '${.now?string('yyyy-MM-dd HH:mm:ss')}'.
*/
public interface ${classInfo.className}Service {

    /**
    * 新增
    */
    public ReturnT<String> insert(${classInfo.className} ${classInfo.className?uncap_first});

    /**
    * 删除
    */
    public ReturnT<String> delete(${classInfo.primaryKeyfieldClass} ${classInfo.primaryKeyfieldName?uncap_first});

    /**
    * 更新
    */
    public ReturnT<String> update(${classInfo.className} ${classInfo.className?uncap_first});

    /**
    * Load查询
    */
    public ${classInfo.className} load(${classInfo.primaryKeyfieldClass} ${classInfo.primaryKeyfieldName?uncap_first});

    /**
    * 分页查询
    */
    public Map<String,Object> pageList(int offset, int pagesize);

}
