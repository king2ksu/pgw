<#assign className = "${tableDTO.className}">
public class ${className?cap_first}Action extends BaseAction{

    private static ${className?cap_first}Service ${className}Service = null;
	public static ${className?cap_first}Service get${className?cap_first}Service(){
		if(${className}Service == null){
			${className}Service = (${className?cap_first}Service)Look.up("${className}Service");
		}
		return ${className}Service;
	}
	
	public ObjectResult findList(Map<String, Object> parametersMap,int start, int limit){
		ObjectResult result = new ObjectResult();
		List<${className?cap_first}DTO> list = get${className?cap_first}Service().select(parametersMap, start, limit);
		int count = get${className?cap_first}Service().count(parametersMap);
		result.setList(list);
		result.setCount(count);
		return result;
	}
	
	public ${className?cap_first}DTO find(Map<String, Object> parametersMap){
		${className?cap_first}DTO ${className}DTO = (${className?cap_first}DTO)get${className?cap_first}Service().selectOne(parametersMap);
		return ${className}DTO;
	}
	
	public ObjectResult findList(Map<String, Object> parametersMap){
		ObjectResult result = new ObjectResult();
		List<${className?cap_first}DTO> list = get${className?cap_first}Service().select(parametersMap);
		result.setList(list);
		return result; 
	}
	
	public ${className?cap_first}DTO add(Map<String, Object> parametersMap){
		Map<String, Object> mapTemp = new HashMap<String, Object>();
		mapTemp.put("", parametersMap.get(""));
		List<${className?cap_first}DTO> list = get${className?cap_first}Service().select(mapTemp);
		if(list != null && list.size() > 0){
			throw new ExceptionRes("");
		}
		${className?cap_first}DTO ${className}DTO = get${className?cap_first}Service().save(parametersMap);
		return ${className}DTO;
	}
	
	public void mod(Map<String, Object> parametersMap){
		Map<String, Object> mapTemp = new HashMap<String, Object>();
		mapTemp.put("",parametersMap.get(""));
		mapTemp.put("id", parametersMap.get("id"));
		List<${className?cap_first}DTO> list = get${className?cap_first}Service().selectRepeat(mapTemp);
		if(list != null && list.size() > 0){
			throw new ExceptionRes("");
		}
		get${className?cap_first}Service().mod(parametersMap);
	}
	
	public void del(List<String> idList){
		get${className?cap_first}Service().del(idList);
	}
}