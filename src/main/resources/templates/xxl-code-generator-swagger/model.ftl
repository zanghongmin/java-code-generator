<#if ppname??>
package ${ppname}.model;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
</#if>
<#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
    <#list classInfo.fieldList as fieldItem >
        <#if fieldItem.fieldClass == "Date">
            <#assign importDdate = true />
        </#if>
    </#list>
</#if>
<#if importDdate?? && importDdate>
import java.util.Date;

</#if>

/**
*  ${classInfo.classComment}
*
*  Created by zang on '${.now?string('yyyy-MM-dd HH:mm:ss')}'.
*/
@ApiModel(value="${classInfo.className}",description = "${classInfo.classComment}")
@Data
public class ${classInfo.className}{

<#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
<#list classInfo.fieldList as fieldItem >


    <#if fieldItem.columnName == "create_time" || fieldItem.columnName == "update_time">
    @JsonIgnore
    </#if>
    @ApiModelProperty(name= "${fieldItem.fieldName}", value = "${fieldItem.fieldComment}", example="",required = false)
    private ${fieldItem.fieldClass} ${fieldItem.fieldName};

</#list>
</#if>

<#--<#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>-->
<#--<#list classInfo.fieldList as fieldItem>-->
    <#--public ${fieldItem.fieldClass} get${fieldItem.fieldName?cap_first}() {-->
        <#--return ${fieldItem.fieldName};-->
    <#--}-->

    <#--public void set${fieldItem.fieldName?cap_first}(${fieldItem.fieldClass} ${fieldItem.fieldName}) {-->
        <#--this.${fieldItem.fieldName} = ${fieldItem.fieldName};-->
    <#--}-->

<#--</#list>-->
<#--</#if>-->
}