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

<title>ManagerList</title>

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
		window.location.href = "manager/getManagerList?pageNo=" + pageno;
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
	function toAddManager(){
		$("#manager-edit").css('display','none');
		$("#manager-add").css('display','block');
	}
	function checkUsername(){
		var username = $("#add-username").attr("value");
		
		$.ajax({
		    type : "POST",
		    dataType: "json",
		    url : "manager/checkManagerUsername?username="+username,
		    success : function(data) {
		        if(data.resultCode==-1){
		        	$("#add-user-msg").html("&times;");
		        }
		        if(data.resultCode==1){
		        	$("#add-user-msg").html("&radic;");
		        }
		    },
		    error : function(data) {
		        // 输出错误信息;
		        console.log(data.info);
		    }
		});
	}
	function addManager(){
		var username = $("#add-username").attr("value");
		var password = $("#add-password").attr("value");
		
		$.ajax({
		    type : "POST",
		    dataType: "json",
		    url : "manager/addManager?username="+username+"&password="+password,
		    success : function(data) {
		        if(data.resultCode==-1){
		        	// 输出错误信息;
			        console.log("增加用户失败");
			        $("#add-manager-msg").html(data.msg);
		        }
		        if(data.resultCode==1){
		        	window.location.href = "manager/getManagerList";
		        }
		    },
		    error : function(data) {
		        // 输出错误信息;
		        console.log(data.info);
		    }
		});
	}
	function deleteManager(uuid){
		$.ajax({
		    type : "POST",
		    dataType: "json",
		    url : "manager/deleteManager?uuid="+uuid,
		    success : function(data) {
		        if(data.resultCode==-1){
		        	// 输出错误信息;
			        console.log("修改信息不成功");
		        }
		        if(data.resultCode==1){
		        	window.location.href = "manager/getManagerList?pageNo=" + ${page.pageNo};
		        }
		    },
		    error : function(data) {
		        // 输出错误信息;
		        console.log(data.info);
		    }
		});
	}
	function editManager(uuid){
		$.ajax({
		    type : "POST",
		    dataType: "json",
		    url : "manager/findManager?uuid="+uuid,
		    success : function(data) {
		        if(data.resultCode==-1){
		        	// 输出错误信息;
			        console.log("用户不存在");
		        }
		        if(data.resultCode==1){
		        	var html="";
					html += "<div class='edit-form'>";
					html += "<div class='edit-form-line-one'>";
		        	html += "<input id='uuid' type='hidden' name='uuid' value='"+data.resultUser.uuid+"' />";
		        	html += "<input id='type' type='hidden' name='type' value='"+data.resultUser.type+"' />";
			    	html += "<span class='edit-title'>用户名：</span>";
					html += "<input id='username' class='edit-input' type='text' name='username' readOnly='true' value='"+data.resultUser.username+"'/>";
					html += "</div><div class='edit-form-line-two'>";
			        html += "<span class='edit-title'>密&nbsp;码：</span>";
					html += "<input id='password' class='edit-input' type='password' name='password' value='"+data.resultUser.password+"'/>";
			        html += "</div><div class='edit-form-line-three'>";
			        html += "<input class='edit-buttom' type='submit' value='确定' onclick='update()'>";
			        html += "<input class='edit-buttom' type='submit' value='取消' onclick='editCancle()'>";
					html += "</div></div>";
			        $("#edit").html(html);
		        	$("#manager-edit").css('display','block');
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
		var type = $("#type").attr("value");
		
		$.ajax({
		    type : "POST",
		    dataType: "json",
		    url : "manager/updateManager?uuid="+uuid+"&username="+username+"&password="+password+"&type="+type,
		    success : function(data) {
		        if(data.resultCode==-1){
		        	// 输出错误信息;
			        console.log("修改信息不成功");
		        }
		        if(data.resultCode==1){
		        	window.location.href = "manager/getManagerList?pageNo=" + ${page.pageNo};
		        }
		    },
		    error : function(data) {
		        // 输出错误信息;
		        console.log(data.info);
		    }
		});
	
	}
	function editCancle(){
		$("#manager-edit").css('display','none');
	}
	function addCancle(){
		$("#manager-add").css('display','none');
	}
</script>

</head>

<body class="body">
	<div id="manager-list" class="user-list">
		<span>用户管理&rarr;管理员列表&nbsp;&spades;<button onclick="toAddManager()">增加</button>&spades;</span>
		<table>
			<tr>
				<td>用户名</td>
				<td>类型</td>
				<td>密码</td>
				<td>创建时间</td>
				<td>操作</td>
			</tr>
			<c:forEach items="${managerList}" var="manager">
				<tr>
					<td>${manager.username}</td>
					<td>${manager.type}</td>
					<td>${manager.password}</td>
					<td><fmt:formatDate value='${manager.createDatetime}'
							pattern='yyyy-MM-dd HH:mm:ss' /></td>
					<td>
						<button onclick="deleteManager('${manager.uuid}')">删除</button>
						<button onclick="editManager('${manager.uuid}')">修改</button>
					</td>
				</tr>
			</c:forEach>
		</table>
		<div id="page-bottom"></div>
	</div>
	<div id="manager-edit" class="manager-edit">
		<div class="manager-box" onclick="editCancle()">
		</div>
		<div id="edit" class="edit">
		</div>
	</div>
	<div id="manager-add" class="manager-add">
		<div class="manager-box" onclick="addCancle()">
		</div>
		<div id="add" class="add">
			<div class="add-form">
		    	<div class="add-form-line-one">
			    	<span class="add-title">用户名：</span>
			    	<input id="add-username" class="add-input" type="text" name="add-username" onchange="checkUsername()">
			    	<span id="add-user-msg" class="add-msg"></span>
		    	</div>
		    	<div class="add-form-line-two">
			    	<span class="add-title">密&nbsp;码：</span>
			    	<input id="add-password" class="add-input" type="password" name="add-password" >
		        </div>
		        <div class="add-form-line-three">
			        <input class="add-buttom" type="submit" value="增加" name="submit" onclick="addManager()">
			        <input class="add-buttom" type="submit" value="取消" name="submit" onclick="addCancle()">
			    </div>
			    <span id="add-manager-msg" class="add-msg"></span>
	        </div>
		</div>
	</div>
</body>
</html>
