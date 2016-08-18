<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">

<title>manager login</title>

<link rel="shortcut icon" href="./favicon.ico" />
<link rel="bookmark" href="./favicon.ico" />

<link rel="stylesheet" type="text/css" href="./css/m-styles.css">

<script src="./js/jquery-1.6.2.min.js"></script>
<script type="text/javascript">
	function login() {
		var username = $("#l-username").attr("value");
		var password = $("#l-password").attr("value");

		if(username==null || username==""){
			$("#loginUsernameMsg").html("请输入账号");
			$("#loginPasswordMsg").html("");
			return;
		}
		
		if(password==null || password==""){
			$("#loginUsernameMsg").html("");
			$("#loginPasswordMsg").html("请输入密码");
			return;
		}

		$.ajax({
			type : "POST",
			dataType : "json",
			url : "manager/login?username=" + username + "&password=" + password,
			success : function(data) {
				if (data.resultCode == -1) {
					$("#loginUsernameMsg").html("");
					$("#loginPasswordMsg").html(data.msg);
				}
				if (data.resultCode == -2) {
					$("#loginUsernameMsg").html(data.msg);
					$("#loginPasswordMsg").html("");
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
	<div class="m-login-main">
		<div id="login" class="m-login-box">
			<div class="m-login-from">
				<div class="m-login-from-line-one">
					<span class="m-login-title">账&nbsp;号：</span>
					<input id="l-username" class="m-login-input" type="text" name="username" placeholder="用户名" />
					<span id="loginUsernameMsg" class="m-login-msg"></span>
				</div>
				<div class="m-login-from-line-two">
					<span class="m-login-title">密&nbsp;码：</span>
					<input id="l-password" class="m-login-input" type="password" name="password" placeholder="密码" />
					<span id="loginPasswordMsg" class="m-login-msg"></span>
				</div>
				<div class="m-login-from-line-three">
					<input type="submit" class="m-login-buttom" value="登陆" name="submit" onclick="login()">
				</div>
			</div>
		</div>
	</div>
</body>
</html>
