<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<title>manager</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<link rel="shortcut icon" href="./favicon.ico" />
<link rel="bookmark" href="./favicon.ico" />

<link rel="stylesheet" type="text/css" href="./css/m-styles.css">

<script src="./js/jquery-1.6.2.min.js"></script>
<script type="text/javascript">
	function manager_main(){
		$("#mian").attr("src","<%=path%>/jsp/manager/welcome.jsp");
	}
	function manager_manager(){
		$("#mian").attr("src","manager/getManagerList");
	}
	function manager_user(){
		$("#mian").attr("src","user/getUserList");
	}
</script>
</head>

<body class="body">
	<div class="header">
		<button onclick="manager_main()" class="menu-button">首页</button>
		<button onclick="manager_manager()" class="menu-button">管理员用户管理</button>
		<button onclick="manager_user()" class="menu-button">用户管理</button>
	</div>
	<div class="main">
		<iframe id="mian" class="iframe" src="<%=path%>/jsp/manager/welcome.jsp">
			
		</iframe>
	</div>
	<div class="fooder">底部</div>
</body>
</html>
