<#assign className = "${tableDTO.classNameNoPrefix}">
package com.lycx.businessmanager.controller.${className?lower_case}Manager;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.lycx.businessmanager.controller.BaseController;
import com.lycx.businessmanager.model.${className?cap_first};
import com.lycx.businessmanager.service.I${className?cap_first}Service;

/**
 * controller
 * 
 * @author lambert
 * 
 */

@Controller
@RequestMapping("/${className?lower_case}")
public class ${className?cap_first}Controller extends BaseController{
	@SuppressWarnings("unused")
	private static Logger log = Logger.getLogger(${className?cap_first}Controller.class);
	private I${className?cap_first}Service ${className?lower_case}Service;

	public void set${className?cap_first}Service(I${className?cap_first}Service ${className?lower_case}Service) {
		this.${className?lower_case}Service = ${className?lower_case}Service;
	}

	@RequestMapping(value = "/list")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("/${className?lower_case}/list");
		return mv;
	}
	
	@RequestMapping(value = "/getListForPage")
	@ResponseBody
	public List<${className?cap_first}> getListForPage(${className?cap_first} ${className?lower_case},int startNum,int limit){
		List<${className?cap_first}> ${className?lower_case}List = null;
		try{
		    ${className?lower_case}List = ${className?lower_case}Service.selectForPage(${className?lower_case},startNum,limit);
		}catch(Exception e){
			e.printStackTrace();
		}
        return ${className?lower_case}List;
	}
	
	@RequestMapping(value = "/getTotalCount",method = RequestMethod.POST)
	@ResponseBody
	public int getTotalCount(${className?cap_first} ${className?lower_case}){
		return ${className?lower_case}Service.selectTotalCount(${className?lower_case});
	}
	
	@RequestMapping(value = "/add",method = RequestMethod.POST)
	@ResponseBody
	public String add(${className?cap_first} ${className?lower_case}){
		String result = null;
		if(${className?lower_case}!=null){
	        result = ${className?lower_case}Service.add(${className?lower_case});
		}
        return result;
	}
	
	@RequestMapping(value = "/del",method = RequestMethod.POST)
	@ResponseBody
	public String del(HttpServletRequest request, HttpServletResponse response,int ids[]){
		String result = null;
		result = ${className?lower_case}Service.del(ids);
		return result;
	}
	
	@RequestMapping(value = "/mod",method = RequestMethod.POST)
	@ResponseBody
	public String mod(HttpServletRequest request, HttpServletResponse response,${className?cap_first} ${className?lower_case}){
		String result = null;
		if(${className?lower_case}!=null){
			result = ${className?lower_case}Service.mod(${className?lower_case});
		}
		return result;
	}

}
