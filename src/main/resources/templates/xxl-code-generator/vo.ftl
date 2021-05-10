<#if ppname??>
package ${ppname}.dto.DBVo;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
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
</#if>
/**
*  ${classInfo.classComment}
*  Created by zang on '${.now?string('yyyy-MM-dd HH:mm:ss')}'.
*/
@ApiModel(value="${classInfo.classComment}")
@Data
public class ${classInfo.oldclassName}Vo {
<#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
    <#list classInfo.fieldList as fieldItem >
        <#if fieldItem.columnName != "create_time" && fieldItem.columnName != "update_time">
    @ApiModelProperty(name= "${fieldItem.fieldName}", value = "${fieldItem.fieldComment}", example="",required = false)
    private ${fieldItem.fieldClass} ${fieldItem.fieldName};
        </#if>
    </#list>
</#if>
}