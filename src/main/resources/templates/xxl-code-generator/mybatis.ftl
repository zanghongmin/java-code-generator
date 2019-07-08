<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="Dao路径.${classInfo.className}Dao">

    <resultMap id="${classInfo.className}" type="model路径.${classInfo.className}">
    <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
    <#list classInfo.fieldList as fieldItem >
        <result column="${fieldItem.columnName}" property="${fieldItem.fieldName}"/>
    </#list>
    </#if>
    </resultMap>

    <sql id="Base_Column_List">
    <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
    <#list classInfo.fieldList as fieldItem >
        `${fieldItem.columnName}`<#if fieldItem_has_next>,</#if>
    </#list>
    </#if>
    </sql>

    <sql id="condition">
        <if test="${classInfo.className?uncap_first}  != null">
            <trim prefix="where" prefixOverrides="and">
<#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
<#list classInfo.fieldList as fieldItem >
<if test="${classInfo.className?uncap_first}.${fieldItem.fieldName} != null">
    and `${fieldItem.columnName}` = ${r"#{"}${classInfo.className?uncap_first}.${fieldItem.fieldName}${r"}"}
</if>
</#list>
</#if>
            </trim>
        </if>
    </sql>


    <insert id="insert" parameterType="java.util.Map"  keyProperty="${classInfo.className?uncap_first}.${classInfo.primaryKeycolumnName}"  useGeneratedKeys="true">
        INSERT INTO ${classInfo.tableName}
        <trim prefix="(" suffix=")" suffixOverrides=",">
        <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
            <#list classInfo.fieldList as fieldItem >
                <#if fieldItem.columnName != "${classInfo.primaryKeycolumnName}" >
                    <if test="${classInfo.className?uncap_first}.${fieldItem.fieldName} != null">
                        `${fieldItem.columnName}` ,
                    </if>
                </#if>
            </#list>
        </#if>
        </trim>
        <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
            <trim prefix="values (" suffix=")" suffixOverrides=",">
            <#list classInfo.fieldList as fieldItem >
                <#if fieldItem.columnName != "${classInfo.primaryKeycolumnName}" >
                      <if test="${classInfo.className?uncap_first}.${fieldItem.fieldName} != null">
                          ${r"#{"}${classInfo.className?uncap_first}.${fieldItem.fieldName}${r"}"} ,
                      </if>
                </#if>
            </#list>
            </trim>
        </#if>
    </insert>

    <delete id="delete" parameterType="java.util.Map">
        DELETE FROM ${classInfo.tableName}
        WHERE `${classInfo.primaryKeycolumnName}` = ${r"#{"}${classInfo.primaryKeyfieldName?uncap_first}${r"}"}
    </delete>

    <update id="update" parameterType="java.util.Map">
        UPDATE ${classInfo.tableName}
        <trim prefix="SET" suffixOverrides=",">
           <#list classInfo.fieldList as fieldItem >
            <#if fieldItem.columnName != "${classInfo.primaryKeycolumnName}">
                  <if test="${classInfo.className?uncap_first}.${fieldItem.fieldName} != null">
                      `${fieldItem.columnName}` =  ${r"#{"}${classInfo.className?uncap_first}.${fieldItem.fieldName}${r"}"},
                  </if>
            </#if>
           </#list>
        </trim>
        WHERE `${classInfo.primaryKeycolumnName}` = ${r"#{"}${classInfo.className?uncap_first}.${classInfo.primaryKeyfieldName?uncap_first}${r"}"}
    </update>


    <select id="load" parameterType="java.util.Map" resultMap="${classInfo.className}">
        SELECT
        <include refid="Base_Column_List"/>
        FROM ${classInfo.tableName}
        WHERE `${classInfo.primaryKeycolumnName}` = ${r"#{"}${classInfo.primaryKeyfieldName?uncap_first}${r"}"}
    </select>

    <select id="pageList" parameterType="java.util.Map" resultMap="${classInfo.className}">
        SELECT
        <include refid="Base_Column_List"/>
        FROM ${classInfo.tableName}
        <include refid="condition" />
        LIMIT ${r"#{offset}"}, ${r"#{pagesize}"}
    </select>

    <select id="pageListCount" parameterType="java.util.Map" resultType="int">
        SELECT count(1)
        FROM ${classInfo.tableName}
        <include refid="condition" />
    </select>

</mapper>
