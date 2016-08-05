package com.vic.controller;

import java.util.Date;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.vic.model.User;
import com.vic.service.IUserService;

@Controller
@RequestMapping("/user")
public class UserController {
	@Resource
	private IUserService userService;
	
	@RequestMapping("/toAddUser")
	public String toAddUser(HttpServletRequest request,Model model){  
        return "addUser";  
    }
	
	@RequestMapping("/addUser")
	public String addUser(HttpServletRequest request,Model model){  
		UUID uuid = UUID.randomUUID();
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        Date date = new Date();
        
        User user = new User();
        user.setUuid(uuid.toString());
        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);
        user.setCreateTime(date);
        
        int i = this.userService.insertSelective(user);
        
        if(i==1){
        	model.addAttribute("user", user);
        }
        
		return "showUser";  
    }
	
	@RequestMapping("/showUser")
	public String toIndex(HttpServletRequest request,Model model){  
        String userId = request.getParameter("id");  
        User user = this.userService.selectByPrimaryKey(userId);  
        model.addAttribute("user", user);  
        return "showUser";  
    }
}
