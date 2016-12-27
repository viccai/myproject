<%@ page language="java" import="java.util.*,com.vic.model.Manager" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String mpath = request.getServerName() + ":" + request.getServerPort() + path + "/";
	//System.out.println("ip=="+mpath);
%>

<!doctype html>
<html lang="zh-CN">
<head>
<base href="<%=basePath%>">

<title>manager login</title>

<style type="text/css">  
    #connect-container {  
        float: left;  
        width: 400px  
    }  

    #connect-container div {  
        padding: 5px;  
    }  

    #console-container {  
        float: left;  
        margin-left: 15px;  
        width: 400px;  
    }  

    #console {  
        border: 1px solid #CCCCCC;  
        border-right-color: #999999;  
        border-bottom-color: #999999;  
        height: 170px;  
        overflow-y: scroll;  
        padding: 5px;  
        width: 100%;  
    }  

    #console p {  
        padding: 0;  
        margin: 0;  
    }  
</style>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<link rel="stylesheet" type="text/css" href="./css/main-styles.css">

<script src="./js/sockjs.js"></script>
<script src="http://lib.sinaapp.com/js/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript">
	
	var ws = null;
	var url = null;
	var transports = [];

	function setConnected(connected) {
		document.getElementById('connect').disabled = connected;
		document.getElementById('disconnect').disabled = !connected;
		document.getElementById('echo').disabled = !connected;
		document.getElementById('echo_file').disabled = !connected;
		document.getElementById('send_video').disabled = !connected;
	}

	function connect() {
		//alert(url);  
		//console.log(url);  
		if (!url) {
			alert('Select whether to use W3C WebSocket or SockJS');
			return;
		}

		//ws = (url.indexOf('sockjs') != -1) ?new SockJS(url, undefined, {protocols_whitelist: transports}) : new WebSocket(url);  
		if ('WebSocket' in window) {
			ws = new WebSocket("ws://<%=mpath %>websck");
			console.log("ws://<%=mpath %>websck");
		} else {
			ws = new SockJS("http://<%=mpath %>sockjs/websck");
			console.log("http://<%=mpath %>sockjs/websck");
		}
		//websocket = new SockJS("http://localhost:8080/SpringWebSocketPush/sockjs/websck");  
		ws.onopen = function() {
			//alert('open');
			setConnected(true);
			//log('Info: connection opened.');  
		};
		ws.onmessage = function(event) {
			//alert('Received:' + event.data);
			//log('Received: ' + event.data);
			
			if(typeof(event.data)=="string"){  
				log('Received: ' + event.data);
				var img = document.getElementById("imgDiv");  
   				//img.innerHTML = "<img src = "+url+" />";
                img.innerHTML = "<video src = "+event.data+" autoplay></video>";
		    }else{  
		    	var reader = new FileReader();  
		        reader.onload = function(event){  
		            if(event.target.readyState == FileReader.DONE){  
		                var url = event.target.result;  
		    			//alert(url);  
		                var img = document.getElementById("imgDiv");  
		   				//img.innerHTML = "<img src = "+url+" />";
		                img.innerHTML = "<video src = "+url+" autoplay></video>";
		            }  
		        };
		        reader.readAsDataURL(event.data);
		    }
			
		};
		ws.onclose = function(event) {
			setConnected(false);
			log('Info: connection closed.');
			log(event);
		};
	}

	function disconnect() {
		if (ws != null) {
			ws.close();
			ws = null;
		}
		setConnected(false);
	}

	function echo() {
		if (ws != null) {
			var message = document.getElementById('message').value;
			log('Sent: ' + message);
			ws.send(message);
		} else {
			alert('connection not established, please connect.');
		}
	}
	//发送文件
	function echo_file() {
		if (ws != null) {
			
			//var inputElement = document.getElementById("file");
			//var file = inputElement.files;
			//var reader = new FileReader();
			//以二进制形式读取文件
			//reader.readAsArrayBuffer(file);
			//文件读取完毕后该函数响应
			//reader.onload = function loaded(evt) {
			        //var binaryString = evt.target.result;
			        //log('Sent: file');
			        //发送文件
			        //ws.send(binaryString);
			//};
			
			var inputElement = document.getElementById("file");
	        var fileList = inputElement.files;
	        
	        for ( var i = 0; i < fileList.length; i++) {
	            console.log(fileList[i]);
	            log(fileList[i].name);
	            //发送文件名
	            ws.send(fileList[i].name);
				//reader.readAsBinaryString(fileList[i]);
				//读取文件
				var reader = new FileReader();
	            reader.readAsArrayBuffer(fileList[i]);
				//reader.readAsText(fileList[i]);
				//文件读取完毕后该函数响应
				var size = fileList[i].size;
				
	            reader.onload = function loaded(evt) {
	                var binaryString = evt.target.result;
	                // Handle UTF-16 file dump
	                log("\n开始发送文件");
	                //alert("开始发送文件");
	                //alert("开始发送2:"+size);
	                ws.send(binaryString,size);
	                alert("wang");
	            };
	        }
	        return false;
			
		} else {
			alert('connection not established, please connect.');
		}
	}
	
	function send_video(){
		if (ws != null) {
			
			var getUserMedia = (navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia);

			getUserMedia.call(navigator, {
				video: true,
				audio: true
			}, function(localMediaStream) {
				var video = document.getElementById('video');
				video.src = window.URL.createObjectURL(localMediaStream);
				video.onloadedmetadata = function(e) {
					console.log("Label: " + localMediaStream.label);
					console.log("AudioTracks" , localMediaStream.getAudioTracks());
					console.log("VideoTracks" , localMediaStream.getVideoTracks());
				};
				
				//alert(localMediaStream);
				
				
				/*var reader = new FileReader();
	            reader.readAsArrayBuffer(fileList[i]);
				//reader.readAsText(fileList[i]);
				//文件读取完毕后该函数响应
				var size = fileList[i].size;
				
	            reader.onload = function loaded(evt) {
	                var binaryString = evt.target.result;
	                // Handle UTF-16 file dump
	                log("\n开始发送文件");
	                ws.send(binaryString,size);
	            };*/
	            /*alert("1:"+localMediaStream);
	            alert("2:"+URL.createObjectURL(localMediaStream));
	            alert("3:"+window.URL.createObjectURL(localMediaStream));
	            if (localMediaStream instanceof Blob){
	            	alert("1这是blob");
	            }
	            if (URL.createObjectURL(localMediaStream) instanceof Blob){
	            	alert("2这是blob");
	            }
	            if (window.URL.createObjectURL(localMediaStream) instanceof Blob){
	            	alert("3这是blob");
	            }*/
	            //var reader = new FileReader();
	            //reader.readAsBinaryString(window.URL.createObjectURL(localMediaStream));
	            
	            //alert(reader.size);
				ws.send(window.URL.createObjectURL(localMediaStream));
	            
			}, function(e) {
				console.log('Reeeejected!', e);
			});
			
		} else {
			alert('connection not established, please connect.');
		}
	}

	function updateUrl(urlPath) {
		if (urlPath.indexOf('sockjs') != -1) {
			url = urlPath;
			document.getElementById('sockJsTransportSelect').style.visibility = 'visible';
		} else {
			if (window.location.protocol == 'http:') {
				url = 'ws://' + window.location.host + urlPath;
			} else {
				url = 'wss://' + window.location.host + urlPath;
			}
			document.getElementById('sockJsTransportSelect').style.visibility = 'hidden';
		}
	}

	function updateTransport(transport) {
		alert(transport);
		transports = (transport == 'all') ? [] : [ transport ];
	}

	function log(message) {
		var console = document.getElementById('console');
		var p = document.createElement('p');
		p.style.wordWrap = 'break-word';
		p.appendChild(document.createTextNode(message));
		console.appendChild(p);
		while (console.childNodes.length > 25) {
			console.removeChild(console.firstChild);
		}
		console.scrollTop = console.scrollHeight;
	}
	
	$(document).ready(function(){  
	    //$("#a").click(function(){  
	        var url = 'http://chaxun.1616.net/s.php?type=ip&output=json&callback=?&_='+Math.random();    
	        $.getJSON(url, function(data){
				//alert(data);
	            $("#b").html("显示：IP【"+data.Ip+"】 地址【"+data.Isp+"】 浏览器【"+data.Browser+"】 系统【"+data.OS+"】");  
	        });   
	    //});  
	});  
	
