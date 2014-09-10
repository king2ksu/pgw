package com.ksu.projectGeneratorWeb.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.ksu.projectGeneratorWeb.dao.GeneratorDao;
import com.ksu.projectGeneratorWeb.model.SystemConfDTO;
import com.ksu.projectGeneratorWeb.model.TableConfDTO;
import com.ksu.projectGeneratorWeb.model.TableDTO;
import com.ksu.projectGeneratorWeb.model.TemplateDTO;
import com.ksu.projectGeneratorWeb.service.IGeneratorService;
import com.ksu.projectGeneratorWeb.service.ISystemConfService;
import com.ksu.projectGeneratorWeb.util.Contants;
import com.ksu.projectGeneratorWeb.util.MyUtils;

import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;

@Service("generatorService")
public class GeneratorServiceImpl implements IGeneratorService {

	@Resource
	private GeneratorDao generatorDao;

	private ISystemConfService systemConfService;

	public void setGeneratorDao(GeneratorDao generatorDao) {
		this.generatorDao = generatorDao;
	}

	public void setSystemConfService(ISystemConfService systemConfService) {
		this.systemConfService = systemConfService;
	}

	private List<TableDTO> getTableInfo(SystemConfDTO systemConfDTO,TableDTO tableDTO) {
		return (List<TableDTO>) generatorDao.selectList(systemConfDTO,tableDTO);
	}

	private void createClass(SystemConfDTO systemConfDTO, List<TableDTO> tableColumnList, TableDTO tableDTO) throws Exception {
		if (tableColumnList != null && tableColumnList.size() > 0) {
			List<TemplateDTO> templateList = systemConfDTO.getTemplateList();
			if (templateList != null && templateList.size() > 0) {
				for (TemplateDTO template : templateList) {
					if (template.getStatus().equals(Contants.STATUS_OPEN)) {// 启用
						freeMarkerCreate(systemConfDTO, template, tableColumnList, tableDTO);
					}
				}
			}
		}
	}

	private void freeMarkerCreate(SystemConfDTO systemConfDTO, TemplateDTO template, List<TableDTO> tableColumnList, TableDTO tableDTO) throws Exception {
		Configuration cfg = new Configuration();
		cfg.setDirectoryForTemplateLoading(new File(systemConfDTO.getTemplatePath()));
		cfg.setObjectWrapper(new DefaultObjectWrapper());
		Map<String, Object> root = new HashMap<String, Object>();
		Template classTemplate = cfg.getTemplate(template.getTemplateName());
		if (classTemplate != null) {
			String newFileName = null;
			if (tableDTO.getPrefix().equals(Contants.PREFIX_TRUE)) {
				newFileName = StringUtils.replace(template.getFileName(), "#className#", StringUtils.capitalize(tableDTO.getClassName()));
			} else if (tableDTO.getPrefix().equals(Contants.PREFIX_FALSE)){
				newFileName = StringUtils.replace(template.getFileName(), "#className#", StringUtils.capitalize(tableDTO.getClassNameNoPrefix()));
			}
			String filePath = systemConfDTO.getOutputPath() + File.separator + template.getFilePath();
			File file = new File(filePath);
			if (!file.exists()) {
				file.mkdirs();
			}
			FileOutputStream fos = new FileOutputStream(filePath + File.separator + newFileName);
			Writer out = new OutputStreamWriter(fos);
			root.put("tableColumnList", tableColumnList);
			root.put("tableDTO", tableDTO);
			root.put("currentDate", MyUtils.dateToStringNoTime(new Date()));
			classTemplate.process(root, out);
			out.flush();
			fos.close();
		}
	}

	/**
	 * 根据数据库类型获取sql
	 * 
	 * @param tableName
	 * @return
	 */
	private String getSelectSql(SystemConfDTO systemConfDTO,String tableName) {
		if (systemConfDTO.getDriverName().equals("com.microsoft.jdbc.sqlserver.SQLServerDriver")) {
			String sql = Contants.SQLSERVER_TABLE_SELECT_SQL;
			sql = StringUtils.replace(sql, "#tableName#", tableName);
			return sql;
		} else if (systemConfDTO.getDriverName().equals("com.mysql.jdbc.Driver")) {
			String sql = Contants.MYSQL_TABLE_SELECT_SQL;
			sql = StringUtils.replace(sql, "#tableName#", tableName);
			return sql;
		} else if (systemConfDTO.getDriverName().equals("oracle.jdbc.driver.OracleDriver")) {
			String sql = Contants.ORACLE_TABLE_SELECT_SQL;
			sql = StringUtils.replace(sql, "#tableName#", tableName);
			return sql;
		}

		return null;
	}

	@Override
	public void generate(String projectName) throws Exception {
		SystemConfDTO systemConfDTO = new SystemConfDTO();
		systemConfDTO.setProjectName(projectName);
		systemConfDTO = systemConfService.select(systemConfDTO);
		List<TableConfDTO> tableConfList = systemConfDTO.getTableConfList();
		if (tableConfList != null && tableConfList.size() > 0) {
			for (TableConfDTO tableConfDTO : tableConfList) {
				if (tableConfDTO.getStatus().equals(Contants.STATUS_OPEN)) {// 启用状态
					String selectSql = getSelectSql(systemConfDTO,tableConfDTO.getTableName());
					TableDTO tableDTO = new TableDTO();
					tableDTO.setSelectSql(selectSql);
					tableDTO.setTableName(tableConfDTO.getTableName());
					tableDTO.setPrefix(tableConfDTO.getPrefix());
					// 获取表结构
					List<TableDTO> tableColumnList = getTableInfo(systemConfDTO,tableDTO);
					createClass(systemConfDTO, tableColumnList, tableDTO);
				}
			}
		}

	}
}
