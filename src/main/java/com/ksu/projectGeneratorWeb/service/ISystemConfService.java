package com.ksu.projectGeneratorWeb.service;

import java.util.List;

import com.ksu.projectGeneratorWeb.model.SystemConfDTO;
import com.ksu.projectGeneratorWeb.model.TableConfDTO;
import com.ksu.projectGeneratorWeb.model.TemplateDTO;

public interface ISystemConfService {

	public SystemConfDTO select(SystemConfDTO systemConfDTO);

	public List<SystemConfDTO> selectList();

	public String add(SystemConfDTO systemConfDTO);

	public String del(String[] names);

	public String mod(SystemConfDTO systemConfDTO);

	public List<TemplateDTO> getTemplateListByFilePath(SystemConfDTO systemConfDTO);

	public String saveTemplate(String projectName,String templateJson);
	
	public String saveTable(String projectName, String jsonStr);

	public List<TableConfDTO> getTableConfList(SystemConfDTO systemConfDTO);

}
