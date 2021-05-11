<#if ppname??>
package ${ppname}.dto.DBDto;
import ${ppname}.core.QueryHead;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
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
*  Created by zang on '${.now?string('yyyy-MM-dd HH:mm:ss')}'.
*/
@ApiModel(value="${classInfo.className}CreateDto",description = "${classInfo.classComment}新建请求类")
@Data
public class ${classInfo.oldclassName}CreateDto extends QueryHead {
<#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
    <#list classInfo.fieldList as fieldItem >
        <#if fieldItem.columnName != "create_time" && fieldItem.columnName != "update_time" && fieldItem.columnName != "id">
        @ApiModelProperty(name= "${fieldItem.fieldName}", value = "${fieldItem.fieldComment}", example="",required = false)
            <#if fieldItem.columnName != "ctime">
                <#if !fieldItem.columnEmpty>
        @NotEmpty(message = "${fieldItem.fieldComment}不能为空")
                </#if>
                <#if !fieldItem.columnNull>
        @NotNull(message = "${fieldItem.fieldComment}不能为空")
                </#if>
            </#if>
        private ${fieldItem.fieldClass} ${fieldItem.fieldName};
        </#if>
    </#list>
</#if>
}