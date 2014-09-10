package com.ksu.projectGeneratorWeb.controller;


import java.io.FileNotFoundException;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ksu.projectGeneratorWeb.service.IGeneratorService;
import com.ksu.projectGeneratorWeb.util.ErrorCodeUtils;

@Controller
@RequestMapping("/generator")
public class GeneratorController {
	
	@SuppressWarnings("unused")
	private static Logger log = Logger.getLogger(GeneratorController.class);
	
	private IGeneratorService generatorService;
	public void setGeneratorService(IGeneratorService generatorService) {
		this.generatorService = generatorService;
	}
	@RequestMapping(value = "/generate",method = RequestMethod.POST,produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String generate(String projectName) {
		String result = null;
		if(StringUtils.isNotEmpty(projectName)){
			try{
				generatorService.generate(projectName);
			}catch(FileNotFoundException fe){
				result = ErrorCodeUtils.getErrorDesc("0001");
			}catch(Exception e){
				result = e.getMessage();
				e.printStackTrace();
			}
		}
		return result;
	}

}
