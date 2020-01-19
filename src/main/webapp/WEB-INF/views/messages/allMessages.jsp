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

<title>メッセージ Page</title>

<!-- Custom fonts for this template-->
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

a {
	color: green;
}

title {
	text-align: center;
}

</style>
<script src="resources/js/jquery-3.3.1.js"></script>
<script>
	$(function() {
		toAllMessages();
		$("#profile-tab").on('click', fromAllMessages);
	});
	
	function fromAllMessages(){
		$.ajax({
			method : 'GET',
			url : 'fromAllMessages',
			success : function(resp) {
				fromoutput(resp);
			}
		});
	}
	
	function fromoutput(resp){
		var content = '<table class="table table-bordered" id="messageTable" style="width:100%;" cellspacing="0">';
		content += '<tr><th style="text-align: center;">発信者</th><th style="text-align: center;">内容</th><th style="text-align: center;">日付</th></tr>';
		if (resp == "") {
			content += '<tr><td colspan="5" style="text-align:center;">メッセージはありません。</td></tr>';
		}
		if (resp != "") {
			$
					.each(
							resp,
							function(index, item) {
								content += '<tr>';
								content += '<td class="toId" style="text-align:center; width:180px; vertical-align:middle;">'
										+ item.toId + '</td>';
								content += '<td class="messageContent"  style="vertical-align:middle;">'
										+ '<div class = "getSendMessage" style = "color:blue; text-align:left;" data-val = "'+item.msg_seq+'">'
										+ item.messageContent
										+ '</div>'
										+ '</td>';
								content += '<td class="messageIndate" style="width:290px; text-align:center; vertical-align:middle;">'
										+ item.messageIndate + '</td>';
								content += '</tr>';
							});
		}

		content += '</table>';

		$('#messagesSendData').html(content);
		var a = $('.getSendMessage').on('click', getSendMsg);
		a.css('cursor', 'pointer');
		$('.newMsg').on('click', respMsg);
	}
	
	function getSendMsg(){
		var num = $(this).attr("data-val");
		$.ajax({
			method : 'get',
			url : 'getMsg',
			data : {
				"msg_seq" : num
			},
			success : function(resp) {
				outFromMsg(resp);
			},
			error : function(resp) {
				console.log(resp);
			}

		});
	}
	
	function outFromMsg(resp){
		var content = '<table class="table table-bordered" id="oneMsgTable" width="100%" cellspacing="0">';
		content += '<tr><th style="font-size:18px;">' + resp.toId
				+ ' 様に<br>受信時間' + resp.messageIndate + '</th></tr>';
		content += '<tr><th style="font-size:20px;">' + resp.messageContent
				+ '</th></tr>';
		content += '</table>';
		content += '<div style="float:right;"><a class="btn btn-outline-success" href="viewAllMessages" role="button" style="font-weight:bold;">戻る</a></div>';

		$('.card-body').html(content);
	}

	function toAllMessages() {
		$.ajax({
			method : 'GET',
			url : 'toAllMessages',
			success : function(resp) {
				output(resp);
			}
		});
	};

	function output(resp) {
		var content = '<table class="table table-bordered" id="messageTable" style="width:100%;" cellspacing="0">';
		content += '<tr><th style="text-align: center;">削除</th><th style="text-align: center;">送信者</th><th style="text-align: center;">内容</th><th style="text-align: center;">日付</th><th style="text-align: center;">備考</th></tr>';
		if (resp == "") {
			content += '<tr><td colspan="5" style="text-align:center;">メッセージはありません。</td></tr>';
		}
		if (resp != "") {
			$
					.each(
							resp,
							function(index, item) {
								content += '<tr><td style="text-align:center; width:100px; vertical-align:middle;"><input class="delCheck" type = "checkbox" value = "'+item.msg_seq+'"></td>';
								content += '<td class="fromId" style="text-align:center; width:180px; vertical-align:middle;">'
										+ item.fromId + '</td>';
								content += '<td class="messageContent"  style="vertical-align:middle;">'
										+ '<div class = "getMessage" style = "color:blue; text-align:left;" data-val = "'+item.msg_seq+'">'
										+ item.messageContent
										+ '</div>'
										+ '</td>';
								content += '<td class="messageIndate" style="width:290px; text-align:center; vertical-align:middle;">'
										+ item.messageIndate + '</td>';
								if (item.messageContent.includes("招待") == true
										&& item.confirm == 0) { //보낸내용이 초대가 포함될 경우에만 승낙 버튼이 뜨도록
									content += '<td class="memberCheck" style="text-align:center; width:150px; vertical-align:middle;"><button class="btn btn-primary" id="agree" style="width: 100px; font-weight: bold;" data-val = "'+item.applicationSeq+'" data-value = "'+item.msg_seq+'">承知</button></td>';
								} else {
									content += '<td class="memberCheck" style="text-align:center; width:150px;vertical-align:middle;">-</td>';
								}
								content += '</tr>';
							});
		}

		content += '</table>';

		$('#messagesData').html(content);
		$('#deleteMsg').on('click', deleteMsg);
		var a = $('.getMessage').on('click', getMsg);
		a.css('cursor', 'pointer');
		$('.newMsg').on('click', respMsg);
		$("#agree").on('click', check);
	};

	//메시지 삭제 1
	function deleteMsg() {
		//체크 되었는지 검사 후 데이터를 넘긴다.
		var check_flag = false;
		var test = "";
		$.each($('.delCheck'), function(index, item) {
			if ($(this).prop("checked")) {
				var temp = $(this).val();
				test += temp;
				test += ",";
				check_flag = true;
				return check_flag;
			}
		})
		alert(test);
		deleteMessage(test);

		if (!check_flag) {
			alert('한개 이상을 선택해 주세요.');
		}

	}

	function deleteMessage(test) {
		$.ajax({
			method : 'GET',
			url : 'deleteMsg',
			data : {
				"msg_seq" : test
			},
			success : function(res) {
				if (res == 1) {
					alert('削除成功');//test
					allMessages();
				} else {
					alert('失敗しました。');//test
				}
			},
			error : function(e) {
				console.log(e);
			}

		});

	}
	//메시지 1개만 출력
	function getMsg() {
		var num = $(this).attr("data-val");

		$.ajax({
			method : 'GET',
			url : 'updateMessageCheck',
			data : {
				"msg_seq" : num
			}
		});

		$.ajax({
			method : 'get',
			url : 'getMsg',
			data : {
				"msg_seq" : num
			},
			success : function(resp) {
				outMsg(resp);
			},
			error : function(resp) {
				console.log(resp);
			}

		});

	}

	function outMsg(resp) {

		var content = '<table class="table table-bordered" id="oneMsgTable" width="100%" cellspacing="0">';
		content += '<tr><th style="font-size:18px;">' + resp.fromId
				+ ' 様から<br>受信時間' + resp.messageIndate + '</th></tr>';
		content += '<tr><th style="font-size:20px;">' + resp.messageContent
				+ '</th></tr>';
		content += '</table>';
		content += '<div style="float:right;"><input type = "button" value = "返事" id = "respMsg" data-fromId = '+resp.fromId+' class="btn btn-outline-success" style="font-weight: bold;">&nbsp;';
		content += '<a class="btn btn-outline-success" href="viewAllMessages" role="button" style="font-weight:bold;">戻る</a></div>';

		$('.card-body').html(content);
		$('#respMsg').on('click', respMsg);
	};

	//메시지 보내는 자식창으로
	function respMsg() {
		var fromId = $(this).attr("data-fromId");//TODO
		window.open('/popup', 'text',
				'width=484, height=524, resizable = no, scrollbars = no');

	}

	function check() {
		var applicationSeq = $(this).attr("data-val");
		var msg_seq = $(this).attr("data-value");

		$.ajax({
			method : 'POST',
			url : 'updateMemberCheck',
			data : {
				'applicationSeq' : applicationSeq,
				'msg_seq' : msg_seq
			},
			success : function(resp) {
				if (resp == 0) {
					alert("失敗しました。");
					return;
				} else {
					toAllMessages();
				}
			}
		});
	};
