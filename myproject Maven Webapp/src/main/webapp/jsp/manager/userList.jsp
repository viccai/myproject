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
	function deleteUser(uuid){
		alert(uuid);
	}
	function editUser(uuid){
		alert(uuid);
	}
</script>

</head>

<body class="body">
	<p>用户管理--用户列表</p>
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
	<!-- <p>第${page.pageNo}页|${fn:length(userList)}/${page.totalRecord}|总共${page.totalPage}页</p>
	<button onclick="getpage()">第二页</button> -->
</body>
</html>
