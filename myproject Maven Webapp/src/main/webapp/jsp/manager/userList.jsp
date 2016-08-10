<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>UserList</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<link rel="stylesheet" type="text/css" href="./css/main-styles.css">
<script src="./js/jquery-1.6.2.min.js"></script>
<script>
	$(document).ready(function() {
		load_page_bottom();
	});
</script>
<script type="text/javascript">
	//获取某一页的数据
	function getpage(pageno) {
		window.location.href = "user/getUserList?pageNo=" + pageno;
	}
	//加载分页底部的条栏
	function load_page_bottom() {
		var pre = ${page.pageNo} - 1;
		var next = ${page.pageNo} + 1;

		var html = "<div>";
		if (${page.pageNo} != 1) {
			html += "<button onclick='getpage(" + pre + ")'>上一页</button>";
		}
		html += "第${page.pageNo}/${page.totalPage}页|总共${page.totalRecord}条";
		if (${page.pageNo} < ${page.totalPage}) {
			html += "<button onclick='getpage(" + next + ")'>下一页</button>";
		}
		html += "</div>";
		$("#page-bottom").html(html);
	}
	function toAddUser(){
		$("#user-edit").css('display','none');
		$("#user-add").css('display','block');
	}
	function addUser(){
		var username = $("#add-username").attr("value");
		var password = $("#add-password").attr("value");
		var email = $("#add-email").attr("value");
		
		$.ajax({
		    type : "POST",
		    dataType: "json",
		    url : "user/addUser?username="+username+"&password="+password+"&email="+email,
		    success : function(data) {
		        if(data.resultCode==-1){
		        	// 输出错误信息;
			        console.log("增加用户失败");
		        }
		        if(data.resultCode==1){
		        	window.location.href = "user/getUserList";
		        }
		    },
		    error : function(data) {
		        // 输出错误信息;
		        console.log(data.info);
		    }
		});
	}
	function deleteUser(uuid){
		$.ajax({
		    type : "POST",
		    dataType: "json",
		    url : "user/deleteUser?uuid="+uuid,
		    success : function(data) {
		        if(data.resultCode==-1){
		        	// 输出错误信息;
			        console.log("修改信息不成功");
		        }
		        if(data.resultCode==1){
		        	window.location.href = "user/getUserList?pageNo=" + ${page.pageNo};
		        }
		    },
		    error : function(data) {
		        // 输出错误信息;
		        console.log(data.info);
		    }
		});
	}
	function editUser(uuid){
		$.ajax({
		    type : "POST",
		    dataType: "json",
		    url : "user/findUser?uuid="+uuid,
		    success : function(data) {
		        if(data.resultCode==-1){
		        	// 输出错误信息;
			        console.log("用户不存在");
		        }
		        if(data.resultCode==1){
		        	var html="";
		        	html += "<input id='uuid' type='text' name='uuid' value='"+data.resultUser.uuid+"' />";
			    	html += "用户名：<input id='username' type='text' name='username' value='"+data.resultUser.username+"'/>";
			        html += "密 码：<input id='password' type='password' name='password' value='"+data.resultUser.password+"'/>";
			        html += "电子邮箱：<input id='email' type='text' name='email' value='"+data.resultUser.email+"'/>";
			        html += "<div id='msg'></div>";
			        html += "<input type='submit' value='确定' onclick='update()'>";
			        html += "<input type='submit' value='取消' onclick='editCancle()'>";
			        $("#edit").html(html);
		        	$("#user-edit").css('display','block');
		        }
		    },
		    error : function(data) {
		        // 输出错误信息;
		        console.log(data.info);
		    }
		});
		
	}
	function update(){
		var uuid = $("#uuid").attr("value");
		var username = $("#username").attr("value");
		var password = $("#password").attr("value");
		var email = $("#email").attr("value");
		
		$.ajax({
		    type : "POST",
		    dataType: "json",
		    url : "user/updateUser?uuid="+uuid+"&username="+username+"&password="+password+"&email="+email,
		    success : function(data) {
		        if(data.resultCode==-1){
		        	// 输出错误信息;
			        console.log("修改信息不成功");
		        }
		        if(data.resultCode==1){
		        	window.location.href = "user/getUserList?pageNo=" + ${page.pageNo};
		        }
		    },
		    error : function(data) {
		        // 输出错误信息;
		        console.log(data.info);
		    }
		});
	
	}
	function editCancle(){
		$("#user-edit").css('display','none');
	}
	function addCancle(){
		$("#user-add").css('display','none');
	}
</script>

</head>

<body class="body">
	<div id="user-list" class="user-list">
		<p>用户管理--用户列表<button onclick="toAddUser()">增加</button></p>
		<table>
			<tr>
				<td>用户名</td>
				<td>邮箱</td>
				<td>密码</td>
				<td>创建时间</td>
				<td>操作</td>
			</tr>
			<c:forEach items="${userList}" var="user">
				<tr>
					<td>${user.username}</td>
					<td>${user.email}</td>
					<td>${user.password}</td>
					<td><fmt:formatDate value='${user.createTime}'
							pattern='yyyy-MM-dd HH:mm:ss' /></td>
					<td>
						<button onclick="deleteUser('${user.uuid}')">删除</button>
						<button onclick="editUser('${user.uuid}')">修改</button>
					</td>
				</tr>
			</c:forEach>
		</table>
		<div id="page-bottom"></div>
	</div>
	<div id="user-edit" class="user-edit">
		<div class="user-box" onclick="editCancle()">
		</div>
		<div id="edit" class="edit">
		</div>
	</div>
	<div id="user-add" class="user-add">
		<div class="user-box" onclick="addCancle()">
		</div>
		<div id="add" class="add">
	    	用户名：<input id="add-username" type="text" name="add-username" size="20">
	                密 码：<input id="add-password" type="password" name="add-password" size="20">
	                电子邮箱：<input id="add-email" type="text" name="add-email" size="50"/>
	        <input type="submit" value="增加" name="submit" onclick="addUser()">
	        <input type="submit" value="取消" name="submit" onclick="addCancle()">
		</div>
	</div>
</body>
</html>
