package com.vic.service;

import com.vic.model.User;

public interface IUserService {
	
	public int deleteByPrimaryKey(String id);

	public int insert(User record);

	public int insertSelective(User record);

	public User selectByPrimaryKey(String id);

	public int updateByPrimaryKeySelective(User record);

	public int updateByPrimaryKey(User record);
	 
}
