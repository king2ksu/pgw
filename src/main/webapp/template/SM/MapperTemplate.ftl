<#assign className = "${tableDTO.className}">

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${className}">
<resultMap id="${className}Result" type="${className?cap_first}DTO"> 
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

<select id="select" parameterType="${className?cap_first}DTO" resultMap="${className}Result">
    select <include refid="column"/> from ${tableDTO.tableName} t <include refid="where"/>
</select>

<update id="update" parameterType="${className?cap_first}DTO">
    update ${tableDTO.tableName}
     <trim prefix="SET" suffixOverrides=",">
     <#list tableColumnList as tableColumn>${tableColumn.field?lower_case} = ${r"#{"}${tableColumn.property}:${tableColumn.jdbcType}}<#if tableColumn_has_next == true>,</#if></#list>
     </trim>
    where id = ${r"#{id}"}
</update>

<insert id="insert" parameterType="${className?cap_first}DTO">
    insert into ${tableDTO.tableName}(<#list tableColumnList as tableColumn>${tableColumn.field?lower_case}<#if tableColumn_has_next == true>,</#if></#list>)
    values (<#list tableColumnList as tableColumn>${r"#{"}${tableColumn.property}:${tableColumn.jdbcType}}<#if tableColumn_has_next == true>,</#if></#list>)
</insert>

<delete id="delete" parameterType="${className?cap_first}DTO">
	delete from ${tableDTO.tableName} t
	<trim prefix="WHERE" prefixOverrides="AND |OR ">
	    <if test="id != null and id != ''">
		        t.id = ${r"#{id}"}
		</if>
	</trim>
</delete>

<select id="selectOne" parameterType="${className?cap_first}DTO" resultMap="${className}Result">
    select <include refid="column"/> from ${tableDTO.tableName} t <include refid="where"/>
</select>

<select id="count" parameterType="${className?cap_first}DTO" resultType="int">
	select count(t.id) from  ${tableDTO.tableName} t where <include refid="where" />
</select>

<select id="selectRepeat" parameterType="${className?cap_first}DTO" resultMap="${className}Result">
    select <include refid="column"/> from ${tableDTO.tableName} t 
      <trim prefix="WHERE" prefixOverrides="AND |OR ">
	    <if test="id != null and id != ''">
		        t.id != ${r"#{id}"}
		</if>
	  </trim>
</select>

</mapper>

