<#assign className = "${tableDTO.classNameNoPrefix}">
package com.lycx.businessmanager.service;

import java.util.List;

import com.lycx.businessmanager.model.${className?cap_first};

public interface I${className?cap_first}Service {

	public List<${className?cap_first}> selectForPage(${className?cap_first} ${className?lower_case},int startNum,int limit);

	public String add(${className?cap_first} ${className?lower_case});

	public String del(int[] ids);

	public String mod(${className?cap_first} ${className?lower_case});

	public int selectTotalCount(${className?cap_first} ${className?lower_case});

}
