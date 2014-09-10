<#assign className = "${tableDTO.className}">
package com.ilingjie.smartstreet.model;
import java.util.Date;
import java.io.Serializable;
public class ${className?cap_first} implements Serializable{

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