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

<title>チーム 掲示板</title>

<!-- Custom fonts for this template-->
<link
	href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=M+PLUS+Rounded+1c:400,500,700&amp;subset=japanese"
	rel="stylesheet" type='text/css'>

<!-- Custom styles for this template-->
<link
	href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css"
	rel="stylesheet">
<style>

.week {
	text-align: center;
	font-size: 30px;
	vertical-align: middle;
}

#insertCalendar {
	display: none;
}

body {
	font-family: 'M PLUS Rounded 1c', sans-serif;
}

button {
	font-family: 'M PLUS Rounded 1c', sans-serif;
}

/* 	달력  */
#prev, #next {
	display: inline-block;
	text-decoration: none;
	color: black;
	float: left;
	font-size: 20px;
	text-align: center;
	padding-left: 23%;
	padding-top: 0px;
}

#delete_schdule {
	text-align: right;
	background-color: #E91E63;
}

#youbi {
	font-size: 20px;
	text-align: center;
}

.td {
	font-size: 15px;
	text-align: center;
	background-color: white;
	background-size: cover;
}

#d-none {
	text-align: center;
}

#calendar_wrap {
	width: 30%;
	/* 	height:320px; */
	color: black;
	float: left;
	margin-left: auto;
	text-align: center;
	margin-right: 50px;
}

#select_view {
	color: grey;
	height: 370px;
	width: 100%;
	overflow: auto;
}

.schdule_table {
	color: black;
	float: left;
	/* 	margin-left:auto; */
	width: 390px;
	padding: 8px;
	border: 8px;
}

#insert_calendar_view_ {
	float: left;
	width: 375px;
}

#insert_calendar_view_ {
	display: none;
}

caption {
	font-size: 25px;
	color: black;
	text-align: center;
	/* 	padding: 20px; */
}

#depart_ment {
	width: 29%;
	color: black;
	float: left;
	margin-left: auto;
}

ul {
	text-align: center;
}

li {
	list-style: none;
}

#izen, #izen2, #calendar_insert {
	vertical-align: top;
	color: #e3e6f0;
}

