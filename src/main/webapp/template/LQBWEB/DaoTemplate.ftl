<#assign className = "${tableDTO.className}">
package com.ilingjie.smartstreet.dao;

import org.springframework.stereotype.Repository;

@Repository("${className}Dao")
public class ${className?cap_first}Dao extends BaseDao {

}
