package com.vic.service;

import java.util.List;

import com.vic.model.Manager;
import com.vic.util.Page;

public interface IManagerService {
	
	public int deleteByPrimaryKey(String id);

	public int insert(Manager record);

	public int insertSelective(Manager record);

	public Manager selectByPrimaryKey(String id);
	
	public Manager selectByUsername(String username);

	public int updateByPrimaryKeySelective(Manager record);

	public int updateByPrimaryKey(Manager record);
	
	public List<Manager> selectManagerList(Page<Manager> page);
}
