<#assign className = "${tableDTO.className}">
package cn.trustfar.web.action.cmdb;
public class ${className?cap_first}Action extends BaseAction{

    private static ${className?cap_first}Service ${className}Service = null;
	public static ${className?cap_first}Service get${className?cap_first}Service(){
		if(${className}Service == null){
			${className}Service = (${className?cap_first}Service)Look.up("${className}Service");
		}
		return ${className}Service;
	}
	
}