<#assign className = "${tableDTO.className}">
package com.ilingjie.smartstreet.service;
import java.util.Map;
import com.ilingjie.smartstreet.model.${className?cap_first};

public interface I${className?cap_first}Service {

	public Map<String,Object> selectForPage(${className?cap_first} ${className},int startNum,int limit);

	public Map<String,Object> add(${className?cap_first} ${className});

	public Map<String,Object> del(String[] ids);

	public Map<String,Object> mod(${className?cap_first} ${className});

	public Map<String,Object> selectTotalCount(${className?cap_first} ${className});
	
	public Map<String,Object> select(${className?cap_first} ${className});

}
