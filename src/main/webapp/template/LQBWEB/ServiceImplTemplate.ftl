<#assign className = "${tableDTO.className}">
package com.ilingjie.smartstreet.service.impl;
import java.util.Map;
import java.util.HashMap;
import java.util.Date;
import java.util.List;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import com.ilingjie.smartstreet.constant.ConstantsDbOperation;
import com.ilingjie.smartstreet.constant.ConstantsMessage;
import com.ilingjie.smartstreet.constant.ConstantsTableName;
import com.ilingjie.smartstreet.dao.${className?cap_first}Dao;
import com.ilingjie.smartstreet.util.MyUtils;
import com.ilingjie.smartstreet.model.${className?cap_first};
import com.ilingjie.smartstreet.service.I${className?cap_first}Service;

@Service("${className}Service") 
public class ${className?cap_first}ServiceImpl implements I${className?cap_first}Service {
	
	private ${className?cap_first}Dao ${className}Dao;
	
	@Resource
	public void set${className?cap_first}Dao(${className?cap_first}Dao ${className}Dao){
		this.${className}Dao = ${className}Dao;
	}

    @Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true) 
	@SuppressWarnings("unchecked")
	@Override
	public Map<String,Object> selectForPage(${className?cap_first} ${className},int startNum,int limit) {
		Map<String,Object> resultMap = new HashMap<String,Object>();
    	String message = null;
    	String type = null;
		List<${className?cap_first}> ${className}List = null;
		try{
			${className}List = ${className}Dao.selectForPagination(ConstantsDbOperation.${tableDTO.tableName?upper_case}_SELECT, ${className},startNum,limit);
		    message = ConstantsMessage.${tableDTO.tableName?upper_case}_FIND_LIST_SUCCESS;
			type = ConstantsMessage.SUCCESS;
		}catch(Exception e){
			e.printStackTrace();
			message = ConstantsMessage.${tableDTO.tableName?upper_case}_FIND_LIST_FAIL;
			type = ConstantsMessage.FAIL;
		}
		resultMap.put("type", type);
		resultMap.put("message", message);
		resultMap.put("object", ${className}List);
    	return resultMap;
	}

	@Transactional(propagation=Propagation.REQUIRED, readOnly=false) 
	@Override
	public Map<String,Object> add(${className?cap_first} ${className}) {
		Map<String,Object> resultMap = new HashMap<String,Object>();
    	String message = null;
    	String type = null;
		try {
			List<${className?cap_first}> list = selectRepeat(${className});
			if (list != null && list.size() > 0) {
			    message = ConstantsMessage.${tableDTO.tableName?upper_case}_ADD_REPEAT;
				type = ConstantsMessage.FAIL;
			} else {
				${className}.setId(ConstantsTableName.${tableDTO.tableName?upper_case} + ":" + MyUtils.getUUID());
				${className}Dao.insert(ConstantsDbOperation.${tableDTO.tableName?upper_case}_INSERT, ${className});
				message = ConstantsMessage.${tableDTO.tableName?upper_case}_ADD_SUCCESS;
			    type = ConstantsMessage.SUCCESS;
			}
		} catch (Exception e) {
			e.printStackTrace();
			message = ConstantsMessage.${tableDTO.tableName?upper_case}_ADD_FAIL;
			type = ConstantsMessage.FAIL;
			${className} = new ${className?cap_first}();
		}
		resultMap.put("type", type);
		resultMap.put("message", message);
		resultMap.put("object", ${className});
    	return resultMap;
	}

	@Transactional(propagation=Propagation.REQUIRED, readOnly=false) 
	@Override
	public Map<String,Object> del(String[] ids) {
		Map<String,Object> resultMap = new HashMap<String,Object>();
    	String message = null;
    	String type = null;
		try {
			if (ids != null && ids.length > 0) {
				for (String id : ids) {
					${className?cap_first} ${className} = new ${className?cap_first}();
					${className}.setId(id);
					${className}Dao.delete(ConstantsDbOperation.${tableDTO.tableName?upper_case}_DELETE, ${className});
				}
				message = ConstantsMessage.${tableDTO.tableName?upper_case}_DEL_SUCCESS;
			    type = ConstantsMessage.SUCCESS;
			}
		} catch (Exception e) {
			e.printStackTrace();
			message = ConstantsMessage.${tableDTO.tableName?upper_case}_DEL_FAIL;
			type = ConstantsMessage.FAIL;
		}
		resultMap.put("type", type);
		resultMap.put("message", message);
    	return resultMap;
	}

    @Transactional(propagation=Propagation.REQUIRED, readOnly=false) 
	@Override
	public Map<String,Object> mod(${className?cap_first} ${className}) {
		Map<String,Object> resultMap = new HashMap<String,Object>();
    	String message = null;
    	String type = null;
		try{
			List<${className?cap_first}> list = selectRepeat(${className});
			if (list != null && list.size() > 0) {
			    message = ConstantsMessage.${tableDTO.tableName?upper_case}_MOD_REPEAT;
				type = ConstantsMessage.FAIL;
			} else {
				${className}Dao.update(ConstantsDbOperation.${tableDTO.tableName?upper_case}_UPDATE, ${className});
				${className?cap_first} ${className}Temp = new ${className?cap_first}();
				${className}Temp.setId(${className}.getId());
				${className} = (${className?cap_first})${className}Dao.selectOne(ConstantsDbOperation.${tableDTO.tableName?upper_case}_SELECT, ${className}Temp);
				message = ConstantsMessage.${tableDTO.tableName?upper_case}_MOD_SUCCESS;
			    type = ConstantsMessage.SUCCESS;
			}
		    
		}catch(Exception e){
			e.printStackTrace();
			message = ConstantsMessage.${tableDTO.tableName?upper_case}_MOD_FAIL;
			type = ConstantsMessage.FAIL;
			${className} = new ${className?cap_first}();
		}
        resultMap.put("type", type);
		resultMap.put("message", message);
		resultMap.put("object", ${className});
    	return resultMap;
	}

    @Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true) 
	@Override
	public Map<String,Object> selectTotalCount(${className?cap_first} ${className}) {
		Map<String,Object> resultMap = new HashMap<String,Object>();
    	String message = null;
    	String type = null;
    	Integer count = null;
    	try{
    	    count = (Integer)${className}Dao.selectOne(ConstantsDbOperation.${tableDTO.tableName?upper_case}_SELECT_TOTAL_COUNT, ${className});
    	    message = ConstantsMessage.${tableDTO.tableName?upper_case}_TOTAL_COUNT_SUCCESS;
			type = ConstantsMessage.SUCCESS;
    	}catch(Exception e){
    	    e.printStackTrace();
    	    message = ConstantsMessage.${tableDTO.tableName?upper_case}_TOTAL_COUNT_FAIL;
			type = ConstantsMessage.FAIL;
    	}
		resultMap.put("type", type);
		resultMap.put("message", message);
		resultMap.put("object", count);
    	return resultMap;
	}
	
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true) 
	@SuppressWarnings("unchecked")
	private List<${className?cap_first}> selectRepeat(${className?cap_first} ${className}) {
		return (List<${className?cap_first}>) ${className}Dao.select(ConstantsDbOperation.${tableDTO.tableName?upper_case}_SELECT_REPEAT, ${className});
	}
	
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true) 
	@Override
	public Map<String,Object> select(${className?cap_first} ${className}) {
		Map<String,Object> resultMap = new HashMap<String,Object>();
		String message = null;
    	String type = null;
		try{
		    ${className} = (${className?cap_first}) ${className}Dao.selectOne(ConstantsDbOperation.${tableDTO.tableName?upper_case}_SELECT, ${className});
		    message = ConstantsMessage.${tableDTO.tableName?upper_case}_FIND_SUCCESS;
			type = ConstantsMessage.SUCCESS;
		}catch(Exception e){
			e.printStackTrace();
			${className} = new ${className?cap_first}();
			message = ConstantsMessage.${tableDTO.tableName?upper_case}_FIND_FAIL;
			type = ConstantsMessage.FAIL;
		}
		resultMap.put("type", type);
		resultMap.put("message", message);
		resultMap.put("object", ${className});
    	return resultMap;
	}

}
