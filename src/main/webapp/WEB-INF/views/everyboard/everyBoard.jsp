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

#chatroom {
	width: 300px;
	height: 300px;
	border: 1px solid;
	border-radius: 10px;
	border-color: #f1f1f1;
	padding: 5px;
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
<script src="<c:url value="/resources/js/sockjs.js" />"></script>
<script src="<c:url value="/resources/js/stomp.js" />"></script>
<script>
	$(function() {
		selectMsgCount();
		$('#selectFiveMessages').on('click', selectFive).css('cursor', 'pointer');
		$('.boardDetail').on('click', boardDetail).css('cursor', 'pointer');
		$('#writeBoard').on('click', writeBoard).css('cursor', 'pointer');
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

	function updateHitcount(num) {
		$.ajax({
			method : 'POST',
			url : 'updateHitcount',
			data : {
				'everyBoardSeq' : num
			}
		});
	};

	function boardDetail() {

		var everyBoardSeq = $(this).attr("data-val");

		updateHitcount(everyBoardSeq);

		$.ajax({
			method : 'POST',
			url : 'getBoard',
			data : {
				'everyBoardSeq' : everyBoardSeq
			},
			success : function(result) {
				if (result == "") {
					alert("データの読み込みに失敗しました。");
					return;
				} else {
					$('#paging').css('display', 'none');
					$('#commentSpace').css('display', '');

					outBoard(result);

					$.ajax({
						method : 'POST',
						url : 'all_comment',
						data : {
							'everyBoardSeq' : everyBoardSeq
						},
						success : function(resp) {
							reple_outBoard(resp);
							console.log(resp);

						}
					});

				}
			}
		});
	};

	function writeBoard() {
		location.href = "/everyBoardWrite";
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
					<form
						class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search"
						action="everyBoard" method="get">
						<div class="input-group">
							<div class="form-group">
								<select name="keyField" class="form-control">
									<option value="everyBoardTitle" selected>題目</option>
									<option value="id">著者</option>
									<option value="everyBoardContent">内容</option>
								</select>
							</div>
							<div style="width: 10px;"></div>
							<input type="text" class="form-control bg-light border-0 small"
								placeholder="Search for..." aria-label="Search"
								aria-describedby="basic-addon2" name="keyWord" id="keyWord"
								value="${keyWord}">
							<div class="input-group-append">
								<button class="btn btn-info" type="submit">
									<i class="fas fa-search fa-sm"></i>
								</button>
							</div>
						</div>
					</form>
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

					<div
						class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800" style="font-weight: bold;">掲示板</h1>
						<button type="button" id="writeBoard"
							class="d-none d-sm-inline-block btn btn-sm btn-info shadow-sm">
							<i class="fas fa-pencil-alt"></i> 投稿する
						</button>
					</div>
					<hr class="sidebar-divider d-none d-md-block">

					<div class="container-fluid">
						<div class="card shadow mb-4">
							<div class="card-body">
								<div class="table-responsive">
									<table class="table table-bordered" id="dataTable" width="100%"
										cellspacing="0">
										<tr>
											<th style="width: 100px;">番号</th>
											<th>題目</th>
											<th style="width: 180px;">著者</th>
											<th style="width: 100px;">ヒット</th>
											<th style="width: 200px;">日付</th>
										</tr>
										<c:if test="${EveryBoard == null}">
											<tr>
												<td colspan="5" style="font-size: 20px; text-align: center;">登録された文がありません。</td>
											</tr>
										</c:if>
										<c:if test="${EveryBoard != null}">
											<c:forEach items="${EveryBoard}" var="EveryBoard"
												varStatus="status">
												<tr>
													<td class="index"
														style="text-align: center; vertical-align: middle;">${navi.totalRecord - ((navi.currentPage - 1) * navi.boardPerPage + status.index)}</td>
													<td class="everyBoardTitle" style="vertical-align: middle;"><a
														class="boardDetail" style="color: blue"
														href="everyBoardDetail?everyBoardSeq=${EveryBoard.everyBoardSeq}"
														data-val="${EveryBoard.everyBoardSeq}">${EveryBoard.everyBoardTitle}</a>
														<c:if test="${EveryBoard.recount>0}">
															<span style="color: red;">(${EveryBoard.recount})</span>
														</c:if></td>
													<td class="id"
														style="text-align: center; vertical-align: middle;">${EveryBoard.id}</td>
													<td class="everyBoardHitcount"
														style="text-align: center; vertical-align: middle;">${EveryBoard.everyBoardHitcount}</td>
													<td class="everyBoardDate"
														style="text-align: center; vertical-align: middle;">${EveryBoard.everyBoardDate}</td>
												</tr>
											</c:forEach>
										</c:if>
									</table>
									<div id="paging">
										<nav aria-label="Page navigation example">
											<ul class="pagination justify-content-center">
												<li class="page-item"><a class="page-link"
													href="everyBoard?page=${navi.currentPage - 1}"
													aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
														<span class="sr-only">Previous</span>
												</a></li>
												<c:forEach var="page" begin="${navi.startPageGroup}"
													end="${navi.endPageGroup}">

													<c:if test="${navi.currentPage == page}">
														<li class="page-item"><a class="page-link"
															href="everyBoard?page=${page}">${page}</a></li>
													</c:if>

													<c:if test="${navi.currentPage != page}">
														<li class="page-item"><a class="page-link"
															href="everyBoard?page=${page}">${page}</a></li>
													</c:if>

												</c:forEach>
												<li class="page-item"><a class="page-link"
													href="everyBoard?page=${navi.currentPage+1}"
													aria-label="Next"> <span aria-hidden="true">&raquo;</span>
														<span class="sr-only">Next</span>
												</a></li>
											</ul>
										</nav>
									</div>
								</div>
							</div>
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