package com.ksu.projectGeneratorWeb.model;

import java.util.List;

public class SystemConfDTO {
	private String projectName;
	private String outputPath;
	private String templatePath;
	private String displayName;
	private List<TemplateDTO> templateList;
	private List<TableConfDTO> tableConfList;
	private String driverName;
	private String user;
	private String password;
	private String url;
	
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getOutputPath() {
		return outputPath;
	}
	public void setOutputPath(String outputPath) {
		this.outputPath = outputPath;
	}
	public String getTemplatePath() {
		return templatePath;
	}
	public void setTemplatePath(String templatePath) {
		this.templatePath = templatePath;
	}
	public List<TemplateDTO> getTemplateList() {
		return templateList;
	}
	public void setTemplateList(List<TemplateDTO> templateList) {
		this.templateList = templateList;
	}
	public String getDisplayName() {
		return displayName;
	}
	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}
	public List<TableConfDTO> getTableConfList() {
		return tableConfList;
	}
	public void setTableConfList(List<TableConfDTO> tableConfList) {
		this.tableConfList = tableConfList;
	}
	public String getDriverName() {
		return driverName;
	}
	public void setDriverName(String driverName) {
		this.driverName = driverName;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}

	
}
