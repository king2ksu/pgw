<#assign className = "${tableDTO.className}">
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${className}">
<resultMap id="${className}Result" type="${className}"> 
<#list tableColumnList as tableColumn>
    <#if tableColumn.field?lower_case == 'id'><id property="id" column="id" />
    <#else><result property="${tableColumn.property}" column="${tableColumn.field?lower_case}" <#if tableColumn.jdbcType == 'BLOB'>typeHandler="org.apache.ibatis.type.BlobTypeHandler"</#if>/> </#if>
</#list>
 </resultMap> 

<sql id="where">
   <trim prefix="WHERE" prefixOverrides="AND |OR ">
	    <if test="id != null and id != ''">
		        t.id = ${r"#{id}"}
		</if>
	</trim>
</sql>
<sql id="column">
     <#list tableColumnList as tableColumn>t.${tableColumn.field?lower_case}<#if tableColumn_has_next == true>,</#if></#list>
</sql>

<select id="select" parameterType="${className}" resultMap="${className}Result">
    select <include refid="column"/> from ${tableDTO.tableName} t <include refid="where"/>
</select>

<update id="update" parameterType="${className}">
    update ${tableDTO.tableName}
     <trim prefix="SET" suffixOverrides=",">
     <#list tableColumnList as tableColumn>
         <if test="${tableColumn.property} != null">${tableColumn.field?lower_case} = ${r"#{"}${tableColumn.property}:${tableColumn.jdbcType}},</if>
     </#list>
     </trim>
    where id = ${r"#{id}"}
</update>

<insert id="insert" parameterType="${className}">
    insert into ${tableDTO.tableName}(<#list tableColumnList as tableColumn>${tableColumn.field?lower_case}<#if tableColumn_has_next == true>,</#if></#list>)
    values (<#list tableColumnList as tableColumn>${r"#{"}${tableColumn.property}:${tableColumn.jdbcType}}<#if tableColumn_has_next == true>,</#if></#list>)
</insert>

<delete id="delete" parameterType="${className}">
	delete from ${tableDTO.tableName}
	<trim prefix="WHERE" prefixOverrides="AND |OR ">
	    <if test="id != null and id != ''">
		        id = ${r"#{id}"}
		</if>
	</trim>
</delete>

<select id="selectOne" parameterType="${className}" resultMap="${className}Result">
    select <include refid="column"/> from ${tableDTO.tableName} t <include refid="where"/>
</select>

<select id="count" parameterType="${className}" resultType="int">
	select count(t.id) from  ${tableDTO.tableName} t where <include refid="where" />
</select>

<select id="selectRepeat" parameterType="${className}" resultMap="${className}Result">
    select <include refid="column"/> from ${tableDTO.tableName} t 
      <trim prefix="WHERE" prefixOverrides="AND |OR ">
	    <if test="id != null and id != ''">
		        t.id != ${r"#{id}"}
		</if>
	  </trim>
</select>

</mapper>

