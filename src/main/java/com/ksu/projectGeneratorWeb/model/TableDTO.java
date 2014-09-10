package com.ksu.projectGeneratorWeb.model;

import org.springframework.util.StringUtils;

public class TableDTO {

	private String tableName;
	private String columnName;
	private String columnType;
	private String selectSql;
	private String field;
	private String type;
	private String isNull;
	private String key;
	private String isDefault;
	private String extra;
	private String prefix;

	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getColumnName() {
		return columnName;
	}
	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
	public String getColumnType() {
		return columnType;
	}
	public void setColumnType(String columnType) {
		this.columnType = columnType;
	}
	public String getSelectSql() {
		return selectSql;
	}
	public void setSelectSql(String selectSql) {
		this.selectSql = selectSql;
	}
	public String getField() {
		return field;
	}
	public void setField(String field) {
		this.field = field;
	}
	public String getType() {
		return type;
	}
	public String getNewType(){
		return type.split("\\(")[0];
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getIsNull() {
		return isNull;
	}
	public void setIsNull(String isNull) {
		this.isNull = isNull;
	}
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public String getIsDefault() {
		return isDefault;
	}
	public void setIsDefault(String isDefault) {
		this.isDefault = isDefault;
	}
	public String getExtra() {
		return extra;
	}
	public void setExtra(String extra) {
		this.extra = extra;
	}
	
	public String getPrefix() {
		return prefix;
	}
	public void setPrefix(String prefix) {
		this.prefix = prefix;
	}
	public String getClassName() {
		String[] fieldArray = this.tableName.toLowerCase().split("_");
		if(fieldArray.length <= 1){
			return this.tableName.toLowerCase();
		}else{
			String property = "";
			int i=0;
			for(String field : fieldArray){
				if(i == 0){
					property = field;
				}else{
					property+=StringUtils.capitalize(field);
				}
				i++;
			}
			return property;
		}
	}
	public String getClassNameNoPrefix() {
		String[] fieldArray = this.tableName.toLowerCase().split("_");
		if(fieldArray.length <= 1){
			return this.tableName.toLowerCase();
		}else{
			String property = "";
			int i=0;
			for(String field : fieldArray){
				if(i > 0){
					property+=StringUtils.capitalize(field);
				}
				i++;
			}
			return property;
		}
	}
	public String getJdbcType(){
		String result = "";
		if(getNewType().equalsIgnoreCase("int")){
			result = "INTEGER";
		}else if(getNewType().equalsIgnoreCase("varchar")){
			result = "VARCHAR";
		}else if(getNewType().equalsIgnoreCase("bigint")){
			result = "INTEGER";
		}else if(getNewType().equalsIgnoreCase("datetime")){
			result = "TIMESTAMP";
		}else if(getNewType().equalsIgnoreCase("decimal")){
			result = "DOUBLE";
		}else if(getNewType().equalsIgnoreCase("smallint")){
			result = "INTEGER";
		}else if(getNewType().equalsIgnoreCase("VARCHAR2")){
			result = "VARCHAR";
		}else if(getNewType().equalsIgnoreCase("TIMESTAMP")){
			result = "TIMESTAMP";
		}else if(getNewType().equalsIgnoreCase("CLOB")){
			result = "CLOB";
		}else if(getNewType().equalsIgnoreCase("NUMBER")){
			result = "NUMERIC";
		}else if(getNewType().equalsIgnoreCase("BLOB")){
			result = "BLOB";
		}
		return result;
	}
	public String getJavaType(){
		String result = "";
		if(getNewType().equalsIgnoreCase("int")){
			result = "Integer";
		}else if(getNewType().equalsIgnoreCase("varchar")){
			result = "String";
		}else if(getNewType().equalsIgnoreCase("bigint")){
			result = "Long";
		}else if(getNewType().equalsIgnoreCase("datetime")){
			result = "java.util.Date";
		}else if(getNewType().equalsIgnoreCase("decimal")){
			result = "Double";
		}else if(getNewType().equalsIgnoreCase("smallint")){
			result = "Integer";
		}else if(getNewType().equalsIgnoreCase("VARCHAR2")){
			result = "String";
		}else if(getNewType().equalsIgnoreCase("TIMESTAMP")){
			result = "Date";
		}else if(getNewType().equalsIgnoreCase("CLOB") || getNewType().equalsIgnoreCase("longtext") || getNewType().equalsIgnoreCase("varchar(max)")){
			result = "String";
		}else if(getNewType().equalsIgnoreCase("NUMBER")){
			result = "Integer";
		}else if(getNewType().equalsIgnoreCase("BLOB")){
			result = "byte[]";
		}
		return result;
	}
	
	public String getProperty(){
		String[] fieldArray = this.field.toLowerCase().split("_");
		if(fieldArray.length <= 0){
			return this.field.toLowerCase();
		}else{
			String property = "";
			int i=0;
			for(String field : fieldArray){
				if(i == 0){
					property = field;
				}else{
					char[] propertyTemp = field.toCharArray();
					propertyTemp[0] = String.valueOf(propertyTemp[0]).toUpperCase().toCharArray()[0];
					property+=String.valueOf(propertyTemp);
				}
				i++;
			}
			return property;
		}
	}
	
}
