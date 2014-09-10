<#assign className = "${tableDTO.className}">
package cn.trustfar.cmdb.service.impl;
public class ${className?cap_first}ServiceImpl implements ${className?cap_first}Service{

    private ${className?cap_first}DAO ${className}DAO;
    
    public void set${className?cap_first}DAO(${className?cap_first}DAO ${className}DAO){
        this.${className}DAO = ${className}DAO;
    }
    
    public List<${className?cap_first}DTO> select(){

    }
    
	public ${className?cap_first}DTO mod(){

	}
	public ${className?cap_first}DTO save(){

	}
	
	public void del(List<String> idList){
	    
	}
}