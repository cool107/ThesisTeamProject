<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html>
<head lang="en">
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

<title>卒業作品 管理システム</title>
<meta name="description"
	content="BlackTie.co - Free Handsome Bootstrap Themes" />
<meta name="keywords"
	content="themes, bootstrap, free, templates, bootstrap 3, freebie,">
<meta property="og:title" content="">

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/style.css">
<link
	href="https://fonts.googleapis.com/css?family=M+PLUS+Rounded+1c:400,500,700&amp;subset=japanese"
	rel="stylesheet" type='text/css'>
<!-- 쪽지 아이콘 -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<link
	href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<style>
body {
	background-image: url('resources/images/bg1.jpg');
	background-size: 100%;
	color: white;
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

.badge-counter {
    transform: scale(.9);
    transform-origin: top right;
    right: 1em;
    top: -0.3em;
    margin-top: -.25rem;
    background-color: red;
}
</style>
<script src="<c:url value="/resources/js/html5shiv.js"/>"></script>
<script src="<c:url value="/resources/js/jquery-1.10.2.min.js"/>"></script>
<script src="<c:url value="/resources/js/jquery-migrate-1.2.1.min.js"/>"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>
<script src="<c:url value="/resources/js/jquery.easing.1.3.js"/>"></script>
<script src="<c:url value="/resources/js/jquery-3.3.1.js"/>"></script>
<script>
	$(function() {
		selectMsgCount();
		$('#selectFiveMessages').on('click', selectFive);
		$('#goGroupBoardLogin').on('click', goGroupBoardLogin);
		$('#goApplicationForm').on('click', goApplicationForm);
		$('#goEveryBoard').on('click', goEveryBoardFrom);
		$('#insertThesis').on('click', goInsertThesisForm);
		$('#updateThesis').on('click', goUpdateThesisForm);
		$('#goSelectSearchForm').on('click', goSelectSearchForm);
		//5개 뽑아오기
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

			var content = '<table class="table table-bordered" id="msgTable" cellspacing="0" style="table-layout:fixed;">';
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
									content += '<td class="fromId" style="width:80px;">'
											+ item.fromId + '</td>';
									content += '<td class="messageContent" style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap;">'
											+ '<a href = "entergetMsg?msg_seq='
											+ item.msg_seq
											+ '" id = "getMessage">'
											+ item.messageContent
											+ '</a>'
											+ '</td>';
									content += '<td class="messageIndate" style="width:150px;">'
											+ item.messageIndate + '</td>';
									content += '</tr>';
								});
			}
			content += '</table>';

			$('.listOfMessage').html(content);
		}
		;

		function goInsertThesisForm() {
			location.href = "/insertThesis";
		}

		function goApplicationForm() {
			location.href = "/insertApplicationForm";
		}
		;

		function goGroupBoardLogin() {
			location.href = "/goGroupBoardLogin";
		}
		;

		function goEveryBoardFrom() {
			location.href = "/goEveryBoard";
		}
		;

		function goUpdateThesisForm() {
			location.href = "/updateThesis";
		};
		
		function goSelectSearchForm() {
			location.href = "/goSelectSearchForm";
		};
	});
</script>
</head>

