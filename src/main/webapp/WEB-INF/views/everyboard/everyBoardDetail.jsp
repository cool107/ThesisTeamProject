<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>全体 掲示板 Page</title>

<link
	href="${pageContext.request.contextPath}/resources/vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=M+PLUS+Rounded+1c:400,500,700&amp;subset=japanese"
	rel="stylesheet" type='text/css'>
<link
	href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css"
	rel="stylesheet">
<style>
body {
	font-family: 'M PLUS Rounded 1c', sans-serif;
}

button {
	font-family: 'M PLUS Rounded 1c', sans-serif;
}

th {
	text-align: center;
}

#text {
	font-size: 8px;
	text-align: center;
}

#comment_list_div {
	text-align: center;
}

.dropdown {
	float: right;
}

.link {
	float: right;
}

li {
	color: black;
}

.dropdown-content a:hover {
	background-color: #3C85C4;
	color: white;
}

.badge-counter {
    position: absolute;
    -webkit-transform: scale(.7);
    transform: scale(.7);
    -webkit-transform-origin: top right;
    transform-origin: top right;
    right: -0.3rem;
    margin-top: -.25rem;
    background-color: red;
}
</style>

<script src="resources/js/jquery-3.3.1.js"></script>
<script src="resources/ckeditor/ckeditor.js"></script>
<script>

	$(function() {
		selectMsgCount();
		$('#selectFiveMessages').on('click', selectFive).css('cursor', 'pointer');
		updateHitcount();
		all_comment();
		$("#replyButton").on('click', replyWrite);
		$("#sendMsg").on('click', sendMsg).css('cursor', 'pointer');
		$("#chatForm").on("click", goChatForm).css('cursor', 'pointer');
	});
	
	function selectMsgCount(){
		var toId = '${sessionScope.loginId}';
		$.ajax({
			method : 'get'
			, url : 'selectMsgCount'
			, data : {'toId' : toId}
			, success : function(resp){
				$("#msgCount").text(resp);
			}
		})
	}
	
	function updateHitcount() {
		var everyBoardSeq = $("#everyBoardSeq").val();
		$.ajax({
			method : 'POST'
			, url : 'updateHitcount'
			, data : {'everyBoardSeq' : everyBoardSeq}
		});
	};

	function selectFive() {
		$.ajax({
			method : 'get',
			url : 'selectFiveMessages',
			success : outputMsg,
			error : function(resp) {
				console.log(resp);
			}
		});
	}

	function outputMsg(resp) {

		var content = '<table class="table table-bordered" id="msgTable" cellspacing="0" style="table-layout:fixed; font-size:12px;">';
		if (resp == "") {
			content += '<p style="text-align:center; font-weight: bold; font-size:25px; color:#93b2ec;"><img src="/resources/images/message.svg" style="width:40px;"> ${sessionScope.loginName}様のメッセージ</p>';
			content += '<tr style="text-align:center; font-size:15px;"><td colspan="2">新着メッセージがありません。</td></tr>';
		}
		if (resp != "") {
			content += '<p style="text-align:center; font-weight: bold; font-size:25px; color:#93b2ec;"><img src="/resources/images/message.svg" style="width:40px;"> ${sessionScope.loginName}様のメッセージ</p>';
			$
					.each(
							resp,
							function(index, item) {
								content += '<tr>';
								content += '<td class="fromId" style="width:80px; color:black;">'
										+ item.fromId + '</td>';
								content += '<td class="messageContent" style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap;">'
										+ '<a href = "#" id = "getMessage">'
										+ item.messageContent
										+ '</a>'
										+ '</td>';
								content += '<td class="messageIndate" style="width:200px; color:black;">'
										+ item.messageIndate + '</td>';
								content += '</tr>';
							});
		}

		content += '</table>';
		$('.listOfMessage').html(content);
	};
	
	function replyWrite() {
		var everyBoardSeq = $("#everyBoardSeq").val();
		var everyBoardComment = $("#everyBoardComment").val();
		var rData = {
			"everyBoardSeq" : everyBoardSeq,
			"everyBoardComment" : everyBoardComment
		}
		$.ajax({
			method : 'post',
			url : 'insert_comment',
			data : rData,
			success : all_comment
		});

	}
	
	function all_comment(){
		var everyBoardSeq = $("#everyBoardSeq").val();
		$.ajax({
			method : 'POST'
			, url : 'all_comment'
			, data : {'everyBoardSeq' : everyBoardSeq}
			, success : outputComment
		});
	};
	
	function outputComment(resp) {
		var show = '<table>';
		$.each(resp,function(index, item) {
							show += '<tr class="forreply" reply-sno="'+item.everyBoardCommentSeq+'">';
							show += '<td class="name" style="width:200px;">' + item.id + '</td>';
							show += '<td class="text" style="width:70%;">'
									+ item.everyBoardComment + '</td>';
							show += '<td class="date" style="width:200px;">'
									+ item.everyBoardCommentDate + '</td>';
							if ("${sessionScope.loginId}"== item.id) {
								show += '<td style="width:100px;"><button type="button" class="delBtn btn btn-outline-info" reply-sno="'+item.everyBoardCommentSeq+'" reply-bno="'+item.everyBoardSeq+'">削除</button></td>';
								show += '<td style="width:100px;"><button type="button" class="upBtn btn btn-outline-info"  reply-sno="'+item.everyBoardCommentSeq+'" reply-bno="'+item.everyBoardSeq+'">修正</button></td>';
								show += '<input type="hidden" class="modify" value="'+item.everyBoardSeq+'" reply-bno="'+item.everyBoardSeq+'"/>';
								show += '<input type="hidden" class="modifyComment" value="'+item.everyBoardCommentSeq+'" reply-sno="'+item.everyBoardCommentSeq+'"/>';
							}
							show += '</tr>';
						
						});
		show += '</table>';
		$("#print_reply").empty();
		$("#print_reply").html(show);
		$(".delBtn").on('click', replyDelete);
		$(".upBtn").on('click', replyUpdate);
	}

	function replyDelete(){
		var everyBoardCommentSeq = $(this).attr('reply-sno');
		var everyBoardSeq = $(this).attr('reply-bno');
		
		$.ajax({
			method : 'post',
			url : 'delete_comment',
			data : {
				"everyBoardCommentSeq" : everyBoardCommentSeq,
				"everyBoardSeq" : everyBoardSeq
			},
			success : function(){
				all_comment();
			}
		});
	}
	
	function replyUpdate(){
		var everyBoardCommentSeq = $(this).attr('reply-sno');
		var everyBoardSeq = $(this).attr('reply-bno');

		$.ajax({
					method : 'POST',
					url : 'all_comment',
					data : {'everyBoardSeq' : everyBoardSeq},
					success : function(resp) {
						var show = '<table>';
						$.each(resp,function(index, item) {
											if (item.everyBoardCommentSeq != everyBoardCommentSeq) {
												show += '<tr class="forreply2" reply-sno="'+item.everyBoardCommentSeq+'">';
												show += '<td class="nme" style="width:200px;">'
														+ item.id + '</td>';
												show += '<td class="text" style="width:80%;">'
														+ item.everyBoardComment
														+ '</td>';
												show += '<td class="date" style="width:200px;">'
														+ item.everyBoardCommentDate
														+ '</td>';
												show += '</tr>';
											} else {
												show += '<tr class="forreply2" reply-sno="'+item.everyBoardCommentSeq+'" style="width:100%">';
												show += '<td class="name" style="width:200px;">'+ item.id + '</td>';
			
													show += '<td><input type="text" id="recomment" value="'+item.everyBoardComment+'" style="width:100%;"></td>';
													show += '<td style="width:100px;"><button type="button" class="go_update btn btn-outline-info" reply-sno="'+item.everyBoardCommentSeq+'" reply-bno="'+item.everyBoardSeq+'">修正</button></td>';
													show += '</tr>';												
											}
										});
						show += '</table>';
						
						$("#print_reply").empty();
						$("#print_reply").html(show);
						$(".go_update").on('click', replyUpdate_insert);
					}
				});
	}
	
	function replyUpdate_insert() {
		var everyBoardCommentSeq = $(this).attr('reply-sno');
		var everyBoardSeq = $(this).attr("reply-bno");
		var everyBoardComment = $("#recomment").val();
		
		var data = {
			"everyBoardSeq" : everyBoardSeq,
			"everyBoardComment" : everyBoardComment,
			"everyBoardCommentSeq" : everyBoardCommentSeq
		}
		$.ajax({
			method : 'post',
			url : 'update_comment',
			data : data,
			success : all_comment
		});
	}
	
	function deleteCheck(everyBoardSeq) {
		if (confirm("本当に削除しますか。")) {
			location.href = 'deleteEveryBoard?everyBoardSeq=' + everyBoardSeq;
		}
	}
	
	function sendMsg(){
		var fromId = $(this).attr("data-fromId");
		window.open('/popup', 'text',
				'width=534, height=590, resizable = no, scrollbars = no');
	}
	
	function goChatForm() {
		window.open('/chatForm', 'text',
				'width=610, height=557, resizable = no, scrollbars = no');
	}
		  