.container-fluid {
	margin-right: 30px;
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
<script
	src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery.min.js">
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
				href="goGroupBoard" style="cursor: auto;">
				<div class="sidebar-brand-icon rotate-n-15">
					<i class="far fa-laugh-squint"></i>
				</div>
				<div class="sidebar-brand-text mx-3" style="font-size: 20px;">チーム
					掲示板</div>
			</a>

			<!-- Divider -->
			<hr class="sidebar-divider my-0">

			<!-- Nav Item - Dashboard -->
			<li class="nav-item"><a class="nav-link"
				href="goGroupBoard"> <i class="fas fa-book"></i> <span
					style="font-size: 15px;">掲示板
						ホーム(Team${sessionScope.groupBoardNum})</span></a></li>

			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading -->
			<div class="sidebar-heading">MENU</div>

			<!-- Nav Item - Pages Collapse Menu -->
			<li class="nav-item"><a class="nav-link collapsed" href="groupboard_list"> <i
					class="fas fa-fw fa-folder"></i> <span>資料共有掲示板</span>
			</a></li>

			<!-- Nav Item - Charts -->
			<li class="nav-item"><a class="nav-link" href="thesisWrite"> <i
					class="fas fa-book-open"></i> <span>論文作成</span></a></li>

			<!-- Nav Item - Tables -->
			<li class="nav-item active"><a class="nav-link" href="goGroupBoardCalendar"> <i
					class="fas fa-calendar-alt"></i> <span>スケジュール</span></a></li>

			<!-- Divider -->
			<hr class="sidebar-divider d-none d-md-block">

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
						<li style="width:5px;"></li>
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

				<!-- Begin Page Content -->
				<div class="container-fluid">
					<div
						class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800" style="font-weight: bold;">今月のスケジュール</h1>
					</div>
					<hr class="sidebar-divider d-none d-md-block">
					<div class="row">
						<div class="col-sm-6">
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h3 class="m-0 font-weight-bold text-primary">
										<span class="year"></span> 年 <span class="month"></span>月
									</h3>
								</div>
								<div class="card-body">
									<div class='square-box'>
										<div class='square-content'>
											<table id="calendar" class="table table-bordered"
												style="width: 100%; height: 747px;">
												<tr>
													<th class="week">日</th>
													<th class="week">月</th>
													<th class="week">火</th>
													<th class="week">水</th>
													<th class="week">木</th>
													<th class="week">金</th>
													<th class="week">土</th>
												</tr>
												<tr>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
												</tr>
												<tr>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
												</tr>
												<tr>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
												</tr>
												<tr>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
												</tr>
												<tr>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
												</tr>
												<tr>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
													<td class="td">&nbsp;</td>
												</tr>
											</table>
										</div>
									</div>
									<div id="calendar_button" style="text-align: center;">
										<li>
											<ul>
												<a href="#" id="prev"> <prev_button
													class="far fa-hand-point-left  fa-3x"
													style="color: #4e73df;"></prev_button>
												</a>

												<a href="#" id="next"> <next_button
													class="far fa-hand-point-right fa-3x"
													style="color: #4e73df;"></next_button>
												</a>
											</ul>
										</li>
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h3 class="m-0 font-weight-bold text-primary">タスク</h3>
								</div>
								<div class="card-body">
									<div class="text-center">
										<a href="#" id="izen"
											class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i
											class="fas fa-align-left"></i> 今月のテスク</a> <a href="#"
											id="izen2"
											class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i
											class="fas fa-school"></i> 全体テスク</a> <a href="#"
											id="calendar_insert"
											class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i
											class=""></i>テスクインサート</a>
									</div>
									<br>
									<div id="select_view">
										<!-- 	선택 스케쥴 테이블. 달력의 < >  누르면  전, 다음 달로 이동되어 해당 달의 이벤트만 출력-->
										<div id="select_table_1"></div>
									</div>
									<!-- 		select_view  끝-->
								</div>
							</div>
							
							
								<div class="card shadow mb-4" id="update_Calendar">
								<div class="card-header py-3">
								<h3 class="m-0 font-weight-bold" style="color:#4e73df;">テスクイ修正</h3>
									</div>
									<div class="card-body">
										<div class="text-center">
											<div id="update_calendar_form">											
												</div>
										</div>
									</div>
							</div>
							
							
							<div class="card shadow mb-4" id="insertCalendar">
								<div class="card-header py-3">
									<h3 class="m-0 font-weight-bold text-primary">テスクインサート</h3>
								</div>
								<div class="card-body">
									<div class="text-center">
										<div>
											<form method="POST" action="insert_calendar" id="insert_calendar">
												<table style="width: 100%;">

													<tr>
														<td style="width: 100px;"><input type="hidden"
															class="id" id="id"> <input type="hidden"
															class="department" id="department"> <input
															type="hidden" class="groupBoardNum" id="groupBoardNum">
															タイトル</td>
														<td><input type="text" class="form-control"
															id="schdule_title" style="width: 100%;"></td>
													</tr>

													<tr>
														<td>スタート</td>
														<td><input type="date" class="form-control"
															id="start_day" style="width: 100%;"></td>
													</tr>

													<tr>
														<td>ラスト</td>
														<td><input type="date" class="form-control"
															id="last_day" style="width: 100%;"></td>
													</tr>

													<tr>
														<td>場所</td>
														<td><input type="text" class="form-control"
															id="place" style="width: 100%;"></td>
													</tr>


													<tr>
														<td>メモ</td>
														<td><input type="text" class="form-control"
															id="discription" style="width: 100%;"></td>
													</tr>
													<tr style="height: 5px;">
													</tr>
													<tr style="text-align: right;">
														<td colspan="2">
															<button type="button" class="btn btn-outline-primary"
																style="font-weight: bold;" id="calendar_submit">タスク保存</button>
														</td>
													</tr>
												</table>
											</form>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--   	container_fluid 끝 -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- Bootstrap core JavaScript-->
	<script
		src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script
		src="${pageContext.request.contextPath}/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="<c:url value="/resources/js/sb-admin-2.min.js"/>"></script>
	<!-- Page level plugins -->
	<script
		src="${pageContext.request.contextPath}/resources/vendor/chart.js/Chart.min.js"></script>


</body>
<script src="resources/js/jquery-3.3.1.js"></script>
<script type="text/javascript">




	// 	Date객체로 현재 년, 월 데이터 가져옴
	var year = new Date().getFullYear(), month = new Date().getMonth();

	// 	레디 함수 !  right = 전체스케쥴 테이블, select_view = 선택한 달의 스케쥴
	// calendar_wrap = 달력 테이블

	$(function() {
		selectMsgCount();
		$('#selectFiveMessages').on('click', selectFive).css('cursor', 'pointer');
		$("#chatForm").on("click", goChatForm).css('cursor', 'pointer');
		var $select_view = $("#select_view");
		var $calendar_wrap = $("#calendar_wrap");
		//  	달력 < 버튼 누르면 생기는 이벤트!

		// 전역변수인 year랑 month ! 여기서   < 클릭할 때마다 현재 --month 시켜서
		// calendar 함수 재 실행

		var $update_Calendar= $('#update_Calendar');		
		$update_Calendar.hide();

		
		$("#prev").on('click', function() {
			

			var $update_Calendar= $('#update_Calendar');					
			$update_Calendar.hide();
			
			white_calendar();

			if (month < 1) {
				alert("タスクがありません");
				return;
			}			
			
			calendar(year, --month);

// 			$('#all_table_2').hide();
			$('#select_table_1').show();

			//그냥 계산하려고 만든 변수 				
			var start_day = year;
			var last_day = year;

			// 날짜를 string으로 변환시켜서  3월- > 03  으로 출력 되도록 변환 시킴 
			// date는  현재 월 -1로 나오기때문에 +1 해줌
			if (month.toString().length <= 1) {
				start_day += '0' + month;
				start_day = parseInt(start_day) + 1;
			} else {
				start_day += month + 1;
				console.log(start_day);
			}

			// 계산한 현재 년 월 보내버려서 output 에서 데이터 출력!!

			$.ajax({
				method : 'POST',
				url : 'Selected_group_Calendar',
				data : {
					'start_day' : start_day
				},
				success : function(resp) {
					output(resp);
					console.log(resp);
				},
				error : function(resp) {
					console.log(resp);
				}

			});

		});

		//prev와 거의 동일! ++month로 바뀜 
		$("#next").on('click', function() {


			var $update_Calendar= $('#update_Calendar');					
			$update_Calendar.hide();
			
			
			if (month > 10) {
				alert("タスクがありません");
				return;
			}

			white_calendar();

			$('#all_table_2').hide();
			$('#select_table_1').show();

			calendar(year, ++month);
			
			//시작일자 계산하려고 만든 변수 				
			var start_day = year;

			if (month.toString().length <= 1) {
				start_day += '0' + month;
				start_day = parseInt(start_day) + 1;
			} else {
				start_day += month;
				start_day = parseInt(start_day) + 1;
			}

			$.ajax({
				method : 'POST',
				url : 'Selected_group_Calendar',
				data : {
					'start_day' : start_day

				},
				success : function(resp) {
					output(resp);
					console.log(resp);
				},
				error : function(resp) {
					output(resp);
					console.log(resp);
				}

			});

		});

		//전체 이벤트달력 에이젝스
		$("#izen2").on('click', function() {


			var $update_Calendar= $('#update_Calendar');					
			$update_Calendar.hide();
			
			
			white_calendar();

			calendar(year, month);

			$('#select_table_1').show();

			$.ajax({
				method : 'POST',
				url : 'all_Group_Calendar',
				success : function(resp) {
					output(resp);
					console.log(resp);
				},
				error : function(resp) {
					console.log(resp);
				}

			});

		});

		//이번달 이벤트 에이젝스
		$("#izen").on(
				'click',
				function() {



					var $update_Calendar= $('#update_Calendar');					
					$update_Calendar.hide();
					
					
					white_calendar();

					var year_ = new Date().getFullYear(), month_ = new Date()
							.getMonth();

					year = year_;
					month = month_;

					calendar(year, month);

					$('#all_table_2').hide();
					$('#select_table_1').show();

					var start_day = year;

					if (month.toString().length <= 1) {
						start_day += '0' + month_;
						start_day = parseInt(start_day) + 1;
					} else {
						start_day = parseInt(start_day) + 1;
					}

					$.ajax({
						method : 'POST',
						url : 'Selected_group_Calendar',
						data : {
							'start_day' : start_day
						},
						success : function(resp) {
							output(resp);
							console.log(resp);
						},
						error : function(resp) {
							console.log(resp);
						}

					});

				});

		// insert 클릭하면 생겼다 사라지,는 이벤트
		$('#calendar_insert').on('click', function() {
			$('#all_table_2').hide();
			//상태 반대로 변환시켜줌 슬라이드토글!
			$('#insertCalendar').slideToggle();
			
			
			var $update_Calendar= $('#update_Calendar');					
			$update_Calendar.hide();

		});

		$('#calendar_submit')
				.on(
						'click',
						function() {
							
							//제약조건 체크
							if (!insert_check()) {
								return;
							};

							var id = $('#id').val(), department = $(
									'#department').val(), groupBoardNum = $(
									'#groupBoardNum').val(), schdule_title = $(
									'#schdule_title').val(), start_day = $(
									'#start_day').val(), last_day = $(
									'#last_day').val(), place = $('#place')
									.val(), discription = $('#discription')
									.val(); 	
							
							var data_ = {
								'id' : id,
								'department' : department,
								'groupBoardNum ' : groupBoardNum,
								'schdule_title' : schdule_title,
								'start_day' : start_day,
								'last_day' : last_day,
								'place' : place,
								'discription' : discription
							}

							$.ajax({
								method : 'POST',
								url : 'insert_Group_calendar',
								data : data_,
								success : function(resp) {
									if (resp == 1) {

									$.ajax({
										method : 'POST',
										url : 'all_Group_Calendar',
										success : function(resp) {
											output(resp);
											alert('テスクの追加に成功しました。');
											$('#select_table_1').show();
											$('#all_table_2').hide();
										},
										error : function(resp) {
											console.log(resp);
										}

									});
									}
								}

							});

						});
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
	
	
	//인서트 체크
	function insert_check(){

		var start_day = $('#start_day').val();
		var last_day = $('#last_day').val();
		
		if(start_day > last_day){
			
			alert("間違っている日付です。");
			return false;
		}

		if(start_day == "" || last_day ==""){
			
			alert("日付を入力してください。");
			return false;
		}
		
		if(schdule_title==""){
			alert("テスクのタイトルを入力してください。");
			return false;
		}
		
		return true;

	}
	

	// ajax로 이전달, 다음 달  이벤트 가져와서 출력 
	function output(resp) {

		
		 white_calendar();
		 
		var $update_Calendar= $('#update_Calendar');					
		$update_Calendar.hide();
		
		//등록된 스케쥴의 시작 달 수만 짜른 변수
		var start_month = "";
		var last_month = "";
		
		//등록된 스케쥴의 전체 날짜 YYYY年MM月DD日 형식으로 되어있당 
		var start_day = null;
		var last_day = null;
		
		//현재 달력의 월 가져옴^^..
		var calendar_month = $('.month').html();

		
		//현재 페이지에 표시된  달력의 월 수가 두 자리 수가 아니면 앞에 0을 붙여줌
		if (calendar_month.length < 2) {
			calendar_month = null;
			calendar_month = '0' + $('.month').html();
		}
		
		var data = '<table id="right2" class="table-striped table-bordered table-hover" style="width:100%;">';
		

		$.each(resp,function(index, item) {

							data += '<tr>';
							data += '<td  style="padding:8px; width :100%;">'
									+ item.schdule_title
									+ '<span>&nbsp;&nbsp;</span>'
									+ '<k class="far fa-edit" data-sno="'+item.group_calendar_num+'">'
									+ '</k>'
									+ '<span></span>'
									+ '<del_group class="fas fa-trash-alt" data-sno="'+item.group_calendar_num+'">'
									+ '</del_group>' + '<br>' + item.start_day + '~'
									+ item.last_day + '<br>' + '場所:'
									+ item.place + '<br>' + 'メモ:'
									+ item.discription + '</td>';
							data += '</tr>';
							start_day = item.start_day;
							last_day = item.last_day;
						
							//스케쥴  시작 날짜  now_month  
							//스케쥴 끝나는 날짜 last_month
							now_month = start_day.substring(5, 7);
							
							//전체일정 눌렀을 때, 해당 달 스케쥴이 아니면 핑크색 표시 안되게 하는 조건문
							
							if (start_month.includes('年',5)) {
								start_month = "";
								start_month = '0' + start_day.substring(6, 7);
							}else{
								start_month = start_day.substring(5, 7);								
							}


							if (calendar_month==start_month){
								
							for (var i = 0; i < 42; i++) {

								var day_color = $(".td").eq(i).html();

								if (day_color.length < 2) {
									day_color = null;
									day_color = '0' + $(".td").eq(i).html();
								}
								if (start_month + start_day.substring(8, 10) <= start_month
										+ day_color
										&& start_month
												+ last_day.substring(8, 10) >= start_month
												+ day_color) {

									$(".td").eq(i).css("background-color",
											"pink");
								}
							
							}
							
							
							}
							/* else if(start_month<last_month){
							날짜 걸치기~
							스케쥴  시작 월 start_month  	
							스케쥴의 시작일~  달력 페이지, 해당 달의 마지막 날 까지 핑크칠 하고 
							다음 달 페이지 넘기면 1일 부터 마지막 날 (last_Day)까지 핑크칠							
							calendar 함수 절대값 사용할 수잇을지도
							28에서  더 색칠해야할 값 +-로 나옴  (2월이 28일이니까 기준으로 해봄)
							Math.abs(d_length -28)								
							} */					
							
						});

		data += '</table>';

		$('#select_table_1').html(data);
		$('del_group').click(delete_schedule);
		$('k').click(update_schedule_table);

	}

	function update_schedule_table() {

		var $update_Calendar= $('#update_Calendar');		
		$update_Calendar.show();

		$('#insertCalendar').hide();
		
	var group_calendar_num  = $(this).attr('data-sno');

	 	$.ajax({
			method :'post',
			url : 'select_Group_calendar_update',
			data : {
				'group_calendar_num':group_calendar_num
			},success : function(resp){
					
				var data = '<table>';
				
				data += '<table style="width: 100%;">';
		
				data += '<tr><td style="width: 100px;"><input type="hidden" class="id" id="id">'		
				+'<input type="hidden" class="department" id="department">'
				+"タイトル"+'</td>'+'<td><input type="text" class="form-control" id="schdule_title" style="width: 100%;" value="'+resp.schdule_title+'"></td></tr>';
		
				data += '<tr><td>スタート</td><td><input type="date" value="'+resp.start_day+'" class="form-control" id="start_day" style="width: 100%;"></td></tr>'
					+'<tr><td>ラスト</td><td><input type="date" value="'+resp.last_day+'" class="form-control" id="last_day" style="width: 100%;"></td></tr><tr><td>場所</td>';
				data +='<td><input type="text" value="'+resp.place+'"class="form-control" id="place" style="width: 100%;"></td></tr>';
				data +='<tr><td>メモ</td><td><input type="text" value="'+resp.place+'" class="form-control" id="discription" style="width: 100%;"></td></tr>';
				data +='<tr style="height: 5px;"></tr><tr style="text-align: right;"><td colspan="2"><button type="button" class="btn btn-outline-primary" style="font-weight: bold;" sno="'+resp.group_calendar_num+'" id="calendar_update_submit">修正</button></td></tr>';
				data += '</table>';

				
			$('#update_calendar_form').html(data);
			
			$('#calendar_update_submit').click(update_schedule_submit);
			
		}
			
	 	});
	}
		
		function update_schedule_submit() {
		
			
			if (!insert_check()) {
				return;
			};
			
			
			var $update_Calendar= $('#update_Calendar');		
			$update_Calendar.show();

			$('#insertCalendar').hide();
			
			

			var group_calendar_num  = $(this).attr('sno'),
			
			schdule_title = $(
			'#schdule_title').val(), start_day = $(
			'#start_day').val(), last_day = $(
			'#last_day').val(), place = $('#place')
			.val(), discription = $('#discription').val(); 

			
			var data_  =  { 'schdule_title' :schdule_title,
							'start_day' :start_day,
							'last_day':last_day,
							'place' :place,
							'discription' : discription,
							'group_calendar_num':group_calendar_num			
			}

			
			
			$.ajax({
				method : "POST"
				,url :"update_Group_Calendar"
				,data : data_
			 	,success :function(resp){
			 		
			 		if(resp==1){
			 			alert("修正を成功しました。");

						calendar(year, month);

						var year_ = new Date().getFullYear(), month_ = new Date()
								.getMonth();

						year = year_;
						month = month_;

						$('#select_table_1').show();
						$('#all_table_2').hide();

						var start_day = year;

						if (month.toString().length <= 1) {
							start_day += '0' + month_;
							start_day = parseInt(start_day) + 1;
						} else {
							start_day = parseInt(start_day) + 1;
						}

						$.ajax({
							method : 'POST',
							url : 'Selected_group_Calendar',
							data : {
								'start_day' : start_day

							},
							success : function(resp) {
								output(resp);
								console.log(resp);
							},
							error : function(resp) {
								console.log(resp);
							}

						});

			 			
			 		}else{
			 			
			 			alert("修正失敗しました。")
			 		}
		 		}		
			});
			
	

	}
	
	function delete_schedule() {


		var $update_Calendar= $('#update_Calendar');		
		$update_Calendar.hide();
		
		
		var group_calendar_num = $(this).attr('data-sno');
	
		$.ajax({
			method : 'POST',
			url : 'delete_Group_calendar',
			data : {
				'group_calendar_num' : group_calendar_num
			},
			success : function(resp) {
			
				alert("テスクを削除しました。");

				calendar(year, month);

				var year_ = new Date().getFullYear(), month_ = new Date()
						.getMonth();

				year = year_;
				month = month_;

				$('#select_table_1').show();
				$('#all_table_2').hide();

				var start_day = year;

				if (month.toString().length <= 1) {
					start_day += '0' + month_;
					start_day = parseInt(start_day) + 1;
				} else {
					start_day = parseInt(start_day) + 1;
				}

				$.ajax({
					method : 'POST',
					url : 'Selected_group_Calendar',
					data : {
						'start_day' : start_day

					},
					success : function(resp) {
						output(resp);
						console.log(resp);
					},
					error : function(resp) {
						console.log(resp);
					}

				});

			},
			error : function(resp) {
				alert("テスクの削除に失敗しました。もう一実行してください。");
				console.log(resp);
			}

		});

	}

	//달력 초기화
	function white_calendar() {
		for (var i = 0; i < 42; i++) {
			$(".td").eq(i).css("background-color", "white");

		}

	}
	// 달력 만드는 함수
	function calendar(new_year, new_month) {

		var d = new Date(new_year, new_month, 1), d_length = 32 - new Date(
				new_year, new_month, 32).getDate(), year = d.getFullYear(), month = d
				.getMonth() + 1, date = d.getDate(), day = d.getDay();


		var $caption_year = $('.year'), $caption_month = $('.month');

		//달력 숫자초기화
		for (var i = 0; i < 42; i++) {
			$(".td").eq(i).text('');

		}
		//달력에 숫자넣기
		for (var i = day; i < day + d_length; i++) {
			$(".td").eq(i).html(date);
			date++;
		}

		//달력에 년도랑 월 집어넣음.
		$caption_year.html(year);
		$caption_month.html(month);

	}


	//즉시실행함수 
	(function() {

		calendar(year, month);

		var year_ = new Date().getFullYear(), month_ = new Date().getMonth();

		year = year_;
		month = month_;

		$('#select_table_1').show();
		$('#all_table_2').hide();

		var start_day = year;

		if (month.toString().length <= 1) {
			start_day += '0' + month_;
			start_day = parseInt(start_day) + 1;
		} else {
			start_day = parseInt(start_day) + 1;
		}

		$.ajax({
			method : 'POST',
			url : 'Selected_group_Calendar',
			data : {
				'start_day' : start_day

			},
			success : function(resp) {
				output(resp);
			}
		});

	})();
	
	function goChatForm() {
		window.open('/chatForm', 'text',
				'width=610, height=557, resizable = no, scrollbars = no');
	}
</script>
</html>