package com.vic.service.impl;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vic.dao.UserMapper;
import com.vic.model.User;
import com.vic.service.IUserService;

@Service("userService")
public class UserServiceImpl implements IUserService {
	
	private static Logger logger = Logger.getLogger(UserServiceImpl.class);

	@Autowired
	private UserMapper userMapper;
	
	@Override
	public int deleteByPrimaryKey(Integer id) {
		logger.info("删除id为:"+id+"的用户");
		return this.userMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(User record) {
		logger.info("新增用户");
		return this.userMapper.insert(record);
	}

	@Override
	public int insertSelective(User record) {
		return this.userMapper.insertSelective(record);
	}

	@Override
	public User selectByPrimaryKey(Integer id) {
		logger.warn("查找id为:"+id+"的用户");
		return this.userMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(User record) {
		return this.userMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(User record) {
		return this.userMapper.updateByPrimaryKey(record);
	}

}