<body>
	<div class="navbar navbar-fixed-top">
		<c:if test="${sessionScope.loginId != null }">
			<div class="link">
				<p style="text-align: right; font-size: 20px;">
					&nbsp;&nbsp;&nbsp;&nbsp; <a class="nav-link active"
						href="logoutMember">LOGOUT</a> &nbsp;&nbsp;
					<c:if test="${sessionScope.loginDivision == '学生'}">
				&nbsp;&nbsp;
				<a class="nav-link" href="mypage">MYPAGE</a>
				&nbsp;&nbsp;
					<c:if test="${sessionScope.loginGroupBoardNum == 0}">
						&nbsp;&nbsp;
							<a class="nav-link active" href="applicationForm">チーム掲示板 申請</a>
						 &nbsp;&nbsp;&nbsp;
					</c:if>
					</c:if>
				</p>
			</div>
			<c:if test="${sessionScope.loginDivision == '学生'}">
				<div class="dropdown" id="selectFiveMessages">

					<a class="dropdown-toggle" data-toggle="dropdown"> <img
						src="https://img.icons8.com/ultraviolet/40/000000/new-post.png"
						width="30px" height="30px" />
						<span class="badge badge-danger badge-counter" id="msgCount"></span>
					</a>
					<c:if test="${sessionScope.loginGroupBoardNum != 0}">
						<ul class="dropdown-menu pull-right" role="menu"
							aria-labelledby="dLabel" id="menu">
							<li><div class="listOfMessage" style="width: 500px;"></div></li>
							<li><div class="dropdown-divider"></div> <a
								class="viewAllMessages" href="viewAllMessages"
								style="text-align: center; font-size: 15px;">全てのメッセージを見る</a></li>
						</ul>
					</c:if>
					<c:if test="${sessionScope.loginGroupBoardNum == 0}">
						<ul class="dropdown-menu dropdown-menu-right" role="menu"
							aria-labelledby="dLabel" id="menu">
							<li><div class="listOfMessage" style="width: 500px;"></div></li>
							<li><div class="dropdown-divider"></div> <a
								class="viewAllMessages" href="viewAllMessages"
								style="text-align: center; font-size: 15px;">全てのメッセージを見る</a></li>
						</ul>
					</c:if>
				</div>
			</c:if>

		</c:if>
		<c:if test="${sessionScope.loginId == null }">
			<!-- 로그인전 -->
			<p style="text-align: right; font-size: 20px;">
				<a class="nav-link active" href="loginMember">LOGIN</a>
				&nbsp;&nbsp;&nbsp;&nbsp; <a class="nav-link" href="joinMember">JOIN</a>
				&nbsp;&nbsp;&nbsp;
			</p>
		</c:if>
	</div>
	<!-- /.navbar -->


	<!-- === MAIN Background === -->
	<div class="slide story" id="slide-1">
		<div class="container">
			<div id="home-row-1" class="row clearfix">
				<div class="col-12">
					<h1 class="font-semibold">
						SC UNIVERSITY <span class="font-thin">卒業作品 管理システム</span>
					</h1>
					<c:if test="${sessionScope.loginId != null }">
						<!-- 로그인후 -->
						<h4 class="font-thin">
							<span style="font-size: 45px;">${sessionScope.loginName }
								様</span>、こんにちは！
						</h4>
					</c:if>
					<c:if test="${sessionScope.loginId == null }">
						<!-- 로그인전 -->
						<h4 class="font-thin">
							皆さんの<span style="font-size: 45px;">円滑な論文作成</span>を手伝います。
						</h4>
					</c:if>
					<br> <br>
				</div>
				<!-- /col-12 -->
			</div>
			<!-- /row -->
			<c:if
				test="${sessionScope.loginId == null || sessionScope.loginDivision != '管理者'}">
				<div id="home-row-2" class="row clearfix">
					<div class="col-12 col-sm-4">
						<div class="home-hover navigation-slide" id="goSelectSearchForm">
							<i class="fas fa-search fa-5x"></i>
						</div>
						<span>論文検索</span>
					</div>
					<div class="col-12 col-sm-4">
						<div class="home-hover navigation-slide" id="goGroupBoardLogin">
							<i class="fas fa-chalkboard-teacher fa-5x"></i>
						</div>
						<span>掲示板<br>(TEAM)
						</span>
					</div>
					<div class="col-12 col-sm-4">
						<div class="home-hover navigation-slide" id="goEveryBoard">
							<i class="fas fa-users fa-5x"></i>
						</div>
						<span>掲示板<br>(ANYONE)
						</span>
					</div>
				</div>
			</c:if>
			<c:if
				test="${sessionScope.loginId != null && sessionScope.loginDivision == '管理者'}">
				<!-- 관리자 로그인후 -->
				<div id="home-row-2" class="row clearfix">
					<div class="col-12 col-sm-3">
						<div class="home-hover navigation-slide">
							<a href="insertThesis"><i class="fas fa-torah fa-5x"></i></a>
						</div>
						<span>論文登録</span>
					</div>
					<div class="col-12 col-sm-3">
						<div class="home-hover navigation-slide">
							<div id="goApplicationForm">
								<i class="fas fa-user-plus fa-5x"></i>
							</div>
						</div>
						<span>チーム掲示板生成</span>
					</div>
					<div class="col-12 col-sm-3">
						<div class="home-hover navigation-slide">
							<div id="updateThesis">
								<i class="fas fa-sync-alt fa-5x"></i>
							</div>
						</div>
						<span>論文様式修正</span>
					</div>
					<div class="col-12 col-sm-3">
						<div class="home-hover navigation-slide">
							<a href=goEveryBoard><i class="fas fa-users fa-5x"></i></a>
						</div>
						<span>掲示板<br>(ANYONE)</span>
					</div>
				</div>
			</c:if>
			<!-- /row -->
		</div>
		<!-- /container -->
	</div>
	<!-- /slide1 -->

</body>

</html>