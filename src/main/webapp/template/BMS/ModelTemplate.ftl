<#assign className = "${tableDTO.classNameNoPrefix}">
package com.lycx.businessmanager.model;
public class ${className?cap_first}{

<#list tableColumnList as tableColumn>
    private ${tableColumn.javaType} ${tableColumn.property};
</#list>

<#list tableColumnList as tableColumn>
    public void set${tableColumn.property?cap_first}(${tableColumn.javaType} ${tableColumn.property}){
        this.${tableColumn.property} = ${tableColumn.property};
    }
    
    public ${tableColumn.javaType} get${tableColumn.property?cap_first}(){
        return ${tableColumn.property};
    }
</#list>
}