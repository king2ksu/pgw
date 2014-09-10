package com.ksu.projectGeneratorWeb.service.impl;

import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.ksu.projectGeneratorWeb.model.SystemConfDTO;
import com.ksu.projectGeneratorWeb.model.TableConfDTO;
import com.ksu.projectGeneratorWeb.model.TemplateDTO;
import com.ksu.projectGeneratorWeb.service.ISystemConfService;
import com.ksu.projectGeneratorWeb.util.Contants;

@Service("systemConfService")
public class SystemConfServiceImpl implements ISystemConfService {

	private static String filePath = Thread.currentThread().getContextClassLoader().getResource("").getPath() + File.separator + "projectConf.xml";

	@Override
	public List<TableConfDTO> getTableConfList(SystemConfDTO systemConfDTO) {
		systemConfDTO = select(systemConfDTO);
		return systemConfDTO.getTableConfList();
	}

	@Override
	public SystemConfDTO select(SystemConfDTO systemConfDTO) {
		List<SystemConfDTO> systemConfList = readXml();
		if (systemConfList != null && systemConfList.size() > 0) {
			for (SystemConfDTO systemConfTempDTO : systemConfList) {
				if (systemConfTempDTO.getProjectName().equals(systemConfDTO.getProjectName())) {
					return systemConfTempDTO;
				}
			}
		}
		return null;
	}

	@Override
	public List<SystemConfDTO> selectList() {
		return readXml();
	}