</script>
</head>

<body id="page-top">

	<div id="wrapper">

		<ul class="navbar-nav bg-gradient-info sidebar sidebar-dark accordion"
			id="accordionSidebar">
			<li><a
				class="sidebar-brand d-flex align-items-center justify-content-center"
				href="#" style="cursor: auto;">
					<div class="sidebar-brand-icon rotate-n-15">
						<i class="fas fa-laugh-wink"></i>
					</div>
					<div class="sidebar-brand-text mx-3" style="font-size: 20px;">全体
						掲示板</div>
			</a></li>

			<hr class="sidebar-divider my-0">

			<li class="nav-item"><a class="nav-link" href="goEveryBoard">
					<i class="fas fa-book"></i> <span style="font-size: 15px;">掲示板
						ホーム</span>
			</a></li>

			<hr class="sidebar-divider">

			<div class="sidebar-heading">MENU</div>

			<li class="nav-item active"><a class="nav-link"
				href="everyBoard"> <i class="fas fa-chalkboard-teacher"></i> <span>掲示板</span>
			</a></li>

			<li class="nav-item"><a class="nav-link"
				href="all_Every_Calendar"> <i class="fas fa-calendar-alt"></i> <span>スケジュール</span></a>
			</li>

			<hr class="sidebar-divider d-none d-md-block">

		</ul>

		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<nav
					class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
					<ul class="navbar-nav ml-auto">
						<li class="nav-item dropdown no-arrow mx-1">
							<div class="dropdown-toggle" data-toggle="dropdown"
								class="dropdown" id="chatForm">
								<a style="font-size: 25px; color: white;"> <i
									class="fas fa-comments" style="color: gray;"></i>
								</a>
							</div>
						</li>
						<li style="width:10px;"></li>
						<li class="nav-item dropdown no-arrow mx-1">
							<div class="dropdown" id="selectFiveMessages">
								<a class="dropdown-toggle" data-toggle="dropdown"
									style="font-size: 25px; color: white;"> <i
									class="fas fa-envelope" style="color: gray;"></i>
									<span class="badge badge-danger badge-counter" id="msgCount"></span>
								</a>
								<ul class="dropdown-menu dropdown-menu-right" role="menu"
									aria-labelledby="dLabel" id="menu">
									<li><div class="listOfMessage" style="width: 500px;"></div></li>
									<li>
										<div class="dropdown-content">
											<a class="dropdown-item text-center" href="viewAllMessages"
												style="text-align: center; font-size: 15px;">全てのメッセージを見る</a>
										</div>
									</li>
								</ul>
							</div>
						</li>
						<li class="nav-item dropdown no-arrow mx-1"><a href="../"
							style="font-size: 25px; color: white;"><i class="fas fa-home"
								style="color: gray;"></i></a></li>
						<div class="topbar-divider d-none d-sm-block"></div>
						<li class="nav-item dropdown no-arrow"><span
							class="mr-2 d-none d-lg-inline text-gray-600 small"
							style="font-size: 20px;">${sessionScope.loginName} 様</span></li>
					</ul>
				</nav>

				<div class="container-fluid">
					<div class="card shadow mb-4">
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%"
									cellspacing="0">
									<tr style="font-size: 30px;">
										<th colspan="2" style="text-align: left;">${EveryBoard.everyBoardTitle}</th>
									</tr>
									<tr>
										<th style="width: 200px;">作成者</th>
										<td>${EveryBoard.id} 
										<c:if test="${sessionScope.loginId != EveryBoard.id}">
										<span id="sendMsg"><i class="fas fa-paper-plane"></i></span>
										</c:if>										
										</td>
									</tr>
									<tr>
										<th>作成時間</th>
										<td>${EveryBoard.everyBoardDate}</td>
									</tr>
									<tr>
										<th>ヒット</th>
										<td>${EveryBoard.everyBoardHitcount}</td>
									</tr>
									<tr>
										<th>添付ファイル</th>
										<td><c:if test="${EveryBoard.everyBoardOrgname != null}">
												<a
													href="everyBoardDownload?everyBoardSeq=${EveryBoard.everyBoardSeq}">
													${EveryBoard.everyBoardOrgname}</a>
											</c:if></td>
									</tr>
									<tr style="font-size: 30px;">
										<th colspan="2" style="text-align: left;">${EveryBoard.everyBoardContent}</th>
									</tr>

									<c:if test="${loginId == EveryBoard.id}">
										<tr style="text-align: right;">
											<td colspan="2"><a class="btn btn-info"
												href="updateEveryBoard?everyBoardSeq=${EveryBoard.everyBoardSeq}"
												role="button"><i class="fas fa-wrench"></i> 修正</a> <a
												class="btn btn-info"
												href="javascript:deleteCheck(${EveryBoard.everyBoardSeq})"
												role="button"><i class="fas fa-trash-alt"></i> 削除</a> <a
												class="btn btn-info" href="everyBoard" role="button"> <i
													class="fas fa-undo-alt"></i> 戻る
											</a></td>
										</tr>
									</c:if>
									<c:if test="${loginId != EveryBoard.id}">
										<tr style="text-align: right;">
											<td colspan="2"><a class="btn btn-info"
												href="everyBoard" role="button"> <i
													class="fas fa-undo-alt"></i> 戻る
											</a></td>
										</tr>
									</c:if>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="container-fluid" id="commentSpace">
				<div class="card shadow mb-4">
					<div class="card-body" id="commentBody">
						<h3>リプライ</h3>
						<input type="hidden" id="everyBoardSeq"
							value="${EveryBoard.everyBoardSeq}" />
						<textarea rows="3" id="everyBoardComment"
							style="width: 87%; resize: none;"></textarea>
						&nbsp;&nbsp;
						<button type="button" class="btn btn-info" id="replyButton"
							style="vertical-align: top; height: 81px;"
							data-val="${EveryBoard.everyBoardSeq}">リプライ保存</button>
						<div class="card-body" id="print_reply"></div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script src="resources/vendor/jquery/jquery.min.js"></script>
	<script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="resources/vendor/jquery-easing/jquery.easing.min.js"></script>
	<script src="resources/js/sb-admin-2.min.js"></script>
	<script src="resources/vendor/datatables/jquery.dataTables.min.js"></script>
</body>

</html>