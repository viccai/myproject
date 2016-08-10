package com.vic.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vic.model.User;
import com.vic.service.IUserService;
import com.vic.util.Page;

@Controller
@RequestMapping("/user")
public class UserController {
	@Resource
	private IUserService userService;

	@RequestMapping("/toAddUser")
	public String toAddUser(HttpServletRequest request, Model model) {
		User user = (User) request.getSession().getAttribute("user");
		if (user != null) {
			model.addAttribute(user);
		}
		return "addUser";
	}

	@RequestMapping("/addUser")
	public @ResponseBody
	Map<String, Object> addUser(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		Map<String, Object> rmap = new HashMap<String, Object>();

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
		
		if (i == 1) {
			model.addAttribute("user", user);
			rmap.put("resultCode", 1);
			rmap.put("model", model);
			rmap.put("msg", "注册成功");
		} else {
			rmap.put("resultCode", -1);
			rmap.put("msg", "注册失败，数据有误");
		}
		
		return rmap;

	}

	@RequestMapping("/login")
	public @ResponseBody
	Map<String, Object> login(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		Map<String, Object> rmap = new HashMap<String, Object>();

		String email = request.getParameter("email");
		String password = request.getParameter("password");

		User user = this.userService.selectByEmail(email);

		if (user.getPassword().equals(password)) {
			request.getSession().setAttribute("user", user);
			// model.addAttribute("user", user);
			rmap.put("resultCode", 1);
			// rmap.put("model", model);
			rmap.put("msg", user.getUsername());
		} else {
			rmap.put("resultCode", -1);
			rmap.put("msg", "登陆失败，请确认登陆信息");
		}

		return rmap;

	}

	@RequestMapping("/findUser")
	public @ResponseBody
	Map<String, Object> findUser(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String userId = request.getParameter("uuid");

		User user = this.userService.selectByPrimaryKey(userId);

		Map<String, Object> rmap = new HashMap<String, Object>();

		if (user != null) {
			rmap.put("resultUser", user);
			rmap.put("resultCode", 1);
		} else {
			rmap.put("resultCode", -1);
		}

		return rmap;

	}

	@RequestMapping("/updateUser")
	public @ResponseBody
	Map<String, Object> updateUser(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String uuid = request.getParameter("uuid");
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

		int i = this.userService.updateByPrimaryKey(user);

		Map<String, Object> rmap = new HashMap<String, Object>();

		if (i == 1) {
			rmap.put("resultCode", 1);
		} else {
			rmap.put("resultCode", -1);
		}

		return rmap;

	}

	@RequestMapping("/deleteUser")
	public @ResponseBody
	Map<String, Object> deleteUser(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String uuid = request.getParameter("uuid");

		int i = this.userService.deleteByPrimaryKey(uuid);

		Map<String, Object> rmap = new HashMap<String, Object>();

		if (i == 1) {
			rmap.put("resultCode", 1);
		} else {
			rmap.put("resultCode", -1);
		}

		return rmap;

	}

	@RequestMapping("/showUser")
	public String showUser(HttpServletRequest request, Model model) {
		String userId = request.getParameter("id");
		User user = this.userService.selectByPrimaryKey(userId);

		model.addAttribute("user", user);
		return "showUser";
	}

	@RequestMapping("/getUserList")
	public String getUserList(HttpServletRequest request, Model model) {

		String no = request.getParameter("pageNo");
		int pageNo = 1;

		if (no != null && !"".equals(no)) {
			pageNo = Integer.parseInt(no);
		}

		Page<User> page = new Page<User>();
		page.setPageNo(pageNo);
		page.setPageSize(4);

		List<User> users = this.userService.selectUserList(page);

		model.addAttribute("userList", users);
		model.addAttribute("page", page);

		return "manager/userList";
	}

}
