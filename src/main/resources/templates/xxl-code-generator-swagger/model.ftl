<#if packgage??>
package ${packgage}.model;
</#if>
<#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
    <#list classInfo.fieldList as fieldItem >
        <#if fieldItem.fieldClass == "Date">
            <#assign importDdate = true />
        </#if>
    </#list>
</#if>
import java.io.Serializable;
<#if importDdate?? && importDdate>
import java.util.Date;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiParam;
</#if>

/**
*  ${classInfo.classComment}
*
*  Created by zang on '${.now?string('yyyy-MM-dd HH:mm:ss')}'.
*/
@ApiModel(value="${classInfo.classComment}")
public class ${classInfo.className} implements Serializable {
    private static final long serialVersionUID = 42L;

<#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
<#list classInfo.fieldList as fieldItem >

    @ApiParam(name= "${fieldItem.fieldName}", value = "${fieldItem.fieldComment}", defaultValue="",required = false)
    private ${fieldItem.fieldClass} ${fieldItem.fieldName};

</#list>
</#if>

<#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
<#list classInfo.fieldList as fieldItem>
    public ${fieldItem.fieldClass} get${fieldItem.fieldName?cap_first}() {
        return ${fieldItem.fieldName};
    }

    public void set${fieldItem.fieldName?cap_first}(${fieldItem.fieldClass} ${fieldItem.fieldName}) {
        this.${fieldItem.fieldName} = ${fieldItem.fieldName};
    }

</#list>
</#if>
}