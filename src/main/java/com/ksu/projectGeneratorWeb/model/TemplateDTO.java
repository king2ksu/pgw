package com.ksu.projectGeneratorWeb.model;

import org.apache.commons.lang.StringUtils;

import com.ksu.projectGeneratorWeb.util.Contants;

public class TemplateDTO {

	private String templateName;
	private String fileName;
	private String filePath;
	private String status;
	private String desc;
	private String flag;
	public String getTemplateName() {
		return templateName;
	}
	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
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
	public void setStatusName(String statusName) {
		if(statusName.equals(Contants.STATUS_OPEN_DESC)){
			this.status = Contants.STATUS_OPEN;
		}else if(statusName.equals(Contants.STATUS_CLOSE_DESC)){
			this.status = Contants.STATUS_CLOSE;
		}
	}
	
}
