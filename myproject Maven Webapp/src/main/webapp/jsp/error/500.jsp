<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>500</title>

	<link rel="shortcut icon" href="./favicon.ico" />
	<link rel="bookmark" href="./favicon.ico" />
    
  </head>
  
  <body BGCOLOR="#FDF5E6">

	<H2>500了，好像哪里不对!</H2>
		
	<span>请点击<A HREF="/myproject">这里</A>回到首页.</span>
	
  </body>
</html>
