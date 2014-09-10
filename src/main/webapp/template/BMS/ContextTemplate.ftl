<#assign className = "${tableDTO.classNameNoPrefix}">
<bean id="${className?lower_case}Service" class="com.lycx.businessmanager.service.impl.${className?cap_first}ServiceImpl"/>



<bean id="${className?lower_case}Dao" class="com.lycx.businessmanager.dao.${className?cap_first}Dao">
     <property name="sqlSessionFactory" ref="sessionFactory"></property>
</bean>