	@SuppressWarnings("rawtypes")
	private List<SystemConfDTO> readXml() {
		List<SystemConfDTO> systemConfList = new ArrayList<SystemConfDTO>();
		try {
			Document document = null;
			SAXReader saxReader = new SAXReader();
			document = saxReader.read(new File(filePath)); // 读取XML文件,获得document对象
			document.setXMLEncoding("utf-8");
			if (document != null) {
				Element projectsElement = document.getRootElement(); // 获取文档根节点
				for (Iterator i = projectsElement.elementIterator(); i.hasNext();) {// 获取project节点
					SystemConfDTO systemConfDTO = new SystemConfDTO();
					Element projectElement = (Element) i.next();
					systemConfDTO.setProjectName(projectElement.attribute("name").getValue());
					systemConfDTO.setOutputPath(projectElement.attribute("output_path").getValue());
					systemConfDTO.setDisplayName(projectElement.attribute("display_name").getValue());
					systemConfDTO.setTemplatePath(projectElement.attribute("template_path").getValue());
					systemConfDTO.setDriverName(projectElement.attribute("driverName").getValue());
					systemConfDTO.setUser(projectElement.attribute("user").getValue());
					systemConfDTO.setPassword(projectElement.attribute("password").getValue());
					systemConfDTO.setUrl(projectElement.attribute("url").getValue());
					List<TemplateDTO> templateList = new ArrayList<TemplateDTO>();
					List<TableConfDTO> tableConfList = new ArrayList<TableConfDTO>();
					for (Iterator j = projectElement.elementIterator(); j.hasNext();) {// 获取templates节点
						Element subNodesElement = (Element) j.next();
						for (Iterator k = subNodesElement.elementIterator(); k.hasNext();) {// 获取template,table节点
							Element subNodeElement = (Element) k.next();
							if (subNodeElement.getName().equals("template")) {
								TemplateDTO templateDTO = new TemplateDTO();
								templateDTO.setFileName(subNodeElement.attribute("file_name").getValue());
								templateDTO.setTemplateName(subNodeElement.attribute("name").getValue());
								templateDTO.setFilePath(subNodeElement.attribute("file_path").getValue());
								templateDTO.setStatus(subNodeElement.attribute("status").getValue());
								templateDTO.setDesc(subNodeElement.attribute("desc").getValue());
								templateList.add(templateDTO);
							} else if (subNodeElement.getName().equals("table")) {
								TableConfDTO tableConfDTO = new TableConfDTO();
								tableConfDTO.setTableName(subNodeElement.attribute("name").getValue());
								tableConfDTO.setStatus(subNodeElement.attribute("status").getValue());
								tableConfDTO.setPrefix(subNodeElement.attribute("prefix").getValue());
								tableConfList.add(tableConfDTO);
							}
						}
					}
					systemConfDTO.setTemplateList(templateList);
					systemConfDTO.setTableConfList(tableConfList);
					systemConfList.add(systemConfDTO);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return systemConfList;
	}

	@Override
	public String add(SystemConfDTO systemConfDTO) {
		String result = null;
		Document document = null;
		try {
			SAXReader saxReader = new SAXReader();
			document = saxReader.read(new File(filePath)); // 读取XML文件,获得document对象
			Element projectsElement = document.getRootElement(); // 获取文档根节点
			Element projectElement = projectsElement.addElement("project");
			projectElement.addAttribute("name", systemConfDTO.getProjectName());
			projectElement.addAttribute("display_name", systemConfDTO.getDisplayName());
			projectElement.addAttribute("template_path", systemConfDTO.getTemplatePath());
			projectElement.addAttribute("output_path", systemConfDTO.getOutputPath());
			projectElement.addAttribute("driverName", systemConfDTO.getDriverName());
			projectElement.addAttribute("user", systemConfDTO.getUser());
			projectElement.addAttribute("password", systemConfDTO.getPassword());
			projectElement.addAttribute("url", systemConfDTO.getUrl());
			projectElement.addElement("templates");
			projectElement.addElement("tables");
			saveXMLFile(document);
		} catch (Exception e) {
			result = "0002";
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public String del(String[] names) {
		String result = null;
		try {
			if (names != null && names.length > 0) {
				Document document = delXml(names);
				saveXMLFile(document);
			}
		} catch (Exception e) {
			result = "0003";
			e.printStackTrace();
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	private Document delXml(String[] names) throws Exception {
		Document document = null;
		SAXReader saxReader = new SAXReader();
		document = saxReader.read(new File(filePath)); // 读取XML文件,获得document对象
		Element projectsElement = document.getRootElement(); // 获取文档根节点
		for (String projectName : names) {
			List<Element> eleList = (List<Element>) projectsElement.elements();
			if (eleList != null && eleList.size() > 0) {
				for (Element element : eleList) {
					if (element.attributeValue("name", null).equals(projectName)) {
						projectsElement.remove(element);
					}
				}
			}
		}
		return document;
	}

	@SuppressWarnings("unchecked")
	@Override
	public String mod(SystemConfDTO systemConfDTO) {
		String result = null;
		try {
			Document document = null;
			SAXReader saxReader = new SAXReader();
			document = saxReader.read(new File(filePath)); // 读取XML文件,获得document对象
			Element projectsElement = document.getRootElement(); // 获取文档根节点
			List<Element> eleList = projectsElement.elements();
			if (eleList != null && eleList.size() > 0) {
				for (Element projectElement : eleList) {
					if (projectElement.attributeValue("name", null).equals(systemConfDTO.getProjectName())) {
						Attribute displayNameAttr = projectElement.attribute("display_name");
						Attribute templatePathAttr = projectElement.attribute("template_path");
						Attribute outputPathAttr = projectElement.attribute("output_path");
						Attribute driverNameAttr = projectElement.attribute("driverName");
						Attribute userAttr = projectElement.attribute("user");
						Attribute passwordAttr = projectElement.attribute("password");
						Attribute urlAttr = projectElement.attribute("url");
						displayNameAttr.setValue(systemConfDTO.getDisplayName());
						templatePathAttr.setValue(systemConfDTO.getTemplatePath());
						outputPathAttr.setValue(systemConfDTO.getOutputPath());
						driverNameAttr.setValue(systemConfDTO.getDriverName());
						userAttr.setValue(systemConfDTO.getUser());
						passwordAttr.setValue(systemConfDTO.getPassword());
						urlAttr.setValue(systemConfDTO.getUrl());
						saveXMLFile(document);
						break;
					}
				}
			}
		} catch (Exception e) {
			result = "0004";
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 保存XML文件
	 * 
	 * @param document
	 *            : XML文件名
	 */
	private void saveXMLFile(Document document) throws Exception {
		OutputFormat format = OutputFormat.createPrettyPrint();
		format.setEncoding("UTF-8");
		PrintWriter pw = new PrintWriter(filePath, "utf-8");
		XMLWriter writer = new XMLWriter(pw, format);
		writer.write(document);
		writer.close();
	}

	@Override
	public List<TemplateDTO> getTemplateListByFilePath(SystemConfDTO systemConfDTO) {
		List<TemplateDTO> resultList = new ArrayList<TemplateDTO>();
		List<TemplateDTO> templateDTOList = new ArrayList<TemplateDTO>();
		if (systemConfDTO != null && StringUtils.isNotEmpty(systemConfDTO.getTemplatePath())) {
			systemConfDTO = select(systemConfDTO);
			// 读取路径中模板文件列表
			File file = new File(systemConfDTO.getTemplatePath());
			if (file.isDirectory()) {
				String[] fileNames = file.list();
				if (fileNames != null && fileNames.length > 0) {
					for (String fileName : fileNames) {
						TemplateDTO templateDTO = new TemplateDTO();
						templateDTO.setTemplateName(fileName);
						templateDTO.setStatus(Contants.STATUS_OPEN);
						templateDTOList.add(templateDTO);
					}
				}
			}
			// 路径中模板文件与xml中模板文件比对
			List<TemplateDTO> xmlTemplateList = systemConfDTO.getTemplateList();
			for (TemplateDTO xmlTemplate : xmlTemplateList) {
				int i = 0;
				for (TemplateDTO pathTemplate : templateDTOList) {
					// xml中模板存在
					if (xmlTemplate.getTemplateName().equals(pathTemplate.getTemplateName())) {
						i++;
						break;
					}
				}
				if (i == 0) {
					xmlTemplate.setFlag(Contants.TEMPLATE_DELETE);
				}
				resultList.add(xmlTemplate);
			}

			for (TemplateDTO pathTemplate : templateDTOList) {
				int i = 0;
				for (TemplateDTO xmlTemplate : xmlTemplateList) {
					// path中模板存在
					if (xmlTemplate.getTemplateName().equals(pathTemplate.getTemplateName())) {
						i++;
						break;
					}
				}
				if (i == 0) {
					pathTemplate.setFlag(Contants.TEMPLATE_ADD);
					resultList.add(pathTemplate);
				}

			}
		}
		return resultList;
	}

	@Override
	public String saveTemplate(String projectName, String jsonStr) {
		String result = null;
		List<TemplateDTO> templateDTOList = null;
		if(StringUtils.isNotEmpty(jsonStr)){
			templateDTOList = JSON.parseArray(jsonStr, TemplateDTO.class);
		}
		try {
			Document document = modXml(templateDTOList, Contants.TEMPLATES_FLAG, projectName);
			saveXMLFile(document);
		} catch (Exception e) {
			result = "0005";
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public String saveTable(String projectName, String jsonStr) {
		String result = null;
		List<TableConfDTO> tableDTOList = null;
		if(StringUtils.isNotEmpty(jsonStr)){
			tableDTOList = JSON.parseArray(jsonStr, TableConfDTO.class);
		}
		try {
			Document document = modXml(tableDTOList, Contants.TABLES_FLAG, projectName);
			saveXMLFile(document);
		} catch (Exception e) {
			result = "0006";
			e.printStackTrace();
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	private <T> Document modXml(List<T> list, String flag, String projectName) throws Exception {
		Document document = null;
		SAXReader saxReader = new SAXReader();
		document = saxReader.read(new File(filePath)); // 读取XML文件,获得document对象
		Element projectsElement = document.getRootElement(); // 获取文档根节点
		List<Element> eleList = (List<Element>) projectsElement.elements();
		if (eleList != null && eleList.size() > 0) {
			for (Element element : eleList) {
				if (element.attributeValue("name", null).equals(projectName)) {
					// 删除templates或tables下所有节点
					Element subsElement = element.element(flag);
					List<Element> subElementList = subsElement.elements();
					if (subElementList != null && subElementList.size() > 0) {
						for (Element subElement : subElementList) {
							subsElement.remove(subElement);
						}
					}
					if (list != null && list.size() > 0) {
						for (Object obj : list) {
							if (flag.equals(Contants.TEMPLATES_FLAG)) {
								Element newTemplateElement = subsElement.addElement(Contants.TEMPLATE_FLAG);
								TemplateDTO newTemplate = (TemplateDTO) obj;
								newTemplateElement.addAttribute("name", newTemplate.getTemplateName());
								newTemplateElement.addAttribute("file_name", newTemplate.getFileName());
								newTemplateElement.addAttribute("file_path", newTemplate.getFilePath());
								newTemplateElement.addAttribute("desc", newTemplate.getDesc());
								newTemplateElement.addAttribute("status", newTemplate.getStatus());
							} else if (flag.equals(Contants.TABLES_FLAG)) {
								Element newTableElement = subsElement.addElement(Contants.TABLE_FLAG);
								TableConfDTO newTableConf = (TableConfDTO) obj;
								newTableElement.addAttribute("name", newTableConf.getTableName());
								newTableElement.addAttribute("status", newTableConf.getStatus());
								newTableElement.addAttribute("prefix", newTableConf.getPrefix());
							}
						}
					}
					break;
				}
			}
		}
		return document;
	}
}
