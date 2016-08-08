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

<title>欢迎您</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<link rel="stylesheet" type="text/css" href="./css/styles.css">

<script src="./js/jquery-1.6.2.min.js"></script>

<link rel="shortcut icon" href="./favicon.ico" />
<link rel="bookmark" href="./favicon.ico" />

</head>

<script type="text/javascript">
	function openLogin() {
		$("#login").removeClass("hide");
		$("#login").addClass("show");
		$("#buttom").removeClass("show");
		$("#buttom").addClass("hide");
	}

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
					$("#login").removeClass("show");
					$("#login").addClass("hide");
					$("#buttom").removeClass("hide");
					$("#buttom").addClass("show");
					$("#buttom-text").html(data.msg);
				}
			},
			error : function(data) {
				// 输出错误信息;
				console.log(data.info);
			}
		});

	}
</script>

<body>
	<div class="main">
		<div id="login" class="top hide">
			<div id="login-text" class="login-text">
				邮箱：<input id="l-email" type="text" name="email" size="50" /> 
				密码：<input id="l-password" type="password" name="password" size="20"> 
				<input type="submit" value="登陆" name="submit" onclick="login()">
				<div id="loginmsg"></div>
			</div>
		</div>
		<div id="buttom" class="top-box show" onclick="openLogin()">
			<div id="buttom-text" class="buttom-text">登陆</div>
		</div>
	</div>
</body>
</html>
