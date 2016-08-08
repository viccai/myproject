<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>注册用户</title>

	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script src="./js/jquery-1.6.2.min.js"></script>
	<script type="text/javascript">
		function register(){
			var username = $("#username").attr("value");
			var password = $("#password").attr("value");
			var email = $("#email").attr("value");

			$.ajax({
			    type : "POST",
			    dataType: "json",
			    url : "user/addUser?username="+username+"&password="+password+"&email="+email,
			    success : function(data) {
			        if(data.resultCode==-1){
				        $("#msg").html(data.msg);
			        }
			        if(data.resultCode==1){
			        	$("#add").hide();
				        $("#msg").html(data.msg);
			        }
			        //window.location.href ="showUser" ;
			    },
			    error : function(data) {
			        // 输出错误信息;
			        console.log(data.info);
			    }
			});
		
		}
		
		function login(){
			var email = $("#l-email").attr("value");
			var password = $("#l-password").attr("value");

			$.ajax({
			    type : "POST",
			    dataType: "json",
			    url : "user/login?email="+email+"&password="+password,
			    success : function(data) {
			        if(data.resultCode==-1){
				        $("#loginmsg").html(data.msg);
			        }
			        if(data.resultCode==1){
			        	$("#login").hide();
				        $("#loginmsg").html(data.msg);
			        }
			        //window.location.href ="showUser" ;
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
	用户信息:<c:if test="${user!=null}">${user.username}</c:if>
    <div id="add">
    	用户名：<input id="username" type="text" name="username" size="20">
                密 码：<input id="password" type="password" name="password" size="20">
                电子邮箱：<input id="email" type="text" name="email" size="50"/>
        <input type="submit" value="注册" name="submit" onclick="register()">
    </div>
    <div id="msg"></div>
    ---------------------华丽的分割线-----------------------
    <div id="login">
    	注册邮箱：<input id="l-email" type="text" name="email" size="50"/>
                密 码：<input id="l-password" type="password" name="password" size="20"> 
        <input type="submit" value="登陆" name="submit" onclick="login()">
    </div>
    <div id="loginmsg"></div>
  </body>
</html>