</script>

</head>
<%
	session.setAttribute("user", ((Manager)request.getSession().getAttribute("manager")).getUuid());
%>
<body class="body">
	<c:if test="${manager!=null}">welcome:${manager.username}</c:if>
	
	<noscript>
		<h2 style="color: #ff0000">Seems your browser doesn't support
			Javascript! Websockets rely on Javascript being enabled. Please
			enable Javascript and reload this page!</h2>
	</noscript>
	<div>
		<br>
		<div id="connect-container">
			<input id="radio1" type="radio" name="group1"
				onclick="updateUrl('/myproject/websck');"> <label
				for="radio1">W3C WebSocket</label> <br> <input id="radio2"
				type="radio" name="group1"
				onclick="updateUrl('/myproject/sockjs/websck');"> <label
				for="radio2">SockJS</label>
			<div id="sockJsTransportSelect" style="visibility:hidden;">
				<span>SockJS transport:</span> <select
					onchange="updateTransport(this.value)">
					<option value="all">all</option>
					<option value="websocket">websocket</option>
					<option value="xhr-polling">xhr-polling</option>
					<option value="jsonp-polling">jsonp-polling</option>
					<option value="xhr-streaming">xhr-streaming</option>
					<option value="iframe-eventsource">iframe-eventsource</option>
					<option value="iframe-htmlfile">iframe-htmlfile</option>
				</select>
			</div>
			<div>
				<button id="connect" onclick="connect();">Connect</button>
				<button id="disconnect" disabled="disabled" onclick="disconnect();">Disconnect</button>
			</div>
			<div>
				<textarea id="message" style="width: 350px">Here is a message!</textarea>
			</div>
			<div>
				<button id="echo" onclick="echo();" disabled="disabled">Echo
					message</button>
			</div>
			<!-- send file start -->
			<div>
				<input id="file" type="file" multiple />
			</div>
			<div>
				<button id="echo_file" onclick="echo_file();" disabled="disabled">Echo
					file</button>
			</div>
			<div>
				<button id="send_video" onclick="send_video();" disabled="disabled">video</button>
			</div>
			<!-- send file end -->
		</div>
		<div id="console-container">
			<div id="console"></div>
		</div>
		<div id="imgDiv"></div>
		<video id="video" autoplay></video>
	</div>
	
	<a href="javascript:;" style="margin-left:100px;"><span id="a" style="color: #000;font-size:18px;border:#000 0px solid;">Click Me</span></a>  
    <br/>  
    <br/>  
    <br/>  
    <br/>  
    <span id="b" style="color: #000;font-size:18px;border:#000 0px solid;">显示：点击上方【Click Me】显示ip详情！</span>
	
</body>
</html>
