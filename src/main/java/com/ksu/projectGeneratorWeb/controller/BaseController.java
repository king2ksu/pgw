package com.ksu.projectGeneratorWeb.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

import com.ksu.projectGeneratorWeb.util.PropertyEditor;


/**
 * 控制器父类
 * @author jinliang jinliang@lingqianpay.com
 * 2013-12-24
 *
 */
public class BaseController {

	
	@InitBinder  
	public void initBinder(HttpServletRequest request,ServletRequestDataBinder binder) throws Exception {  
	       
	    binder.registerCustomEditor(int.class,new PropertyEditor());   
	      
	}  
}
