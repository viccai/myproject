package com.vic.controller.manager;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/manager")
public class ManagerController {
	
	@RequestMapping("")
	public String toLogin(HttpServletRequest request,Model model){
		return "manager/index"; 
    }
	
	@RequestMapping("/manager")
	public String manager(HttpServletRequest request,Model model){
		return "manager/manager"; 
    }
}
