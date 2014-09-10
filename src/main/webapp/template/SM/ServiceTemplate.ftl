<#assign className = "${tableDTO.className}">
public interface ${className?cap_first}Service{
    public List<${className?cap_first}DTO> select(Map<String, Object> parametersMap,int start, int limit);
	public ${className?cap_first}DTO mod(Map<String, Object> parametersMap);
	public ${className?cap_first}DTO save(Map<String, Object> parametersMap);
	public void del(List<String> idList);
	public int count(Map<String, Object> parametersMap);
	public List<${className?cap_first}DTO> select(Map<String, Object> parametersMap);
	public ${className?cap_first}DTO selectOne(Map<String, Object> parametersMap);
	public List<${className?cap_first}DTO> selectRepeat(Map<String, Object> parametersMap);
}