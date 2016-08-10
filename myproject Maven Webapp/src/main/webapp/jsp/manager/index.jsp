<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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

<title>manager login</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<link rel="shortcut icon" href="./favicon.ico" />
<link rel="bookmark" href="./favicon.ico" />

<script src="./js/jquery-1.6.2.min.js"></script>
<script type="text/javascript">
	function login() {
		var email = $("#l-email").attr("value");
		var password = $("#l-password").attr("value");

		$.ajax({
			type : "POST",
			dataType : "json",
			url : "user/login?email=" + email + "&password=" + password,
			success : function(data) {
				if (data.resultCode == -1) {
					$("#loginmsg").html(data.msg);
				}
				if (data.resultCode == 1) {
					window.location.href = "manager/manager";
				}
			},
			error : function(data) {
				// 输出错误信息;
				console.log(data.info);
			}
		});

	}
</script>
</head>

<body>
	manager
	<br>
	<div id="login">
		注册邮箱：<input id="l-email" type="text" name="email" size="50" /> 密 码：<input
			id="l-password" type="password" name="password" size="20"> <input
			type="submit" value="登陆" name="submit" onclick="login()">
	</div>
	<div id="loginmsg"></div>
</body>
</html>
