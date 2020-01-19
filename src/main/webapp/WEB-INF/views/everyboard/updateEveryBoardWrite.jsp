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

<title>文を修正する Page</title>

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

.filebox input[type="file"] {
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
}

.filebox label {
	display: inline-block;
	padding: .5em .75em;
	color: white;
	font-size: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #36b9cc;
	cursor: pointer;
	border: 1px solid #36b9cc;
	border-bottom-color: #36b9cc;
	border-radius: .25em;
}

.filebox .upload-name {
	display: inline-block;
	padding: .5em .75em;
	font-size: inherit;
	font-family: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #f5f5f5;
	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2;
	border-radius: .25em;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
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
		CKEDITOR.replace('everyBoardContent', {
			height : '480px'
		});
		selectMsgCount();
		$('#writeBoard').on('click', writeEveryBoard);
		$('#selectFiveMessages').on('click', selectFive).css('cursor', 'pointer');
		$('#fileDelete').on('click', fileDelete);
		$("#chatForm").on("click", goChatForm).css('cursor', 'pointer');
		var fileTarget = $('.filebox .upload-hidden');
		fileTarget.on('change', function(){ 
			if(window.FileReader){ 
				var filename = $(this)[0].files[0].name; } else { 
					var filename = $(this).val().split('/').pop().split('\\').pop(); 
				} 
			$(this).siblings('.upload-name').val(filename).css('color','gray');
		});
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

	function writeEveryBoard() {
		var everyBoardTitle = $('#everyBoardTitle').val();
		var everyBoardContent = CKEDITOR.instances.everyBoardContent.getData();

		if (everyBoardTitle == "" || everyBoardContent == "") {
			alert('内容を入力してください。');
			return;
		}
		$('#updateEveryBoard').submit();

	}
	
	function fileDelete(){
		var everyBoardSeq = ${EveryBoard.everyBoardSeq};
		$.ajax({
			method : 'post'
			, url : 'fileDelete'
			, data : {'everyBoardSeq' : everyBoardSeq}
			, success : function(resp){
				if (resp == 1) {
					$('.upload-name').val('添付したファイルを削除しました。').css('color','red');
				} 
			}
		});
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

					<div
						class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800" style="font-weight: bold;">掲示板</h1>
						<button type="button" id="writeBoard"
							class="d-none d-sm-inline-block btn btn-sm btn-info shadow-sm">
							<i class="fas fa-save"></i> 修正する
						</button>
					</div>
					<hr class="sidebar-divider d-none d-md-block">
					<form id="updateEveryBoard" method="POST" action="updateEveryBoard"  enctype="multipart/form-data">
						<input type="hidden" value="${EveryBoard.everyBoardSeq}"
							name="everyBoardSeq">
						<div class="container-fluid">

							<div class="card shadow mb-4">
								<div class="card-body">
									<input type="text" style="width: 100%; line-height: 40px;"
										name="everyBoardTitle" id="everyBoardTitle"
										value="${EveryBoard.everyBoardTitle}"> <br>
									<br>
									<textarea name="everyBoardContent" id="everyBoardContent"
										rows="10" cols="80">
			                    		${EveryBoard.everyBoardContent}
			                    	</textarea>
			                    	<br>
									<div class="filebox">
										<input class="upload-name" value="${EveryBoard.everyBoardOrgname}" disabled="disabled"
											style="vertical-align: top; color: gray; width:500px;"> <label
											for="ex_filename">ファイル添付</label> <input type="file"
											style="width: 100%;" name="upload" id="ex_filename"
											class="upload-hidden">
										<button type="button" class="btn btn-outline-info" style="float: right;" id="fileDelete">ファイル削除</button>
									</div>
								</div>
							</div>
						</div>
					</form>
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