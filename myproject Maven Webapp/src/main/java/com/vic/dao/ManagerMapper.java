package com.vic.dao;

import java.util.List;

import com.vic.model.Manager;
import com.vic.model.User;
import com.vic.util.Page;

public interface ManagerMapper {

    int deleteByPrimaryKey(String uuid);

    int insert(Manager record);

    int insertSelective(Manager record);

    Manager selectByPrimaryKey(String uuid);
    
    Manager selectByUsername(String username);

    int updateByPrimaryKeySelective(Manager record);

    int updateByPrimaryKey(Manager record);
    
    List<Manager> findPage(Page<Manager> page);
}