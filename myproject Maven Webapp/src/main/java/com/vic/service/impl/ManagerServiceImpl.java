package com.vic.service.impl;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vic.dao.ManagerMapper;
import com.vic.model.Manager;
import com.vic.service.IManagerService;
import com.vic.util.Page;

@Service("managerService")
public class ManagerServiceImpl implements IManagerService {
	
	private static Logger logger = Logger.getLogger(ManagerServiceImpl.class);

	@Autowired
	private ManagerMapper managerMapper;
	
	@Override
	public int deleteByPrimaryKey(String id) {
		logger.info("删除uuid为:"+id+"的管理员用户");
		return this.managerMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(Manager record) {
		logger.info("新增管理员用户:"+record.getUsername());
		return this.managerMapper.insert(record);
	}

	@Override
	public int insertSelective(Manager record) {
		try{
			logger.info("增加管理员用户:"+record.getUsername()+"管理员用户");
			return this.managerMapper.insertSelective(record);
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e);
			return -1;
		}
	}

	@Override
	public Manager selectByPrimaryKey(String id) {
		logger.warn("查找uuid为:"+id+"的管理员用户");
		return this.managerMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Manager record) {
		return this.managerMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Manager record) {
		return this.managerMapper.updateByPrimaryKey(record);
	}

	@Override
	public List<Manager> selectManagerList(Page<Manager> page) {
		return this.managerMapper.findPage(page);
	}

	@Override
	public Manager selectByUsername(String email) {
		return this.managerMapper.selectByUsername(email);
	}

}
