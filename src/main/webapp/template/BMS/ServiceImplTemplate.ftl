<#assign className = "${tableDTO.classNameNoPrefix}">
package com.lycx.businessmanager.service.impl;

import java.util.Date;
import java.util.List;

import com.lycx.businessmanager.constant.ConstantsDbOperation;
import com.lycx.businessmanager.constant.ConstantsMessage;
import com.lycx.businessmanager.constant.ConstantsTableName;
import com.lycx.businessmanager.dao.${className?cap_first}Dao;
import com.lycx.businessmanager.manager.SequenceManager;
import com.lycx.businessmanager.model.${className?cap_first};
import com.lycx.businessmanager.service.I${className?cap_first}Service;

public class ${className?cap_first}ServiceImpl implements I${className?cap_first}Service {
	
	private ${className?cap_first}Dao ${className?lower_case}Dao;
	
	public void set${className?cap_first}Dao(${className?cap_first}Dao ${className?lower_case}Dao){
		this.${className?lower_case}Dao = ${className?lower_case}Dao;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<${className?cap_first}> selectForPage(${className?cap_first} ${className?lower_case},int startNum,int limit) {
		List<${className?cap_first}> result = null;
		try{
			result = ${className?lower_case}Dao.selectForPagination(ConstantsDbOperation.${className?upper_case}_SELECT, ${className?lower_case},startNum,limit);
		}catch(Exception e){
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public String add(${className?cap_first} ${className?lower_case}) {
		String result = null;
		try {
			List<${className?cap_first}> list = selectRepeat(${className?lower_case});
			if (list != null && list.size() > 0) {
				result = ConstantsMessage.${className?upper_case}_REPEAT_FAIL;
			} else {
				${className?lower_case}.setId(SequenceManager.createId(ConstantsTableName.${className?upper_case}));
				${className?lower_case}.setCreateTime(new Date());
				${className?lower_case}.setModifyTime(new Date());
				${className?lower_case}Dao.insert(ConstantsDbOperation.${className?upper_case}_INSERT, ${className?lower_case});
				result = ConstantsMessage.${className?upper_case}_ADD_SUCCESS;
			}
		} catch (Exception e) {
			e.printStackTrace();
			result = ConstantsMessage.${className?upper_case}_ADD_FAIL;
		}
		return result;
	}

	@Override
	public String del(int[] ids) {
		String result = null;
		try {
			if (ids != null && ids.length > 0) {
				for (int id : ids) {
					${className?cap_first} ${className?lower_case} = new ${className?cap_first}();
					${className?lower_case}.setId(id);
					${className?lower_case}Dao.delete(ConstantsDbOperation.${className?upper_case}_DELETE, ${className?lower_case});
				}
				result = ConstantsMessage.${className?upper_case}_DEL_SUCCESS;
			}
		} catch (Exception e) {
			e.printStackTrace();
			result = ConstantsMessage.${className?upper_case}_DEL_FAIL;
		}
		return result;
	}

	@Override
	public String mod(${className?cap_first} ${className?lower_case}) {
		String result = null;
		try{
			List<${className?cap_first}> list = selectRepeat(${className?lower_case});
			if (list != null && list.size() > 0) {
				result = ConstantsMessage.${className?upper_case}_REPEAT_FAIL;
			} else {
				${className?lower_case}.setModifyTime(new Date());
				${className?lower_case}Dao.update(ConstantsDbOperation.${className?upper_case}_UPDATE, ${className?lower_case});
		        result = ConstantsMessage.${className?upper_case}_MOD_SUCCESS;
			}
		    
		}catch(Exception e){
			e.printStackTrace();
			result = ConstantsMessage.${className?upper_case}_MOD_FAIL;
		}
        return result;
	}

	@Override
	public int selectTotalCount(${className?cap_first} ${className?lower_case}) {
		return (Integer)${className?lower_case}Dao.selectOne(ConstantsDbOperation.${className?upper_case}_SELECT_TOTAL_COUNT, ${className?lower_case});
	}
	
	@SuppressWarnings("unchecked")
	private List<${className?cap_first}> selectRepeat(${className?cap_first} ${className?lower_case}) {
		return (List<${className?cap_first}>) ${className?lower_case}Dao.select(ConstantsDbOperation.${className?upper_case}_SELECT_REPEAT, ${className?lower_case});
	}

}
