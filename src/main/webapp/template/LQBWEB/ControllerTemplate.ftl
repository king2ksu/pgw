<#assign className = "${tableDTO.className}">
package com.ilingjie.smartstreet.controller;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import java.util.Map;
import com.ilingjie.smartstreet.controller.BaseController;
import com.ilingjie.smartstreet.model.${className?cap_first};
import com.ilingjie.smartstreet.service.I${className?cap_first}Service;

/**
 * ${className?cap_first}Controller
 * 
 * @author jinliang jinliang@lingqianpay.com
 * ${currentDate}
 */

@Controller
@RequestMapping("/${className?lower_case}")
public class ${className?cap_first}Controller extends BaseController{
	@SuppressWarnings("unused")
	private static Logger log = Logger.getLogger(${className?cap_first}Controller.class);
	private I${className?cap_first}Service ${className}Service;

	public void set${className?cap_first}Service(I${className?cap_first}Service ${className}Service) {
		this.${className}Service = ${className}Service;
	}

	@RequestMapping(value = "/list")
	public ModelAndView list() {
		ModelAndView mv = new ModelAndView("/${className?lower_case}/list");
		return mv;
	}
	
	@RequestMapping(value = "/find")
	@ResponseBody
	public Map<String,Object> find(${className?cap_first} ${className}){
        return ${className}Service.select(${className});
	}
	
	@RequestMapping(value = "/getListForPage")
	@ResponseBody
	public Map<String,Object> getListForPage(${className?cap_first} ${className},int startNum,int limit){
        return ${className}Service.selectForPage(${className},startNum,limit);
	}
	
	@RequestMapping(value = "/getTotalCount",method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> getTotalCount(${className?cap_first} ${className}){	
		return ${className}Service.selectTotalCount(${className});
	}
	
	@RequestMapping(value = "/add",method = RequestMethod.POST,produces="text/plain;charset=UTF-8")
	@ResponseBody
	public Map<String,Object> add(${className?cap_first} ${className}){
		if(${className}!=null){
	        return ${className}Service.add(${className});
		}
        return null;
	}
	
	@RequestMapping(value = "/del",method = RequestMethod.POST,produces="text/plain;charset=UTF-8")
	@ResponseBody
	public Map<String,Object> del(String ids[]){
		return ${className}Service.del(ids);
	}
	
	@RequestMapping(value = "/mod",method = RequestMethod.POST,produces="text/plain;charset=UTF-8")
	@ResponseBody
	public Map<String,Object> mod(${className?cap_first} ${className}){
		if(${className}!=null){
			return ${className}Service.mod(${className});
		}
		return null;
	}

}
