package com.ksu.projectGeneratorWeb.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.ksu.projectGeneratorWeb.model.SystemConfDTO;
import com.ksu.projectGeneratorWeb.model.TableDTO;

@Repository("generatorDao")
public class GeneratorDao{

	public List<TableDTO> selectList(SystemConfDTO systemConfDTO, TableDTO tableDTO) {
		List<TableDTO> resultList = new ArrayList<TableDTO>();
		try {
			Class.forName(systemConfDTO.getDriverName()).newInstance();
			Connection conn= DriverManager.getConnection(systemConfDTO.getUrl(),systemConfDTO.getUser(),systemConfDTO.getPassword());
			PreparedStatement ps = conn.prepareStatement(tableDTO.getSelectSql());
			ResultSet rs = ps.executeQuery();
			TableDTO tableDTOTemp = null;
			while(rs.next()){
				tableDTOTemp = new TableDTO();
				tableDTOTemp.setField(rs.getString(1));
				tableDTOTemp.setType(rs.getString(2));
				resultList.add(tableDTOTemp);
			}
			rs.close();
			ps.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		return resultList;
	}

	
}
