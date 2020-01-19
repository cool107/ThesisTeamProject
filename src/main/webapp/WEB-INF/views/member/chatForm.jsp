<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>チャット Page</title>

<link
	href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">

<!-- Page level plugin CSS-->
<link
	href="${pageContext.request.contextPath}/resources/vendor/datatables/dataTables.bootstrap4.css"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link
	href="${pageContext.request.contextPath}/resources/css/sb-admin.css"
	rel="stylesheet">

<link
	href="https://fonts.googleapis.com/css?family=M+PLUS+Rounded+1c:400,500,700&amp;subset=japanese"
	rel="stylesheet" type='text/css'>
<style>
body {
	font-family: 'M PLUS Rounded 1c', sans-serif;
}

input {
	font-family: 'M PLUS Rounded 1c', sans-serif;
}

#chatroom {
	width: 100%;
	height: 430px;
	border: 1px solid;
	border-radius: 10px;
	border-color: gray;
	padding: 10px;
}

.balloon {
	position: relative; width : 120px; height : 50px; padding : 0px;
	background : #f6c23e; -webkit-border-radius : 10px; -moz-border-radius
	: 10px;
	border-radius: 10px;
	width: 120px;
	height: 50px;
	padding: 0px;
	background: #f6c23e;
	-webkit-border-radius: 10px;
	-moz-border-radius: 10px;
}

.balloon:after {
	content: '';
	position: absolute;
	border-style: solid;
	border-width: 9px 0 9px 13px;
	border-color: transparent #f6c23e;
	display: block;
	width: 0;
	z-index: 1;
	right: -13px;
	top: 16px;
}

.bubble 
{
position: relative;
width: 120px;
height: 50px;
padding: 0px;
background: #FFFFFF;
-webkit-border-radius: 10px;
-moz-border-radius: 10px;
border-radius: 10px;
}

.bubble:after 
{
content: '';
position: absolute;
border-style: solid;
border-width: 10px 10px 10px 0;
border-color: transparent #FFFFFF;
display: block;
width: 0;
z-index: 1;
left: -10px;
top: 15px;
}
</style>
<script src="resources/js/jquery-3.3.1.js"></script>
<script src="resources/js/sockjs.js"></script>
<script src="resources/js/stomp.js"></script>
<script>
	var flag=true;
	$(function() {
		connect();

		$("#send").on("click", function() {
			sendMessage();
		})

		document.onkeydown = function(event) {
			if (event.keyCode == 116 || event.ctrlKey == true
					&& (event.keyCode == 82)) {
				disconnect();
				event.cancelBubble = true;
				event.returnValue = false;
				setTimeout(function() {
					window.location.reload();
				}, 100);
				return false;
			}
		}
	})

	var stompClient = null;

	function connect() {
		var roomNum = ${sessionScope.loginGroupBoardNum};
		var socket = new SockJS('/endpoint');
		stompClient = Stomp.over(socket);
		stompClient.connect({},function(frame) {
			stompClient.subscribe('/subscribe/chat/' + roomNum,function(message) {
						var data = JSON.parse(message.body);
						if('${sessionScope.loginId}' == data.id){
						$("#chatMsg").append(
						'<li style="padding:10px;"><div class="balloon" style="text-align:left; padding:10px;width:100%;">'+ data.message+ '</div></li>');
						} else {
						$("#chatMsg").append(
						'<li style="padding:10px;"><div class="bubble" style="text-align:left; padding:10px;width:100%;">'+ data.message+ '</div></li>');
						}
					});

				});
	}

	function sendMessage() {
		var roomNum = ${sessionScope.loginGroupBoardNum};
		var str = $("#chatbox").val();
		str = str.replace(/ /gi, '&nbsp;')
		str = str.replace(/(?:\r\n|\r|\n)/g, '<br />');
		if (str.length > 0) {
			stompClient.send("/chat/" + roomNum, {}, JSON.stringify({
				message : str
			}));

		}

		$("#chatbox").val("");
	}

	function disconnect() {
		stompClient.disconnect();
	}
</script>
</head>
<body id="page-top">
	<nav class="navbar navbar-expand navbar-dark bg-warning static-top">
		<a class="navbar-brand mr-1" style="font-size: 25px; color: white;">チャット</a>
	</nav>
	<div style="padding: 18px;">
		<div id="chatroom" style="background-color: #9bbbd4;">
			<ul style="list-style-type: none;" id="chatMsg">
			</ul><br>
		</div>
		<br>
		<textarea style="width: 88%; border-radius: 10px;" id="chatbox"></textarea>
		<input type="button" class="btn btn-warning" value="伝送" id="send"
			style="vertical-align: top; height: 57px; color: white;">
	</div>
	</div>

	<script
		src="<c:url value="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"/>"></script>
	<script
		src="<c:url value="/resources/vendor/jquery-easing/jquery.easing.min.js"/>"></script>
	<script
		src="<c:url value="/resources/vendor/datatables/jquery.dataTables.js"/>"></script>
	<script
		src="<c:url value="/resources/vendor/datatables/dataTables.bootstrap4.js"/>"></script>
	<script src="<c:url value="/resources/js/sb-admin.min.js"/>"></script>
</body>
</html>