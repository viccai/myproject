package com.vic.myBatis;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.vic.model.User;
import com.vic.service.IUserService;

//@RunWith(SpringJUnit4ClassRunner.class)     //表示继承了SpringJUnit4ClassRunner类  
//@ContextConfiguration(locations = {"classpath:spring-mybatis.xml"})

public class TestMyBatis {
	
	private static Logger logger = Logger.getLogger(TestMyBatis.class);
	//private ApplicationContext ac = null;
	
	@Resource
	private IUserService userService = null;
	
	//@Before
	//public void before(){
	//	ac = new ClassPathXmlApplicationContext("applicationContext.xml");
	//	userService = (IUserService) ac.getBean("userService");
	//}
	
	@Test
	public void test1(){
		System.out.println(userService);
		User user = userService.selectByPrimaryKey("7f10f6b6-1be9-4cbd-93aa-14f31842998d");  
        System.out.println(user.getUsername());  
        // logger.info("值："+user.getUserName());  
        //logger.info(JSON.toJSONString(user));  
	}
	
}
