<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

</head>

<body>
	<p>USERLIST</p>
	<c:forEach items="${userList}" var="user">
	用户名：<c:out value="${user.username}" />
		<p>
	</c:forEach>
	<p>页码:${page.pageNo}</p>
	<p>当前页条数:${fn:length(userList)}</p>
	<p>每页显示的记录数:${page.pageSize}</p>
	<p>总记录数:${page.totalRecord}</p>
	<p>总页数:${page.totalPage}</p>
</body>
</html>
