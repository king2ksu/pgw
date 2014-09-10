package com.ksu.projectGeneratorWeb.model;

import org.apache.commons.lang.StringUtils;

import com.ksu.projectGeneratorWeb.util.Contants;

public class TableConfDTO {

	private String tableName;
	private String status;
	private String prefix;
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getPrefix() {
		return prefix;
	}
	public void setPrefix(String prefix) {
		this.prefix = prefix;
	}
	
	public String getStatusName() {
		if(StringUtils.isNotEmpty(this.status)){
			if(this.status.equals(Contants.STATUS_OPEN)){
				return Contants.STATUS_OPEN_DESC;
			}else if(this.status.equals(Contants.STATUS_CLOSE)){
				return Contants.STATUS_CLOSE_DESC;
			}
		}
		return null;
	}
	public void setStatusName(String prefixName) {
		if(prefixName.equals(Contants.STATUS_OPEN_DESC)){
			this.status = Contants.STATUS_OPEN;
		}else if(prefixName.equals(Contants.STATUS_CLOSE_DESC)){
			this.status = Contants.STATUS_CLOSE;
		}
	}
	
	public String getPrefixName() {
		if(StringUtils.isNotEmpty(this.status)){
			if(this.prefix.equals(Contants.PREFIX_TRUE)){
				return Contants.PREFIX_TRUE_DESC;
			}else if(this.prefix.equals(Contants.PREFIX_FALSE)){
				return Contants.PREFIX_FALSE_DESC;
			}
		}
		return null;
	}
	public void setPrefixName(String prefixName) {
		if(prefixName.equals(Contants.PREFIX_TRUE_DESC)){
			this.prefix = Contants.PREFIX_TRUE;
		}else if(prefixName.equals(Contants.PREFIX_FALSE_DESC)){
			this.prefix = Contants.PREFIX_FALSE;
		}
	}
	
	
}
