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

<title>文を書く Page</title>

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
	background-color: #4e73df;
	cursor: pointer;
	border: 1px solid #4e73df;
	border-bottom-color: #4e73df;
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
	var editorConfig = { filebrowserUploadUrl : "/fileUpload"
		 		,width : '100%'
		 		,height : '480px'
	};
	$(function() {
		selectMsgCount();
		$('#selectFiveMessages').on('click', selectFive).css('cursor', 'pointer');
		$("#chatForm").on("click", goChatForm).css('cursor', 'pointer');
		$("#go_groupBoard").on('click', go_groupBoard);
		var fileTarget = $('.filebox .upload-hidden');
		fileTarget.on('change', function(){ 
			if(window.FileReader){ 
				var filename = $(this)[0].files[0].name; } else { 
					var filename = $(this).val().split('/').pop().split('\\').pop(); 
				} 
			$(this).siblings('.upload-name').val(filename);
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
	
	function goChatForm() {
		window.open('/chatForm', 'text',
				'width=610, height=557, resizable = no, scrollbars = no');
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

	function go_groupBoard() {
		location.href = "groupboard_list";
	}

	$(function() {
		CKEDITOR.replace('groupBoardContent', editorConfig);
		$('#writeBoard').on('click', writeGroupBoard);
	});

	function writeGroupBoard() {
		var groupBoardTitle = $('#groupBoardTitle').val();
		var groupBoardContent = CKEDITOR.instances.groupBoardContent.getData();

		if (groupBoardTitle == "" || groupBoardContent == "") {
			alert('内容を入力してください。');
			return;
		}
		$('#groupBoard_write').submit();

	}
</script>
</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<ul
			class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
			id="accordionSidebar">

			<!-- Sidebar - Brand -->
			<a
				class="sidebar-brand d-flex align-items-center justify-content-center"
				href="index.html">
				<div class="sidebar-brand-icon rotate-n-15">
					<i class="far fa-laugh-squint"></i>
				</div>
				<div class="sidebar-brand-text mx-3" style="font-size: 20px;">チーム
					掲示板</div>
			</a>

			<!-- Divider -->
			<hr class="sidebar-divider my-0">

			<!-- Nav Item - Dashboard -->
			<li class="nav-item"><a class="nav-link" href="#"> <i
					class="fas fa-book"></i> <span style="font-size: 15px;">掲示板
						ホーム(Team${sessionScope.groupBoardNum})</span></a></li>

			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading -->
			<div class="sidebar-heading">MENU</div>

			<!-- Nav Item - Pages Collapse Menu -->
			<li class="nav-item active" id="go_groupBoard"><a
				class="nav-link collapsed" href="groupboard_list"> <i
					class="fas fa-fw fa-folder"></i> <span>資料共有掲示板</span>
			</a></li>

			<!-- Nav Item - Charts -->
			<li class="nav-item"><a class="nav-link" href="thesisWrite">
					<i class="fas fa-book-open"></i> <span>論文作成</span>
			</a></li>

			<!-- Nav Item - Tables -->
			<li class="nav-item"><a class="nav-link"
				href="goGroupBoardCalendar"> <i class="fas fa-calendar-alt"></i>
					<span>スケジュール</span></a></li>

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

				<div class="container-fluid">

					<div
						class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800" style="font-weight: bold;">掲示板</h1>
						<button type="button" id="writeBoard"
							class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm">
							<i class="fas fa-save"></i> 保存する
						</button>
					</div>
					<hr class="sidebar-divider d-none d-md-block">
					<form id="groupBoard_write" action="groupBoard_write" method="post"
						enctype="multipart/form-data">
						<div class="container-fluid">

							<div class="card shadow mb-4">
								<div class="card-body">
									<input type="text" style="width: 100%; line-height: 40px;"
										name="groupBoardTitle" id="groupBoardTitle"> <br>
									<br>
									<textarea name="groupBoardContent" id="groupBoardContent"
										rows="10" cols="80">
			                    	</textarea>
									<br>
									<div class="filebox">
										<input class="upload-name" value="ファイル選択" disabled="disabled" style="vertical-align: top; color: gray;">
										<label for="ex_filename">ファイル添付</label> <input type="file"
											style="width: 100%;" name="upload"
											id="ex_filename" class="upload-hidden">
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