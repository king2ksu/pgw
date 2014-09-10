<#assign className = "${tableDTO.className}">
<?xml version="1.0"?>
<!DOCTYPE hibernate-mapping PUBLIC "-//Hibernate/Hibernate Mapping DTD 3.0//EN"
"http://hibernate.sourceforge.net/hibernate-mapping-3.0.dtd">
<hibernate-mapping>
    <class name="cn.trustfar.cmdb.dto.${className?cap_first}DTO" table="${tableDTO.tableName}" >
        <#list tableColumnList as tableColumn>
        <#if tableColumn.field?lower_case == 'id'>
        <id name="id" type="string">
            <column name="ID" />
        </id>
        <#else>
        <property name="${tableColumn.property}" type="${tableColumn.javaType}">
            <column name="${tableColumn.field?upper_case}" />
        </property>
        </#if>
        </#list>
    </class>
</hibernate-mapping>
