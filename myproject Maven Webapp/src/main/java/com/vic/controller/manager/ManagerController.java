package com.vic.controller.manager;

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

import com.vic.model.Manager;
import com.vic.service.IManagerService;
import com.vic.util.MD5Util;
import com.vic.util.Page;

@Controller
@RequestMapping("/manager")
public class ManagerController {
	@Resource
	private IManagerService managerService;

	@RequestMapping("")
	public String toLogin(HttpServletRequest request, Model model) {
		return "manager/index";
	}

	@RequestMapping("/manager")
	public String manager(HttpServletRequest request, Model model) {
		return "manager/manager";
	}

	@RequestMapping("/checkManagerUsername")
	public @ResponseBody Map<String, Object> checkManagerUsername(HttpServletRequest request,HttpServletResponse response,Model model){
		Map<String, Object> rmap = new HashMap<String, Object>();
		
		String username = request.getParameter("username");
		
		Manager manager = this.managerService.selectByUsername(username);

		if (manager != null) {
			rmap.put("resultCode", -1);
			rmap.put("msg", "用户名已经被使用");
		} else {
			rmap.put("resultCode", 1);
			rmap.put("msg", "该用户名可以使用");
		}
		
		return rmap;
	}
	
	@RequestMapping("/addManager")
	public @ResponseBody
	Map<String, Object> addManager(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		Map<String, Object> rmap = new HashMap<String, Object>();

		UUID uuid = UUID.randomUUID();
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		Date date = new Date();

		Manager manager = new Manager();
		manager.setUuid(uuid.toString());
		manager.setUsername(username);
		manager.setPassword(MD5Util.encode(password));
		manager.setCreateDatetime(date);

		int i = this.managerService.insertSelective(manager);

		if (i == 1) {
			model.addAttribute("manager", manager);
			rmap.put("resultCode", 1);
			rmap.put("model", model);
			rmap.put("msg", "创建成功");
		} else {
			rmap.put("resultCode", -1);
			rmap.put("msg", "创建失败，数据有误");
		}

		return rmap;

	}

	@RequestMapping("/findManager")
	public @ResponseBody
	Map<String, Object> findManager(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String userId = request.getParameter("uuid");

		Manager manager = this.managerService.selectByPrimaryKey(userId);

		Map<String, Object> rmap = new HashMap<String, Object>();

		if (manager != null) {
			rmap.put("resultUser", manager);
			rmap.put("resultCode", 1);
		} else {
			rmap.put("resultCode", -1);
		}

		return rmap;

	}

	@RequestMapping("/updateManager")
	public @ResponseBody
	Map<String, Object> updateManager(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String uuid = request.getParameter("uuid");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		int type = Integer.parseInt(request.getParameter("type"));
		Date date = new Date();

		Manager manager = new Manager();
		manager.setUuid(uuid.toString());
		manager.setUsername(username);
		manager.setPassword(MD5Util.encode(password));
		manager.setType(type);
		manager.setCreateDatetime(date);

		int i = this.managerService.updateByPrimaryKey(manager);

		Map<String, Object> rmap = new HashMap<String, Object>();

		if (i == 1) {
			rmap.put("resultCode", 1);
		} else {
			rmap.put("resultCode", -1);
		}

		return rmap;

	}

	@RequestMapping("/deleteManager")
	public @ResponseBody
	Map<String, Object> deleteManager(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String uuid = request.getParameter("uuid");

		int i = this.managerService.deleteByPrimaryKey(uuid);

		Map<String, Object> rmap = new HashMap<String, Object>();

		if (i == 1) {
			rmap.put("resultCode", 1);
		} else {
			rmap.put("resultCode", -1);
		}

		return rmap;

	}

	@RequestMapping("/getManagerList")
	public String getManagerList(HttpServletRequest request, Model model) {

		Manager manager = (Manager) request.getSession()
				.getAttribute("manager");
		if (manager == null) {
			return "error/noLoginError";
		}

		String no = request.getParameter("pageNo");
		int pageNo = 1;

		if (no != null && !"".equals(no)) {
			pageNo = Integer.parseInt(no);
		}

		Page<Manager> page = new Page<Manager>();
		page.setPageNo(pageNo);
		page.setPageSize(4);

		List<Manager> managers = this.managerService.selectManagerList(page);

		model.addAttribute("managerList", managers);
		model.addAttribute("page", page);

		return "manager/managerList";
	}

	@RequestMapping("/login")
	public @ResponseBody
	Map<String, Object> login(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		Map<String, Object> rmap = new HashMap<String, Object>();

		String username = request.getParameter("username");
		String password = request.getParameter("password");

		Manager manager = this.managerService.selectByUsername(username);

		if (manager != null) {
			if (manager.getPassword().equals(MD5Util.encode(password))) {
				request.getSession().setAttribute("manager", manager);
				// model.addAttribute("user", user);
				rmap.put("resultCode", 1);
				// rmap.put("model", model);
				rmap.put("msg", manager.getUsername());
			} else {
				rmap.put("resultCode", -1);
				rmap.put("msg", "密码错误");
			}
		} else {
			rmap.put("resultCode", -2);
			rmap.put("msg", "用户不存在");
		}

		return rmap;

	}
}