</script>
</head>

<body id="page-top">

	<nav class="navbar navbar-expand navbar-dark bg-success static-top">
		<a class="navbar-brand mr-1" style="font-size: 25px; color: white;"><i class="fas fa-dove"></i> メッセージ</a>
		<div
			class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
			<a href="../" style="font-size: 25px; color: white;"><i
				class="fas fa-home"></i></a>
		</div>
	</nav>

	<div id="wrapper">
		<div id="content-wrapper">
			<div class="container-fluid">

				<!-- DataTables Example -->
				<div class="card mb-3">
					<div class="card-header" style="font-size: 25px;">
						<i class="fas fa-envelope-open-text"></i> メッセージ
					</div>
					<div class="card-body">
	<ul class="nav nav-tabs" id="myTab" role="tablist">
  <li class="nav-item">
    <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="発信" aria-selected="true">発信</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="送信" aria-selected="false">送信</a>
  </li>
</ul>
<div class="tab-content" id="myTabContent">
  <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
  <br>
  	<div style="float:right;"><input type="button" value="削除" id="deleteMsg"
							class="btn btn-outline-success" style="font-weight: bold;">&nbsp;
						<input type="button" value="新しいメッセージ"
							class="newMsg btn btn-outline-success" style="font-weight: bold;"></div>
						<br> <br>
						<div class="table-responsive" id="messagesData"></div>
  </div>
  <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
  <br>
  	  	<div style="float:right;">
						<input type="button" value="新しいメッセージ"
							class="newMsg btn btn-outline-success" style="font-weight: bold;"></div>
						<br> <br>
						<div class="table-responsive" id="messagesSendData"></div>
  </div>
</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /.content-wrapper -->
	</div>
	<!-- /#wrapper -->


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