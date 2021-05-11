package com.xxl.codegenerator.admin.core.model;

/**
 * field info
 *
 * @author xuxueli 2018-05-02 20:11:05
 */
public class FieldInfo {

    private String columnName;
    private String fieldName;
    private String fieldClass;
    private String fieldComment;
    private Boolean columnEmpty;//字符串类型 是否能为null,true的话 该字段可为null
    private Boolean columnNull;//其他类型 是否能为null,true的话 该字段可为null

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public String getFieldName() {
        return fieldName;
    }

    public void setFieldName(String fieldName) {
        this.fieldName = fieldName;
    }

    public String getFieldClass() {
        return fieldClass;
    }

    public void setFieldClass(String fieldClass) {
        this.fieldClass = fieldClass;
    }

    public String getFieldComment() {
        return fieldComment;
    }

    public void setFieldComment(String fieldComment) {
        this.fieldComment = fieldComment;
    }

    public Boolean getColumnEmpty() {
        return columnEmpty;
    }

    public void setColumnEmpty(Boolean columnEmpty) {
        this.columnEmpty = columnEmpty;
    }

    public Boolean getColumnNull() {
        return columnNull;
    }

    public void setColumnNull(Boolean columnNull) {
        this.columnNull = columnNull;
    }
}
