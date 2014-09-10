<#assign className = "${tableDTO.classNameNoPrefix}">

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${className?lower_case}">
<resultMap id="${className?lower_case}Result" type="${className?lower_case}"> 
<#list tableColumnList as tableColumn>
    <#if tableColumn.field?lower_case == 'id'><id property="id" column="id" />
    <#else><result property="${tableColumn.property}" column="${tableColumn.field?lower_case}"/> </#if>
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

<select id="select" parameterType="${className?lower_case}" resultMap="${className?lower_case}Result">
    select <include refid="column"/> from ${tableDTO.tableName} t <include refid="where"/>
</select>

<update id="update" parameterType="${className?lower_case}">
    update ${tableDTO.tableName}
     <trim prefix="SET" suffixOverrides=",">
     <#list tableColumnList as tableColumn>${tableColumn.field?lower_case} = ${r"#{"}${tableColumn.property}:${tableColumn.jdbcType}}<#if tableColumn_has_next == true>,</#if></#list>
     </trim>
    where id = ${r"#{id}"}
</update>

<insert id="insert" parameterType="${className?lower_case}">
    insert into ${tableDTO.tableName}(<#list tableColumnList as tableColumn>${tableColumn.field?lower_case}<#if tableColumn_has_next == true>,</#if></#list>)
    values (<#list tableColumnList as tableColumn>${r"#{"}${tableColumn.property}:${tableColumn.jdbcType}}<#if tableColumn_has_next == true>,</#if></#list>)
</insert>

<delete id="delete" parameterType="${className?lower_case}">
	delete from ${tableDTO.tableName} t
	<trim prefix="WHERE" prefixOverrides="AND |OR ">
	    <if test="id != null and id != ''">
		        t.id = ${r"#{id}"}
		</if>
	</trim>
</delete>

<select id="selectOne" parameterType="${className?lower_case}" resultMap="${className?lower_case}Result">
    select <include refid="column"/> from ${tableDTO.tableName} t <include refid="where"/>
</select>

<select id="count" parameterType="${className?lower_case}" resultType="int">
	select count(t.id) from  ${tableDTO.tableName} t where <include refid="where" />
</select>

<select id="selectRepeat" parameterType="${className?lower_case}" resultMap="${className?lower_case}Result">
    select <include refid="column"/> from ${tableDTO.tableName} t 
      <trim prefix="WHERE" prefixOverrides="AND |OR ">
	    <if test="id != null and id != ''">
		        t.id != ${r"#{id}"}
		</if>
	  </trim>
</select>

</mapper>

