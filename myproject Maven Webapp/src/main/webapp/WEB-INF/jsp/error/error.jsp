<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>404: Not Found</title>

  </head>
  
  <body BGCOLOR="#FDF5E6">

	<H2>404了，好像哪里不对!</H2>
		
	<li>请点击<A HREF="/myproject">这里</A>回到首页.</li>
	
  </body>
</html>
