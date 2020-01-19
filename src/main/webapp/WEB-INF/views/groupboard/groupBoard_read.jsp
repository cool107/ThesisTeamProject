
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

	.dropdown-content a:hover {
		background-color: #3C85C4; color:white;
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
<script type="text/javascript">
	$(function() {
		selectMsgCount();
		$("#go_groupBoard").on('click', go_groupBoard);
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
	
	function go_groupBoard() {
		location.href = "groupboard_list";
	}

	$(function() {
		$("#replyButton").on('click', replyWrite);
		$('#selectFiveMessages').on('click', selectFive).css('cursor', 'pointer');
		$("#chatForm").on("click", goChatForm).css('cursor', 'pointer');
		init();
	});
	
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
			content += '<p style="text-align:center; font-weight: bold; font-size:25px; color:#1cc88a;"><i class="fas fa-dove fa-lg" style="color:#1cc88a;"></i> ${sessionScope.loginName}様のメッセージ</p>';
			content += '<tr style="text-align:center; font-size:15px;"><td colspan="2">新着メッセージがありません。</td></tr>';
		}
		if (resp != "") {
			content += '<p style="text-align:center; font-weight: bold; font-size:25px; color:#1cc88a;"><i class="fas fa-dove fa-lg" style="color:#1cc88a;"></i> ${sessionScope.loginName}様のメッセージ</p>';
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
	
	//리플 입력
	function replyWrite() {
		var groupBoardSeq = $("#groupBoardSeq").val();
		var groupBoardComment = $("#groupBoardComment").val();
		var rData = {
			"groupBoardSeq" : groupBoardSeq,
			"groupBoardComment" : groupBoardComment
		}
		$.ajax({
			method : 'post',
			url : 'groupBoard_replyWrite',
			data : rData,
			success : init
		});

	}
	//리플 리스트
	function init() {
		var groupBoardSeq = $("#groupBoardSeq").val();
		$.ajax({
			method : 'get',
			url : 'groupBoard_replylist',
			data : {
				'groupBoardSeq' : groupBoardSeq
			},
			success : showreply
		});

	}
	//리플 리스트 반복문
	function showreply(resp) {
		var show = '<table>';
		$.each(resp,function(index, item) {
							show += '<tr class="forreply" reply-sno="'+item.groupBoardCommentSeq+'">';
							show += '<td class="name" style="width:200px;">' + item.gbcid + '</td>';
							show += '<td class="text" style="width:70%;">'
									+ item.groupBoardComment + '</td>';
							show += '<td class="date" style="width:200px;">'
									+ item.groupBoardCommentDate + '</td>';
							if ("${sessionScope.loginId}"== item.gbcid) {
								show += '<td style="width:100px;"><button type="button" class="delBtn btn btn-outline-primary " reply-sno="'+item.groupBoardCommentSeq+'" reply-bno="'+item.groupBoardSeq+'">削除</button></td>';
								show += '<td style="width:100px;"><button type="button" class="upBtn btn btn-outline-primary" reply-sno="'+item.groupBoardCommentSeq+'"reply-bno="'+item.groupBoardSeq+'">修正</button></td>';
								show += '<input type="hidden" class="modify" value="'+item.groupBoardSeq+'" reply-bno="'+item.groupBoardSeq+'"/>';
								show += '<input type="hidden" class="modifyComment" value="'+item.groupBoardCommentSeq+'" reply-sno="'+item.groupBoardCommentSeq+'"/>';
							}
							show += '</tr>';
						
						});
		show += '</table>';
		$("#print_reply").empty();
		$("#print_reply").html(show);
		$(".delBtn").on('click', replyDelete);
		$(".upBtn").on('click', replyUpdate);
	}

	//리플삭제
	function replyDelete() {
		var groupBoardCommentSeq = $(this).attr('reply-sno');
		var groupBoardSeq = $(this).attr('reply-bno');
		
		$.ajax({
			method : 'post',
			url : 'groupBoard_replyDelete',
			data : {
				"groupBoardCommentSeq" : groupBoardCommentSeq,
				"groupBoardSeq" : groupBoardSeq
			},
			success : function(){
				init();
				}
		});
	}

	//리플업뎃 반복문
	function replyUpdate() {
		var groupBoardCommentSeq = $(this).attr('reply-sno');
		var groupBoardSeq = $(this).attr('reply-bno');
		$.ajax({method : 'get',
					url : 'groupBoard_replylist',
					data : {
						'groupBoardSeq' : groupBoardSeq
					},
					success : function(resp) {
						var show = '<table>';
						$.each(resp,function(index, item) {
											if (item.groupBoardCommentSeq != groupBoardCommentSeq) {
												show += '<tr class="forreply2" reply-sno="'+item.groupBoardCommentSeq+'">';
												show += '<td class="name" style="width:200px;">'
														+ item.gbcid + '</td>';
												show += '<td class="text" style="width:80%;">'
														+ item.groupBoardComment
														+ '</td>';
												show += '<td class="date" style="width:200px;">'
														+ item.groupBoardCommentDate
														+ '</td>';
												show += '</tr>';
											} else {
												show += '<tr class="forreply2" reply-sno="'+item.groupBoardCommentSeq+'" style="width:100%">';
												show += '<td class="name" style="width:200px;">'+ item.gbcid + '</td>';
												show += '<td><input type="text" id="recomment" value="'+item.groupBoardComment+'" style="width:100%;"></td>';
												show += '<td style="width:100px;"><button type="button" class="go_update btn btn-outline-primary" reply-sno="'+item.groupBoardCommentSeq+'" reply-bno="'+item.groupBoardSeq+'">修正</button></td>';
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

	//리플 업뎃
	function replyUpdate_insert() {
		var groupBoardCommentSeq = $(this).attr("reply-sno");
		var groupBoardSeq = $(this).attr("reply-bno");
		var groupBoardComment = $("#recomment").val();
		var data = {
			"groupBoardSeq" : groupBoardSeq,
			"groupBoardComment" : groupBoardComment,
			"groupBoardCommentSeq" : groupBoardCommentSeq
		}
		$.ajax({
			method : 'post',
			url : 'groupBoard_replyUpdate',
			data : data,
			success : init
		});
	}

	//글삭제시 확인 스크립트
	function deleteCheck(groupBoardSeq) {
		if (confirm("本当に削除しますか。")) {
			location.href = 'groupBoard_delete?groupBoardSeq=' + groupBoardSeq;
		}
	}
	
	function goChatForm() {
		window.open('/chatForm', 'text',
				'width=610, height=557, resizable = no, scrollbars = no');
	}
</script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판</title>

</head>
<body id="page-top">

  <!-- Page Wrapper -->
  <div id="wrapper">

    <!-- Sidebar -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

      <!-- Sidebar - Brand -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="">
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="far fa-laugh-squint"></i>
        </div>
        <div class="sidebar-brand-text mx-3" style="font-size: 20px;">チーム 掲示板</div>
      </a>

      <!-- Divider -->
      <hr class="sidebar-divider my-0">

      <!-- Nav Item - Dashboard -->
      <li class="nav-item active">
        <a class="nav-link" href="#">
          <i class="fas fa-book"></i>
          <span style="font-size: 15px;">掲示板 ホーム(Team${sessionScope.groupBoardNum})</span></a>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider">

      <!-- Heading -->
      <div class="sidebar-heading">
        MENU
      </div>

      <!-- Nav Item - Pages Collapse Menu -->
      <li class="nav-item" id="go_groupBoard">
        <a class="nav-link collapsed" href="groupboard_list">
          <i class="fas fa-fw fa-folder"></i>
          <span>資料共有掲示板</span>
        </a>
      </li>

      <!-- Nav Item - Charts -->
      <li class="nav-item">
        <a class="nav-link" href="thesisWrite">
          <i class="fas fa-book-open"></i>
          <span>論文作成</span></a>
      </li>

      <!-- Nav Item - Tables -->
      <li class="nav-item">
        <a class="nav-link" href="goGroupBoardCalendar">
          <i class="fas fa-calendar-alt"></i>
          <span>スケジュール</span></a>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider d-none d-md-block">

      <!-- Sidebar Toggler (Sidebar) -->
      <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
      </div>

    </ul>
    <!-- End of Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Topbar -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
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
									<a
										class="dropdown-item text-center" href="viewAllMessages"
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
        <!-- End of Topbar -->

				<hr class="sidebar-divider d-none d-md-block">

				<div class="container-fluid">

					<div class="card shadow mb-4">
						<div class="card-body">
							<div class="table-responsive" id="editor1">
								<table class="table table-bordered" id="dataTable" width="100%"
									cellspacing="0">
									<tr style="font-size: 30px;">
										<th colspan="2" style="text-align: left;">${board.groupBoardTitle}</th>
									</tr>
									<tr>
										<th style="width: 200px;">作成者</th>
										<td>${board.groupBoardId}</td>
									</tr>
									<tr>
										<th>作成時間</th>
										<td>${board.groupBoardDate}</td>
									</tr>
									<tr>
										<th>ヒット</th>
										<td>${board.groupBoardHitcount}</td>
									</tr>
									<tr>
										<th>添付ファイル</th>
										<td><c:if test="${board.orgname != null}">
												<a
													href="groupBoard_download?groupBoardSeq=${board.groupBoardSeq}">
													${board.orgname}</a>
											</c:if></td>
									</tr>
									<tr style="font-size: 30px;">
										<th colspan="2" style="text-align: left;">${board.groupBoardContent}</th>
									</tr>

									<c:if test="${loginId == board.groupBoardId}">
										<tr style="text-align: right;">
											<td colspan="2"><a class="btn btn-primary"
												href="groupBoard_edit?groupBoardSeq=${board.groupBoardSeq}"
												role="button"><i class="fas fa-wrench"></i> 修正</a> <a class="btn btn-primary"
												href="javascript:deleteCheck(${board.groupBoardSeq})"
												role="button"><i class="fas fa-trash-alt"></i> 削除</a>
												<a class="btn btn-primary" href="groupboard_list" role="button">
												<i class="fas fa-undo-alt"></i>  戻る</a>	
											</td>
										</tr>
									</c:if>
									<c:if test="${loginId != board.groupBoardId}">
										<tr style="text-align: right;">
											<td colspan="2">
												<a class="btn btn-primary" href="groupboard_list" role="button">
												<i class="fas fa-undo-alt"></i>  戻る</a>	
											</td>
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
						<h3>リプライ</h3><input type="hidden" id="groupBoardSeq"	value="${board.groupBoardSeq}" />
						<textarea rows="3" id="groupBoardComment"
							style="width: 87%; resize: none;"></textarea>
						&nbsp;&nbsp;
						<button type="button" class="btn btn-primary" id="replyButton"
							style="vertical-align: top; width =5%; height: 81px;"
							data-val="${board.groupBoardSeq}">リプライ保存</button>
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