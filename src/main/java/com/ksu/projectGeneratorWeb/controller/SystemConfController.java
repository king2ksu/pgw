package com.ksu.projectGeneratorWeb.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ksu.projectGeneratorWeb.model.SystemConfDTO;
import com.ksu.projectGeneratorWeb.model.TableConfDTO;
import com.ksu.projectGeneratorWeb.model.TemplateDTO;
import com.ksu.projectGeneratorWeb.service.ISystemConfService;
import com.ksu.projectGeneratorWeb.util.ErrorCodeUtils;

import java.util.List;

/**
 * SystemConfController
 * 
 * @author jinliang jinliang@lingqianpay.com 2014-03-06
 */

@Controller
@RequestMapping("/systemconf")
public class SystemConfController extends BaseController {
	@SuppressWarnings("unused")
	private static Logger log = Logger.getLogger(SystemConfController.class);
	private ISystemConfService systemConfService;

	public void setSystemConfService(ISystemConfService systemConfService) {
		this.systemConfService = systemConfService;
	}

	@RequestMapping(value = "/list")
	public ModelAndView list() {
		ModelAndView mv = new ModelAndView("/systemconf/list");
		return mv;
	}

	@RequestMapping(value = "/find")
	@ResponseBody
	public SystemConfDTO find(SystemConfDTO systemConfDTO) {
		return systemConfService.select(systemConfDTO);
	}

	@RequestMapping(value = "/getTemplateList", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public List<TemplateDTO> getTemplateListByFilePath(SystemConfDTO systemConfDTO) {
		return systemConfService.getTemplateListByFilePath(systemConfDTO);
	}

	@RequestMapping(value = "/getTableList", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public List<TableConfDTO> getTableConfList(SystemConfDTO systemConfDTO) {
		return systemConfService.getTableConfList(systemConfDTO);
	}

	@RequestMapping(value = "/getList", method = RequestMethod.POST)
	@ResponseBody
	public List<SystemConfDTO> getList() {
		return systemConfService.selectList();
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String add(SystemConfDTO systemConfDTO) {
		if (systemConfDTO != null) {
			String result = systemConfService.add(systemConfDTO);
			return ErrorCodeUtils.getErrorDesc(result);
		}
		return null;
	}

	@RequestMapping(value = "/del", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String del(String names[]) {
		String result = systemConfService.del(names);
		return ErrorCodeUtils.getErrorDesc(result);
	}

	@RequestMapping(value = "/mod", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String mod(SystemConfDTO systemConfDTO) {
		if (systemConfDTO != null) {
			String result = systemConfService.mod(systemConfDTO);
			return ErrorCodeUtils.getErrorDesc(result);
		}
		return null;
	}

	@RequestMapping(value = "/saveTemplate", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String saveTemplate(String projectName, String jsonStr) {
		String result = systemConfService.saveTemplate(projectName, jsonStr);
		return ErrorCodeUtils.getErrorDesc(result);
	}

	@RequestMapping(value = "/saveTable", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String saveTable(String projectName, String jsonStr) {
		String result = systemConfService.saveTable(projectName, jsonStr);
		return ErrorCodeUtils.getErrorDesc(result);
	}
}
