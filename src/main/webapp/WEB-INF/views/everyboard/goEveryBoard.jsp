<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

  <!-- Custom fonts for this template-->
  <link href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link
		href="https://fonts.googleapis.com/css?family=M+PLUS+Rounded+1c:400,500,700&amp;subset=japanese"
		rel="stylesheet" type='text/css'>

  <!-- Custom styles for this template-->
  <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">
<style>
	body {
		font-family: 'M PLUS Rounded 1c', sans-serif;
	}
	
	button {
		font-family: 'M PLUS Rounded 1c', sans-serif;
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
<script>
	$(function(){
		selectMsgCount();
		$('#selectFiveMessages').on('click', selectFive).css('cursor', 'pointer');
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
</script>
</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<ul
			class="navbar-nav bg-gradient-info sidebar sidebar-dark accordion"
			id="accordionSidebar">

			<!-- Sidebar - Brand -->
		      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="#" style="cursor: auto;">
		        <div class="sidebar-brand-icon rotate-n-15">
					<i class="fas fa-laugh-wink"></i>
				 </div>
		        <div class="sidebar-brand-text mx-3" style="font-size: 20px;">全体 掲示板</div>
		      </a>

			<!-- Divider -->
			<hr class="sidebar-divider my-0">

			<!-- Nav Item - Dashboard -->
			 <li class="nav-item active">
		        <a class="nav-link" href="goEveryBoard">
		          <i class="fas fa-book"></i>
		          <span style="font-size: 15px;">掲示板 ホーム</span></a>
		    </li>
			<hr class="sidebar-divider">
			<div class="sidebar-heading">MENU</div>

			<!-- Nav Item - Pages Collapse Menu -->
			<li class="nav-item">
	        <a class="nav-link" href="everyBoard">
	          <i class="fas fa-chalkboard-teacher"></i>
	          <span>掲示板</span></a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="all_Every_Calendar">
	          <i class="fas fa-calendar-alt"></i>
	          <span>スケジュール</span></a>
	      </li>

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

				<div class="container-fluid">

					<div
						class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800" style="font-weight: bold;">今日のトピックは</h1>
					</div>
				<hr class="sidebar-divider d-none d-md-block">
					<!-- Content Row -->
					<div class="row">
					<div class="col-xl-12 col-md-6 mb-4">
						<div
						class="d-sm-flex align-items-center justify-content-between mb-12">
						<h4 class="mb-0 text-gray-800">IARU学長会議に五神総長が出席しました</h4>
					</div>
					</div>

					<!-- Content Row -->

					<div class="row">
						<div class="col-sm-6">
							<img src="/resources/images/everyboardMain.jpg" style="width:670px; height:340px;">
						</div>
						<div class="col-sm-6">
						<div class="card shadow mb-4">
						<div class="card-header py-3">
									<h6 class="m-0 font-weight-bold text-primary">2019.1.21</h6>
								</div>
								<div class="card-body">
									<div class="text-center">
									</div>
									<p>
										1月21日（月）、スイス連邦工科大学チューリッヒ校において、第14回IARU学長会議が開催され、五神真総長、藤原帰一総長特別参与（法学政治学研究科）、菊池康紀准教授（IR3S）が出席しました。<br>
本会議では、各加盟大学を取り巻く国内外の情勢や各大学内の施策等について情報交換が行われ、Times Higher Educationからモデレーターを招き”Skills for the 21st Century”をテーマにしたディスカッションを行ったほか、社会の大きな転換に対して大学が果たすべき役割について活発な議論が行われました。<br>
五神総長からは本学の未来社会協創推進本部での取組を報告しました。
									</p>
									<a target="_blank" rel="nofollow" href="http://www.tc.u-tokyo.ac.jp/ja/index.html">東京カレッジ &rarr;</a>
								</div>
							</div>
							</div>
							</div>
							<br>
							<br>
						<div class="row">
					<br>
					<div class="col-xl-12 col-md-6 mb-4">
						<div
						class="d-sm-flex align-items-center justify-content-between mb-12">
						<h4 class="mb-0 text-gray-800"> 東京カレッジを開設しました</h4>
					</div>
					</div>
							<div class="col-sm-6">
							<img src="/resources/images/everyboardMain2.jpg" style="width:670px; height:385px;">
						</div>
						<div class="col-sm-6">
						<div class="card shadow mb-4">
						<div class="card-header py-3">
									<h6 class="m-0 font-weight-bold text-primary">2019.2.28</h6>
								</div>
								<div class="card-body">
									<div class="text-center">
									</div>
									<p>
										東京大学は、世界の志ある人たちとともに、地球と人類の未来のあるべき姿を考え、その実現に向けて行動するための新しい仕組みとして、2月1日に東京カレッジを設置しました。名誉カレッジ長として、サー・アンソニー・レゲット教授（2003年ノーベル物理学賞）を迎えます。<br>
東京カレッジでは、「2050年の地球と人類社会」を主たるテーマに、第一線で活躍する有力研究者、将来性豊かな若手研究者、発言力のある知識人が、東京大学の研究者や学生と交流し、互いに刺激を与えあいながら、未来に向けて新たな知を生み出してゆきます。<br>
また、一般講演会の開催等を通じて、「発見の喜び、知識の力」をキーワードに、学問の魅力や未来社会の創造に果たす大学の役割の重要さを広く社会に伝えていきます。
									</p>
									<a target="_blank" rel="nofollow" href="https://www.u-tokyo.ac.jp/focus/ja/articles/z1311_00010.htmll">IARU学長会議に五神総長が出席（UTokyo FOCUS） &rarr;</a>
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
