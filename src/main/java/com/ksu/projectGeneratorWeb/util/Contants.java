package com.ksu.projectGeneratorWeb.util;


public class Contants {

	public static final String MYSQL_TABLE_SELECT_SQL = "DESCRIBE #tableName#";
    public static final String ORACLE_TABLE_SELECT_SQL = "select  column_name field,data_type type FROM all_tab_columns where table_name = '#tableName#'";
    public static final String SQLSERVER_TABLE_SELECT_SQL = "select c.name as field ,t.name type from syscolumns c inner join systypes t on c.xusertype=t.xusertype where objectproperty(id,'IsUserTable')=1 and id=object_id('#tableName#')";
    public static final String TEMPLATE_ADD = "add";
    public static final String TEMPLATE_DELETE = "delete";
    public static final String STATUS_OPEN_DESC = "启用";
    public static final String STATUS_CLOSE_DESC = "停用";
    public static final String STATUS_OPEN = "1";
    public static final String STATUS_CLOSE = "0";
	public static final String TEMPLATES_FLAG = "templates";
	public static final String TABLES_FLAG = "tables";
	public static final String TEMPLATE_FLAG = "template";
	public static final String TABLE_FLAG = "table";
	public static final String PREFIX_TRUE = "1";
	public static final String PREFIX_FALSE = "0";
	public static final String PREFIX_TRUE_DESC = "有前缀";
	public static final String PREFIX_FALSE_DESC = "无前缀";
}
