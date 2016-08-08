package com.vic.service;

import java.util.List;

import com.vic.model.User;
import com.vic.util.Page;

public interface IUserService {
	
	public int deleteByPrimaryKey(String id);

	public int insert(User record);

	public int insertSelective(User record);

	public User selectByPrimaryKey(String id);
	
	public User selectByEmail(String email);

	public int updateByPrimaryKeySelective(User record);

	public int updateByPrimaryKey(User record);
	
	public List<User> selectUserList(Page<User> page);
}
