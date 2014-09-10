package com.ksu.projectGeneratorWeb.util;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.ksu.projectGeneratorWeb.model.ErrorCodeDTO;

public class ErrorCodeUtils {

	private static List<ErrorCodeDTO> errorCodeList;

	@SuppressWarnings({ "rawtypes" })
	public static void readXml() {
		try {
			String filePath = Thread.currentThread().getContextClassLoader().getResource("").getPath();
			Document document = null;
			SAXReader saxReader = new SAXReader();
			document = saxReader.read(new File(filePath + File.separator + "errorCode.xml")); // 读取XML文件,获得document对象
			errorCodeList = new ArrayList<ErrorCodeDTO>();
			if (document != null) {
				Element errorCodesElement = document.getRootElement(); // 获取文档根节点
				for (Iterator i = errorCodesElement.elementIterator(); i.hasNext();) {// 获取project节点
					ErrorCodeDTO errorCodeDTO = new ErrorCodeDTO();
					Element errorCodeElement = (Element) i.next();
					errorCodeDTO.setCode(errorCodeElement.attribute("code").getValue());
					errorCodeDTO.setDesc(errorCodeElement.attribute("desc").getValue());
					errorCodeList.add(errorCodeDTO);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static String getErrorDesc(String code) {
		if (StringUtils.isNotEmpty(code)) {
			if (errorCodeList != null && errorCodeList.size() > 0) {
				for (ErrorCodeDTO errorCodeDTO : errorCodeList) {
					if (errorCodeDTO.getCode().equals(code)) {
						return errorCodeDTO.getDesc();
					}
				}
			}
		}
		return null;
	}
}
