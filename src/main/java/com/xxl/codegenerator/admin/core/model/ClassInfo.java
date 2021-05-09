package com.xxl.codegenerator.admin.core.model;

import java.util.List;

/**
 * class info
 *
 * @author xuxueli 2018-05-02 20:02:34
 */
public class ClassInfo {

    private String tableName;
	private String oldclassName;
    private String className;
	private String classComment;
	private String primaryKeycolumnName;
	private String primaryKeyfieldName;
	private String primaryKeyfieldClass;


	private List<FieldInfo> fieldList;

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getOldclassName() {
		return oldclassName;
	}

	public void setOldclassName(String oldclassName) {
		this.oldclassName = oldclassName;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public String getClassComment() {
		return classComment;
	}

	public void setClassComment(String classComment) {
		this.classComment = classComment;
	}

	public List<FieldInfo> getFieldList() {
		return fieldList;
	}

	public void setFieldList(List<FieldInfo> fieldList) {
		this.fieldList = fieldList;
	}

	public String getPrimaryKeycolumnName() {
		return primaryKeycolumnName;
	}

	public void setPrimaryKeycolumnName(String primaryKeycolumnName) {
		this.primaryKeycolumnName = primaryKeycolumnName;
	}

	public String getPrimaryKeyfieldName() {
		return primaryKeyfieldName;
	}

	public void setPrimaryKeyfieldName(String primaryKeyfieldName) {
		this.primaryKeyfieldName = primaryKeyfieldName;
	}

	public String getPrimaryKeyfieldClass() {
		return primaryKeyfieldClass;
	}

	public void setPrimaryKeyfieldClass(String primaryKeyfieldClass) {
		this.primaryKeyfieldClass = primaryKeyfieldClass;
	}
}