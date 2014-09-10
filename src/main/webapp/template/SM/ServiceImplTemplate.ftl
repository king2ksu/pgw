<#assign className = "${tableDTO.className}">
public class ${className?cap_first}ServiceImpl implements ${className?cap_first}Service{

    private ${className?cap_first}DAO ${className}DAO;
    
    public void set${className?cap_first}DAO(${className?cap_first}DAO ${className}DAO){
        this.${className}DAO = ${className}DAO;
    }
    
    public List<${className?cap_first}DTO> select(Map<String, Object> parametersMap,int start, int limit){
        ${className?cap_first}DTO ${className}DTO = new ${className?cap_first}DTO();
		${className}DTO = (${className?cap_first}DTO)ConvertUtil.mapToObject(${className}DTO,parametersMap);
		List<${className?cap_first}DTO> list = (List<${className?cap_first}DTO>)${className}DAO.selectForPagination(ConstantsDbOperation.${tableDTO.tableName?upper_case}_SELECT, ${className}DTO,start, limit);
		return list;
    }
    
	public ${className?cap_first}DTO mod(Map<String, Object> parametersMap){
	    ${className?cap_first}DTO ${className}DTO = new ${className?cap_first}DTO();
		if(parametersMap != null && parametersMap.size() > 0){
			${className}DTO = (${className?cap_first}DTO)ConvertUtil.mapToObject(${className}DTO, parametersMap);
		}
		${className}DAO.update(ConstantsDbOperation.${tableDTO.tableName?upper_case}_UPDATE, ${className}DTO);
		return ${className}DTO;
	}
	public ${className?cap_first}DTO save(Map<String, Object> parametersMap){
	    ${className?cap_first}DTO ${className}DTO = new ${className?cap_first}DTO();
		if(parametersMap != null && parametersMap.size() > 0){
			${className}DTO = (${className?cap_first}DTO)ConvertUtil.mapToObject(${className}DTO, parametersMap);
		}
		${className}DTO.setId(OidGenerator.generate(ConstantsClassName.${tableDTO.tableName?upper_case}));
		${className}DAO.insert(ConstantsDbOperation.${tableDTO.tableName?upper_case}_INSERT, ${className}DTO);
		return ${className}DTO;
	}
	
	public void del(List<String> idList){
	    for(int i = 0;i < idList.size();i++){
			${className?cap_first}DTO ${className}DTO = new ${className?cap_first}DTO();
			${className}DTO.setId(idList.get(i));
			${className}DAO.delete(ConstantsDbOperation.${tableDTO.tableName?upper_case}_DELETE, ${className}DTO);
		}
	    
	}
	
	public int count(Map<String, Object> parametersMap){
	    ${className?cap_first}DTO ${className}DTO = new ${className?cap_first}DTO();
		if(parametersMap != null && parametersMap.size() > 0){
			${className}DTO = (${className?cap_first}DTO)ConvertUtil.mapToObject(${className}DTO, parametersMap);
		}
		return ${className}DAO.count(ConstantsDbOperation.${tableDTO.tableName?upper_case}_COUNT,${className}DTO);
	}
	
	public List<${className?cap_first}DTO> select(Map<String, Object> parametersMap){
	    ${className?cap_first}DTO ${className}DTO = new ${className?cap_first}DTO();
		${className}DTO = (${className?cap_first}DTO)ConvertUtil.mapToObject(${className}DTO,parametersMap);
		List<${className?cap_first}DTO> list = (List<${className?cap_first}DTO>)${className}DAO.select(ConstantsDbOperation.${tableDTO.tableName?upper_case}_SELECT, ${className}DTO);
		return list;
	}
	
	public ${className?cap_first}DTO selectOne(Map<String, Object> parametersMap){
	    ${className?cap_first}DTO ${className}DTO = new ${className?cap_first}DTO();
		${className}DTO = (${className?cap_first}DTO)ConvertUtil.mapToObject(${className}DTO,parametersMap);
		return (${className?cap_first}DTO)${className}DAO.selectOne(ConstantsDbOperation.${tableDTO.tableName?upper_case}_SELECT, ${className}DTO);
	}
	
	public List<${className?cap_first}DTO> selectRepeat(Map<String, Object> parametersMap) {
		${className?cap_first}DTO ${className}DTO = new ${className?cap_first}DTO();
		${className}DTO = (${className?cap_first}DTO)ConvertUtil.mapToObject(${className}DTO,parametersMap);
		List<${className?cap_first}DTO> list = (List<${className?cap_first}DTO>)${className}DAO.select(ConstantsDbOperation.${tableDTO.tableName?upper_case}_SELECT_REPEAT, ${className}DTO);
		return list;
	}
}